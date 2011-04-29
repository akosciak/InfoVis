package com.all {

	import flash.display.Sprite;

	public class ClearScreen extends Sprite {

		private var _width:Number;
		private var _height:Number;

		public function ClearScreen(width:Number,height:Number):void {

			_width = width;
			_height = height;

			graphics.beginFill(0xFFFFFF,0.5);
			graphics.drawRect(0,0,_width,_height);
			graphics.endFill();

			return;
		}

	}

}
