package mediaplayer.core
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class Track extends Sprite
	{
		private var sound:Sound = new Sound;
		private var soundChannel:SoundChannel;
		private var lastPosition:Number = 0;
		private var _url:String;
		private var _playing:Boolean = false;
		private var tf:TextField = new TextField;
		
		public function Track(url:String)
		{
			super();
			
			this.height = 15;
			this.width = 100;
			
			tf.defaultTextFormat = new TextFormat("Arial", 10);
			tf.background = true;
			tf.backgroundColor = 0xFFFFFF;
			tf.multiline = false;
			tf.height = this.height;
			tf.width = this.width;
			tf.x = 0;
			tf.y = 0;

			_url = url
			sound.load(new URLRequest(url));
			
			sound.addEventListener(Event.COMPLETE, onSoundLoad);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			this.addEventListener(MouseEvent.DOUBLE_CLICK, play);
		}
		
		public function play():void
		{
			soundChannel = sound.play(lastPosition);
		}
		
		public function pause():void
		{
			lastPosition = soundChannel.position;
			stopSound();
		}
		
		public function stop():void
		{
			lastPosition = 0;
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
		
		private function onSoundLoad(event:Event):void {
			removeListeners();
			
			tf.text = sound.id3.artist + " - " + sound.id3.songName;

			addChild(tf);

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
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
				event.updateAfterEvent();
			}
		}
		
		public function get volume():Number
		{
			return soundChannel.soundTransform.volume;
		}
		
		public function set pan(value:Number):void
		{
			if(soundChannel)
			{
				soundChannel.soundTransform.pan = value;
				event.updateAfterEvent();
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
				tf.backgroundColor = 0x3333FF;
			}
			else
			{
				tf.backgroundColor = 0xFFFFFF;
			}
		}

	}
}