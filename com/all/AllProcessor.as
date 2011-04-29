package com.all {
	

	public class AllProcessor {

		private var _drawProcessor:DrawProcessor;	
		private var _clearProcessor:ClearProcessor;
		
		public function AllProcessor(drawProcessor:DrawProcessor,
																 clearProcessor:ClearProcessor):void {
			_drawProcessor = drawProcessor;
			_clearProcessor = clearProcessor;
			return;
		}

		public function processAllNode(displayNode:DisplayNode):void {
			trace("AllProcessor::processAllNode()");

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
			trace("AllProcessor::handleClearState() - Error: Should be no way", 
				"to click a CLEAR node");
			displayNode.print();
			return;
		}
		
		private function handleNoneState(displayNode:DisplayNode):void{
			trace("AllProcessor::handleNoneState() - Begin handling");
			var node:Node = displayNode.node;
			displayNode.print();

			trace("AllProcessor::handleNoneState() - clear any multiple state nodes");
			// Clear any multiple Nodes on either side
			_clearProcessor.clearRightUp(displayNode,DisplayNode.MULTIPLE);
			_clearProcessor.clearLeftUp(displayNode,DisplayNode.MULTIPLE);
			_clearProcessor.clearRightDown(displayNode,DisplayNode.MULTIPLE);
			_clearProcessor.clearLeftDown(displayNode,DisplayNode.MULTIPLE);

			trace("AllProcessor::handleNoneState() - draw the revenue and spending");
			// Draw a list on both sides
			_drawProcessor.drawDisplayList(displayNode,node.revenue,
											DisplayDirection.UP,DisplayNode.REVENUE);
			_drawProcessor.drawDisplayList(displayNode,node.spending,
											DisplayDirection.DOWN,DisplayNode.SPENDING);

			trace("AllProcessor::handleNoneState() - add the nodes to the display list");
			// Add toe the display list
			_drawProcessor.addDisplayNodes(displayNode,DisplayDirection.UP);
			_drawProcessor.addDisplayNodes(displayNode,DisplayDirection.DOWN);

			trace("AllProcessor::handleNoneState() - DONE, setting state to SINGLE");			
			// Set state to single
			displayNode.state = DisplayNode.SINGLE;

			return;
		}

		private function handleOtherStates(displayNode:DisplayNode):void {
			trace("AllProcessor::handleOtherStates() - Begin handling");
			// Remove nodes
			_clearProcessor.removeSubGraphs(displayNode.up,DisplayDirection.DOWN);
			displayNode.upOpen = false;
			_clearProcessor.removeSubGraphs(displayNode.down,DisplayDirection.UP);
			displayNode.downOpen = false;
			// Set state to none
			displayNode.state = DisplayNode.NONE;
			return;
		}	

	}
	
}
