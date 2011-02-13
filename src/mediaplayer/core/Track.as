package mediaplayer.core
{
	import components.DragableItem;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Track extends DragableItem
	{
		private var sound:Sound = new Sound;
		private var soundChannel:SoundChannel = new SoundChannel;
		private var lastPosition:Number = 0;
		private var _url:String;
		private var _playing:Boolean = false;
		private var _volume:Number = 0;
		private var _pan:Number = 0;
		private var tf:TextField = new TextField;
		
		public function Track(url:String)
		{
			super();

			tf.defaultTextFormat = new TextFormat("Arial", 10);
			tf.background = true;
			tf.multiline = false;
			tf.selectable = false;
			tf.x = 0;
			tf.y = 1;
			tf.autoSize = TextFieldAutoSize.LEFT;

			_url = url
			sound.load(new URLRequest("runtime-assets/" + url));
			sound.addEventListener(Event.COMPLETE, onSoundLoad);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);

			this.doubleClickEnabled = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
		}
		
		private function removeListeners():void
		{
			sound.removeEventListener(Event.COMPLETE, onSoundLoad);
			sound.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}

		private function onDoubleClick(e:MouseEvent):void
		{
			dispatchEvent(new Event("sound_started"));
		}
		
		private function onSoundComplete(e:Event):void
		{
			removeListeners();
			dispatchEvent(new Event(Event.SOUND_COMPLETE));
		}
		
		private function onSoundLoad(e:Event):void
		{
			removeListeners();
			tf.text = sound.id3.artist + " - " + sound.id3.songName;
			addChild(tf);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		//TODO: handle me
		private function onIOError(e:Event):void
		{
			removeListeners();
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
		}
		
		override protected function mouseUpHandler(e:MouseEvent):void
		{
			var temp:Track = e.target as Track;
			
			super.mouseUpHandler(e);
			
			// mouseUp event fired after dragging
			if(temp)
			{
				if(dragging)
					temp.dispatchEvent(new Event("stop_drag"));
				
				dragging = false;
				temp.render();
			}
		}
		
		// renders the marker, which indicates where the selected items will be dropped
		private function renderMarker():void
		{
			if(mouseState == OVER)
				super.graphics.lineStyle(2, 0x00FF00);
			else				
				super.graphics.lineStyle(2, 0xFFFFFF);
		}
		
		override protected function render():void
		{		
			if(dragging)
				renderMarker();
			else
				super.graphics.lineStyle(2, 0xFFFFFF);

			graphics.moveTo(this.x + 1, 1);
			graphics.lineTo(this.x + tf.width - 1, 1);
			
			tf.backgroundColor = selected ? 0x3333AA : 0xFFFFFF;
		}
		
		private function stopSound():void
		{
			if(soundChannel)
			{
				soundChannel.stop();
				_volume = soundChannel.soundTransform.volume;
				soundChannel = null;
			}
		}
		
		public function pause():void
		{
			lastPosition = soundChannel.position;
			stopSound();
		}

		public function set volume(value:Number):void
		{
			_volume = value;
			
			if(soundChannel)
				soundChannel.soundTransform = new SoundTransform(value);
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		
		public function get totalTime():Number
		{
			return sound.length;
		}
		
		public function get elapsedTime():Number
		{
			return soundChannel.position;
		}
		
		public function set elapsedTime(value:Number):void
		{
			stopSound();
			soundChannel = sound.play(value, 0, new SoundTransform(_volume));
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		public function set pan(value:Number):void
		{
			_pan = value;
			
			if(soundChannel)
				soundChannel.soundTransform = new SoundTransform(volume, value);
		}
		
		public function get pan():Number
		{
			return _pan;
		}

		public function get playing():Boolean
		{
			return _playing;
		}

		public function set playing(value:Boolean):void
		{
			_playing = value;
			selected = value;
			
			if(_playing)
			{
				soundChannel = sound.play(lastPosition, 0, new SoundTransform(_volume));
				pan = _pan;
				soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
			else
			{
				lastPosition = 0;
				stopSound();
			}
			
			render();
		}
	}
}