package mediaplayer.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PlayButton extends ControlButton
	{
		public function PlayButton()
		{
			super();
		}
		
		override protected function mouseHandler(e:MouseEvent):void
		{
			super.mouseHandler(e);

			if(mouseState == DOWN)
				dispatchEvent(new Event("play"));
		}
		
		override protected function render():void
		{
			super.render();
			super.graphics.lineStyle(1, 0x000000);
			super.graphics.moveTo(BUTTONOFFSET, BUTTONOFFSET);
			super.graphics.lineTo(BUTTONDIMENSION - BUTTONOFFSET, BUTTONDIMENSION / 2);
			super.graphics.lineTo(BUTTONOFFSET, BUTTONDIMENSION - BUTTONOFFSET);
			super.graphics.lineTo(BUTTONOFFSET, BUTTONOFFSET);
		}
	}
}