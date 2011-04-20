package com.all {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FunctionGraph extends DisplayNodeList{

		private var _box:HoverBox;

		public function FunctionGraph():void {
			super();
			addEventListener(MouseEvent.MOUSE_DOWN,manageMouseClick,true,0,true);
			// Event Listeners for displaying hover boxes (details of the nodes)
			addEventListener(MouseEvent.MOUSE_OVER, manageMouseOver, true, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, manageMouseOut, true, 0, true);
			addEventListener(MouseEvent.MOUSE_MOVE, manageMouseMove, true, 0, true);
			return;
		}
	
		private function manageMouseClick(event:MouseEvent):void{
  		trace("FunctionGraph::MOUSE_CLICK");
			// Set the budgetGraph to simple open for all!
			// For the function node, highlight all of its spending children
			return;
		}

		public function manageMouseOver(event:MouseEvent):void{
  		trace("FunctionGraph::MOUSE_OVER");
			if (event.target is Node && _box == null){
				_box = new HoverBox(Node(event.target));
				_box.draw();
				addChild(_box);
			}
			return;
		}

		public function manageMouseOut(event:MouseEvent):void{
  		trace("FunctionGraph::MOUSE_OUT");
			if (_box != null && event.target is Node){
				removeChild(_box);
				_box = null;
			}
			return;
		}

		private function manageMouseMove(event:MouseEvent):void{
  		trace("FunctionGraph::MOUSE_MOVE");
			var target:* = event.target;
			if (_box && event.target is Node){
				_box.x = stage.mouseX;
				_box.y = stage.mouseY;
			}
			return;
		}

	}
	
}
