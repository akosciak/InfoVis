package com.all {
	
	import flash.display.Sprite;
	
	public class BudgetGraph extends Sprite{

		// The node that has current focus
		private var _centralNode:Node;
		private var _width:Number;
		private var _height:Number;
			
		/*
     * Constructor, the Nodelist given is used as the rootNodeList
     */
		public function BudgetGraph(rootNodes:NodeList,width:Number,height:Number):void {
			_width = width;
			_height = height;
			DisplayNodeList.drawList(rootNodes,DisplayDirection.RIGHT,DisplayStartLoc.LEFT);
			
		}

		public function 

		// Sets all nodes in the List to be horizontal with eachother.
		public function setHorizontal(rootNodes:NodeList){
			
		}

	}
	
}
