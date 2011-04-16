package com.all {
	
	import flash.events.*;
	
	import com.all.NodeList;
	
	public class NodeHover extends Event {

		public static const NODE_HOVER:String = "node_hover";
		public var node:Node;

		public function NodeHoverEvent(type:String,
										  bubbles:Boolean = false,
										  cancelable:Boolean = false,
										  node:Node = null):void  {
			// constructor code
			trace("NodeHoverEvent::NodeHoverEvent()-> creating new node hover event");
			super(type, bubbles, cancelable);
			this.node = node;
			return;
		}
		
		public override function clone():Event {
			return new NodeHoverEvent(type, bubbles, cancelable, node);
		}
		
		public override function toString():String {
			return formatToString("NodeHoverEvent","type","bubbles",
								  "cancelable","eventPhase","nodes");
		}

	}
	
}
