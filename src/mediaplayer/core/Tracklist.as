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
		private var maxContentWidth:uint = 0;
		
		public function Tracklist()
		{
			super();
		}
		
		public function get totalTime():Number
		{
			return tracks[playIndex].totalTime;
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
		
		public function start():void
		{
			tracks[playIndex].playing = true;
		}
		
		public function reset():void
		{
			tracks[playIndex].playing = false;
		}
		
		public function pause():void
		{
			tracks[playIndex].pause();
		}
		
		public function set volume(value:Number):void
		{
			tracks[playIndex].volume = value;
		}
		
		public function set pan(value:Number):void
		{
			tracks[playIndex].pan = value;
		}
		
		private function loadingCompleteHandler(event:Event):void
		{
			urlLoader.removeEventListener(Event.COMPLETE, loadingCompleteHandler);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loadingErrorHandler);
			
			var xmlString:String = urlLoader.data;
			var xml:XML;
			
			try {
				xml = XML(xmlString);
			} catch (error:Error) {
				trace("Something went terribly wrong!");
			}
			
			for each(var node:XML in xml.track) {
				var temporaryTrack:Track = new Track(node.attribute("source").toString());
				temporaryTrack.addEventListener(Event.COMPLETE, onLoad);
				temporaryTrack.addEventListener("SOUND_STARTED", setPlayIndex);
				temporaryTrack.addEventListener(Event.SOUND_COMPLETE, playNext);

				tracks.push(temporaryTrack);
			}
		}
		
		private function playNext(event:Event):void
		{
			tracks[playIndex].playing = false;
			
			if(playIndex + 1 > tracks.length)
			{
				playIndex = 0;
			}
			else
			{
				playIndex++;
			}
			
			tracks[playIndex].playing = true;
			
			dispatchEvent(new Event("NEXT"));
		}

		private function onLoad(event:Event):void
		{
			tracks[loadIndex].removeEventListener(Event.COMPLETE, onLoad);
			addChild(tracks[loadIndex]);

			if(tracks[loadIndex].width > maxContentWidth)
			{
				maxContentWidth = tracks[loadIndex].width + 1;
				render();
			}

			loadIndex++;
		}
		
		private function setPlayIndex(event:Event):void
		{
			for(var i:uint = 0;i < tracks.length;i++)
			{
				if(tracks[i].playing == true)
				{
					playIndex = i;
				}
			}
		}
		
		private function loadingErrorHandler(event:IOErrorEvent):void {
			urlLoader.removeEventListener(Event.COMPLETE, loadingCompleteHandler);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loadingErrorHandler);
			
			throw new Error("Loading of Tracks XML failed " + event.text);
		}
		
		private function render():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.drawRect(0, 0, maxContentWidth, 16);
		}
	}
}