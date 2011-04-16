package com.all {
	
	import com.all.Node;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.EventPhase;
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;

	public class NodeList extends Sprite{
	
		// Types of sorts
		private static var HIGH:int = 0;
		private static var LOW:int = 1;
		private static var MIDDILE:int = 3;

		// An ID to give to NodeLists
		private static var NodeListID:int = 0;

		//The Nodes and different stats about them
		private var _nodes:Vector.<Node>;
		public var length:uint;
		public var max_cost:Number;
		public var max_radius:Number;

		// The NodeLists unique ID
		private var _id:int;

		public function NodeList():void  {

			// Contained Nodes and Stats
			_nodes = new Vector.<Node>();
			length = 0;
			max_cost = 0;

			// Unique ID
			_id = NodeListID;
			NodeListID++;

			return;
		}

		public function getNodeAt(x:int):Node  {
			return _nodes[x];
		}
		
		public function push(node:Node):void  {
			_nodes.push(node);
			length++;
			
			if (node.cost > max_cost){
				max_cost = node.cost;
				max_radius = node.getCostRadius();
			}
			
			return;
		}

		/*
     * Sorts the nodelist with the the highest in the middle and 
     * then spreading out on either side.
     * ie. [3]->[5]->[7]<-[6]<-[4]
     */
		private function sortToMiddle() {
			
			var new_nodes:Vector.<Node> = new Vector.<Node>();
			var node:Node;
			var push:Boolean = true;
			
			// First sort by cost
			_nodes.sort(compareFunction);
			// Now build a new vector with the highest cost in the middle
			node = _nodes.shift();
			
			// Alternate between front and back of vector
			while(node != null){
				if (push){
					new_nodes.push(node);
					push = false;
				} else {
					new_nodes.unshift(node);
					push = true;
				}
				node = nodes.shift();
			}

			_nodes = new_nodes;

			return;
		}

		/*
		 * Used for sorting
		 */
		public function sort(type:int = HIGH):void {

			switch(type):
				case HIGH:
					_nodes.sort(compareHigh);
				case LOW:
					_nodes.sort(compareLow);
				case MIDDLE:
					sortToMiddle();
				default:
					trace("NodeList::sort() - Error: incorrect input");
			}

			return;
		}
		
		private function compareHigh(x:Node,y:Node):Number{
			return y.cost - x.cost;
		}

		private function compareLow(x:Node,y:Node):Number{
			return x.cost - y.cost;
		}
		
		/*
		 * Traces the titles of all nodes in the list, for debugging.
		 */
		public function printTitles():void {
			for (var i:int = 0; i < _nodes.length; i++){
				trace("Title: "+_nodes[i].title);
			}
			return;
		}
		
	}
	
}
