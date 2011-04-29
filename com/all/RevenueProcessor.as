package com.all {
	

	public class RevenueProcessor {

		private var _drawProcessor:DrawProcessor;	
		private var _clearProcessor:ClearProcessor;
		
		public function RevenueProcessor(drawProcessor:DrawProcessor,
																 clearProcessor:ClearProcessor):void {
			_drawProcessor = drawProcessor;
			_clearProcessor = clearProcessor;
			return;
		}

		public function processRevenueNode(displayNode:DisplayNode):void {
			trace("RevenueProcessor::processRevenueNode()");

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
			trace("RevenueProcessor::handleClearState() - Error: Should be no way", 
				"to click a CLEAR node");
			displayNode.print();
			return;
		}
		
		private function handleNoneState(displayNode:DisplayNode):void{
			trace("RevenueProcessor::handleNoneState() - Begin handling");
			var node:Node = displayNode.node;
			var tempNode:DisplayNode = displayNode;
			displayNode.print();

			if (displayNode.left == null){
				// Vertical
				// Find the root and set it to MULTIPLE
				while (tempNode.down != null){
					tempNode = tempNode.down;
				}

				trace("RevenueProcessor::handleNoneState() - VERTICAL:clear any multiple state nodes");
				_clearProcessor.clearUpRight(tempNode,DisplayNode.MULTIPLE);
				_clearProcessor.clearRightUp(tempNode,DisplayNode.SINGLE);

				trace("RevenueProcessor::handleNoneState() - VERTICAL:draw the revenue and revenue");
				_drawProcessor.drawDisplayList(displayNode,node.revenue,
												DisplayDirection.RIGHT,DisplayNode.REVENUE);

				trace("RevenueProcessor::handleNoneState() - VERTICAL:add the nodes to the display list");
				_drawProcessor.addDisplayNodes(displayNode,DisplayDirection.RIGHT);
				tempNode.state = DisplayNode.MULTIPLE;
				
			} else {
				// Horizontal
				// Find the root and set it to MULTIPLE
				while (tempNode.left != null){
					tempNode = tempNode.left;
				}

				trace("RevenueProcessor::handleNoneState() - HORIZONTAL:clear any multiple state nodes");
				_clearProcessor.clearRightUp(tempNode,DisplayNode.MULTIPLE);
				_clearProcessor.clearUpRight(tempNode,DisplayNode.SINGLE);

				trace("RevenueProcessor::handleNoneState() - HORIZONTAL:draw the revenue and revenue");
				_drawProcessor.drawDisplayList(displayNode,node.revenue,
												DisplayDirection.UP,DisplayNode.REVENUE);

				trace("RevenueProcessor::handleNoneState() - HORIZONTAL:add the nodes to the display list");
				_drawProcessor.addDisplayNodes(displayNode,DisplayDirection.UP);

				tempNode.state = DisplayNode.MULTIPLE;		

			}

			trace("RevenueProcessor::handleNoneState() - DONE, setting state to SINGLE");
			// Set state to single
			displayNode.state = DisplayNode.SINGLE;

			return;
		}

		private function handleOtherStates(displayNode:DisplayNode):void {
			trace("RevenueProcessor::handleOtherStates() - Begin handling");

			if (displayNode.left == null){
				// Remove nodes
				_clearProcessor.removeSubGraphs(displayNode.right,DisplayDirection.LEFT);
				displayNode.rightOpen = false;
			} else {
				// Remove nodes
				_clearProcessor.removeSubGraphs(displayNode.up,DisplayDirection.DOWN);
				displayNode.upOpen = false;
			}

			// Set state to none
			displayNode.state = DisplayNode.NONE;
			return;
		}	

	}
	
}
