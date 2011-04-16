package com.all {
	
	import com.all.Node;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.EventPhase;
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;

	public class NodeList extends Sprite{

		// Start Draw Locations
		public static const TOP:int = 1;
		public static const LEFT:int = 2;
		public static const BOTTOM:int = 3;
		public static const RIGHT:int = 4;
		public static const CENTER:int = 5;

		// Directions to draw the NodeList
		public static const DRAW_UP:int = 1;
		public static const DRAW_DOWN:int = 2;
		public static const DRAW_RIGHT:int = 3;

		public static const BUFFER:int = 4;
	
		// An ID to give to NodeLists
		private static var NodeListID:int = 0;

		//	The Nodes and different stats about them
		private var _nodes:Vector.<Node>;
		public var length:uint;
		public var max_cost:Number;
		public var max_radius:Number;

		// Properties that keep track of the state of the NodeList Drawing
		private var _open_nodelists:Array;
		private var _isDrawn:Boolean;
		private var _isSimpleDisplay:Boolean;
		private var _isDetailDisplay:Boolean;

		// Whether or not to allow searching of subnodelists
		private var _searchSpending:Boolean;
		private var _searchRevenue:Boolean;

		// The NodeLists unique ID
		private var _id:int;

		public function NodeList():void  {

			// Contained Nodes and Stats
			_nodes = new Vector.<Node>();
			length = 0;
			max_cost = 0;

			// State Variables
			_open_nodelists = new Array();
			_isDrawn = false;
			_isSimpleDisplay = true;
			_isDetailDisplay = false;

			// DisplayObject Properties
			doubleClickEnabled = true;

			// Unique ID
			_id = NodeListID;
			NodeListID++;

			// Set whether we are allowed to dig into these
			_searchSpending = true;
			_searchRevenue = true;

			return;
		}

		public function getNodeAt(x:int):Node  {
			return _nodes[x];
		}
		
		public function push(node:Node):void  {
			_nodes.push(node);
			length++;
			
			if (node.cost > max_cost){
				max_cost = node.cost;
				max_radius = node.getCostRadius();
			}
			
			return;
		}
		
		public function setSearch(searchRevenue:Boolean,searchSpending:Boolean):void {
			_searchRevenue = searchRevenue;
			_searchSpending = searchSpending;
			return;
		}

		/*
		 * Used for sorting highest to lowest
		 */
		public function sort():void {
			_nodes.sort(compareFunction);
			return;
		}
		
		private function compareFunction(x:Node,y:Node):Number{
			return y.cost - x.cost;
		}
		
		/*
		 * Traces the titles of all nodes in the list, for debugging.
		 */
		public function printTitles():void {
			for (var i:int = 0; i < _nodes.length; i++){
				trace("Title: "+_nodes[i].title);
			}
			return;
		}

		// Check if there is room to draw this
		private function fitsOnScreen(local:Point,radius:Number):Boolean{

			var globalPencil:Point;
			var fit:Boolean = true;

			trace("NodeList("+_id+")::drawRow() - drawing at local: "
					+ local.x + "," + local.y);
			globalPencil = localToGlobal(local);
			trace("NodeList("+_id+")::drawRow() - drawing at global: "
					+ globalPencil.x + "," + globalPencil.y);

			if (globalPencil.y > (stage.stageHeight - 2*radius) 
					|| globalPencil.y < -(stage.stageHeight + 2*radius)){
				var txt:TextField = new TextField();
				txt.appendText("...");
				txt.autoSize = TextFieldAutoSize.CENTER;
				txt.x = local.x;
				txt.y = local.y;
				this.addChild(txt);
				fit = false;
			}	

			return fit;
		}

		/*
		 * Draws a row of Nodes onto the display.
		 */
		public function drawNodes(direction:int, start:int):void {
			
			var i:int, ii:int;
			var node:Node;
			var next_radius:Number;
			var radius:Number;
			// Pencil is the current position to draw.
			var pencil_x:Number = 0;
			var pencil_y:Number = 0;


			trace("NodeList("+_id+")::drawRow() - Start drawing all "+length+" nodes");

			// If this is the first draw
			if (!_isDrawn){
				_isDrawn = true;
			}

			radius = _nodes[0].getCostRadius();

			// Determine start location
			switch(start){
				case TOP: pencil_y += radius; break;
				case BOTTOM: pencil_y -= radius; break;
				case RIGHT: pencil_x -= radius; break;
				case LEFT: pencil_x += radius; break;
				default: 
					trace("NodeList("+_id+")::drawNodes()-Error:incorrect start given");
			}

			for (i = 0; i < length; i++){
				
				ii = i + 1;
				node = _nodes[i];
				if (ii < length){
					next_radius = _nodes[ii].getCostRadius();
				} else {
					next_radius = -1;
				}
				
				radius = node.getCostRadius();
				if(!fitsOnScreen(new Point(pencil_x,pencil_y),radius)){
					break;
				}

				node.addEventListener(MouseEvent.ROLL_OVER,manageMouseOver,false,0,true);
				node.doubleClickEnabled = true;
				node.x = pencil_x;
				node.y = pencil_y;
				node.container = this;
				node.drawNode();
				this.addChild(node);

				if (next_radius >= 0){
					switch(direction){
						case DRAW_DOWN: pencil_y += radius + next_radius; break;
						case DRAW_UP: pencil_y -= radius + next_radius; break;
						case DRAW_RIGHT: pencil_x += radius + next_radius; break;
						default: 
							trace("NodeList("+_id+")::drawNodes()-Error:incorrect direction given");
					}
				}	
					
			}
			
			return;
		}
	
 		/*
		 * Bring the node to the front.
		 */
		private function manageMouseOver(event:MouseEvent):void{
  		trace("NodeList("+_id+")::MOUSE_OVER");
			addChild(Node(event.target));	
			return;
		}

		/*
     * If there is a mouse click on a node display both it's spending 
     * and its revenue, if they arent being displayed already.
     */
		public function setupSimpleDisplay(node:Node):void{
  		trace("NodeList("+_id+")::setupSimpleDisplay");

			// Determine if the nodelist is in simple display mode
			if (!_isSimpleDisplay){
				trace("NodeList("+_id+")::setupSimpleDisplay - showing detailed display");
				clearDisplayedNodeLists();
				_isSimpleDisplay = true;
				_isDetailDisplay = false;
			}

			// Display the revenue
			if (_searchRevenue){
				// Check if the revenue is already being displayed
				if (!this.contains(node.revenue)){
					node.revenue.setSearch(false,false);
					node.revenue.sort();
					node.revenue.x = node.x;
					node.revenue.y = node.y - node.getCostRadius() - BUFFER;
					addChild(node.revenue);
					node.revenue.drawNodes(DRAW_UP,BOTTOM);
					_open_nodelists.push(node.revenue);
				}
			}

			// Display the Spending
			if (_searchSpending){
				// Check if the spending is already being displayed
				if (!this.contains(node.spending)){
					node.spending.setSearch(false,false);
					node.spending.sort();
					node.spending.x = node.x;
					node.spending.y = node.y + node.getCostRadius() + BUFFER;
					addChild(node.spending);
					node.spending.drawNodes(DRAW_DOWN,TOP);
					_open_nodelists.push(node.spending);
				}
			}

			trace("NodeList("+_id+")::setupSimpleDisplay - number of "+
				"nodelists being displayed: "+_open_nodelists.length);

			return;
		}

		/*
     * Clear all displayed nodelists and 
     */ 
		public function clearDisplayedNodeLists():void {

			var i:int;
			var nodelist:NodeList;

			trace("NodeList("+_id+")::manageMouseDoubleClick - number of "+
				"nodelists being displayed: "+_open_nodelists.length);
			
			for (i=0;i<_open_nodelists.length;i<0){
				nodelist = _open_nodelists.pop();
				nodelist.clearDisplayedNodeLists();
				removeChild(nodelist);
			}

			return;
		}

		public function setupDetailDisplay(node:Node):void{
  		trace("NodeList("+_id+")::setupDetailDisplay");
	
			// Determine if the nodelist is in detailed display mode
			if (!_isDetailDisplay){
				trace("NodeList("+_id+")::setupDetailDisplay - showing simple display");
				clearDisplayedNodeLists();
				_isSimpleDisplay = false;
				_isDetailDisplay = true;
			}

			// Redraw the nodelists of only the double clicked nodelist
			if (_searchRevenue){
				if (!this.contains(node.revenue)){
					node.revenue.setSearch(true,false);
					node.revenue.sort();
					node.revenue.x = node.x;
					node.revenue.y = node.y - max_radius - BUFFER;
					addChild(node.revenue);
					node.revenue.drawNodes(DRAW_RIGHT,BOTTOM);
					_open_nodelists.push(node.revenue);
					trace(_open_nodelists.length);
				}
			}

			if (_searchSpending){
				if (!this.contains(node.spending)){
					node.spending.setSearch(false,true);
					node.spending.sort();
					node.spending.x = node.x;
					node.spending.y = node.y + max_radius + BUFFER;
					addChild(node.spending);
					node.spending.drawNodes(DRAW_RIGHT,TOP);
					_open_nodelists.push(node.spending);
					trace(_open_nodelists.length);
				}
			}

			return;
		}
		
	}
	
}
