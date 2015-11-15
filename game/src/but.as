package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.globalization.LastOperationStatus;
	
	public class but extends MovieClip {
		
		private var _value:int;
		private var _boxsi:Array;
		private var _myTimer:Timer; // Timer from the main
		private var QUANT:int = 3; //QUANT of buts
		private var _restart_but:MovieClip;
		private var _mWin:myWin;
		public static var offset;  //offset for swaping
		public static var PADDING = 1;  //PADDING 
		public static var _action = false; //waiting when other rotation will end
		
		public function but(value:int, boxsi:Array, myTimer:Timer, restart_but:MovieClip, mWin:myWin) {
			_value = value;
			_boxsi = boxsi;
			_myTimer = myTimer;
			_restart_but = restart_but;
			_mWin = mWin;
			offset = _boxsi[0][0].width/10 + PADDING/10;  //init offset for swaping
			this.addEventListener(MouseEvent.CLICK, oncll);
		}
		
		private function oncll (e:MouseEvent) {
			var time:Timer = new Timer(20); 
			var tempForFlash:Number; //specially for flash, because fractional coordinates isn't available
			var rotSpeed = _boxsi[Math.floor(_value/QUANT)][_value%QUANT].GetRotSpeed();
			var clc:Number = 0; //for second mode of swapping (without rotation)
			
			time.addEventListener(TimerEvent.TIMER,onFrame);
			if(!_action){
				time.start(); 
				_action = true;
				this.play();
			}

			function onFrame(e:TimerEvent) {
				//_boxsi[Math.floor(_value/QUANT)][_value%QUANT].rotation += rotSpeed;       //first in foursome
				tempForFlash = (_boxsi[Math.floor(_value/QUANT)][_value%QUANT].x * 1000 + offset * 1000) / 1000;  //specially for flash, because fractional coordinates isn't available
				_boxsi[Math.floor(_value/QUANT)][_value%QUANT].x = tempForFlash; 

				//_boxsi[Math.floor(_value/QUANT)][_value%QUANT+1].rotation += rotSpeed;     //second in foursome
				tempForFlash = (_boxsi[Math.floor(_value/QUANT)][_value%QUANT+1].y * 1000 + offset * 1000) / 1000; //specially for flash, because fractional coordinates isn't available
				_boxsi[Math.floor(_value/QUANT)][_value%QUANT+1].y = tempForFlash;
				
				//_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT].rotation += rotSpeed;     //third in foursome
				tempForFlash = (_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT].y * 1000 - offset * 1000) / 1000; //specially for flash, because fractional coordinates isn't available
				_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT].y = tempForFlash;
				
				//_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT+1].rotation += rotSpeed;   //fourth in foursome
				tempForFlash = (_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT+1].x*1000 - offset*1000)/1000; //specially for flash, because fractional coordinates isn't available
				_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT+1].x = tempForFlash;	
				
				clc +=  rotSpeed; //for second mode of swapping (without rotation)
				
				if( clc == 360) { //for first mode of swapping (with rotation) - (_boxsi[Math.floor(_value/QUANT)][_value%QUANT].rotation == 0)
					time.stop();
					reset();
					win(); //check winning
					_action = false;
				}
			}
			
			function reset(){
				var tempp = _boxsi[Math.floor(_value/QUANT)][_value%QUANT]; 
				 _boxsi[Math.floor(_value/QUANT)][_value%QUANT] = _boxsi[Math.floor(_value/QUANT)+1][_value%QUANT];  
				
				var tempp1 = _boxsi[Math.floor(_value/QUANT)][_value%QUANT+1]; 
				 _boxsi[Math.floor(_value/QUANT)][_value%QUANT+1] = tempp; 
				
				tempp = _boxsi[Math.floor(_value/QUANT)+1][_value%QUANT+1];
				 _boxsi[Math.floor(_value/QUANT)+1][_value%QUANT+1] = tempp1; 
				
				 _boxsi[Math.floor(_value/QUANT)+1][_value%QUANT]  = tempp;
			}		
		}
		
		public function win(){ //check winning
			var i:int;
			var j:int;
			var WIN:Boolean = true;
			
			
			for(i = 0; i < QUANT+1; i++) {
				for (j = 0; j < QUANT+1; j++) {
					if(!_boxsi[i][j].win(i, j))
						WIN = false;
				}
			}

			if(WIN){
				_myTimer.stop();
				var sec:Number = int(_myTimer.currentCount%60);
				var min:Number = int(_myTimer.currentCount/60);
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
				if (min == 59)  
					_mWin.mt.text = "MORE";

				_mWin.mt.text = mm + ":" + ss;	
				_mWin.y = _mWin.width/2+70; _mWin.x = _mWin.height/2+27;
				_mWin.visible = true;	
				_restart_but.visible = false; 
				trace("you win");	
			}
		}
	}
}
