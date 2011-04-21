package com.all {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Node extends Sprite {

		// Global Node Properties
		public static var max_cost:Number = 0;
		public static var multiplier:Number = 1000;

		// Node Properties
		public var title:String;
		public var id:String;
		public var cost:Number;
		public var costtype:String;
		public var type:int;
		
		private var _radius:Number;
		private var _alpha:Number;
		private var _highlightAlpha:Number;
		private var _color:Number;
		private var _highlightColor:Number;
		private var _highlightThickness:Number;

		// Some state variables
		private var _isDrawn:Boolean;		
		public var isHighlighted:Boolean;

		// Nodes that it is linked to in the budget
		public var revenue:NodeList = null;
		public var spending:NodeList = null;

		/*
		 * Constructor
		 */ 
		public function Node(title:String="",id:String="",cost:Number=0,
							 costtype:String="",type:int=NodeType.UNKNOWN):void{

			// Set the data properties
			this.title = title;
			this.id = id;
			this.cost = cost;
			this.costtype = costtype;
			this.type = type;
			
			// Set the display properties
			_radius = 0;
			_alpha = 1.0;
			_color = 0x000000;
			_highlightAlpha = 1.0;
			_highlightColor = 0xFF0000;
			_highlightThickness = 5;
			
			// More properties
			_isDrawn = false;
			isHighlighted = false;

			// Connections to other nodes
			revenue = new NodeList();
			spending = new NodeList();
			
			return;
		}

		/*
     * Returns a copy of the this node, with the same properties.
     */
		public function copy():Node {
			var node:Node = new Node(title,id,cost,costtype,type);
			return node;
		}

		/*
     * Determines if the ID's are equal.
     */
		public function isEqualTo(node:Node):Boolean {

			var isEqual:Boolean = false;

			if (this.id == node.id){
				isEqual = true;
			}

			return isEqual;
		}

		public function clear():void {
			graphics.clear();
			return;
		}

		public function unhighlight():void {
			if (!_isDrawn){
				trace("Node::highlight() - node must be drawn before unhighlighting");
			} else {
				isHighlighted = false;
				_draw();
			}
			return;
		}

		/*
     * Surrounds a currently drawn Node with a highlight!
     */		
		public function highlight():void {
			if (!_isDrawn){
				trace("Node::highlight() - node must be drawn before highlighting");
			} else {
				isHighlighted = true;
				_draw();
			}
			return;
		}

		private function _draw():void {

			graphics.clear();

			// Set the highlight
			if (isHighlighted){
				graphics.lineStyle(	_highlightThickness,
														_highlightColor,
														_highlightAlpha);		
			} else {
				graphics.lineStyle();
			}

			// Draw the node circle
			graphics.beginFill(_color,_alpha);
			graphics.drawCircle(0,0,_radius);
			graphics.endFill();		

			return;
		}

		/*
     * Draws the node (circle).
     */
		public function draw():void {

			// If the radius isn't set already 
			if (!_radius){
				setCostRadius();
			}
	
			if (!_isDrawn){
				_isDrawn = true;
				_draw();
			} else {
				graphics.clear();
				_draw();
			}

			return;
		}

		/*
     * Add nodes that are connected.
     */
		public function addRevenue(node:Node):void {
			revenue.push(node);
			return;
		}
		
		public function addSpending(node:Node):void {
			spending.push(node);
			return;
		}
		
		/*
		 * Sets the cost radius using the global max_cost and multipliers to 
		 * determine size.
		 */
		public function setCostRadius():void {
			
			var area:Number;
			
			// Make sure that the max cost is set
			if (!Node.max_cost){
				trace("Node::getCostRadius - ERROR: Maximum cost has not been set");
			} else {
				area = (Math.abs(this.cost)/Node.max_cost)*Node.multiplier;
				_radius = Math.sqrt(area/Math.PI);
			}			
			return;
		}
		
		/*
		 * Returns the radius 
		 */
		public function getCostRadius():Number {
		
			// If the node isn't set already 
			if (!_radius){
				setCostRadius();
			}
			
			return _radius;
		}
	}
}
