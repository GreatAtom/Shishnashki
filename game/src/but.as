package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class but extends MovieClip {
		
		private var _value:int;
		private var _boxsi:Array;
		private var QUANT:int = 3; //QUANT of buts
		public static var offset;  //offset for swaping
		public static var PADDING = 1;  //PADDING 
		public static var _action = false; //waiting when other rotation will end
		
		public function but(value:int, boxsi: Array) {
			_value = value;
			_boxsi = boxsi;
			offset = _boxsi[0][0].width/10 + PADDING/10;  //init offset for swaping
			this.addEventListener(MouseEvent.CLICK, oncll);
		}
		
		private function oncll (e:MouseEvent) {
			var time:Timer = new Timer(30); 
			var tempForFlash:Number; //specially for flash, because fractional coordinates isn't available
			var rotSpeed = _boxsi[Math.floor(_value/QUANT)][_value%QUANT].GetRotSpeed(); 
			
			time.addEventListener(TimerEvent.TIMER,onFrame);
			if(!_action){
				time.start(); 
				_action = true;
				this.play();
			}

			function onFrame(e:TimerEvent) {
				_boxsi[Math.floor(_value/QUANT)][_value%QUANT].rotation += rotSpeed;       //first in foursome
				tempForFlash = (_boxsi[Math.floor(_value/QUANT)][_value%QUANT].x * 1000 + offset * 1000) / 1000;  //specially for flash, because fractional coordinates isn't available
				_boxsi[Math.floor(_value/QUANT)][_value%QUANT].x = tempForFlash; 

				_boxsi[Math.floor(_value/QUANT)][_value%QUANT+1].rotation += rotSpeed;     //second in foursome
				tempForFlash = (_boxsi[Math.floor(_value/QUANT)][_value%QUANT+1].y * 1000 + offset * 1000) / 1000; //specially for flash, because fractional coordinates isn't available
				_boxsi[Math.floor(_value/QUANT)][_value%QUANT+1].y = tempForFlash;
				
				_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT].rotation += rotSpeed;     //third in foursome
				tempForFlash = (_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT].y * 1000 - offset * 1000) / 1000; //specially for flash, because fractional coordinates isn't available
				_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT].y = tempForFlash;
				
				_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT+1].rotation += rotSpeed;   //fourth in foursome
				tempForFlash = (_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT+1].x*1000 - offset*1000)/1000; //specially for flash, because fractional coordinates isn't available
				_boxsi[Math.floor(_value/QUANT)+1][_value%QUANT+1].x = tempForFlash;	

				if(_boxsi[Math.floor(_value/QUANT)][_value%QUANT].rotation == 0) {
					time.stop();
					reset();trace(_boxsi[Math.floor(_value/QUANT)][_value%QUANT].x, _boxsi[Math.floor(_value/QUANT)][_value%QUANT].y);           //////////////////////////////////////////
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
					
			for(i = 0; i < QUANT+1; i++) {
				for (j = 0; j < QUANT+1; j++) {
					_boxsi[i][j].win(i, j);
				}
			}
		}
	}
}
