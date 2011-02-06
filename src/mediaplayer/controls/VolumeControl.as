package mediaplayer.controls
{
	import flash.events.MouseEvent;
	import flash.events.Event
	import components.HSlider;
	
	public class VolumeControl extends HSlider
	{
		public function VolumeControl()
		{
			super();
			super.leftText = "0%";
			super.rightText = "100%";
		}
		
		protected override function mouseMoveHandler(event:MouseEvent):void
		{
			super.mouseMoveHandler(event);
			
			dispatchEvent(new Event("volume_changed"));
		}
	}
}