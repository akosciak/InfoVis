package com.all {
	
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class HoverBox extends Sprite{

		private var _node:Node;

		/*
		 * Constructor
		 */ 
		public function HoverBox(node:Node):void {
			this.mouseEnabled = false;
			_node = node;
			return;
		}

		public function getNode():Node {
			return _node;
		}

		public function draw():void {

			var txtFld:TextField = new TextField();

			txtFld.y = -40;

			// Border and Background
			txtFld.border = true;
			txtFld.borderColor = 0x000000;
			txtFld.background = true;
			txtFld.backgroundColor = 0xFFFFFF;

			// Line placement
			txtFld.autoSize = TextFieldAutoSize.LEFT;
			txtFld.multiline = true;

			// The displayed text
			txtFld.appendText("Title: "+_node.title+"\n");
			txtFld.appendText("Cost: $"+_node.cost);
			txtFld.selectable = false;
	
			addChild(txtFld);
			
			return;
		}

	}
}
