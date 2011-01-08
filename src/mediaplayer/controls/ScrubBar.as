package mediaplayer.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ScrubBar extends HSlider
	{
		public function ScrubBar(pmin:int=0, pmax:int=1)
		{
			super(pmin, pmax, 0);
			
			if(pmax >= 1000){
				super.rightText = mSecondsToTime(pmax);
			}
			else{
				super.rightText = "0:0";
			}

			super.leftText = "0:0";
		}
		
		protected override function mouseMoveHandler(event:MouseEvent):void
		{
			super.mouseMoveHandler(event);
			super.leftText = mSecondsToTime(super.value);
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
			super.rightText = mSecondsToTime(value);
		}

		public override function get value():Number
		{
			return super.value;
		}

		public override function set value(value:Number):void
		{
			super.value = value;
			super.leftText = mSecondsToTime(value);
		}
	}
}