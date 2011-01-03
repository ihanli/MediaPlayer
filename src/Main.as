package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mediaplayer.core.MediaPlayer;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			var musicPlayer:MediaPlayer = new MediaPlayer;
			
			addChild(musicPlayer);
		}
	}
}