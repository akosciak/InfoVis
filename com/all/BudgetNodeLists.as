package com.all {
	
	import com.all.NodeList;
	
	/*
	 * Keeps track of all important node lists used by the application.
	 */
	public class BudgetNodeLists {

		public var budgetNode:Node;
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
			var i:int, j:int;
			var node:Node, newNode:Node, oldNode:Node;
			var map:Object = {};
			
			for (i=0;i<archetype.all.length;i++){
				// Create a copy of all the nodes
				node = archetype.all.getNodeAt(i).copy();
				node.cost = node.cost + node.cost*(.20*(Math.random()-0.75));
				map[node.id] = node;
				_new_nodelists.add(node);
			}

			for (i=0;i<archetype.all.length;i++){
				// Now for each revenue and spending source find the match and add it
				oldNode = archetype.all.getNodeAt(i);
				newNode = map[oldNode.id];
				
				// Add all revenue nodes
				for (j=0;j<oldNode.revenue.length;j++){
					node = oldNode.revenue.getNodeAt(j);
					newNode.addRevenue(map[node.id]);
				}
				// Add all spending nodes
				for (j=0;j<oldNode.spending.length;j++){
					node = oldNode.spending.getNodeAt(j);
					newNode.addSpending(map[node.id]);
				}
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

		public function createBudgetNode():void {

			var i:int;
			var totalCost:Number = 0;

			budgetNode = new Node("Chicago Budget","0",
														funds.max_cost,"Y",
														NodeType.BUDGET);
			for (i=0;i<funds.length;i++){ 
				totalCost += funds.getNodeAt(i).cost;
				budgetNode.addSpending(funds.getNodeAt(i));
			}
			budgetNode.cost = totalCost;

			return;
		}

	}
	
}
