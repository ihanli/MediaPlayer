package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mediaplayer.elements.HSlider;
	import mediaplayer.elements.ScrubBar;
	import mediaplayer.elements.VolumeControl;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			var bla:VolumeControl = new VolumeControl;
			var timeline:ScrubBar = new ScrubBar(0,88200);
			
			timeline.x = 0;
			timeline.y = 15;

			addChild(bla);
			addChild(timeline);
			
			bla.addEventListener("VOLUME_CHANGED", volumeHandler);
		}
		
		private function volumeHandler(event:Event):void
		{
			trace(event.currentTarget);
		}
	}
}