package com.all {
	
	import flash.display.Sprite;
	
	public class PlaceHolder extends Sprite{

		public static const BAR:int = 0;
		public static const LINE:int = 1;
		public static const FUNC:int = 2;

		private var stageWidth:int;
		private var stageHeight:int;

		public function PlaceHolder(x:int,y:int):void {
			stageWidth = x;
			stageHeight = y;
			return;
		}

		public function draw(type:int):void {

			switch(type){
				case BAR:
					graphics.beginFill(0x00FF00,1.0);
					graphics.drawRect(stageWidth/2,0,stageWidth*3/10,stageHeight/3);
					graphics.endFill();	break;
				case LINE:
					graphics.beginFill(0xFF0000,1.0);
					graphics.drawRect(stageWidth/2,stageHeight*2/3,stageWidth*3/10,stageHeight/3);
					graphics.endFill();	break;
				case FUNC:
					graphics.beginFill(0x0000FF,1.0);
					graphics.drawRect(stageWidth*4/5,0,stageWidth/5,stageHeight);
					graphics.endFill();	break;
				default:
					break;
			}

			return;
		}
	}
}
