<<<<<<< HEAD
﻿package com.all {	import com.all.Node;	import flash.display.Sprite;	import flash.events.MouseEvent;	import flash.events.EventPhase;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.TextFieldAutoSize;	import flash.geom.Point;		/*   * A node list used for display in the budget and functions graphs.   */	public class DisplayNodeList {		/*     * Given a point that you are currently at determines the next     * point to draw from by knowing the direction of draw, current     * radius, and next radius to be drawn.     */ 		private function getNextDrawPt(	curPoint:Point,																		radius:Number,																		next_radius:Number,																		direction:int):Point {			var nextPoint:Point = new Point(curPoint.x,curPoint.y);			// Calculate the new point, and the check point			switch(direction){				case DRAW_DOWN: 					nextPoint.y += radius + next_radius;					break;				case DRAW_UP: 					nextPoint.y -= radius + next_radius; 					break;				case DRAW_RIGHT: 					nextPoint.x += radius + next_radius; 					break;				default: 					trace("NodeList("+_id+")::drawNodes()-Error:incorrect direction given");			}			return nextPoint;		}		private static function getStartPos(pencil:Point,start:int,radius:Number):Point {			// Determine start location			switch(start){				case TOP: pencil.y += radius; break;				case BOTTOM: pencil.y -= radius; break;				case RIGHT: pencil.x -= radius; break;				case LEFT: pencil.x += radius; break;				default: 					trace("DisplayNodeList::getStartPos()-Error:incorrect start given");			}			return pencil;		}		private static function drawNode(node:Node,pencil:Point):void{			// Draw the node			node.doubleClickEnabled = true;			node.x = pencil.x;			node.y = pencil.y;			node.draw();			return;		}				/*		 * Draws a row of Nodes onto the display, 		 * without adding them to the display list.		 */		public static function drawList(nodes:NodeList,dir:int,start:int):void {			trace("DisplayNodeList::drawList() ","- Start drawing all "nodes.length" nodes");						var i:int;			var node:Node;			var next_radius:Number;			var radius:Number = nodes[0].getCostRadius();			// Pencil is the current position to draw.			var pencil:Point = new Point(0,0);			pencil = getStartLoc(pencil,start,radius);			// Draw each node			for (i=0; i < nodes.length; i++){				node = nodes[i];				radius = node.getCostRadius();				drawNode(node,pencil);				// If there is another node that can be drawn, than set the new drawing position				if (i+1 < length){					next_radius = nodes[i+1].getCostRadius();					pencil = getNextDrawPt(pencil,radius,next_radius,dir);					// If there was no room					if (pencil == null){						break;					}				}				}						return;		}		}}
=======
package com.all {

	import com.all.Node;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.EventPhase;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.geom.Point;
	
	/*
   * A node list used for display in the budget and functions graphs.
   */
	public class DisplayNodeList {


	
	}

}
>>>>>>> ce011dcf03014e3b9569b3978027bde7071ac24a
