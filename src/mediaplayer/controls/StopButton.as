package mediaplayer.controls
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class StopButton extends ControlButton
	{
		public function StopButton()
		{
			super();
		}
		
		override protected function mouseHandler(e:MouseEvent):void
		{
			super.mouseHandler(e);
			
			if(mouseState == DOWN)
				dispatchEvent(new Event("stop"));
		}
		
		override protected function render():void
		{
			super.render();
			super.graphics.drawRect(BUTTONOFFSET * 2, BUTTONOFFSET * 2, BUTTONDIMENSION - BUTTONOFFSET * 4, BUTTONDIMENSION - BUTTONOFFSET * 4);
		}
	}
}