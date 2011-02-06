package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mediaplayer.core.MediaPlayer;
	import mediaplayer.core.Tracklist;
	
	public class Main extends Sprite
	{
		private var musicPlayer:MediaPlayer = new MediaPlayer;
		private var tracklist:Tracklist = new Tracklist();
		
		public function Main()
		{
			tracklist.source = "runtime-assets/tracks.xml";
			tracklist.x = 0;
			tracklist.y = 66;
			tracklist.addEventListener("next", setToPlaying);
			tracklist.addEventListener("tracklist_complete", loadTrackFromList);

			addChild(musicPlayer);
			addChild(tracklist);
		}
		
		private function loadTrackFromList(event:Event = null):void
		{
			musicPlayer.track = tracklist.getCurrentTrack;			
		}
		
		private function setToPlaying(event:Event):void
		{
			loadTrackFromList();
			musicPlayer.setToPlaying();
		}
	}
}