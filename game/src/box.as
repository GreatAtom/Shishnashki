package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class box extends MovieClip 
	{
		private var _value:int;
		private var _rotSpeed = 36;

		public function box(value:int) {   
			_value = value;
		}
		
		public function GetValue():int {   
			return _value;
		}
		
		public function GetRotSpeed():int {   
			return _rotSpeed;
		}
		
		public function SetValue(value:int) {   
			_value = value;
		}
		
		public function win(i:int, j:int) { //check winning  
			if(GetValue() == i * 4 + j + 1){
				gotoAndPlay(GetValue()+16);
				stop();
			}else{
				gotoAndPlay(GetValue());
				stop();
			}
		}
	}
}
