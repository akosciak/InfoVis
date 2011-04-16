package  {
	
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
			_my_budget_graph = new BudgetGraph(_my_nodes);
			_my_budget_graph.x = 0;
			_my_budget_graph.y = stage.stageHeight/2;
			this.addChild(_my_budget_graph);
			_my_budget_graph.drawBudgetGraph();
			return;
		}

		private var fundnodes:Vector.<Node>;

		private function loadCompleteHandler(event:LoadCompleteEvent):void {
			_my_nodes = event.lists;
			buildScene();
			//fundnodes = _my_nodes.getFundNodes();
			//stage.addEventListener(MouseEvent.CLICK, onTimer);
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

		/*
		private function drawNodes(nodes:Vector.<Node>,isVertical:Boolean,x:Number,y:Number){
			
			// Make sure there are any nodes
			if (nodes.length > 0){
				
				var j:int;
				var node:Node;
				var area:Number;
				var local_x:Number = pencil_x;
				var local_y:Number = pencil_y;
				var highest_radius:Number = 0;
				var sorted_nodes:Vector.<Node>;
				var width:Number = 0;
				
				// Build some preliminary statistics 
				for (j = 0; j < nodes.length; j++){
					
					node = nodes[j];
					highest_radius = Math.max(node.getCostRadius(),highest_radius);
					width = node.getCostRadius()*2 + width;
				}
				
				if (isVertical){
					local_y -= highest_radius;
				} else {
					local_y += highest_radius;
				}
				
				local_x -= width/2;

				for (j = 0; j < nodes.length; j++){
					
					trace("\tdrawing: "+node.title);
					node = nodes[j];
					
					local_x += node.getCostRadius();
					
					node.x = local_x;
					node.y = local_y;
					
					graphics.lineStyle(2,0x335566);
					graphics.moveTo(x,y);
					graphics.lineTo(node.x,node.y);
					
					addChild(node);
					trace(node.getCostRadius());
					node.drawNode();
					
					local_x += node.getCostRadius();
				}
			}			
			
			return;
		}

		private function onTimer(evt:MouseEvent):void {

			var x:int;
			var area:Number;
			var fund:Node = fundnodes[i];
			var txtFld:TextField = new TextField();
			
			// Remove the children / clear the screen
			graphics.clear();
			for(x = 0; x < this.numChildren; x++){
				var me:DisplayObject = this.getChildAt(x);
				me.visible = false;
			}
			
			// Check if we've looped around the funnodes
			i++;
			if (i == fundnodes.length)
				i = 0;

			trace("drawing: "+fund.title);
			trace(fundnodes.length);
			trace(i);
			
			txtFld.appendText(fund.title+"\n"+fund.cost);
			addChild(txtFld);
			
			pencil_x = stage.stageWidth/2;
			pencil_y = stage.stageHeight/2;
			fund.x = pencil_x;
			fund.y = pencil_y;
			
			pencil_y += fund.getCostRadius();
			fund.spending = sortToMiddle(fund.spending);
			drawNodes(fund.spending,false,fund.x,fund.y);
			pencil_y -= 2*(fund.getCostRadius());
			fund.revenue = sortToMiddle(fund.revenue);
			drawNodes(fund.revenue,true,fund.x,fund.y);
			
			addChild(fund);
			fund.drawNode();
			
			return;
		}
		*/
		
		private function activateHandler(event:Event):void {
			trace("activateHandle: " + event);
		}
		
		private function resizeHandler(event:Event):void {
			trace("resizeHandler: "+event);
			trace("stageWidth: "+stage.stageWidth+" stageHeight: "+stage.stageHeight);
			repositionObjects();
		}

	}
	
}
