﻿package com.all{		import flash.display.Sprite;	import flash.display.Graphics;	import flash.events.MouseEvent;	import flash.text.*;		public class LineGraph extends Sprite {				private var _lists:NodeList;		private var _year1List:NodeList;		private var _year2List:NodeList;		private var _year3List:NodeList;		private var _year4List:NodeList;				private var _width:Number;		private var _height:Number;		private var positions:Array;		private var ypos:Number;		private var xpos:Number;		private var Rscale:int;		private var textX;		private var textY:Number =6/7;		public function LineGraph(lists:NodeList,width:Number,height:Number) {			_lists = lists;			_width = width;			_height = height;			Rscale = 2			xpos =10;						graphics.beginFill(0xFFFFFF,1.0);			graphics.drawRect(0,0,_width,_height);						graphics.endFill();						_year1List = new NodeList();		    _year2List = new NodeList();			_year3List = new NodeList();			_year4List = new NodeList();		}				public function drawBudgetGraph(){			this.graphics.clear();			this.graphics.lineStyle(3);			this.graphics.moveTo(0,0);			this.graphics.lineTo(0,_height);			this.graphics.moveTo(0,_height);			this.graphics.lineTo(_width,_height);			this.graphics.moveTo(0,0);			this.graphics.lineTo(_width,0);			this.graphics.moveTo(_width,0);			this.graphics.lineTo(_width,_height);						this.graphics.lineStyle(2);			for(var i:int =1 ;i<=4;i++){				this.graphics.moveTo(_width*(i/5),_height*(1/5));				this.graphics.lineTo(_width*(i/5),_height*(4/5)); 			}			var text1:TextField = new TextField();			var text2:TextField = new TextField();			var text3:TextField = new TextField();			var text4:TextField = new TextField();						text1.text = "2008";			text2.text = "2009";			text3.text = "2010";			text4.text = "2011";						text1.x = _width*(1/5)-10;			text1.y = _height*(textY);			text2.x = _width*(2/5)-10;			text2.y = _height*(textY);			text3.x = _width*(3/5)-10;			text3.y = _height*(textY);						text4.x = _width*(4/5)-10;			text4.y = _height*(textY);						addChild(text1);			addChild(text2);			addChild(text3);			addChild(text4);						if(this._lists.length>0){				for(var i:int =0;i<4;i++){					this.graphics.drawCircle(_width*((1)/5),_height*((i+1)/5),this._lists.getNodeAt(i).getCostRadius()/Rscale);				}			}			else{							}		}		public function updates(_node:NodeList){			//TODO : search for the past year data of the selected node			_lists = _node;			var temp:Array = Main._years;			this.drawBudgetGraph();		}	}	}