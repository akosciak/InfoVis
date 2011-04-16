package com.all {
	
	import com.all.NodeList;
	
	/*
	 * Keeps track of all important node lists used by the application.
	 */
	public class BudgetNodeLists {

		public var funds:DisplayNodeList;
		public var selected:NodeList;
		public var all:NodeList;

		public function BudgetNodeLists():void  {
			// constructor code
			funds = new NodeList();
			all = new NodeList();
			selected = new NodeList();
			return;
		}

		/*
		 * Adds the node to all the lists that it fits into.
		 */
		public function add(node:Node):void  {
			all.push(node);

			// Push to seperate nodes for each type
			if ( node.type == Node.FUND ){
				funds.push(node);
			}
			
			return;
		}

	}
	
}
