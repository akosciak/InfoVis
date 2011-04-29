package com.all {

	import flash.geom.Point;
	import flash.display.DisplayObjectContainer;
	
	public class DrawProcessor {

		private var _display:DisplayObjectContainer;

		public function DrawProcessor(display:DisplayObjectContainer):void {
			_display = display;
			return;
		}

		//=========================================================================
		// Self-contained all accessed through drawList
    //=========================================================================
		private function getNextDrawPt(curPoint:Point,
																					radius:Number,
																					next_radius:Number,
																					direction:int):Point {

			var nextPoint:Point = new Point(curPoint.x,curPoint.y);

			// Calculate the new point, and the check point
			switch(direction){
				case DisplayDirection.DOWN: 
					nextPoint.y += radius + next_radius; break;
				case DisplayDirection.UP: 
					nextPoint.y -= radius + next_radius; break;
				case DisplayDirection.RIGHT: 
					nextPoint.x += radius + next_radius; break;
				default: 
					trace("DrawProcessor()::getNextDrawPt()-Error:incorrect direction given");
			}
			return nextPoint;
		}

		private function getStartLoc(pencil:Point,start:int,
																				radius:Number):Point {

			// Determine start location
			switch(start){
				case DisplayStartLoc.TOP: pencil.y += radius; break;
				case DisplayStartLoc.BOTTOM: pencil.y -= radius; break;
				case DisplayStartLoc.RIGHT: pencil.x -= radius; break;
				case DisplayStartLoc.LEFT: pencil.x += radius; break;
				default: 
					trace("DrawProcessor::getStartPos()-Error:incorrect start given");
			}

			return pencil;
		}

		private function drawNode(node:Node,pencil:Point):void{
			// Draw the node
//			trace("drawing:",node.title," at ",pencil);
			node.doubleClickEnabled = true;
			node.x = pencil.x;
			node.y = pencil.y;
			node.draw();
			return;
		}		

		/*
		 * Draws a row of Nodes onto the display, 
		 * without adding them to the display list.
		 */
		public function drawList(pencil:Point,nodes:NodeList,
																		dir:int,start:int):void {
			trace("DrawProcessor::drawList() ",
				"- Start drawing all ",nodes.length," nodes");			

			var i:int;
			var node:Node;
			var next_radius:Number;
			var radius:Number = nodes.getNodeAt(0).getCostRadius();

			// Pencil is the current position to draw.
			pencil = getStartLoc(pencil,start,radius);

			// Draw each node
			for (i=0; i < nodes.length; i++){

				node = nodes.getNodeAt(i);
				radius = node.getCostRadius();
				drawNode(node,pencil);

				// If there is another node that can be drawn, than set 
				// the new drawing position
				if (i+1 < nodes.length){
					next_radius = nodes.getNodeAt(i+1).getCostRadius();
					pencil = getNextDrawPt(pencil,radius,next_radius,dir);

					// If there was no room
					if (pencil == null){
						break;
					}
				}	
			}
			
			return;
		}
	
		private function displayNodeList( nodeList:NodeList,pencil:Point,
																			dir:int,start:int,perm:int):DisplayNode {
			trace("DrawProcessor::displayNodeList() - drawing out a new list");
			var displayNode:DisplayNode;
		
			if (nodeList.length > 0){
				nodeList.sort(NodeList.HIGH);
				drawList(pencil,nodeList,dir,start);
				displayNode = DisplayNode.initDisplayNodes(nodeList,dir,perm);
			} else {
				trace("DrawProcessor::displayNodeList() - nodelist is empty!");
			}

			return displayNode;
		}

		/*
     * Given a DisplayNode it draws its subnodes!
     */
		public function drawDisplayList(displayNode:DisplayNode,
																	  subNodes:NodeList,
																		dir:int,permissions:int):void {
			trace("DrawProcessor::drawDisplayList() - Creating Nodes...");

			var node:Node = displayNode.node;
			var pencil:Point = new Point();

			switch(dir){
				case DisplayDirection.UP:
					if (displayNode.up == null){
						pencil.x = node.x;
						pencil.y = node.y - node.getCostRadius();
						displayNode.up = displayNodeList(	subNodes,pencil,dir,
																							DisplayStartLoc.BOTTOM,
																							permissions);
						if (displayNode.up != null){
							displayNode.up.down = displayNode;
						}
					} else {
						trace("DrawProcessor::drawDisplayList() - Nodes UP are already drawn");
					}
					break;
				case DisplayDirection.DOWN:
					if (displayNode.down == null){
						pencil.x = node.x;
						pencil.y = node.y + node.getCostRadius();
						displayNode.down = displayNodeList(	subNodes,pencil,dir,
																								DisplayStartLoc.TOP,
																								permissions);
						if (displayNode.down != null){
							displayNode.down.up = displayNode;
						}
					} else {
						trace("DrawProcessor::drawDisplayList() - Nodes DOWN are already drawn");
					}
					break;
				case DisplayDirection.RIGHT:
					if (displayNode.right == null){
						pencil.x = node.x + node.getCostRadius();
						pencil.y = node.y;
						displayNode.right = displayNodeList(subNodes,pencil,dir,
																								DisplayStartLoc.LEFT,
																								permissions);
						if (displayNode.right != null){
							displayNode.right.left = displayNode;
						}
					} else {
						trace("DrawProcessor::drawDisplayList() - Nodes RIGHT are already drawn");
					}
					break;
			}

			return;
		}

		public function addDisplayNodes(displayNode:DisplayNode,
			  													 dir:int):void {

      trace("DrawProcessor::addDisplayNodes() - Adding to display list");
			trace(dir);
			var node:DisplayNode = displayNode;

			if (node.state == DisplayNode.CLEAR){
				_display.addChild(node);
				node.state = DisplayNode.NONE;
			} 

			switch(dir){				
				case DisplayDirection.UP:
					node = node.up;	break;
				case DisplayDirection.DOWN:
					node = node.down;	break;
				case DisplayDirection.LEFT:
					node = node.left;	break;
				case DisplayDirection.RIGHT:
					node = node.right;	break;
				default:
					break;
			}

			while (node != null){
				if (node.state == DisplayNode.CLEAR){
					_display.addChild(node);
					node.state = DisplayNode.NONE;
				} 

				switch(dir){				
					case DisplayDirection.UP:
						node.print();
						node.downOpen = true;
						node.down.upOpen = true;
						node = node.up;	break;
					case DisplayDirection.DOWN:
						node.upOpen = true;
						node.up.downOpen = true;
						node.print();
						node = node.down;	break;
					case DisplayDirection.LEFT:
						node.rightOpen = true;
						node.right.leftOpen = true;
						node = node.left;	break;
					case DisplayDirection.RIGHT:
						node.leftOpen = true;
						node.left.rightOpen = true;
						node = node.right;	break;
					default:
						break;
				}

			}

			return;
		}

	}
	
}
