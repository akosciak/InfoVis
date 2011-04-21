package com.all {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class BudgetGraph extends Sprite{

		// KeyBoard Event KeyCodes
		private static const UP:int = 87;
		private static const DOWN:int = 83;
		private static const LEFT:int = 65;
		private static const RIGHT:int = 68;
	
		// The node that has current focus
		private var _centralRadius:Number = 100; // the radius that each central node needs to conform to
		private var _centralNode:DisplayNode;
		private var _centralScale:Number = 1.0;
		private var _centralPoint:Point;

		private var _rootNodes:NodeList;
		private var _width:Number;
		private var _height:Number;
			
		/*
     * Constructor, the Nodelist given is used as the rootNodeList
     */
		public function BudgetGraph(rootNodes:NodeList,width:Number,height:Number):void {
			_width = width;
			_height = height;
			_rootNodes = rootNodes;
			
			// Set the background white!			
			graphics.beginFill(0xFFFFFF,1.0);
			graphics.drawRect(0,0,_width,_height);
			graphics.endFill();

			return;
		}

		public function turnOffListeners():void {
			Main._stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main._stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			removeEventListener(MouseEvent.CLICK, clickHandler);
			return;
		}

		public function turnOnListeners():void {
			Main._stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main._stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);	
			addEventListener(MouseEvent.CLICK, clickHandler);
			return;
		}

		private function keyUpHandler(event:KeyboardEvent):void {
			Main._stage.addEventListener(KeyboardEvent.KEY_UP, keyDownHandler);
			return;			
		}

		private function scaleBudgetGraph(ratio:Number):void {
			trace("BudgetGraph::scaleBudgetGraph - Pre=",ratio,_centralPoint,x,y);

			var originalCentralPoint:Point = _centralPoint;
			_centralPoint = new Point();
		
			_centralPoint.x = originalCentralPoint.x*ratio;
			_centralPoint.y = originalCentralPoint.y*ratio;

			this.width *= ratio;
			this.height *= ratio;
			_centralScale *= ratio;

			this.x += originalCentralPoint.x - _centralPoint.x;
			this.y += originalCentralPoint.y - _centralPoint.y;

			trace("BudgetGraph::scaleBudgetGraph - Post=",ratio,_centralPoint,x,y);
			return;
		}

		private function clickHandler(event:MouseEvent):void {
			trace("BudgetGraph::clickHandler()");
			var displayNode:DisplayNode;
			var node:Node;
			var pencil:Point = new Point();

			// If the control key is pressed and the target is a Node				  if(event.target is DisplayNode) {	      trace("BudgetGraph::clickHandler() - Node was selected!");
				displayNode = DisplayNode(event.target);
				node = displayNode.node;

				// Depending on the state you need to draw something ...
				switch(displayNode.state){
					case DisplayNode.NONE:
						break;
						if (displayNode.allowed == DisplayNode.REVENUE){
							node.revenue.sort(NodeList.HIGH);

							pencil.x = node.x;
							pencil.y = node.y - node.getCostRadius();

							drawList(pencil,node.revenue,
											 DisplayDirection.UP,
											 DisplayStartLoc.BOTTOM);

							displayNode.up = initDisplayNodes(node.revenue,DisplayDirection.UP);
			
							displayNode = displayNode.up;
							while (displayNode != null){
								addChild(displayNode);
								displayNode = displayNode.up;
							}
						}
						// Need to draw the nodelists for the searched it's allowed to make
						// Need to clear any other full nodelists
						break;
					case DisplayNode.HALF:
						// Need to clear all other half and full nodelists
						// Need to draw the nodelists to the right
						break;
					case DisplayNode.FULL:
						// Need to clear my own nodelist, and done...
						break;
					default:
						break;
				}
		  }						
			return;
		}

		private function addDisplayNodeDir(dir:int):void {

			switch(dir){				
				case DisplayDirection.UP:
					break;
				case DisplayDirection.DOWN:
					break;
				case DisplayDirection.LEFT:
					break;
				case DisplayDirection.RIGHT:
					break;
				default:
					break;
			}

			return;
		}

    private function keyDownHandler(event:KeyboardEvent):void {

			var currRadius:Number = _centralNode.node.getCostRadius();
			var nextRadius:Number;
			var shift:Number;

			switch(event.keyCode){
				case UP:
					break;
				case DOWN:
					break;
				case LEFT:
					if (_centralNode.right){
						nextRadius = _centralNode.right.node.getCostRadius();
						shift = (_centralScale*currRadius) + (_centralScale*nextRadius);
						this.x -= shift;
						_centralPoint.x += shift; 
						scaleBudgetGraph(currRadius/nextRadius);
						_centralNode = _centralNode.right;
					}
					break;	
				case RIGHT:
					if (_centralNode.left){
						nextRadius = _centralNode.left.node.getCostRadius();
						shift = (_centralScale*currRadius) + (_centralScale*nextRadius);
						this.x += shift;
						_centralPoint.x -= shift; 
						scaleBudgetGraph(currRadius/nextRadius);
						_centralNode = _centralNode.left;
					}
					break;
				default:
					break;
			}			
			Main._stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			return;
    }

		public function drawBudgetGraph():void {
			trace("BudgetGraph::drawBudgetGraph() - drawing the budget graph");

			var pencil:Point = new Point(0,0);
			var node:DisplayNode;
			var i:int;

			Node.max_cost = _rootNodes.getNodeAt(0).cost;
			pencil.x = _width/2;
			pencil.y = _height/2;
	
			_rootNodes.sort(NodeList.HIGH);

			drawList(pencil,_rootNodes,
							 DisplayDirection.RIGHT,
							 DisplayStartLoc.LEFT);

			_centralNode = initDisplayNodes(_rootNodes,DisplayDirection.RIGHT);
			_centralPoint = new Point(_width/2+_centralNode.node.getCostRadius(),_height/2);

			node = _centralNode;
			while (node != null){
				addChild(node);
				node = node.right;
			}

			return;
		}

		private function initDisplayNodes(nodeList:NodeList,dir:int):DisplayNode {
			var i:int;
			var central:DisplayNode;
			var curr:DisplayNode;
			var last:DisplayNode;

			// Setup the very first node in the graph
			central = new DisplayNode(nodeList.getNodeAt(0),DisplayNode.ALL);
			last = central;

			// Setup the rest in the list
			for (i=1;i<nodeList.length;i++){
				curr = new DisplayNode(nodeList.getNodeAt(i),DisplayNode.ALL);

				switch(dir){				
					case DisplayDirection.UP:
						curr.down = last;
						last.up = curr;
						break;
					case DisplayDirection.DOWN:
						curr.up = last;
						last.down = curr;
						break;
					case DisplayDirection.LEFT:
						curr.right = last;
						last.left = curr;
						break;
					case DisplayDirection.RIGHT:
						curr.left = last;
						last.right = curr;
						break;
					default:
						break;
				}

				last = curr;
			}

			return central;
		}

		/*
     * Drawing A List of Nodes
     *
     ****************************************************************/

		/*
     * Given a point that you are currently at determines the next
     * point to draw from by knowing the direction of draw, current
     * radius, and next radius to be drawn.
     */ 
		private static function getNextDrawPt(curPoint:Point,
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
					trace("BudgetGraph()::getNextDrawPt()-Error:incorrect direction given");
			}
			return nextPoint;
		}

		private static function getStartLoc(pencil:Point,start:int,
																				radius:Number):Point {

			// Determine start location
			switch(start){
				case DisplayStartLoc.TOP: pencil.y += radius; break;
				case DisplayStartLoc.BOTTOM: pencil.y -= radius; break;
				case DisplayStartLoc.RIGHT: pencil.x -= radius; break;
				case DisplayStartLoc.LEFT: pencil.x += radius; break;
				default: 
					trace("DisplayNodeList::getStartPos()-Error:incorrect start given");
			}

			return pencil;
		}

		private static function drawNode(node:Node,pencil:Point):void{
			// Draw the node
			trace("drawing:",node.title," at ",pencil);
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
		public static function drawList(pencil:Point,nodes:NodeList,
																		dir:int,start:int):void {
			trace("DisplayNodeList::drawList() ",
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
				trace("moving to:",pencil);
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

	}
	
}
