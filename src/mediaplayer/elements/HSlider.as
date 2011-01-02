package mediaplayer.elements
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class HSlider extends Sprite
	{
		private var _value:Number;
		private var _min:int;
		private var _max:int;
		private var draggedInstance:Sprite;
		
		private var rail:Sprite;
		private const RAILWIDTH:uint = 100;
		
		private var thumb:Sprite;
		private const THUMBDIMENSION:uint = 10;
		private const THUMBOFFSET:uint = 2;
		
		public function HSlider()
		{
			super();
			
			_min = 0;
			_max = 1;
			_value = 0;
			
			rail = new Sprite;
			rail.graphics.lineStyle(1, 0x000000);
			rail.graphics.beginFill(0xFFFFFF);
			rail.graphics.drawRect(0, 0, RAILWIDTH + THUMBDIMENSION + 2 * THUMBOFFSET, THUMBDIMENSION + 2 * THUMBOFFSET);
			rail.graphics.endFill();
			rail.x = 0;
			rail.y = 15;

			thumb = new Sprite;
			thumb.graphics.lineStyle(1, 0x000000);
			thumb.graphics.beginFill(0xFFFFFF);
			thumb.graphics.drawRect(THUMBOFFSET, THUMBOFFSET, THUMBDIMENSION, THUMBDIMENSION);
			thumb.graphics.endFill();

			addChild(rail);
			rail.addChild(thumb);
			
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			draggedInstance = event.target as Sprite;
			
			if (draggedInstance)
			{
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				stage.addEventListener(Event.MOUSE_LEAVE, mouseUpHandler);
			}
		}
		
		private function mouseUpHandler(event:Event):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.removeEventListener(Event.MOUSE_LEAVE, mouseUpHandler);
			draggedInstance = null;
		}
		
		private function mouseMoveHandler(event:MouseEvent):void
		{
			draggedInstance.x = Math.max(0, Math.min(RAILWIDTH, mouseX));
			event.updateAfterEvent();
			
			_value = (_max * draggedInstance.x / RAILWIDTH) + (_min * (RAILWIDTH - draggedInstance.x) / RAILWIDTH);
			
			dispatchEvent(new Event("VALUE_CHANGED"));
		}

		public function get min():int
		{
			return _min;
		}

		public function set min(value:int):void
		{
			_min = value;
			
			value = (_max * thumb.x / RAILWIDTH) + (_min * (RAILWIDTH - thumb.x) / RAILWIDTH);
		}

		public function get max():int
		{
			return _max;
		}

		public function set max(value:int):void
		{
			_max = value;
			
			value = (_max * thumb.x / RAILWIDTH) + (_min * (RAILWIDTH - thumb.x) / RAILWIDTH);
		}

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
			
			thumb.x = (RAILWIDTH * (_value - _min)) / (_max - _min);
		}

	}
}