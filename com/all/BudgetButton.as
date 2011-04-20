package com.all {	import flash.display.Graphics;	import flash.display.MovieClip;	import flash.display.Shape;	import flash.display.SimpleButton;	import flash.text.TextField;
	import flash.text.TextFormat;	import flash.text.TextFieldAutoSize;	public class BudgetButton extends MovieClip {		private var _w:Number;		private var _h:Number;		private var _rad:Number;		private var _linW:Number;		private var _col:uint;		private var _txt:String;		private var _txtCol:uint;

			// Set the Format of the TextField
		private static var _format:TextFormat;
		private var _year:YearVis;		public function BudgetButton(w:Number, h:Number,										rad:Number, linW:Number,										col:uint, txt:String,										txtCol:uint) {			_w = w;			_h = h;			_rad = rad;			_linW = linW;			_col = col;			_txt = txt;			_txtCol = txtCol;

			if (_format == null){
				_format = new TextFormat();
				_format.font = "Arial";
				_format.size = 10;
				_format.bold = true;
			}			
			var btn:Shape = createRoundRect(_col);			addChild(btn);			var labl:TextField = createLabel();			addChild(labl);

			this.useHandCursor = true;
			this.buttonMode = true;
			this.mouseChildren = false;

			return;		}

		public function setYear(year:YearVis):void {
			_year = year;
			return;
		}

		public function getYear():YearVis {
			return _year;
		}
		private function createRoundRect(col:uint):Shape {			var rRect:Shape = new Shape();			var g:Graphics = rRect.graphics;			g.lineStyle(_linW, 0x000000);			g.beginFill(col, 0.5);			g.drawRoundRect(0, 0, _w, _h, _rad);			g.endFill();			return rRect;		}				private function createLabel():TextField {			var txt:TextField = new TextField();
			txt.selectable = false;
			txt.mouseEnabled = false;
			txt.width = _w;
			txt.autoSize = TextFieldAutoSize.CENTER;			txt.textColor = _txtCol;			txt.text = _txt;
			txt.setTextFormat(_format);

			return txt;		}	}}
