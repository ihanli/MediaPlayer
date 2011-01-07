package mediaplayer.controls
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Buttons extends Sprite
	{
		private var playButton:SimpleButton = new SimpleButton();
		private var stopButton:SimpleButton = new SimpleButton();
		private var pauseButton:SimpleButton = new SimpleButton();

		private const BUTTONDIMENSION:uint = 20;
		private const BUTTONOFFSET:uint = 3;
		
		public function Buttons()
		{
			super();

			playButton.upState = drawPlayIcon();
			playButton.downState = drawPlayIcon();
			playButton.overState = drawPlayIcon();
			playButton.hitTestState = drawPlayIcon();
			playButton.x = 0;
			playButton.y = 0;
			playButton.useHandCursor = true;
			playButton.addEventListener(MouseEvent.CLICK, onPlayHandler);
			addChild(playButton);
			
			pauseButton.upState = drawPauseIcon();
			pauseButton.downState = drawPauseIcon();
			pauseButton.overState = drawPauseIcon();
			pauseButton.hitTestState = drawPauseIcon();
			pauseButton.x = playButton.x + playButton.width + BUTTONOFFSET;
			pauseButton.y = 0;
			pauseButton.useHandCursor = true;
			pauseButton.alpha = 0.5;
			pauseButton.enabled = false;
			addChild(pauseButton);
			
			stopButton.upState = drawStopIcon();
			stopButton.downState = drawStopIcon();
			stopButton.overState = drawStopIcon();
			stopButton.hitTestState = drawStopIcon();
			stopButton.x = pauseButton.x + pauseButton.width + BUTTONOFFSET;
			stopButton.y = 0;
			stopButton.useHandCursor = true;
			stopButton.alpha = 0.5;
			stopButton.enabled = false;
			addChild(stopButton);
		}
		
		public function pressPlay():void
		{
			pauseButton.removeEventListener(MouseEvent.CLICK, onPauseHandler);
			stopButton.removeEventListener(MouseEvent.CLICK, onStopHandler);
			
			stopButton.alpha = 1;
			stopButton.enabled = true;
			pauseButton.alpha = 1;
			pauseButton.enabled = true;
			playButton.alpha = 0.5;
			playButton.enabled = false;
			
			playButton.removeEventListener(MouseEvent.CLICK, onPlayHandler);
			pauseButton.addEventListener(MouseEvent.CLICK, onPauseHandler);
			stopButton.addEventListener(MouseEvent.CLICK, onStopHandler);
		}
		
		private function onPlayHandler(event:MouseEvent = null):void
		{
			pressPlay();
			dispatchEvent(new Event("PLAY"));
		}
		
		private function onPauseHandler(event:MouseEvent):void
		{
			playButton.removeEventListener(MouseEvent.CLICK, onPlayHandler);
			stopButton.removeEventListener(MouseEvent.CLICK, onStopHandler);
			
			pauseButton.alpha = 0.5;
			pauseButton.enabled = false;
			playButton.alpha = 1;
			playButton.enabled = true;
			
			playButton.addEventListener(MouseEvent.CLICK, onPlayHandler);
			pauseButton.removeEventListener(MouseEvent.CLICK, onPauseHandler);
			stopButton.addEventListener(MouseEvent.CLICK, onStopHandler);
			dispatchEvent(new Event("PAUSE"));
		}
		
		private function onStopHandler(event:MouseEvent):void
		{
			playButton.removeEventListener(MouseEvent.CLICK, onPlayHandler);
			pauseButton.removeEventListener(MouseEvent.CLICK, onPauseHandler);
			
			pauseButton.alpha = 0.5;
			pauseButton.enabled = false;
			playButton.alpha = 1;
			playButton.enabled = true;
			stopButton.alpha = 0.5;
			stopButton.enabled = false;
			
			playButton.addEventListener(MouseEvent.CLICK, onPlayHandler);
			stopButton.removeEventListener(MouseEvent.CLICK, onStopHandler);
			dispatchEvent(new Event("STOP"));
		}
		
		private function drawPlayIcon():Sprite
		{
			var playIcon:Sprite = new Sprite();
			
			playIcon.graphics.lineStyle(1, 0x000000);
			playIcon.graphics.beginFill(0xFFFFFF);
			playIcon.graphics.drawRect(0, 0, BUTTONDIMENSION, BUTTONDIMENSION);
			playIcon.graphics.endFill();
			playIcon.graphics.lineStyle(1, 0x000000);
			playIcon.graphics.moveTo(2, 2);
			playIcon.graphics.lineTo(BUTTONDIMENSION - 2, BUTTONDIMENSION / 2);
			playIcon.graphics.lineTo(2, BUTTONDIMENSION - 2);
			playIcon.graphics.lineTo(2, 2);
			
			return playIcon;
		}
		
		private function drawPauseIcon():Sprite
		{
			var pauseIcon:Sprite = new Sprite();
			
			pauseIcon.graphics.lineStyle(1, 0x000000);
			pauseIcon.graphics.beginFill(0xFFFFFF);
			pauseIcon.graphics.drawRect(0, 0, BUTTONDIMENSION, BUTTONDIMENSION);
			pauseIcon.graphics.endFill();
			pauseIcon.graphics.beginFill(0xFFFFFF);
			pauseIcon.graphics.drawRect(2, 2, 5, 16);
			pauseIcon.graphics.endFill();
			pauseIcon.graphics.beginFill(0xFFFFFF);
			pauseIcon.graphics.drawRect(13, 2, 5, 16);
			pauseIcon.graphics.endFill();
			
			return pauseIcon;
		}
		
		private function drawStopIcon():Sprite
		{
			var stopIcon:Sprite = new Sprite();
			
			stopIcon.graphics.lineStyle(1, 0x000000);
			stopIcon.graphics.beginFill(0xFFFFFF);
			stopIcon.graphics.drawRect(0, 0, BUTTONDIMENSION, BUTTONDIMENSION);
			stopIcon.graphics.endFill();
			stopIcon.graphics.beginFill(0xFFFFFF);
			stopIcon.graphics.drawRect(4, 4, 12, 12);
			stopIcon.graphics.endFill();
			
			return stopIcon;
		}
	}
}