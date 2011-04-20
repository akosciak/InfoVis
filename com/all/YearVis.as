package com.all {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class YearVis extends MovieClip{

		// DATA: The data behind the application
		// -----------------------------------------------

		private var _nodelists:BudgetNodeLists;
		private var _selected:NodeList;

		// VIEWS: The parts of the application!
		// -----------------------------------------------

		// The views being shown by the application		//private var _budget_graph:BudgetGraph;
		//private var _function_graph:FunctionGraph;

		// Placeholders for the real thing
		//private var _bar:PlaceHolder;
		//private var _line:PlaceHolder;

/*		private var _budget_bar:BarGraph;		private var _budget_line:LineGraph;		private var _budget_node:NodeGraph;
*/

		public function YearVis(data:BudgetNodeLists):void {
			_nodelists = data;
			//_budget_graph = new BudgetGraph();
			//_bar = new PlaceHolder();
			//_line = new PlaceHolder();
			//_function_graph = new FunctionGraph();
			return;
		}

		// Resize the year visualization
		public function resize():void {
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
		private function draw():void {			trace("YearVis::draw() - Drawing Scene Views");

			//drawBudgetGraph();
			//drawFunctionGraph();
			//drawBarGraph();
			//drawLineGraph();
			//drawNodeGraph();
			return;		}

/*
		private function drawBudgetGraph():void {
			trace("YearVis::drawBudgetGraph() - drawing the budget graph");	
	
			// Add the Budget Graph			_budget_graph = new BudgetGraph(_nodelists.funds,
																			stage.stageWidth,
																			stage.stageHeight);
			_budget_graph.x = 0;			_budget_graph.y = 0;			this.addChild(_budget_graph);			_budget_graph.drawBudgetGraph();			// Listen for selections			_budget_graph.addEventListener(MouseEvent.MOUSE_DOWN,budgetGraphClick,false,0,true);

			return;
		}

		private function drawFunctionGraph():void {
			trace("YearVis::buildScene() - Building Function Graph");		

			_nodelists.functions.setSearch(false,false);
			_nodelists.functions.sort();
			_nodelists.functions.x = stage.stageWidth*9/10;
			_nodelists.functions.y = 0;

			addChild(_nodelists.functions);
			_nodelists.functions.drawNodes(DisplayNodeList.DRAW_DOWN,
				DisplayNodeList.TOP,1.0);

			return;
		}

		private function drawBarGraph():void {

			trace("YearVis::buildScene() - Building Bar Graph");		
			// Add the Bar Graph
			bar.draw(PlaceHolder.BAR);
			addChild(bar);

			_budget_bar = new BarGraph(_selectedNodes);			_budget_bar.x = stage.stageWidth/2;			_budget_bar.y = stage.0;			this.addChild(_budget_bar);
			_budget_bar.drawBudgetGraph();

			return;
		}

		private function drawLineGraph():void {
			trace("YearVis::buildScene() - Building Line Graph");					// Add the Line Graph			
			line.draw(PlaceHolder.LINE);
			addChild(line);

			_budget_line = new LineGraph(_selectedNodes);			_budget_line.x = stage.stageWidth/2;			_budget_line.y = stage.stageHeight*(1/3);			this.addChild(_budget_line);			_budget_line.drawBudgetGraph();

			return;
		}

		private function drawNodeGraph():void {
			trace("YearVis::buildScene() - Building Budget Graph");		

			// Add the Function Graph			_budget_node = new NodeGraph(_selectedNodes);			_budget_node.x = stage.stageWidth/2;			_budget_node.y = stage.stageHeight*(2/3);			this.addChild(_budget_node);			_budget_node.drawBudgetGraph();

			return;
		}

		/*     * Updates the views if a selection was made in the budget graph view     */ 		public function budgetGraphClick(event:MouseEvent):void {			trace("Main::budgetGraphClick() - update the necessary views");						// If the control key is pressed and the target is a Node				  if(event.ctrlKey && event.target is Node) {	      trace("Main::budgetGraphClick() - Node was selected!");				//TODO: Figure out if the node is already contained in the selected list.				//TODO: Make sure the graph highlights the node that was selected.				_selected.push(Node(event.target));		  }									return;		}		/*     * Updates the view if a selection was made in the function graph view     */		public function functionGraphClick(event:MouseEvent):void {			trace("Main::functionGraphClick() - update the necessary views");			// If the control key is pressed and the target is a Node				  if(event.ctrlKey && event.target is Node) {	      trace("Main::functionGraphClick() - Node was selected!");				_selected.push(Node(event.target));
		  }					return;		}
	}
	
}
