package mediaplayer.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;

	public class ScrubBar extends HSlider
	{
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
			tfMaxTime.autoSize = TextFieldAutoSize.LEFT;
			
			if(pmax >= 1000){
				tfMaxTime.text = mSecondsToTime(pmax);
			}
			else{
				tfMaxTime.text = "0:0"
			}
			
			tfMaxTime.width = tfMaxTime.textWidth * 1.7;
			
			tfCurrentTime.defaultTextFormat = new TextFormat("Arial", 10);
			tfCurrentTime.multiline = false;
			tfCurrentTime.selectable = false;
			tfCurrentTime.wordWrap = true;
			tfCurrentTime.height = super.height;
			tfCurrentTime.text = "0:0";
			tfCurrentTime.width = tfCurrentTime.textWidth * 1.7;
			tfCurrentTime.autoSize = TextFieldAutoSize.LEFT;

			tfCurrentTime.x = super.x - tfCurrentTime.textWidth - 10;
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

		public override function get max():int
		{
			return super.max;
		}

		public override function set max(value:int):void
		{
			super.max = value;
			tfMaxTime.text = mSecondsToTime(value);
		}

		public override function get value():Number
		{
			return super.value;
		}

		public override function set value(value:Number):void
		{
			super.value = value;
			tfCurrentTime.text = mSecondsToTime(value);
		}
	}
}