package com.all {
	
	public class NodeType {

		// Node Type Constants
		public static const REVENUE_SOURCE:int = 0;
		public static const REVENUE_SUBSECTION:int = 1;
		public static const REVENUE_SECTION:int = 2;
		public static const FUND:int = 3;
		public static const FUNCTION:int = 4;
		public static const DEPARTMENT:int = 5;
		public static const DEPARTMENT_SUBSECTION:int = 6;
		public static const TOTAL_APPROPRIATIONS:int = 7;
		public static const TOTAL_POSITIONS:int = 8;
		public static const POSITION_SECTION:int = 9;
		public static const POSITION_SUBSECTION:int = 10;
		public static const POSITION:int = 11;
		public static const APPROPRIATION_SECTION:int = 12;
		public static const APPROPRIATION:int = 13;
		public static const BUDGET:int = 14;
		public static const UNKNOWN:int = 15;

		// Highlight colors
		public static const highlightColorArray:Array = new Array(
			0xFF0000,// REVENUE_SOURCE:int = 0;
			0xFF0000,// REVENUE_SUBSECTION:int = 1;
			0xFF0000,// REVENUE_SECTION:int = 2;
			0x0000FF,// FUND:int = 3;
			0x00FF00,// FUNCTION:int = 4;
			0x00FF00,// DEPARTMENT:int = 5;
			0x00FF00,// DEPARTMENT_SUBSECTION:int = 6;
			0x00FF00,// TOTAL_APPROPRIATIONS:int = 7;
			0x00FF00,// TOTAL_POSITIONS:int = 8;
			0x00FF00,// POSITION_SECTION:int = 9;
			0x00FF00,// POSITION_SUBSECTION:int = 10;
			0x00FF00,// POSITION:int = 11;
			0x00FF00,// APPROPRIATION_SECTION:int = 12;
			0x00FF00,// APPROPRIATION:int = 13;
			0x0000FF,// BUDGET:int = 14;
			0xFFFF00)// UNKNOWN:int = 15;

		// Highlight alphas
		public static const highlightAlphaArray:Array = new Array(
			0.33,// REVENUE_SOURCE:int = 0;
			0.66,// REVENUE_SUBSECTION:int = 1;
			1.0,// REVENUE_SECTION:int = 2;
			0.90,// FUND:int = 3;
			1.0,// FUNCTION:int = 4;
			1.0,// DEPARTMENT:int = 5;
			0.90,// DEPARTMENT_SUBSECTION:int = 6;
			0.80,// TOTAL_APPROPRIATIONS:int = 7;
			0.80,// TOTAL_POSITIONS:int = 8;
			0.70,// POSITION_SECTION:int = 9;
			0.60,// POSITION_SUBSECTION:int = 10;
			0.50,// POSITION:int = 11;
			0.70,// APPROPRIATION_SECTION:int = 12;
			0.50,// APPROPRIATION:int = 13;
			1.0,// BUDGET:int = 14;
			1.0)// UNKNOWN:int = 15;
	}
}
