package mediaplayer.controls
{
	import components.ButtonBase;
	
	public class ControlButton extends ButtonBase
	{
		protected const BUTTONDIMENSION:uint = 20;
		protected const BUTTONOFFSET:uint = 2;

		public function ControlButton()
		{
			super();
		}
		
		override protected function render():void
		{
			super.graphics.lineStyle(1, 0x000000);
			
			if(mouseState == DOWN)
				super.graphics.beginFill(0x666666);
			else if(mouseState == OVER)
				super.graphics.beginFill(0x00FF00);
			else				
				super.graphics.beginFill(0xFFFFFF);
			
			super.graphics.drawRoundRect(0, 0, BUTTONDIMENSION, BUTTONDIMENSION, 4);
			super.graphics.endFill();
			
			super.alpha = super.enabled ? 1 : 0.5;
		}
	}
}