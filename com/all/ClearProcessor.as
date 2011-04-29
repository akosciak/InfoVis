﻿package com.all {
	
	public class ClearProcessor {
	
		private var _display:BudgetGraph;

		public function ClearProcessor(display:BudgetGraph):void {
			_display = display;
			return;
		}

		public function removeSubGraphs(displayNode:DisplayNode,from:int):void {

			if (displayNode != null){
				if (displayNode.state == DisplayNode.CLEAR){
					trace("ClearProcessor::removeSubGraphs() - Node is already removed:");
					displayNode.print();		
				} else if (displayNode.node.type == NodeType.POSITION){
					while (displayNode != null){
						displayNode.state = DisplayNode.CLEAR;
						_display.removeChild(displayNode);

						displayNode.downOpen = false;
						displayNode.upOpen = false;
						displayNode.leftOpen = false;
						displayNode.rightOpen = false;
						switch (from){
							case DisplayDirection.DOWN:
								displayNode = displayNode.up; break;
							case DisplayDirection.UP:
								displayNode = displayNode.down; break;
							case DisplayDirection.LEFT:
								displayNode = displayNode.right; break;
							case DisplayDirection.RIGHT:
								displayNode = displayNode.left; break;
						}
					}
				} else {

					if (from != DisplayDirection.DOWN){
						removeSubGraphs(displayNode.down,DisplayDirection.UP);
					} 
					if (from != DisplayDirection.UP){
						removeSubGraphs(displayNode.up,DisplayDirection.DOWN);
					} 
					if (from != DisplayDirection.LEFT){
						removeSubGraphs(displayNode.left,DisplayDirection.RIGHT);
					} 
					if (from != DisplayDirection.RIGHT){
						removeSubGraphs(displayNode.right,DisplayDirection.LEFT);	
					}

					displayNode.state = DisplayNode.CLEAR;
					_display.removeChild(displayNode);

					displayNode.downOpen = false;
					displayNode.upOpen = false;
					displayNode.leftOpen = false;
					displayNode.rightOpen = false;
				}
			}

			return;
		}

		public function clearRightUp(displayNode:DisplayNode,state:int):void {
			trace("ClearProcessor::clearRightUp() - Clearing all UP displays to the RIGHT");
			DisplayNode.printState(state);
			var node:DisplayNode = displayNode.right;
			while (node != null){
				if (node.state == state || state == DisplayNode.DONT_CARE){
					removeSubGraphs(node.up,DisplayDirection.DOWN);
					node.node.fade();
					node.upOpen = false;
				}
				node = node.right;
			}
			return;
		}

		public function clearRightDown(displayNode:DisplayNode,state:int):void {
			trace("ClearProcessor::clearRightDown() - Clearing all DOWN displays to the RIGHT");
			DisplayNode.printState(state);
			var node:DisplayNode = displayNode.right;
			while (node != null){
				if (node.state == state || state == DisplayNode.DONT_CARE){
					removeSubGraphs(node.down,DisplayDirection.UP);
					node.downOpen = false;
				}
				node = node.right;
			}
			return;
		}

		public function clearLeftUp(displayNode:DisplayNode,state:int):void {
			trace("ClearProcessor::clearLeftUp() - Clearing all UP displays to the LEFT");
			DisplayNode.printState(state);
			var node:DisplayNode = displayNode.left;
			while (node != null){
				if (node.state == state || state == DisplayNode.DONT_CARE){
					removeSubGraphs(node.up,DisplayDirection.DOWN);
					node.upOpen = false;
				}
				node = node.left;
			}
			return;
		}

		public function clearLeftDown(displayNode:DisplayNode,state:int):void {
			trace("ClearProcessor::clearLeftDown() - Clearing all DOWN displays to the LEFT");
			DisplayNode.printState(state);
			var node:DisplayNode = displayNode.left;
			while (node != null){
				if (node.state == state || state == DisplayNode.DONT_CARE){
					removeSubGraphs(node.down,DisplayDirection.UP);
					node.downOpen = false;
				}
				node = node.left;
			}
			return;
		}

		public function clearUpRight(displayNode:DisplayNode,state:int):void {
			trace("ClearProcessor::clearUpRight() - Clearing all RIGHT displays to the UP");
			DisplayNode.printState(state);
			var node:DisplayNode = displayNode.up;
			while (node != null){
				if (node.state == state || state == DisplayNode.DONT_CARE){
					removeSubGraphs(node.left,DisplayDirection.RIGHT);
					node.rightOpen = false;
				}
				node = node.up;
			}
			return;
		}

		public function clearDownRight(displayNode:DisplayNode,state:int):void {
			trace("ClearProcessor::clearLeftDown() - Clearing all RIGHT displays to the DOWN");
			DisplayNode.printState(state);
			var node:DisplayNode = displayNode.down;
			while (node != null){
				if (node.state == state || state == DisplayNode.DONT_CARE){
					removeSubGraphs(node.right,DisplayDirection.LEFT);
					node.leftOpen = false;
				}
				node = node.down;
			}

			return;
		}
	}
	
}