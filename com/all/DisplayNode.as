package com.all {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/*
   * Used in the BudgetGraph to give the node some extra 
   * functionality.
   */
	public class DisplayNode extends Node{

		// Lists the nodes in all 4 directions
		private var _upNodes:NodeList;
		private var _downNodes:NodeList;
		private var _rightNodes:NodeList;
		private var _leftNodes:NodeList;

		/*
		 * Constructors
		 */ 
		public function DisplayNode(node:Node):void{
			// Use the input to initialize the DisplayNode
			super(node.title,node.id,node.cost,node.costtype,node.type);

			// Setup the direction NodeLists
			_upNodes = new NodeList();
			_downNodes = new NodeList();
			_rightNodes = new NodeList();
			_leftNodes = new NodeList();

			return;
		}

	}
}
