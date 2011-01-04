package mediaplayer.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class ScrubBar extends HSlider
	{
		private const SAMPLINGRATE:uint = 44100;
		private var _maxSamples:uint;
		private var _currentSample:uint;
		private var tfMaxSamples:TextField = new TextField;
		private var tfCurrentSample:TextField = new TextField;
		
		public function ScrubBar(pmin:int=0, pmax:int=1)
		{
			super(pmin, pmax, 0);
			
			tfMaxSamples.defaultTextFormat = new TextFormat("Arial", 10);
			tfMaxSamples.multiline = false;
			tfMaxSamples.selectable = false;
			tfMaxSamples.wordWrap = true;
			tfMaxSamples.height = super.height;
			tfMaxSamples.x = super.x + super.width;
			tfMaxSamples.y = super.y;
			
			if(pmax > 1){
				tfMaxSamples.text = samplesToTime(pmax);
			}
			else{
				tfMaxSamples.text = "0:0"
			}
			
			tfCurrentSample.defaultTextFormat = new TextFormat("Arial", 10);
			tfCurrentSample.multiline = false;
			tfCurrentSample.selectable = false;
			tfCurrentSample.wordWrap = true;
			tfCurrentSample.height = super.height;
			tfCurrentSample.text = "0:0";
			tfCurrentSample.width = tfCurrentSample.textWidth * 1.5;

			tfCurrentSample.x = super.x - tfCurrentSample.textWidth - 5;
			tfCurrentSample.y = super.y;

			addChild(tfMaxSamples);
			addChild(tfCurrentSample);
		}
		
		protected override function mouseMoveHandler(event:MouseEvent):void
		{
			super.mouseMoveHandler(event);
			
			tfCurrentSample.text = samplesToTime(super.value);
			dispatchEvent(new Event("TIME_CHANGED"));
		}
		
		private function samplesToTime(samples:uint):String
		{
			var seconds:uint, minutes:uint;
			
			minutes = samples / SAMPLINGRATE / 3600;
			seconds = (samples / SAMPLINGRATE) % 3600;

			return minutes + ":" + seconds;
		}

		public function get maxSamples():uint
		{
			return _maxSamples;
		}

		public function set maxSamples(value:uint):void
		{
			_maxSamples = value;
			
			super.max = _maxSamples;
			tfMaxSamples.text = samplesToTime(value);
		}

		public function get currentSample():uint
		{
			return _currentSample;
		}

		public function set currentSample(value:uint):void
		{
			_currentSample = value;
			
			super.value = value;
			tfCurrentSample.text = samplesToTime(value);
		}
	}
}