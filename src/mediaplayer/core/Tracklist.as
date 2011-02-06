package mediaplayer.core
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Tracklist extends MovieClip
	{
		private var _source:String;
		private var urlLoader:URLLoader;
		private var tracks:Vector.<Track> = new Vector.<Track>();
		private var loadIndex:uint = 0;
		private var playIndex:uint = 0;
		private var trackCount:uint = 0;
		
		public function Tracklist()
		{
			super();
		}
		
		public function get getCurrentTrack():Track
		{
			return tracks[playIndex];
		}

		public function get source():String
		{
			return _source;
		}

		public function set source(value:String):void
		{
			_source = value;
			urlLoader = new URLLoader();
			
			var urlRequest:URLRequest = new URLRequest(_source);
			
			urlLoader.addEventListener(Event.COMPLETE, loadingCompleteHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, loadingErrorHandler);
			urlLoader.load(urlRequest);
		}

		private function loadingCompleteHandler(event:Event):void
		{
			urlLoader.removeEventListener(Event.COMPLETE, loadingCompleteHandler);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loadingErrorHandler);
			
			var xmlString:String = urlLoader.data;
			var xml:XML;
			
			try{
				xml = XML(xmlString);
			}
			catch (error:Error){
				trace("Something went terribly wrong!");
			}
			
			var listOfTracks:XMLList = xml..track;
			trackCount = listOfTracks.length();
			
			for each(var node:XML in xml.track) {
				var temporaryTrack:Track = new Track(node.attribute("source").toString());
				temporaryTrack.addEventListener(Event.COMPLETE, onLoad);
				temporaryTrack.addEventListener("sound_started", handlePreviousSound);
				temporaryTrack.addEventListener(Event.SOUND_COMPLETE, playNext);
				tracks.push(temporaryTrack);
			}
		}
		
		private function playNext(event:Event):void
		{
			tracks[playIndex].playing = false;
			
			if(playIndex + 1 > tracks.length - 1)
				playIndex = 0;
			else
				playIndex++;
			
			tracks[playIndex].playing = true;
			
			dispatchEvent(new Event("next"));
		}

		private function onLoad(event:Event):void
		{
			addChild(tracks[loadIndex]);
			tracks[loadIndex].y = loadIndex * tracks[loadIndex].height;
			loadIndex++;
			
			if(loadIndex == trackCount)
				dispatchEvent(new Event("tracklist_complete"));
		}
		
		private function handlePreviousSound(event:Event):void
		{
			var temporaryTrack:Track = event.target as Track;
			
			tracks[playIndex].playing = false;
			temporaryTrack.playing = true;

			for(var i:uint = 0;i < tracks.length;i++)
			{
				if(tracks[i].playing == true)
					playIndex = i;
			}
			
			dispatchEvent(new Event("next"));
		}
		
		private function loadingErrorHandler(event:IOErrorEvent):void
		{
			urlLoader.removeEventListener(Event.COMPLETE, loadingCompleteHandler);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loadingErrorHandler);
			
			throw new Error("Loading of Tracks XML failed " + event.text);
		}
	}
}