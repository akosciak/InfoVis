package com.all {
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Matrix;

	public class BudgetGraph extends Sprite{

		// KeyBoard Event KeyCodes
		private static const UP:int = 87;
		private static const DOWN:int = 83;
		private static const LEFT:int = 65;
		private static const RIGHT:int = 68;
	
		// Ways to organize using processors
		private var _drawProcessor:DrawProcessor;
		private var _clearProcessor:ClearProcessor;
		private var _allProcessor:AllProcessor;
		private var _spendingProcessor:SpendingProcessor;
		private var _revenueProcessor:RevenueProcessor;

		// The node that has current focus
		private var _centralRadius:Number = 100; 
		// the radius that each central node needs to conform to
		private var _centralNode:DisplayNode;
		private var _centralScale:Number = 1.0;
		private var _centralPoint:Point;
		private var _originalPoint:Point;
		public var yChange:Number;

		private var _rootNode:Node;
		private var _width:Number;
		private var _height:Number;
			
		private static var test:Boolean = false;
		private var _test:Boolean = false;

		/*
     * Constructor, the Nodelist given is used as the rootNodeList
     */
		public function BudgetGraph(rootNode:Node,width:Number,height:Number):void {
			_drawProcessor = new DrawProcessor(this);
			_clearProcessor = new ClearProcessor(this);
			_allProcessor = new AllProcessor(_drawProcessor,_clearProcessor);
			_spendingProcessor = new SpendingProcessor(_drawProcessor,_clearProcessor);
			_revenueProcessor = new RevenueProcessor(_drawProcessor,_clearProcessor);

			_width = width;
			_height = height;
			_rootNode = rootNode;
			yChange = 0;
			doubleClickEnabled = true;
			
			// Set the background white!			
			graphics.beginFill(0xFFFFFF,0.5);
			graphics.drawRect(0,0,_width,_height);
			graphics.endFill();

			if (test){
				_test = test;
			} else {
				test = true;
				_test = test;
			}

			return;
		}

		public function turnOffListeners():void {
			Main._stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main._stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			removeEventListener(MouseEvent.CLICK, clickHandler);
			removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			return;
		}

		public function turnOnListeners():void {
			Main._stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);	
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			return;
		}

		private function keyUpHandler(event:KeyboardEvent):void {
			Main._stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			return;			
		}

		private function scaleBudgetGraph(ratio:Number):void {

			var originalCentralPoint:Point = _centralPoint;
			_centralPoint = new Point();
		
			_centralPoint.x = originalCentralPoint.x*ratio;
			_centralPoint.y = originalCentralPoint.y*ratio;

			this.width *= ratio;
			this.height *= ratio;
			_centralScale *= ratio;
	
			this.x += originalCentralPoint.x - _centralPoint.x;
			this.y += originalCentralPoint.y - _centralPoint.y;

			return;
		}

		private function getDistanceToCentralNode(displayNode:DisplayNode):int {

			var distance:int;
			var node:DisplayNode;

			// Check RIGHT
			node = displayNode.right;
			distance = 1;
			while (node != null){
				if (node.node.id == _centralNode.node.id){
					return distance;
				}
				distance++;
				node = node.right;
			}

			node = displayNode.left;
			distance = -1;
			while (node != null){
				if (node.node.id == _centralNode.node.id){
					return distance;
				}
				distance--;
				node = node.left;
			}

			return 0;
		}

		private function shiftBy(distance:int):void {
	
			var i:int;

			if (distance){

				if (distance > 0){
					for (i=0;i<distance;i++){
						shiftGraph(LEFT);
					}
				} else {
					for (i=0;i>distance;i--){
						shiftGraph(RIGHT);
					}
				}

			}

			return;
		}

		private function doubleClickHandler(event:MouseEvent):void {
			trace("BudgetGraph::doubleClickHandler()");
			var displayNode:DisplayNode;
			var node:Node;
			var distance:int;
			var i:int;

			// If the control key is pressed and the target is a Node				  if(event.target is DisplayNode) {	      trace("BudgetGraph::doubleClickHandler() - Node was selected!");
				displayNode = DisplayNode(event.target);

				if (displayNode.node.id == "0"){
					trace("BudgetGraph::doubleClickHandler() - BudgetNode was selected!");
				} else {

					distance = getDistanceToCentralNode(displayNode);
					displayNode.node.highlight(0x00FF00);
					shiftBy(distance);

				}
		  }

			return;
		}

		private function clickHandler(event:MouseEvent):void {
			trace("BudgetGraph::clickHandler()");
			var displayNode:DisplayNode;
			var node:Node;

			// If the control key is pressed and the target is a Node				  if(event.target is DisplayNode) {	      trace("BudgetGraph::clickHandler() - Node was selected!");
				displayNode = DisplayNode(event.target);
				if (displayNode.node.id == "0"){
					trace("BudgetGraph::clickHandler() - BudgetNode was selected!");
				} else {

					// Handle the three types of Nodes differently
					switch (displayNode.allowed){
						case DisplayNode.ALL:
							_allProcessor.processAllNode(displayNode); break;
						case DisplayNode.REVENUE:
							_revenueProcessor.processRevenueNode(displayNode); break;
						case DisplayNode.SPENDING:
							_spendingProcessor.processSpendingNode(displayNode); break;
					}
				}

		  }						
			return;
		}

    private function keyDownHandler(event:KeyboardEvent):void {
			trace("BudgetGraph::keyDownHandler()",test);			
			shiftGraph(event.keyCode);
			var mat:Matrix = this.transform.matrix;
			var clear:ClearScreen;
			
			// rotate test
			if (event.keyCode == 32){
				// Fade all the other nodes
				_clearProcessor.clearRightUp(_centralNode,DisplayNode.DONT_CARE);
				_clearProcessor.clearLeftUp(_centralNode,DisplayNode.DONT_CARE);
				_clearProcessor.clearRightDown(_centralNode,DisplayNode.DONT_CARE);
				_clearProcessor.clearLeftDown(_centralNode,DisplayNode.DONT_CARE);

				// Fade myself
				_centralNode.node.fade();

				// Remove my subgraphs
				_clearProcessor.removeSubGraphs(_centralNode.down,DisplayDirection.UP);
				_centralNode.downOpen = false;
				_clearProcessor.removeSubGraphs(_centralNode.up,DisplayDirection.DOWN);
				_centralNode.upOpen = false;

				// Redraw				
			}

			Main._stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main._stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			return;
		}

		private function shiftGraph(shiftDir:int):void {
			trace("BudgetGraph::shiftGraph()",test);
			var currRadius:Number = _centralNode.node.getCostRadius();
			var nextRadius:Number;
			var shift:Number;

			_centralNode.node.unfade();
			switch(shiftDir){
				case DOWN:
					if (_centralNode.downOpen){
						nextRadius = _centralNode.down.node.getCostRadius();
						shift = (_centralScale*currRadius) + (_centralScale*nextRadius);
						this.y -= shift;
						_centralPoint.y += shift; 
						scaleBudgetGraph(currRadius/nextRadius);
						_centralNode = _centralNode.down;
					}
					break;
				case UP:
					if (_centralNode.upOpen){
						nextRadius = _centralNode.up.node.getCostRadius();
						shift = (_centralScale*currRadius) + (_centralScale*nextRadius);
						this.y += shift;
						_centralPoint.y -= shift; 
						scaleBudgetGraph(currRadius/nextRadius);
						_centralNode = _centralNode.up;
					}
					break;
				case RIGHT:
					if (_centralNode.rightOpen){
						nextRadius = _centralNode.right.node.getCostRadius();
						shift = (_centralScale*currRadius) + (_centralScale*nextRadius);
						this.x -= shift;
						_centralPoint.x += shift; 
						scaleBudgetGraph(currRadius/nextRadius);
						_centralNode = _centralNode.right;
					}
					break;	
				case LEFT:
					if (_centralNode.leftOpen){
						nextRadius = _centralNode.left.node.getCostRadius();
						shift = (_centralScale*currRadius) + (_centralScale*nextRadius);
						this.x += shift;
						_centralPoint.x -= shift; 
						scaleBudgetGraph(currRadius/nextRadius);
						_centralNode = _centralNode.left;
					}
					break;
				default:
					break;
			}			

			_centralNode.print();
			_centralNode.node.fade();
			return;
    }

		public function drawBudgetGraph():void {
			trace("BudgetGraph::drawBudgetGraph() - drawing the budget graph");

			var pencil:Point = new Point(0,0);
			var node:DisplayNode;
			var i:int;

			Node.max_cost = _rootNode.cost;
			pencil.x = _width/2;
			pencil.y = _height/2;
			_centralNode = new DisplayNode(_rootNode,DisplayNode.ALL);
			_centralNode.x = pencil.x;
			_centralNode.y = pencil.y;
			_centralNode.node.draw();
			pencil.x += _centralNode.node.getCostRadius();			

			_rootNode.spending.sort(NodeList.HIGH);

			_drawProcessor.drawList( pencil,_rootNode.spending,
  														 DisplayDirection.RIGHT,
	  													 DisplayStartLoc.LEFT);

			_centralNode.right = DisplayNode.initDisplayNodes(_rootNode.spending,
													 	 DisplayDirection.RIGHT,DisplayNode.ALL);
			_centralNode.rightOpen = true;
			_centralNode.right.left = _centralNode;
			_centralNode.right.leftOpen = true;

			_centralPoint = new Point(_width/2,_height/2);
			_originalPoint = new Point(_centralPoint.x,_centralPoint.y);
			_drawProcessor.addDisplayNodes(_centralNode,DisplayDirection.RIGHT);

			return;
		}

	}
	
}
