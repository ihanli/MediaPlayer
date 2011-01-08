package mediaplayer.controls
{
	import flash.events.MouseEvent;
	import flash.events.Event
	
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
			
			dispatchEvent(new Event("VOLUME_CHANGED"));
		}
	}
}