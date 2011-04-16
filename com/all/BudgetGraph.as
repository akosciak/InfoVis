package com.all {
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	
	public class BudgetGraph extends Sprite{

		private static const FISH_EYE_TIMER:int = 100;
		private static const SIZE_MULTIPLIER:Number = 250000;

		private var _timer:Timer;
		private var _root_nodes:DisplayNodeList;

		public function BudgetGraph(nodes:DisplayNodeList):void  {
			// constructor code
			trace("BudgetGraph::BudgetGraph() - Constructing the Budget Graph");
			
			// The Root Node List drawn first (should be the Funds)
			_root_nodes = nodes;

			// Setup the fish eye timer
			_timer = new Timer();
			_timer.delay = FISH_EYE_TIMER;
			_timer.repeatCount = 0;
			_timer.addEventListener(TimerEvent.TIMER,updateFishEye);

			// Set the Node properties that will determine the size of the drawing
			Node.max_cost = _root_nodes.max_cost;
			Node.multiplier = SIZE_MULTIPLIER;
			
			return;
		}

		/*
     * Draw the budget graph.
     */ 
		public function drawBudgetGraph():void {
			
			trace("BudgetGraph::drawBudgetGraph() - drawing the budget graph");

			_root_nodes.setSearch(true,true);
			_root_nodes.sort(HIGH);
			_root_nodes.x = 15;
			_root_nodes.y = 0;
			this.addChild(_root_nodes);
			_root_nodes.drawNodes(DisplayNodeList.DRAW_RIGHT,DisplayNodeList.LEFT);
			
			// Set the listeners for the fish-eye timer
			addEventListener(MouseEvent.MOUSE_DOWN,manageMouseDown,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP,manageMouseUp,false,0,true);

			return;
		}

		/*
     * Click and Hold Event Handling to redraw with a fish eye.
     */
		private function manageMouseDown(event:MouseEvent):void{
  		trace("BudgetGraph::MOUSE_DOWN");
			_timer.start;
			return;
		}

		private function manageMouseUp(event:MouseEvent):void{
  		trace("BudgetGraph::MOUSE_UP");
			_timer.stop;
			return;
		}

		/*
     * Zoom in or out, depending on the direction of movement.
     */
		private function updateFishEye(event:TimerEvent):void {
			trace("BudgetGraph::updateFishEye() - BANG!");
			return;			
		}

	}
	
}
