package com.all {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class YearVis extends MovieClip{

		// DATA: The data behind the application
		// -----------------------------------------------

		private var _nodelists:BudgetNodeLists;
		private var _selected:NodeList;

		// VIEWS: The parts of the application!
		// -----------------------------------------------

		private var _originalWidth:Number;
		private var _originalHeight:Number;
		private var _width:Number;
		private var _height:Number;

		// The views being shown by the application		private var _budget_graph:BudgetGraph;
		private var _function_graph:FunctionGraph;
		private var _box:HoverBox;

		// Placeholders for the real thing
		private var _bar:PlaceHolder;
		private var _line:PlaceHolder;

/*		private var _budget_bar:BarGraph;		private var _budget_line:LineGraph;		private var _budget_node:NodeGraph;
*/

		public function YearVis(data:BudgetNodeLists,
														width:Number,
														height:Number):void {
			_nodelists = data;
			_originalWidth = width;
			_originalHeight = height;
			_width = width;
			_height = height;
			_selected = new NodeList();

			data.createBudgetNode();
			Node.max_cost = data.budgetNode.cost;
			_budget_graph = new BudgetGraph(data.budgetNode,_width,_height);
			_function_graph = new FunctionGraph(data.functions);
			_bar = new BarGraph(_selected,(2/5)*_width,(1/4)*_height);			_line = new LineGraph(_selected,(2/5)*_width,(1/4)*_height);

			return;
		}

		// Resize the year visualization
		public function resize(width:Number,height:Number):void {
			_budget_graph.y += (height - _height)/2;
			_budget_graph.yChange += (height - _height)/2;
			_bar.x = width*(2/5);			_line.x = width*(2/5);
			_width = width;
			_height = height;
			var ratio:Number =  _function_graph.height;
			_function_graph.height = _height - 20;
			ratio = (_function_graph.height/ratio);
			_function_graph.width *= ratio;
			_function_graph.x = _width - _function_graph.width - 10;
			_function_graph.y = 10;

			return;
		}

		public function turnOffListeners():void {
			_budget_graph.removeEventListener( MouseEvent.CLICK,
																			budgetGraphClick);
			_budget_graph.turnOffListeners();
			// Event Listeners for displaying hover boxes (details of the nodes)
			removeEventListener(MouseEvent.MOUSE_OVER, manageMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, manageMouseOut);
			removeEventListener(MouseEvent.MOUSE_MOVE, manageMouseMove);
			return;
		}

		public function turnOnListeners():void {
			// Listen for selections			_budget_graph.addEventListener( MouseEvent.CLICK,
																			budgetGraphClick,
																			false,0,true);
			_budget_graph.turnOnListeners();	
			// Event Listeners for displaying hover boxes (details of the nodes)
			addEventListener(MouseEvent.MOUSE_OVER, manageMouseOver, true, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, manageMouseOut, true, 0, true);
			addEventListener(MouseEvent.MOUSE_MOVE, manageMouseMove, true, 0, true);		
			return;
		}

		// NodeLists getter
		public function getNodeLists():BudgetNodeLists {
			return _nodelists;
		}

		// Button getter
		public function getButton():BudgetNodeLists {
			return _nodelists;
		}

		/*     * Builds and draws each view of the application     */ 
		public function draw():void {			trace("YearVis::draw() - Drawing Scene Views");

/*
			_bar.draw(PlaceHolder.BAR);
			addChild(_bar);
			_line.draw(PlaceHolder.LINE);
			addChild(_line);
*/
			drawBudgetGraph();
			drawFunctionGraph();
			//drawBarGraph();
			//drawLineGraph();
			//drawNodeGraph();
			return;		}

		public function drawBudgetGraph():void {
			trace("YearVis::drawBudgetGraph() - drawing the budget graph");	
	
			// Add the Budget Graph
			_budget_graph.x = 0;			_budget_graph.y = 0;			this.addChild(_budget_graph);			_budget_graph.drawBudgetGraph();

			return;
		}

		private function drawBarGraph():void {			trace("YearVis::drawBarGraph() - Building Bar Graph");					// Add the Bar Graph			_bar.x = _width*(2/5)+30;			_bar.y = 5;			this.addChild(_bar);			_bar.drawBudgetGraph();			return;		}						private function drawLineGraph():void {			trace("YearVis::buildScene() - Building Line Graph");					// Add the Line Graph						_line.x = _width*(2/5)+30;			_line.y = (3/4)*_height-5;			this.addChild(_line);			_line.drawBudgetGraph();			return;		}
		/*		private function drawNodeGraph():void {			trace("YearVis::buildScene() - Building Budget Graph");					// Add the Function Graph			_budget_node = new NodeGraph(_selectedNodes);			_budget_node.x = stage.stageWidth/2;			_budget_node.y = stage.stageHeight*(2/3);			this.addChild(_budget_node);			_budget_node.drawBudgetGraph();			return;		}
		*/

		private function drawFunctionGraph():void {
			trace("YearVis::drawFunctionGraph() - drawing the function graph");	
	
			// Add the Function Graph			this.addChild(_function_graph);			_function_graph.drawFunctionGraph();
			var ratio:Number =  _function_graph.height;
			_function_graph.height = _height - 20;
			ratio = (_function_graph.height/ratio);
			_function_graph.width *= ratio;
			_function_graph.x = _width - _function_graph.width - 10;
			_function_graph.y = 10;

			return;
		}

		/*
     * Updates the views if a selection was made in the budget graph view     */ 		public function budgetGraphClick(event:MouseEvent):void {			trace("Main::budgetGraphClick() - update the necessary views");			var displayNode:DisplayNode;						var node:Node;			// If the control key is pressed and the target is a Node			  if(event.ctrlKey && event.target is DisplayNode) {	      trace("Main::budgetGraphClick() - Node was selected!");				displayNode = DisplayNode(event.target);				node = displayNode.node;				if (node.isHighlighted){					node.unhighlight();					_selected.remove(node);					//graphics clear				} else {					node.highlight();					_selected.push(node);				}								_bar.updates(_selected);				//_line.updates(_selected);				//drawLineGraph();				drawBarGraph();				_selected.printTitles();		  }								  		  //when a certain node is selected to view different years		  if(event.altKey && event.target is DisplayNode) {		      trace("AltKey + Click detected");				_line.updates(_selected);				drawLineGraph();				_selected.printTitles();		  }									return;		}
		/*     * Updates the view if a selection was made in the function graph view     */		public function functionGraphClick(event:MouseEvent):void {			trace("Main::functionGraphClick() - update the necessary views");			// If the control key is pressed and the target is a Node				  if(event.ctrlKey && event.target is Node) {	      trace("Main::functionGraphClick() - Node was selected!");				_selected.push(Node(event.target));
		  }					return;		}

 		/*
		 * Show the details of a node when the user hovers over it.
		 */
		public function manageMouseOver(event:MouseEvent):void{
			if (event.target is DisplayNode && _box == null){
				_box = new HoverBox(DisplayNode(event.target).node);
				_box.draw();
				addChild(_box);
			}
			return;
		}
 
		public function manageMouseOut(event:MouseEvent):void{
			if (_box != null && event.target is DisplayNode){
				removeChild(_box);
				_box = null;
			}
			return;
		}

		private function setBoxAtMouse():void {
			
			if (_box != null){
				_box.x = stage.mouseX;
				_box.y = stage.mouseY;
			}

			return;
		}

		private function manageMouseMove(event:MouseEvent):void{
			var target:* = event.target;
			if (_box && event.target is DisplayNode){
				_box.x = stage.mouseX;
				_box.y = stage.mouseY;
			}
			return;
		}
	}
	
}
