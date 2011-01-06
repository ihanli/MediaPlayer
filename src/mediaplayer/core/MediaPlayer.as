package mediaplayer.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mediaplayer.controls.*;
	
	public class MediaPlayer extends Sprite
	{
		private var volumeSlider:VolumeControl = new VolumeControl;
		private var timeline:ScrubBar = new ScrubBar(0, 0);
		private var controls:Buttons = new Buttons();
		private var tracklist:Tracklist = new Tracklist();
		
		public function MediaPlayer()
		{
			super();

			timeline.x = 0;
			timeline.y = 15;
			
			controls.x = 0;
			controls.y = 30;
			controls.addEventListener("PLAY", onPlay);
			controls.addEventListener("PAUSE", onPause);
			controls.addEventListener("STOP", onStop);
			
			tracklist.source = "runtime-assets/tracks.xml";
			tracklist.x = 0;
			tracklist.y = 51;
			tracklist.addEventListener("NEXT", refreshTotalTime);
			
			addChild(volumeSlider);
			addChild(timeline);
			addChild(controls);
			addChild(tracklist);
		}
		
		private function onPlay(event:Event):void
		{
			tracklist.start();
			refreshTotalTime();
		}
		
		private function onPause(event:Event):void
		{
			tracklist.pause();
		}
		
		private function onStop(event:Event):void
		{
			tracklist.reset()
		}
		
		private function refreshTotalTime(event:Event = null):void
		{
			timeline.maxTime = tracklist.totalTime;
		}
	}
}