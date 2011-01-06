package mediaplayer.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class ScrubBar extends HSlider
	{
		private var _maxTime:uint;
		private var _currentTime:uint;
		private var tfMaxTime:TextField = new TextField;
		private var tfCurrentTime:TextField = new TextField;
		
		public function ScrubBar(pmin:int=0, pmax:int=1)
		{
			super(pmin, pmax, 0);
			
			tfMaxTime.defaultTextFormat = new TextFormat("Arial", 10);
			tfMaxTime.multiline = false;
			tfMaxTime.selectable = false;
			tfMaxTime.wordWrap = true;
			tfMaxTime.height = super.height;
			tfMaxTime.x = super.x + super.width;
			tfMaxTime.y = super.y;
			
			if(pmax > 1){
				tfMaxTime.text = mSecondsToTime(pmax);
			}
			else{
				tfMaxTime.text = "0:0"
			}
			
			tfCurrentTime.defaultTextFormat = new TextFormat("Arial", 10);
			tfCurrentTime.multiline = false;
			tfCurrentTime.selectable = false;
			tfCurrentTime.wordWrap = true;
			tfCurrentTime.height = super.height;
			tfCurrentTime.text = "0:0";
			tfCurrentTime.width = tfCurrentTime.textWidth * 1.5;

			tfCurrentTime.x = super.x - tfCurrentTime.textWidth - 5;
			tfCurrentTime.y = super.y;

			addChild(tfMaxTime);
			addChild(tfCurrentTime);
		}
		
		protected override function mouseMoveHandler(event:MouseEvent):void
		{
			super.mouseMoveHandler(event);
			
			tfCurrentTime.text = mSecondsToTime(super.value);
			dispatchEvent(new Event("TIME_CHANGED"));
		}
		
		private function mSecondsToTime(value:uint):String
		{
			var seconds:uint, minutes:uint;
			
			minutes = value / 1000 / 60;
			seconds = (value / 1000) % 60;

			return minutes + ":" + seconds;
		}

		public function get maxTime():uint
		{
			return _maxTime;
		}

		public function set maxTime(value:uint):void
		{
			_maxTime = value;
			
			super.max = _maxTime;
			tfMaxTime.text = mSecondsToTime(value);
		}

		public function get currentTime():uint
		{
			return _currentTime;
		}

		public function set currentTime(value:uint):void
		{
			_currentTime = value;
			
			super.value = value;
			tfCurrentTime.text = mSecondsToTime(value);
		}
	}
}