package  {
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import com.all.Node;
	import com.all.DataImporter;
	import com.all.LoadCompleteEvent;
	import flash.events.*;
	import com.all.NodeList;
	import flash.utils.Timer;
	
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import com.all.BudgetGraph;
	import com.all.BudgetNodeLists;
	
	public class Main extends Sprite{

		// Container for all important nodelists the application should knwo about		
		private var _nodelists:BudgetNodeLists;

		// The views being shown by the application
		private var _budget_graph:BudgetGraph;

		public function Main() {
			trace("Main Sprite Created");
			
			// Import Data
			var importer:DataImporter = new DataImporter();
			importer.addEventListener(LoadCompleteEvent.LD_COMPLETE,
									  loadCompleteHandler);
			importer.importGraphML("graphml.xml");
			
			// Set the stage properties
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, resizeHandler);
			
			// Going to just wait for load to complete...
			return;
		}

		/*
     * What do to once, the graphml data has been loaded.
     * Basically an extension of the Main Constructor.
     */
		private function loadCompleteHandler(event:LoadCompleteEvent):void {
			_nodelists = event.lists;
			buildScene();
			return;
		}
		
		// Repositions my single node
		public function repositionObjects():void {
			_budget_graph.x = 0;
			_budget_graph.y = 0;
		}

		/*
     * Builds and draws each view of the application
     */ 
		private function buildScene():void {

			// Add the Bar Graph

			// Add the Line Graph			

			// Add the Function Graph

			// Add the Budget Graph
			_budget_graph = new BudgetGraph(_nodelists.funds);
			_budget_graph.width = stage.stageWidth;
			_budget_graph.height = stage.stageHeight;
			_budget_graph.x = 0;
			_budget_graph.y = 0;
			this.addChild(_budget_graph);
			_budget_graph.drawBudgetGraph();

			// Listen for selections
			_budget_graph.addEventListener(MouseEvent.MOUSE_DOWN,budgetGraphClick,false,0,true);

			return;
		}
		
		/*
     * Called when the application is resized
     */		
		private function resizeHandler(event:Event):void {
			trace("resizeHandler: "+event);
			trace("stageWidth: "+stage.stageWidth+" stageHeight: "+stage.stageHeight);
			repositionObjects();
		}

		/*
     * Updates the views if a selection was made in the budget graph view
     */ 
		public function budgetGraphClick(event.MouseEvent){
			trace("Main::budgetGraphClick() - update the necessary views");
			
			// If the control key is pressed and the target is a Node		
		  if(e.ctrlKey && event.Target is Node) {
	      trace("Main::budgetGraphClick() - Node was selected!");
				//TODO: Figure out if the node is already contained in the selected list.
				//TODO: Make sure the graph highlights the node that was selected.
				_nodelists.selected.push(Node(event.Target);
		  }						

			return;
		}

		/*
     * Updates the view if a selection was made in the function graph view
     */
		public function functionGraphClick(event.MouseEvent){
			trace("Main::functionGraphClick() - update the necessary views");

			// If the control key is pressed and the target is a Node		
		  if(e.ctrlKey && event.Target is Node) {
	      trace("Main::functionGraphClick() - Node was selected!");
				_nodelists.selected.push(Node(event.Target);
		  }		

			return;
		}

	}
	
}
