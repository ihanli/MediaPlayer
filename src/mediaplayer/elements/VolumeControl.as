package mediaplayer.elements
{
	import flash.events.MouseEvent;
	import flash.events.Event
	
	public class VolumeControl extends HSlider
	{
		public function VolumeControl()
		{
			super();
		}
		
		protected override function mouseMoveHandler(event:MouseEvent):void
		{
			super.mouseMoveHandler(event);
			
			dispatchEvent(new Event("VOLUME_CHANGED"));
		}
	}
}