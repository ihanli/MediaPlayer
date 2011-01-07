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
			
			volumeSlider.addEventListener("VOLUME_CHANGED", volumeChanged);

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
			tracklist.addEventListener("NEXT", refreshControls);
			
			addChild(volumeSlider);
			addChild(timeline);
			addChild(controls);
			addChild(tracklist);
		}
		
		private function onTimeChanged(event:Event):void
		{
			tracklist.elapsedTime = timeline.value;
		}
		
		private function volumeChanged(event:Event = null):void
		{
			tracklist.volume = volumeSlider.value;
		}
		
		private function onEnterFrame(event:Event):void
		{
			timeline.value = tracklist.elapsedTime;
		}
		
		private function onPlay(event:Event = null):void
		{
			volumeChanged();
			tracklist.start();
			timeline.max = tracklist.totalTime;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			timeline.addEventListener("TIME_CHANGED", onTimeChanged);
		}
		
		private function onPause(event:Event):void
		{
			tracklist.pause();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			timeline.removeEventListener("TIME_CHANGED", onTimeChanged);
		}
		
		private function onStop(event:Event):void
		{
			tracklist.reset();
			timeline.max = tracklist.totalTime;
			timeline.value = 0;
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			timeline.removeEventListener("TIME_CHANGED", onTimeChanged);
		}
		
		private function refreshControls(event:Event = null):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			volumeChanged();
			timeline.max = tracklist.totalTime;
			timeline.value = 0;
			controls.pressPlay();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			timeline.addEventListener("TIME_CHANGED", onTimeChanged);
		}
	}
}