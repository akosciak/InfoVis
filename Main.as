﻿package  {
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import com.all.Node;
	import com.all.DataImporter;
	import com.all.LoadCompleteEvent;
	import flash.events.*;
	import com.all.NodeList;
	import flash.utils.Timer;
	
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import com.all.BudgetGraph;
	import com.all.BudgetNodeLists;
	
	public class Main extends Sprite{
		
		private var _my_node:Node;
		private var _my_nodes:BudgetNodeLists;
		private var _my_budget_graph:BudgetGraph;

		public function Main() {
			trace("Main Sprite Created");
			
			pencil_x = 0;
			pencil_y = 0;
			
			// Import Data
			var importer:DataImporter = new DataImporter();
			importer.addEventListener(LoadCompleteEvent.LD_COMPLETE,
									  loadCompleteHandler);
			importer.importGraphML("graphml.xml");
			
			// Set the stage properties
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.ACTIVATE, activateHandler);
			stage.addEventListener(Event.RESIZE, resizeHandler);
			
			// Going to just wait for load to complete...
			return;
		}
		
		// Repositions my single node
		public function repositionObjects():void {
			_my_budget_graph.x = 0;
			_my_budget_graph.y = stage.stageHeight/2;
		}

		private function buildScene():void {

			// Add the Bar Graph
			_bar_graph = new BarGRaph(_selected_nodes);

			// Add the Line Graph			

			// Add the Function Graph

			// Add the Budget Graph
			_my_budget_graph = new BudgetGraph(_my_nodes);
			_my_budget_graph.x = 0;
			_my_budget_graph.y = stage.stageHeight/2;
			this.addChild(_my_budget_graph);
			_my_budget_graph.drawBudgetGraph();

			// Listen for Node Selection so you can make the necessary changes
			addEventListener(MouseEvent.MOUSE_DOWN,manageMouseDown,false,0,true);
			return;
		}

		private var fundnodes:Vector.<Node>;

		private function loadCompleteHandler(event:LoadCompleteEvent):void {
			_my_nodes = event.lists;
			buildScene();
			return;
		}

		private var pencil_x:Number;
		private var pencil_y:Number;
		private var i:int = 0;

		public function compareFunction(x:Node,y:Node):Number {
			return y.cost - x.cost;
		}

		private function sortToMiddle(nodes:Vector.<Node>):Vector.<Node> {
			
			var new_nodes:Vector.<Node> = new Vector.<Node>();
			var node:Node;
			var push:Boolean = true;
			
			// First sort by cost
			nodes.sort(compareFunction);
			// Now build a new vector with the highest cost in the middle
			node = nodes.shift();
			
			// Alternate between front and back of vector
			while(node != null){
				trace(node.cost);
				if (push){
					new_nodes.push(node);
					push = false;
				} else {
					new_nodes.unshift(node);
					push = true;
				}
				node = nodes.shift();
			}

			return new_nodes;
		}

		
		private function activateHandler(event:Event):void {
			trace("activateHandle: " + event);
		}
		
		private function resizeHandler(event:Event):void {
			trace("resizeHandler: "+event);
			trace("stageWidth: "+stage.stageWidth+" stageHeight: "+stage.stageHeight);
			repositionObjects();
		}

		private function manageMouseDown(event:MouseEvent):void{
  		trace("Main::MOUSE_DOWN");
			
			// If the control key is pressed and the target is a Node		
		  if(e.ctrlKey && event.Target is Node) {
	      trace("Main::manageMouseDown() - Node was selected!");
		  }

			return;
		}

	}
	
}
