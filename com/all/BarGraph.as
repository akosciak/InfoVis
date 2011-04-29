﻿package com.all {		import flash.display.Sprite;	import flash.display.Graphics;	public class BarGraph extends Sprite {		private var _lists:NodeList;		private var _width:Number;		private var _height:Number;		private var _highlightNeeded:Boolean;		private var _highlightId:String;		private var GraphStageWidth = 100;		private var barwidth = 10;		private var barheight = 10;		private var barHscale = 4;		private var barspace = 10;		private var xpos = 5;	    private var ypos = 5;		private var max:int = 20;		private var _highlightThickness:Number = 1;		private var _highlightColor:Number= 0x01F000;				public function BarGraph(lists:NodeList,width:Number,height:Number) {			_lists = lists;			_width = width;			_height = height;			_highlightNeeded = false;			graphics.beginFill(0xFFFFFF,1.0);			graphics.drawRect(0,0,_width,_height);									return;		}		public function drawBudgetGraph(){			//Todo : make sure it draws the entire selected nodes on the display			this.graphics.clear();			graphics.endFill();			this.graphics.lineStyle(3);			graphics.beginFill(0xFFFFFF,1.0);			this.graphics.moveTo(0,0);			this.graphics.lineTo(0,_height);			this.graphics.moveTo(0,_height);			this.graphics.lineTo(_width,_height);			this.graphics.moveTo(0,0);			this.graphics.lineTo(_width,0);			this.graphics.moveTo(_width,0);			this.graphics.lineTo(_width,_height);			if(this._lists.length>0){				if(this._lists.length>15){					max = 15;				}				else{					max = this._lists.length;				}				for(var i:int = 0;i<max;i++){					this.graphics.drawRect((xpos+i*barwidth+(i+1)*barspace),_height-this._lists.getNodeAt(i).getCostRadius()*barHscale, barwidth,this._lists.getNodeAt(i).getCostRadius()*barHscale); 				}			}			else{				trace("0 node on the selected list to visualize Bar Graph");			}		}				public function updates(selectedList:NodeList){			this._lists = selectedList;			this.drawBudgetGraph();		}				public function highlight(ids:String){			this.drawBudgetGraph();			for(var i:int = 0;i<max;i++){					if(this._lists.getNodeAt(i).getId()==ids){						graphics.lineStyle(	_highlightThickness,_highlightColor,1.0);								this.graphics.drawRect((xpos+i*barwidth+(i+1)*barspace),_height-this._lists.getNodeAt(i).getCostRadius()*barHscale, barwidth,this._lists.getNodeAt(i).getCostRadius()*barHscale); 					}										else{						trace("0 node on the selected list to visualize Bar Graph");					}						}					}	}	}