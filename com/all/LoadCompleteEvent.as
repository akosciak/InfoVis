package com.all {
	
	import flash.events.*;
	
	import com.all.NodeList;
	
	public class LoadCompleteEvent extends Event {

		public static const LD_COMPLETE:String = "load_complete";
		public var lists:BudgetNodeLists;

		public function LoadCompleteEvent(type:String,
										  bubbles:Boolean = false,
										  cancelable:Boolean = false,
										  lists:BudgetNodeLists = null):void  {
			// constructor code
			trace("LoacCompleteEvent::LoadCompleteEvent()-> creating new load complete event");
			super(type, bubbles, cancelable);
			this.lists = lists;
			return;
		}
		
		public override function clone():Event {
			return new LoadCompleteEvent(type, bubbles, cancelable, lists);
		}
		
		public override function toString():String {
			return formatToString("LoadCompleteEvent","type","bubbles",
								  "cancelable","eventPhase","nodes");
		}

	}
	
}
