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
		public static const DEPARTMENT:int = 4;
		public static const DEPARTMENT_SUBSECTION:int = 5;
		public static const TOTAL_APPROPRIATIONS:int = 6;
		public static const TOTAL_POSITIONS:int = 7;
		public static const POSITION_SECTION:int = 8;
		public static const POSITION_SUBSECTION:int = 9;
		public static const POSITION:int = 10;
		public static const APPROPRIATION_SECTION:int = 11;
		public static const APPROPRIATION:int = 12;
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
		public var isDrawn:Boolean;
		
		public var revenue:NodeList = null;
		public var spending:NodeList = null;
		public var container:NodeList = null;
		private var box:HoverBox = null;

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
			
			revenue = new NodeList();
			spending = new NodeList();
			
			this.mouseChildren = false;
			addEventListener(MouseEvent.ROLL_OVER, manageMouseOver, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, manageMouseOut, false, 0, true);
			addEventListener(MouseEvent.MOUSE_MOVE, manageMouseMove, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN,manageMouseClick,false,0,true);
			addEventListener(MouseEvent.DOUBLE_CLICK,manageMouseDoubleClick,false,0,true);
			
			return;
		}

		public function drawNode():void {

			// If the radius isn't set already 
			if (!_radius){
				setCostRadius();
			}
			
			if (!isDrawn){
				
				trace("Node::drawNode() - drawing the node");
				graphics.lineStyle();
				graphics.beginFill(0xFF0000,0.5);
				graphics.drawCircle(0,0,_radius);
				graphics.endFill();		
				isDrawn = true;
			} else {
				trace("Node::drawNode() - already drawn making it visible");
				this.visible = true;
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
 
 		/*
		 * Show the details of the node when the user hovers over it.
		 */
		private function manageMouseOver(event:MouseEvent):void{

			if (!box){
				box = new HoverBox(this);
			} 

			box.draw();
			addChild(box);
	
			return;
		}
 
		private function manageMouseOut(event:MouseEvent):void{
  		//your out code here
			removeChild(box);
			box = null;

			return
		}

		private function manageMouseMove(event:MouseEvent):void{

			var target:* = event.target;

			if (box){
				box.x = target.mouseX;
				box.y = target.mouseY;
			}
		}

		/*
     * If there is a mouse click on a node display both it's spending 
     * and its revenue, if they arent being displayed already.
     */
		private function manageMouseClick(event:MouseEvent):void{
  		trace("Node::MOUSE_CLICK");
			var node:Node = Node(event.target);
			container.setupSimpleDisplay(node);
			return;
		}

		private function manageMouseDoubleClick(event:MouseEvent):void{
  		trace("Node::DOUBLE_CLICK");
			var node:Node = Node(event.target);
			container.setupDetailDisplay(node);
			return;
		}
		
	}
}
