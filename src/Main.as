package
{
	import flash.display.Sprite;
	
	import mediaplayer.elements.HSlider;
	import mediaplayer.elements.VolumeControl;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			var bla:VolumeControl = new VolumeControl;

			addChild(bla);
		}
	}
}