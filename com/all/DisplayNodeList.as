package com.all {

	
	/*
   * A node list used for display in the budget and functions graphs.
   */
	public class DisplayNodeList extends NodeList {

    // Constants
 		// --------------------------------------------------------------		

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

		// The amount of space between to give a new nodelist drawing
		public static const BUFFER:int = 4;

		// Class Variables
		// --------------------------------------------------------------

		// Properties that keep track of the state of the NodeList Drawing
		private var _open_nodelists:Array;
		private var _isDrawn:Boolean;
		private var _isSimpleDisplay:Boolean;
		private var _isDetailDisplay:Boolean;

		// Allow searching (display on click/double-click) of subnodelists
		private var _searchSpending:Boolean;
		private var _searchRevenue:Boolean;

		public function DisplayNodeList():void {
			super();

			// State Variables
			_open_nodelists = new Array();
			_isDrawn = false;
			_isSimpleDisplay = true;
			_isDetailDisplay = false;

			// Set whether we are allowed to dig into these
			_searchSpending = true;
			_searchRevenue = true;

			// DisplayObject Properties
			doubleClickEnabled = true;

			return;
		}

		/*
     * Allow searching of subnodelists
     */
		public function setSearch(searchRevenue:Boolean,searchSpending:Boolean):void {
			_searchRevenue = searchRevenue;
			_searchSpending = searchSpending;
			return;
		}

    /*
     * Drawing to show that there is no room to draw a new node.
     */ 
		private function drawNoRoom(x:int,y:int){

			// My current solution to the problem...
			var txt:TextField = new TextField();
			txt.text = "...";

			// Makes it easier to see how it fits into the view
			txt.background = true
			txt.backgroundColor = 0xFFFFFF;
			txt.border = true;
			txt.borderColor = 0x000000;

			trace("DisplayNodeList::drawNoRoom() - pre autosize: "+txt.height+","+txt.width");
			txt.autoSize = TextFieldAutoSize.CENTER;
			trace("DisplayNodeList::drawNoRoom() - post autosize: "+txt.height+","+txt.width");
			txt.x = x;
			txt.y = y;
			this.addChild(txt);

			return;
		}

		/*
     * Checks if the point is out of bounds.
     */
		private function fitsInView(local:Point):Boolean{

			var fits:Boolean = true;

			if ( (local.y > this.height) || 
					 (local.x > this.width ) || 
					 (local.y < 0          ) || 
					 (local.x < 0          ) 		){
				fits = false;
			}	

			return fits;
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

			// Determine start location
			radius = _nodes[0].getCostRadius();
			switch(start){
				case TOP: pencil_y += radius; break;
				case BOTTOM: pencil_y -= radius; break;
				case RIGHT: pencil_x -= radius; break;
				case LEFT: pencil_x += radius; break;
				default: 
					trace("NodeList("+_id+")::drawNodes()-Error:incorrect start given");
			}

			// Draw each node
			for (i=0; i < length; i++){
				
				node = _nodes[i];
				radius = node.getCostRadius();

				// Draw the node
				node.addEventListener(MouseEvent.ROLL_OVER,manageMouseOver,false,0,true);
				node.doubleClickEnabled = true;
				node.x = pencil_x;
				node.y = pencil_y;
				node.container = this;
				node.drawNode();
				this.addChild(node);

				// If there is another node that can be drawn, than set the new drawing position
				if (i+1 < length){

					var fits:Boolean;
					next_radius = _nodes[ii].getCostRadius();

					switch(direction){
						case DRAW_DOWN: 
							pencil_y += radius + next_radius;
							fits = fitsInView(new Point(pencil_x+2*radius,pencil_y));
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
