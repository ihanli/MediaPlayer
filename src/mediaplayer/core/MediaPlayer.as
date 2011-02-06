package mediaplayer.core
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mediaplayer.controls.*;
	
	public class MediaPlayer extends Sprite
	{
		private var volumeSlider:VolumeControl = new VolumeControl;
		private var timeline:ScrubBar = new ScrubBar(0, 0);
		private var play:PlayButton = new PlayButton();
		private var pause:PauseButton = new PauseButton();
		private var stop:StopButton = new StopButton();
		private var balance:BalanceControl = new BalanceControl(-1, 1, 0);
		private var trackInstance:Track;
		
		public function MediaPlayer()
		{
			super();
			
			volumeSlider.addEventListener("volume_changed", volumeChanged);
			
			balance.addEventListener("balance_changed", balanceChanged);
			balance.x = 0;
			balance.y = 15;

			timeline.x = 0;
			timeline.y = 30;
			
			play.x = 0;
			play.y = 45;
			play.addEventListener("play", onPlay);
						
			pause.x = play.x + play.width + 5;
			pause.y = 45;
			pause.addEventListener("pause", onPause);
			pause.enabled = false;
			
			stop.x = pause.x + pause.width + 5;
			stop.y = 45;
			stop.addEventListener("stop", onStop);
			stop.enabled = false;
			
			addChild(volumeSlider);
			addChild(balance);
			addChild(timeline);
			addChild(play);
			addChild(pause);
			addChild(stop);
		}

		public function set track(value:Track):void
		{
			trackInstance = value;
		}
		
		private function balanceChanged(event:Event = null):void
		{
			trackInstance.pan = balance.value;
		}
		
		private function onTimeChanged(event:Event):void
		{
			trackInstance.elapsedTime = timeline.value;
		}
		
		private function volumeChanged(event:Event = null):void
		{
			trackInstance.volume = volumeSlider.value;
		}
		
		private function onEnterFrame(event:Event):void
		{
			timeline.value = trackInstance.elapsedTime;
		}
		
		private function onPlay(event:Event = null):void
		{
			triggerDependentButtonState("play");
			volumeChanged();
			balanceChanged();
			trackInstance.playing = true;
			timeline.max = trackInstance.totalTime;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			timeline.addEventListener("time_changed", onTimeChanged);
		}
		
		private function onPause(event:Event):void
		{
			triggerDependentButtonState("pause");
			trackInstance.pause();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			timeline.removeEventListener("time_changed", onTimeChanged);
		}
		
		private function onStop(event:Event):void
		{
			triggerDependentButtonState("stop");
			trackInstance.playing = false;
			timeline.max = trackInstance.totalTime;
			timeline.value = 0;
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			timeline.removeEventListener("time_changed", onTimeChanged);
		}
		
		public function setToPlaying():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			volumeChanged();
			balanceChanged();
			timeline.max = trackInstance.totalTime;
			timeline.value = 0;
			triggerDependentButtonState("play");
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			timeline.addEventListener("time_changed", onTimeChanged);
		}
		
		private function triggerDependentButtonState(button:String):void
		{
			switch(button){
				case "play":
					stop.enabled = true;
					pause.enabled = true;
					play.enabled = false;
					break;
				case "pause":
					play.enabled = true;
					stop.enabled = true;
					pause.enabled = false;
					break;
				case "stop":
					play.enabled = true;
					pause.enabled = false;
					stop.enabled = false;
					break;
			}
		}
	}
}