﻿package com.all {
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	public class FunctionGraph extends Sprite{

		private var _functions:NodeList;
		private var _drawProcessor:DrawProcessor;

		public function FunctionGraph(functions:NodeList):void {
			_drawProcessor = new DrawProcessor(this);
			_functions = functions;
			return;
		}
	
		public function drawFunctionGraph():void{
  		trace("FunctionGraph::drawFunctionGraph()");

			var pencil:Point = new Point(0,0);
			var node:DisplayNode;

			trace(_functions.length);
			_functions.printDetails();
			pencil.x = _functions.getNodeAt(0).getCostRadius();
			pencil.y = 0;

			_functions.sort(NodeList.HIGH);

			_drawProcessor.drawList( pencil,_functions,
  														 DisplayDirection.DOWN,
	  													 DisplayStartLoc.TOP);

			node = DisplayNode.initDisplayNodes(_functions,
																					DisplayDirection.DOWN,
																					DisplayNode.NONE);

			_drawProcessor.addDisplayNodes( node,
																			DisplayDirection.DOWN);

			return;
		}

	}
	
}
