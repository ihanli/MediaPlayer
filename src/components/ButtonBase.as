package components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ButtonBase extends Sprite
	{
		public static const UP:String = "up";
		public static const OVER:String = "over";
		public static const DOWN:String = "down";
		public static const triggersToStates:Object = {
			mouseUp: OVER,
			mouseDown: DOWN,
			mouseOut: UP,
			mouseOver: OVER
		};
		
		private var _enabled:Boolean = true;
		private var _mouseState:String = UP;
		
		public function ButtonBase()
		{
			mouseChildren = false;
			
			super();
			
			addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			addEventListener(MouseEvent.CLICK, mouseHandler);
			
			render();
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			if (value == _enabled)
				return;
			
			_enabled = value;
			
			if (!enabled)
				_mouseState = UP;
			
			render();
			
		}
		
		public function get mouseState():String
		{
			return _mouseState;
		}
		
		public function set mouseState(value:String):void
		{
			if (value == _mouseState)
				return;
			
			_mouseState = value;
			render();
		}
		
		protected function mouseHandler(e:MouseEvent):void
		{
			if (!enabled)
			{
				e.stopImmediatePropagation();
				render();
				return;
			}
			
			mouseState = triggersToStates[e.type] || mouseState;
		}
		
		protected function render():void
		{
			trace("TODO: implement render function");
		}
	}
}