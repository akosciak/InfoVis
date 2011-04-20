﻿package com.all {
	
	import com.all.NodeList;
	
	/*
	 * Keeps track of all important node lists used by the application.
	 */
	public class BudgetNodeLists {

		public var funds:NodeList;
		public var depts:NodeList;
		public var subDepts:NodeList;
		public var functions:NodeList;
		public var all:NodeList;

		public function BudgetNodeLists():void  {
			trace("BudgetNodeLists::BudgetNodeLists() - Constructed BudgetNodelist Set");

			// constructor code
			funds = new NodeList();
			depts = new NodeList();
			subDepts = new NodeList();
			functions = new NodeList();
			all = new NodeList();

			return;
		}

		/*
     * Takes an existing NodeList Set and builds a new one.
     */
		public static function buildYear(archetype:BudgetNodeLists)
																			:BudgetNodeLists {

			var _new_nodelists:BudgetNodeLists = new BudgetNodeLists();
			var i:int;
			var node:Node;
			
			for (i=0;i<archetype.all.length;i++){
				node = archetype.all.getNodeAt(i).copy();
				node.cost = node.cost*(.20*(Math.random()-0.5));
				_new_nodelists.add(node);
			}

			return _new_nodelists;
		}

		/*
		 * Adds the node to all the lists that it fits into.
		 */
		public function add(node:Node):void  {
			all.push(node);

			// Push to seperate nodes for each type
			switch(node.type){
				case NodeType.FUND:
					funds.push(node); break;
				case NodeType.FUNCTION:
					functions.push(node); break;
				case NodeType.DEPARTMENT:
					depts.push(node); break;
				case NodeType.DEPARTMENT_SUBSECTION:
					subDepts.push(node); break;
				default:
					break;
			}

			return;
		}

	}
	
}
