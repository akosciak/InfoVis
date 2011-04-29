package com.all {
	

	public class SpendingProcessor {

		private var _drawProcessor:DrawProcessor;	
		private var _clearProcessor:ClearProcessor;
		
		public function SpendingProcessor(drawProcessor:DrawProcessor,
																 clearProcessor:ClearProcessor):void {
			_drawProcessor = drawProcessor;
			_clearProcessor = clearProcessor;
			return;
		}

		public function processSpendingNode(displayNode:DisplayNode):void {
			trace("SpendingProcessor::processSpendingNode()");

			// Depending on the state you need to draw something ...
			switch(displayNode.state){
				case DisplayNode.CLEAR:
					handleClearState(displayNode); break;
				case DisplayNode.NONE:
					handleNoneState(displayNode); break;
				default:
					handleOtherStates(displayNode); break;
			}

			return;
		}

		// NOTE: does not use class variables
		private function handleClearState(displayNode:DisplayNode):void {
			trace("SpendingProcessor::handleClearState() - Error: Should be no way", 
				"to click a CLEAR node");
			displayNode.print();
			return;
		}
		
		private function handleNoneState(displayNode:DisplayNode):void{
			trace("SpendingProcessor::handleNoneState() - Begin handling");
			var node:Node = displayNode.node;
			var tempNode:DisplayNode = displayNode;
			displayNode.print();

			if (displayNode.left == null){
				// Vertical
				// Find the root and set it to MULTIPLE
				while (tempNode.up != null){
					tempNode = tempNode.up;
				}

				trace("SpendingProcessor::handleNoneState() - VERTICAL:clear any multiple state nodes");
				_clearProcessor.clearDownRight(tempNode,DisplayNode.MULTIPLE);
				_clearProcessor.clearRightDown(tempNode,DisplayNode.SINGLE);

				trace("SpendingProcessor::handleNoneState() - VERTICAL:draw the revenue and spending");
				_drawProcessor.drawDisplayList(displayNode,node.spending,
												DisplayDirection.RIGHT,DisplayNode.SPENDING);

				trace("SpendingProcessor::handleNoneState() - VERTICAL:add the nodes to the display list");
				_drawProcessor.addDisplayNodes(displayNode,DisplayDirection.RIGHT);
				tempNode.state = DisplayNode.MULTIPLE;
				
			} else {
				// Horizontal
				// Find the root and set it to MULTIPLE
				while (tempNode.left != null){
					tempNode = tempNode.left;
				}

				trace("SpendingProcessor::handleNoneState() - HORIZONTAL:clear any multiple state nodes");
				_clearProcessor.clearRightDown(tempNode,DisplayNode.MULTIPLE);
				_clearProcessor.clearDownRight(tempNode,DisplayNode.SINGLE);

				trace("SpendingProcessor::handleNoneState() - HORIZONTAL:draw the revenue and spending");
				_drawProcessor.drawDisplayList(displayNode,node.spending,
												DisplayDirection.DOWN,DisplayNode.SPENDING);

				trace("SpendingProcessor::handleNoneState() - HORIZONTAL:add the nodes to the display list");
				_drawProcessor.addDisplayNodes(displayNode,DisplayDirection.DOWN);

				tempNode.state = DisplayNode.MULTIPLE;		

			}

			trace("SpendingProcessor::handleNoneState() - DONE, setting state to SINGLE");
			// Set state to single
			displayNode.state = DisplayNode.SINGLE;

			return;
		}

		private function handleOtherStates(displayNode:DisplayNode):void {
			trace("SpendingProcessor::handleOtherStates() - Begin handling");

			if (displayNode.left == null){
				// Remove nodes
				_clearProcessor.removeSubGraphs(displayNode.right,DisplayDirection.LEFT);
				displayNode.rightOpen = false;
			} else {
				// Remove nodes
				_clearProcessor.removeSubGraphs(displayNode.down,DisplayDirection.UP);
				displayNode.downOpen = false;
			}

			// Set state to none
			displayNode.state = DisplayNode.NONE;
			return;
		}	

	}
	
}
