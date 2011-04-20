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

		// The views being shown by the application
		private var _function_graph:FunctionGraph;

		// Placeholders for the real thing
		private var _bar:PlaceHolder;
		private var _line:PlaceHolder;

/*
*/

		public function YearVis(data:BudgetNodeLists):void {
			_nodelists = data;
			_budget_graph = new BudgetGraph();
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

		/*
		private function draw():void {

			drawBudgetGraph();
			//drawFunctionGraph();
			//drawBarGraph();
			//drawLineGraph();
			//drawNodeGraph();


		private function drawBudgetGraph():void {
			trace("YearVis::drawBudgetGraph() - drawing the budget graph");	
	
			// Add the Budget Graph
																			stage.stageWidth,
																			stage.stageHeight);
			_budget_graph.x = 0;

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
/*
			_budget_bar = new BarGraph(_selectedNodes);
			_budget_bar.drawBudgetGraph();
*/
			return;
		}

		private function drawLineGraph():void {
			trace("YearVis::buildScene() - Building Line Graph");		
			line.draw(PlaceHolder.LINE);
			addChild(line);
/*
			_budget_line = new LineGraph(_selectedNodes);
*/
			return;
		}

		private function drawNodeGraph():void {
			trace("YearVis::buildScene() - Building Budget Graph");		

/*
*/
			return;
		}

		/*
		  }		

	}
	
}