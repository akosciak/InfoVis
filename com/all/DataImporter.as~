package com.all {
	
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	
	import flare.data.converters.*;
	import flare.data.*;
	
	import com.all.Node;
	import com.all.NodeList;
	import com.all.LoadCompleteEvent;
	import flash.display.Sprite;
	
	public class DataImporter extends Sprite{

		public static const SOURCE:String = "source";
		public static const TARGET:String = "target";

		private var _graphML:GraphMLConverter;
		private var _urlLoader:URLLoader;
		
		public function DataImporter():void  {
			// constructor code
			trace("DataImporter::DataImporter()-> creating new GraphML Converter");
			_graphML = new GraphMLConverter();
			return;
		}
	
		public function importGraphML(filename:String):void {
			trace("DataImporter::importGraphML()-> starting up graphml import from "
				  +filename);
			var _req:URLRequest = new URLRequest("graphml.xml");
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onIOError,false,0,true);
			_urlLoader.addEventListener(Event.COMPLETE, onComplete,false,0,true);
			_urlLoader.load(_req);
			return;
		}
	
		/*
		 * Takes a map of id->node and uses the edge list from the dataset
		 * to set children and ancestors of each node.
		 */
		private static function processEdges(map:Object,dataset:DataSet):void {

			var source:Node;
			var target:Node;
			
			trace("DataImporter::processEdges()-> processing edges from dataset");
			
			// add edge data
			for each (var edge:Object in dataset.edges.data) {
				
				// Grab the source node
				source = map[edge[SOURCE]];
				target = map[edge[TARGET]];
				
				if (!source || !target ){
					trace("Missing node src="+edge[SOURCE]+" trg="+edge[TARGET]);
					continue;
				}
				
				// Set revenue and spending connections
				if (target.type > source.type){
					source.addSpending(target);
					target.addRevenue(source);
				} else {
					source.addRevenue(target);
					target.addSpending(source);
				}
			}
			
			return;
		}
	
		/*
		 * Lets create a list of nodes that make sure to point to each other node,
		 * using the data obtained from the graphml file.
		 * 
		 * Parts of this are copied from the Flare library.
		 */
		public static function getNodes(dataset:DataSet):BudgetNodeLists {			
			
			var i:int;
			var lists:BudgetNodeLists = new BudgetNodeLists();
			var map:Object = {};
			
			trace("DataImporter::getNodes()-> process and retrieve nodes from the dataset");
			
			for each (var node:Object in dataset.nodes.data) {
				var new_node:Node;
				if (node[NodeProperty.TYPE] != NodeType.POSITION){
					new_node = new Node(node[NodeProperty.TITLE],
															node[NodeProperty.ID],
															node[NodeProperty.COST],
															node[NodeProperty.COSTTYPE],
															node[NodeProperty.TYPE]);
				}
				lists.add(new_node);
				map[new_node.id] = new_node;
			}
			
			// exit if there is no edge data
			if (!dataset.edges){
				trace("Error: no edge data was found!");
			} else {
				processEdges(map,dataset);
			}
		
			return lists;
		}	
	
		private function onIOError(evt:IOErrorEvent):void {
			trace("DataImporter::onIOError()-> XML load error.\n" + evt.text);
		}
		
		private function onComplete(evt:Event):void {
			trace("DataImporter::onComplete()-> completed graphml import");
			
			// Clean up the listeners for memory management
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlLoader.removeEventListener(Event.COMPLETE, onComplete);
			
			// Try to retrieve the XML data
			try {
				var xml:XML = new XML(evt.target.data);
				trace("DataImporter::onComplete()-> successful load of XML data");
			} catch (err:Error) {
				trace("DataImporter::onComplete()-> XML parse error:\n" + err.message);
			}
			
			// Parse the data to retrieve nodes and edges
			var dataset:DataSet = _graphML.parse(xml);
			trace("DataImporter::onComplete()-> dispatching load complete event");
			dispatchEvent(new LoadCompleteEvent(LoadCompleteEvent.LD_COMPLETE,
												true,
												false,
												getNodes(dataset)));
			return;
		}
		
	}
}
