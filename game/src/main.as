package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class main extends MovieClip {
		var QUANT:int = 4; //QUANT of boxs
		var PADDING = 1;  //PADDING 
		var myTimer:Timer = new Timer(1000);
		var boxs:Array = new Array(QUANT);
		var mWin:myWin = new myWin();
		
		public function main() {	 
			but_play1.addEventListener(MouseEvent.CLICK, playCll); //play button
			how.addEventListener(MouseEvent.CLICK, howPlay); //how button
			mWin.rest_b.addEventListener(MouseEvent.CLICK, playRST); //restart button
			myTimer.addEventListener(TimerEvent.TIMER,onFrame); //My timer		
			
			function onFrame(e:TimerEvent) {
				var sec:Number = int(myTimer.currentCount%60);
				var min:Number = int(myTimer.currentCount/60);
				var ss:String;
				var mm:String;
				
				if (sec <= 9) 
					ss = "0" + sec;
				else
					ss = "" + sec;
				if (min <= 9) 
					mm = "0" + min;	
				else
					mm = "" + min;
				if (min == 59) { 
					myTime.text = "MORE";
					myTimer.stop();
					return;
				}
				
				myTime.text = mm + ":" + ss;
			}
			
			function playCll (e:MouseEvent) {
				but_play1.removeEventListener(MouseEvent.CLICK, playCll);
				gotoAndStop(5);
				InitBoxs();
				InitBut(); 
				myTimer.start();
				restart_but.addEventListener(MouseEvent.CLICK, playRST); //restart
				stage.addChild(mWin);	
				mWin.visible = false;
			}
			
			function howPlay (e:MouseEvent) {
				var myHelp:help = new help();
				
				myHelp.howBack.addEventListener(MouseEvent.CLICK, howBackf); //how button2			
				myHelp.x=0;
				myHelp.y=0;addChild(myHelp);
				
				function howBackf (e:MouseEvent) {		
					removeChild(myHelp);
				}				
			}
			
			function playRST (e:MouseEvent) {
				var i:int;
				var j:int;
				
				restart_but.visible = true; 
				mWin.visible = false; 
				myTime.text = "00:00";
				myTimer.reset();
				myTimer.start();
				restart_but.play();
				
				for(i = 0; i < QUANT; i++) {
					for (j = 0; j < QUANT; j++) {
						removeChild(boxs[j][i]);
					}
				}

				InitBoxs();
				InitBut(); 
			}
		}
		
		public function InitBoxs():void {
			var i:int;
			var j:int;

			var count:Array = new Array();
			for(i = 0; i < QUANT * QUANT; i++) {
				if(int(Math.random() * 2) % 2 == 0)
					count.push(i);
				else
					count.unshift(i);
			}
			for(i = 0; i < QUANT; i++) {
				boxs[i] = new Array(QUANT);
				for (j = 0; j < QUANT; j++) {
					var row:box = new box(count[i * 4 + j]+1);
					row.x = (j + PADDING) * (row.width + PADDING);
					row.y = (i + PADDING) * (row.width + PADDING) + 50;
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
		
			for(i = 0; i < QUANT-1; i++) {
				buts[i] = new Array(QUANT-1);
				for (j = 0; j < QUANT-1; j++) {
					var row:but = new but(count, boxs, myTimer, restart_but, mWin);
					count++;
					row.x = (j + PADDING) * (boxs[0][0].width + PADDING) + (boxs[0][0].width + PADDING)/2;
					row.y = (i + PADDING) * (boxs[0][0].width + PADDING) + (boxs[0][0].width + PADDING)/2 + 50;
					buts[i][j] = row; 
					addChild(buts[i][j]);
				}
			}
		}	
		
	}
}
