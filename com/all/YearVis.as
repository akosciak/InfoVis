﻿package com.all {
	
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

		private var _width:Number;
		private var _height:Number;

		// The views being shown by the application		private var _budget_graph:BudgetGraph;
		//private var _function_graph:FunctionGraph;

		// Placeholders for the real thing
		private var _bar:PlaceHolder;
		private var _line:PlaceHolder;

/*		private var _budget_bar:BarGraph;		private var _budget_line:LineGraph;		private var _budget_node:NodeGraph;
*/

		public function YearVis(data:BudgetNodeLists,
														width:Number,
														height:Number):void {
			_nodelists = data;
			_width = width;
			_height = height;
			_selected = new NodeList();

			_budget_graph = new BudgetGraph(_nodelists.funds,_width,_height);
			//_bar = new PlaceHolder(_width,_height);
			//_line = new PlaceHolder(_width,_height);
			//_function_graph = new FunctionGraph();
			return;
		}

		// Resize the year visualization
		public function resize(width:Number,height:Number):void {
			_budget_graph.y += (height - _height)/2;
			_width = width;
			_height = height;
			return;
		}

		public function turnOffListeners():void {
			_budget_graph.removeEventListener( MouseEvent.CLICK,
																			budgetGraphClick);
			_budget_graph.turnOffListeners();
			return;
		}

		public function turnOnListeners():void {
			// Listen for selections			_budget_graph.addEventListener( MouseEvent.CLICK,
																			budgetGraphClick,
																			false,0,true);
			_budget_graph.turnOnListeners();			
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
			//drawFunctionGraph();
			//drawBarGraph();
			//drawLineGraph();
			//drawNodeGraph();
			return;		}

		private function drawBudgetGraph():void {
			trace("YearVis::drawBudgetGraph() - drawing the budget graph");	
	
			// Add the Budget Graph
			_budget_graph.x = 0;			_budget_graph.y = 0;			this.addChild(_budget_graph);			_budget_graph.drawBudgetGraph();

			return;
		}

/*
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

			trace("YearVis::drawBarGraph() - Building Bar Graph");		
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

		/*     * Updates the views if a selection was made in the budget graph view     */ 		public function budgetGraphClick(event:MouseEvent):void {			trace("Main::budgetGraphClick() - update the necessary views");			var displayNode:DisplayNode;			
			var node:Node;
			// If the control key is pressed and the target is a Node				  if(event.ctrlKey && event.target is DisplayNode) {	      trace("Main::budgetGraphClick() - Node was selected!");				displayNode = DisplayNode(event.target);
				node = displayNode.node;

				if (node.isHighlighted){
					node.unhighlight();
					_selected.remove(node);
				} else {
					node.highlight();					_selected.push(node);
				}
				_selected.printTitles();		  }									return;		}		/*     * Updates the view if a selection was made in the function graph view     */		public function functionGraphClick(event:MouseEvent):void {			trace("Main::functionGraphClick() - update the necessary views");			// If the control key is pressed and the target is a Node				  if(event.ctrlKey && event.target is Node) {	      trace("Main::functionGraphClick() - Node was selected!");				_selected.push(Node(event.target));
		  }					return;		}
	}
	
}
