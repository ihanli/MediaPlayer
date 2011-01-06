package mediaplayer.core
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Track extends MovieClip
	{
		private var sound:Sound = new Sound;
		private var soundChannel:SoundChannel = new SoundChannel;
		private var lastPosition:Number = 0;
		private var _url:String;
		private var _playing:Boolean = false;
		private var tf:TextField = new TextField;
		
		public function Track(url:String)
		{
			super();

			tf.defaultTextFormat = new TextFormat("Arial", 10);
			tf.background = true;
			tf.backgroundColor = 0xFFFFFF;
			tf.multiline = false;
			tf.selectable = false;
			tf.x = 0;
			tf.y = 0;
			tf.autoSize = TextFieldAutoSize.LEFT;

			_url = url
			sound.load(new URLRequest("runtime-assets/" + url));
			
			sound.addEventListener(Event.COMPLETE, onSoundLoad);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);

			//TODO: sounds will be played simultaniously after double click
			this.doubleClickEnabled = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
		}

		private function onDoubleClick(event:MouseEvent):void
		{
			playing = true;
			dispatchEvent(new Event("SOUND_STARTED"));
		}
		
		public function pause():void
		{
			lastPosition = soundChannel.position;
			stopSound();
		}

		private function stopSound():void
		{
			if(soundChannel)
			{
				soundChannel.stop();
				soundChannel = null;
			}
		}
		
		private function onSoundComplete(event:Event):void {
			removeListeners();
			
			dispatchEvent(new Event(Event.SOUND_COMPLETE));
		}
		
		private function onSoundLoad(event:Event):void {
			removeListeners();
			tf.text = sound.id3.artist + " - " + sound.id3.songName;
			addChild(tf);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		//TODO: handle me
		private function onIOError(event:Event):void {
			removeListeners();

			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
		}
		
		private function removeListeners():void
		{
			sound.removeEventListener(Event.COMPLETE, onSoundLoad);
			sound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		public function set volume(value:Number):void
		{
			if(soundChannel)
			{
				soundChannel.soundTransform.volume = value;
			}
		}
		
		public function get volume():Number
		{
			return soundChannel.soundTransform.volume;
		}
		
		public function get totalTime():Number
		{
			return sound.length;
		}
		
		public function set pan(value:Number):void
		{
			if(soundChannel)
			{
				soundChannel.soundTransform.pan = value;
			}
		}
		
		public function get pan():Number
		{
			return soundChannel.soundTransform.pan;
		}

		public function get playing():Boolean
		{
			return _playing;
		}

		public function set playing(value:Boolean):void
		{
			_playing = value;
			
			if(_playing == true)
			{
				tf.backgroundColor = 0x3333AA;
				soundChannel = sound.play(lastPosition);
			}
			else
			{
				tf.backgroundColor = 0xFFFFFF;
				lastPosition = 0;
				stopSound();
			}
		}

	}
}