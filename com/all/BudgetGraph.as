package com.all {
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	
	public class BudgetGraph extends Sprite{

		private var _lists:BudgetNodeLists;

		public function BudgetGraph(lists:BudgetNodeLists):void  {
			// constructor code
			trace("BudgetGraph::BudgetGraph() - Constructing the Budget Graph");
			
			// Set some preliminary properties for drawing nodes
			Node.max_cost = lists.all.max_cost;
			Node.multiplier = 25000;
			
			_lists = lists;
			return;
		}

		public function drawBudgetGraph():void {
			
			var nodes:NodeList = _lists.funds;
			var revenue_btn:BudgetButton;
			var spending_btn:BudgetButton;

			//revenue_btn = new BudgetButton(100,15,2,1,0xFFFFFF,"REVENUE",0x000000);
			//spending_btn = new BudgetButton(100,15,2,1,0xFFFFFF,"SPENDING",0x000000);
			
			trace("BudgetGraph::drawBudgetGraph() - drawing the budget graph");
			//revenue_btn.x = 5;		
			//revenue_btn.y = -stage.stageHeight-50;
			//spending_btn.y = stage.stageHeight+50;
			//spending_btn.x = 5;
			//addChild(revenue_btn);
			//addChild(spending_btn);

			nodes.setSearch(true,true);
			nodes.sort();
			nodes.x = 15;
			nodes.y = 0;
			this.addChild(nodes);
			nodes.drawNodes(NodeList.DRAW_RIGHT,NodeList.LEFT);
			
			addEventListener(MouseEvent.MOUSE_DOWN,manageMouseDown,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP,manageMouseUp,false,0,true);

			return;
		}

		private function manageMouseDown(event:MouseEvent):void{
  		trace("BudgetGraph::MOUSE_DOWN");
		
			// While the mouse is down if you move then move the screen in a fish-eye way

			return;
		}

		private function manageMouseUp(event:MouseEvent):void{
  		trace("BudgetGraph::MOUSE_UP");
		
			// While the mouse is down if you move then move the screen in a fish-eye way

			return;
		}

	}
	
}
