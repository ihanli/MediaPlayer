package mediaplayer.controls
{
	import flash.events.MouseEvent;
	import flash.events.Event
	
	public class BalanceControl extends HSlider
	{
		public function BalanceControl(pmin:int=0, pmax:int=1, startValue:Number=0.3)
		{
			super(pmin, pmax, startValue);
			super.leftText = "left";
			super.rightText = "right";
		}
		
		protected override function mouseMoveHandler(event:MouseEvent):void
		{
			super.mouseMoveHandler(event);
			
			dispatchEvent(new Event("BALANCE_CHANGED"));
		}
	}
}