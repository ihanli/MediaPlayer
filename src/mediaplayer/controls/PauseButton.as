package mediaplayer.controls
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class PauseButton extends ControlButton
	{
		public function PauseButton()
		{
			super();
		}
		
		override protected function mouseHandler(e:MouseEvent):void
		{
			super.mouseHandler(e);
			
			if(mouseState == DOWN)
				dispatchEvent(new Event("pause"));
		}
		
		override protected function render():void
		{
			super.render();
			super.graphics.drawRect(BUTTONOFFSET * 2, BUTTONOFFSET, BUTTONOFFSET * 2, BUTTONDIMENSION - BUTTONOFFSET *2);
			super.graphics.drawRect(BUTTONOFFSET * 6, BUTTONOFFSET, BUTTONOFFSET *2, BUTTONDIMENSION - BUTTONOFFSET *2);
		}
	}
}