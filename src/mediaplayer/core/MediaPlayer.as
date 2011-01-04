package mediaplayer.core
{
	import flash.display.Sprite;
	import mediaplayer.controls.*;
	
	public class MediaPlayer extends Sprite
	{
		public function MediaPlayer()
		{
			super();
			
			var bla:VolumeControl = new VolumeControl;
			var timeline:ScrubBar = new ScrubBar(0,88200);
			var controls:Buttons = new Buttons();
			
			timeline.x = 0;
			timeline.y = 15;
			
			controls.x = 0;
			controls.y = 30;
			
			addChild(bla);
			addChild(timeline);
			addChild(controls);
		}
	}
}