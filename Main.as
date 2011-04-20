package  {		import flash.display.Sprite;	import flash.display.StageScaleMode;	import flash.display.StageAlign;
	import flash.display.DisplayObject;
	import flash.display.StageDisplayState;

	import flash.events.MouseEvent;
	import flash.events.Event;

	import flash.text.TextField;
	import com.all.Node;	import com.all.DataImporter;	import com.all.LoadCompleteEvent;	import com.all.NodeList;	import com.all.BudgetNodeLists;
	import com.all.BudgetGraph;
	import com.all.PlaceHolder;
	import com.all.FunctionGraph;
	import com.all.DisplayNodeList;
	import com.all.Year;
	import com.all.BudgetButton;
	import com.all.YearVis;
/*	import com.all.BarGraph;	import com.all.LineGraph;	import com.all.NodeGraph;
*/		public class Main extends Sprite{		// Container for all important nodelists the application should knwo about		
		private var _years:Array = new Array();
		private var _curYear:YearVis = null;		public function Main() {			trace("Main::Main() - Sprite Created");

			// Import Data			var importer:DataImporter = new DataImporter();			importer.addEventListener(LoadCompleteEvent.LD_COMPLETE,									  loadCompleteHandler);			importer.importGraphML("graphml.xml");						// Set the stage properties			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, resizeHandler);
			// Set the background white!			
			graphics.beginFill(0xFFFFFF,1.0);
			graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			graphics.endFill();
			// Going to just wait for load to complete...
			return;		}		/*     * What do to once, the graphml data has been loaded.     * Basically an extension of the Main Constructor.     */		private function loadCompleteHandler(event:LoadCompleteEvent):void {
			trace("Main::loadCompleteHandler() - Completed Loading Data");

			var temp_nodelists:BudgetNodeLists;
			
			// Set Important Global Node Values
			Node.max_cost = temp_nodelists.all.max_cost;
			trace("Set max node cost to: ",Node.max_cost);

			// Load 4 years of data			_years[Year.Y_2011] = new YearVis(event.lists);
			trace("Main::loadCompleteHandler() - 2011 Loaded");

			temp_nodelists = _years[Year.Y_2011].getNodeLists();
			temp_nodelists = BudgetNodeLists.buildYear(temp_nodelists);
			_years[Year.Y_2010] = new YearVis(temp_nodelists);
			trace("Main::loadCompleteHandler() - 2010 Loaded");

			temp_nodelists = _years[Year.Y_2010].getNodeLists();
			temp_nodelists = BudgetNodeLists.buildYear(temp_nodelists);
			_years[Year.Y_2009] = new YearVis(temp_nodelists);
			trace("Main::loadCompleteHandler() - 2009 Loaded");

			temp_nodelists = _years[Year.Y_2009].getNodeLists();
			temp_nodelists = BudgetNodeLists.buildYear(temp_nodelists);
			_years[Year.Y_2008] = new YearVis(temp_nodelists);
			trace("Main::loadCompleteHandler() - 2008 Loaded");

			setYear(_years[Year.Y_2011]);
			buildYearButtons();
			return;		}		
		private function buildYearButtons():void {
			trace("Main::buildYearButtons() - Building The Buttons to Switch Years");

			var i:int;
			var x:int = 5;
			var budgetbtn:BudgetButton;

			for (i=0;i<_years.length;i++){

				// Setup a new button
				budgetbtn = new BudgetButton(100,15,5,2,0xFFFFFF,Year.yearStrs[i],0x000000);
				budgetbtn.setYear(_years[i]);
				budgetbtn.x = x + i*budgetbtn.width;
				budgetbtn.y = 5;

				// Add ot tp the display
				addChild(budgetbtn);
				budgetbtn.addEventListener(MouseEvent.CLICK,yearButtonHandler,false,0,false);
				x += 5;
			}

			return;
		}

		private function yearButtonHandler(event:MouseEvent):void {
			trace("Main::yearButtonHandler() - Year Button has been selected");
			var budgetbtn:BudgetButton = BudgetButton(event.target);
			setYear(budgetbtn.getYear());
			return;
		}

		/*
     * Sets the year to be displayed on the application.
     * A change in the year brings back the same state of the old year
     * that was left off.
     */
		private function setYear(year:YearVis):void {

			trace("Main::setYear() - Setting the Year to be Visualized");

			if (_curYear != year){
				if (_curYear != null){
					removeChild(_curYear);
				} 
				_curYear = year;
				addChild(_curYear);
			} else {
				trace("Main::setYear() - Selected a currently selected year");
			}

			return;
		}
		// Redraw each year		private function repositionObjects():void {

			var i:int;

			for (i=0;i<_years.length;i++){
				_years[i].resize();
			}

/*
			// Remove all the children
			_budget_graph.clean();
			removeChild(_budget_graph);
			_budget_graph = null;

			// Rebuild the scene
			buildScene();
*/

			return;		}				/*     * Called when the application is resized     */				private function resizeHandler(event:Event):void {			trace("Main::resizeHandler() - ",event);			trace("Main::resizeHandler() - stageWidth: " + stage.stageWidth
				+ " stageHeight: " + stage.stageHeight);
			//repositionObjects();
			graphics.beginFill(0xFFFFFF,1.0);
			graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			graphics.endFill();

			return;		}	}	}
>>>>>>> 5a12b554a67f0ec971ec007168709712e71e0d3c
