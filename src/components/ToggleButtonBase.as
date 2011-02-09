package components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ToggleButtonBase extends ButtonBase
	{
		private var _selected:Boolean;
		
		public function ToggleButtonBase()
		{
			super();
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			if (value == _selected)
				return;
			
			_selected = value;
			render();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		override protected function mouseHandler(e:MouseEvent):void
		{
			super.mouseHandler(e);
			
			if (e.type == MouseEvent.CLICK)
				selected = !selected;
		}
		
		override protected function render():void
		{
			graphics.beginFill(_selected ? 0x00ff00 : 0x666666);
			graphics.drawCircle(20, 20, 8);
			graphics.endFill();
		}
	}
}