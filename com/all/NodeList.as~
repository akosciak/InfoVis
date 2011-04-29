package com.all {
	
	import com.all.Node;
	import flash.display.Sprite;

	public class NodeList extends Sprite{
	
		// Types of sorts
		public static const HIGH:int = 0;
		public static const LOW:int = 1;
		public static const MIDDLE:int = 3;

		// An ID to give to NodeLists
		private static var NodeListID:int = 0;

		// The Nodes and different stats about them
		protected var _nodes:Vector.<Node>;
		public var length:uint;
		public var max_cost:Number;

		// The NodeLists unique ID
		protected var _id:int;

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
			}
			
			return;
		}

		public function remove(node:Node):void {
			var index:int = _nodes.indexOf(node);
			if (index >= 0){
				_nodes.splice(index,1);
 			} else {
				trace("NodeList::remove() - Error - unable to find ",node.title);
			}
				
			return;
		}

		protected function shiftTo(node:Node):void{

			var i:int;
			var local:Node;

			trace("NodeList::shiftTo - Shifting ...");
			for (i=0;i<_nodes.length;i++){
				if (_nodes[0].isEqualTo(node)){
					trace("NodeList::shiftTo - ",_nodes[0].id,node.id," Found It!");				
					break;
				} else {
					trace("NodeList::shiftTo - ",_nodes[0].id,node.id," shift");		
					local = _nodes.shift();
					_nodes.push(local);
				}
			}

			return;
		}

		/*
     * Sorts the nodelist with the the highest in the middle and 
     * then spreading out on either side.
     * ie. [3]->[5]->[7]<-[6]<-[4]
     */
		private function sortToMiddle():void {
			
			var new_nodes:Vector.<Node> = new Vector.<Node>();
			var node:Node;
			var push:Boolean = true;
			
			// First sort by cost
			_nodes.sort(compareHigh);
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
				node = _nodes.shift();
			}

			_nodes = new_nodes;

			return;
		}

		/*
		 * Used for sorting
		 */
		public function sort(type:int = HIGH):void {

			switch(type){
				case HIGH:
					_nodes.sort(compareHigh); break;
				case LOW:
					_nodes.sort(compareLow); break;
				case MIDDLE:
					sortToMiddle(); break;
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
			trace("NodeList::printTitles() - printing Titles of all nodes");
			for (var i:int = 0; i < _nodes.length; i++){
				trace("Title: "+_nodes[i].title);
			}
			return;
		}

		public function printDetails():void {
			for (var i:int = 0; i < _nodes.length; i++){
				trace("Title:",_nodes[i].title," ID:",_nodes[i].id);
			}
			return;
		}
		
	}
	
}
