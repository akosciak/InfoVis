package com.all {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/*
   * Used in the BudgetGraph to give the node some extra 
   * functionality.
   */
	public class DisplayNode extends Sprite {

		// Display Node States
		public static const NONE:int = 0;
		public static const HALF:int = 1;
		public static const FULL:int = 2;

		// Allowed Searching
		public static const REVENUE:int = 3;
		public static const SPENDING:int = 4;
		public static const ALL:int = 5;

		// Lists the nodes in all 4 directions
		public var up:DisplayNode = null;
		public var down:DisplayNode = null;
		public var right:DisplayNode = null;
		public var left:DisplayNode = null;
		public var node:Node = null;

		// Properties
		public var allowed:int;
		public var state:int;
		public var center:Point;

		/*
		 * Constructors
		 */ 
		public function DisplayNode(node:Node,allowed:int):void{
			// Use the input to initialize the DisplayNode
			this.allowed = allowed;
			this.state = NONE;
			this.center = new Point();
			this.mouseChildren = false;
			this.node = node;
			addChild(node);
			return;
		}

	}
}
