package com.all {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Node extends Sprite{

		// Node Type Constants
		public static const REVENUE_SOURCE:int = 0;
		public static const REVENUE_SUBSECTION:int = 1;
		public static const REVENUE_SECTION:int = 2;
		public static const FUND:int = 3;
		public static const FUNCTION:int = 4;
		public static const DEPARTMENT:int = 5;
		public static const DEPARTMENT_SUBSECTION:int = 6;
		public static const TOTAL_APPROPRIATIONS:int = 7;
		public static const TOTAL_POSITIONS:int = 8;
		public static const POSITION_SECTION:int = 9;
		public static const POSITION_SUBSECTION:int = 10;
		public static const POSITION:int = 11;
		public static const APPROPRIATION_SECTION:int = 12;
		public static const APPROPRIATION:int = 13;
		public static const UNKNOWN:int = -1;

		public static const TITLE:String = "title"; 
		public static const ID:String = "id"; 
		public static const COST:String = "cost"; 
		public static const COSTTYPE:String = "costtype"; 
		public static const TYPE:String = "type"; 

		// Global Node Properties
		public static var max_cost:Number = 0;
		public static var multiplier:Number = 100;

		// Node Properties
		public var title:String;
		public var id:String;
		public var cost:Number;
		public var costtype:String;
		public var type:int;
		
		private var _radius:Number;
		private var _isDrawn:Boolean;		

		public var revenue:DisplayNodeList = null;
		public var spending:DisplayNodeList = null;
		public var container:DisplayNodeList = null;

		/*
		 * Constructor
		 */ 
		public function Node(title:String="",id:String="",cost:Number=0,
							 costtype:String="",type:int=UNKNOWN):void{
			this.title = title;
			this.id = id;
			this.cost = cost;
			this.costtype = costtype;
			this.type = type;
			
			_radius = 0;
			
			revenue = new DisplayNodeList();
			spending = new DisplayNodeList();
			
			this.mouseChildren = false;
			doubleClickEnabled = true;

			addEventListener(MouseEvent.MOUSE_DOWN,manageMouseClick,false,0,true);
			addEventListener(MouseEvent.DOUBLE_CLICK,manageMouseDoubleClick,false,0,true);

			return;
		}

		public function isEqualTo(node:Node):Boolean {

			var isEqual:Boolean = false;

			if (this.id == node.id){
				isEqual = true;
			}

			return isEqual;
		}

		public function drawNode(alpha:Number = 0.5):void {

			// If the radius isn't set already 
			if (!_radius){
				setCostRadius();
			}
	
			if (!_isDrawn){
				_isDrawn = true;
				trace("Node::drawNode() - drawing the node");
				graphics.lineStyle();
				graphics.beginFill(0xFF0000,alpha);
				graphics.drawCircle(0,0,_radius);
				graphics.endFill();		
			}

			return;
		}

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
				trace("Node::getCostRadius - ERROR:Maximum cost has not been set");
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

		private var _isDetailed:Boolean = false;

		/*
     * If there is a mouse click on a node display both it's spending 
     * and its revenue, if they arent being displayed already.
     */
		private function manageMouseClick(event:MouseEvent):void{
  		trace("Node::MOUSE_CLICK");
			if (!_isDetailed){
				var node:Node = Node(event.target);
				container.setupSimpleDisplay(node);
			}
			return;
		}

		private function manageMouseDoubleClick(event:MouseEvent):void{
  		trace("Node::DOUBLE_CLICK");
			var node:Node = Node(event.target);
			var type:int;
		
			// If either is empty, then this node is the end of some line
			if (node.spending.length > 0 && node.revenue.length > 0){

				trace("Node::manageMouseDoubleClick - ",node.title);
				type = node.spending.getNodeAt(0).type;
				if (type == POSITION){
					trace("Node::manageMouseDoubleClick - next node is a position");
				} else if (type == APPROPRIATION){
					trace("Node::manageMouseDoubleClick - next node is an appropriation");
				}

				if (_isDetailed){
					_isDetailed = false;
					container.setupSimpleDisplay(node)
				} else {
					container.setupDetailDisplay(node);
					_isDetailed = true;
				}
			} else {
				trace("Node::manageMouseDoubleClick - end of the line");
			}

			return;
		}

	}
}
