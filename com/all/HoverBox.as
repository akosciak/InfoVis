package com.all {
	
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class HoverBox extends Sprite{

		private static var colors:Array = [0xFEFEFF,0xE4E5F0];
		private static var alphas:Array = [1,1];
		private static var ratios:Array = [0,255];

		private var _node:Node;

		/*
		 * Constructor
		 */ 
		public function HoverBox(node:Node):void {
			_node = node;
			return;
		}

		public function draw():void {

//			graphics.lineStyle(1,0x000000,0.5);
//			graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios);			
//			graphics.drawRoundRect(0,0,100,20,5);
//			graphics.endFill();

			var txtFld:TextField = new TextField();
			txtFld.y = -40;
			txtFld.border = true;
			txtFld.borderColor = 0x000000;
			txtFld.background = true;
			txtFld.backgroundColor = 0xFFFFFF;
			txtFld.autoSize = TextFieldAutoSize.LEFT;
			txtFld.multiline = true;
			txtFld.appendText("Title: "+_node.title+"\n");
			txtFld.appendText("Cost: $"+_node.cost);
			txtFld.selectable = false;
			addChild(txtFld);
			
			return;
		}

	}
}
