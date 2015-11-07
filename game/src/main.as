package  {
	
	import flash.display.MovieClip;
	
	public class main extends MovieClip {
		var QUANT:int = 4; //QUANT of boxs
		var PADDING = 1;  //PADDING 
		var boxs:Array = new Array(QUANT);
		
		public function main() {
			InitBoxs();
			InitBut(); 
		}
		
		public function InitBoxs():void {
			var i:int;
			var j:int;
			var count:int = 0;
		
			for(i = 0; i <QUANT; i++) {
				boxs[i] = new Array(QUANT);
				for (j = 0; j < QUANT; j++) {
					var row:box = new box(count+1);
					count++;
					row.x = (j + PADDING) * (row.width + PADDING);
					row.y = (i + PADDING) * (row.width + PADDING);
					row.win(i, j);
					boxs[i][j] = row; 
					addChild(boxs[i][j]);
				}
			}
		}
		
		public function InitBut():void {
			var buts:Array = new Array(QUANT-1);
			var i:int;
			var j:int;
			var count:int = 0;
		
			for(i = 0; i <QUANT-1; i++) {
				buts[i] = new Array(QUANT-1);
				for (j = 0; j < QUANT-1; j++) {
					var row:but = new but(count, boxs);
					count++;
					row.x = (j + PADDING) * (boxs[0][0].width) + boxs[0][0].width/2;
					row.y = (i + PADDING) * (boxs[0][0].width) + boxs[0][0].width/2;
					buts[i][j] = row; 
					addChild(buts[i][j]);
				}
			}
		}	
		
	}
}
