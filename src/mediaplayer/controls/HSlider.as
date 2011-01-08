package mediaplayer.controls
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class HSlider extends Sprite
	{
		private var _value:Number;
		private var _min:int;
		private var _max:int;
		private var draggedInstance:Sprite;

		private const RAILWIDTH:uint = 100;
		
		private var thumb:Sprite = new Sprite;
		private const THUMBDIMENSION:uint = 10;
		private const THUMBOFFSET:uint = 2;
		
		private var tfLeft:TextField = new TextField;
		private var tfRight:TextField = new TextField;
		
		public function HSlider(pmin:int = 0, pmax:int = 1, startValue:Number = 0.3)
		{
			super();
			
			_min = pmin;
			_max = pmax;
			value = startValue;

			this.graphics.lineStyle(1, 0x000000);
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawRect(0, 0, RAILWIDTH + THUMBDIMENSION + 2 * THUMBOFFSET, THUMBDIMENSION + 2 * THUMBOFFSET);
			this.graphics.endFill();
			this.x = 0;
			this.y = 0;
			
			thumb.graphics.lineStyle(1, 0x000000);
			thumb.graphics.beginFill(0xFFFFFF);
			thumb.graphics.drawRect(THUMBOFFSET, THUMBOFFSET, THUMBDIMENSION, THUMBDIMENSION);
			thumb.graphics.endFill();
			
			tfRight.defaultTextFormat = new TextFormat("Arial", 10);
			tfRight.multiline = false;
			tfRight.selectable = false;
			tfRight.wordWrap = true;
			tfRight.height = THUMBDIMENSION + 2* THUMBOFFSET;
			tfRight.x = this.x + RAILWIDTH + THUMBDIMENSION + 2 * THUMBOFFSET;
			tfRight.y = this.y;
			
			tfLeft.defaultTextFormat = new TextFormat("Arial", 10);
			tfLeft.multiline = false;
			tfLeft.selectable = false;
			tfLeft.wordWrap = true;
			tfLeft.height = THUMBDIMENSION + 2* THUMBOFFSET;
			tfLeft.x = this.x - tfLeft.textWidth - THUMBDIMENSION;
			tfLeft.y = this.y;

			addChild(tfRight);
			addChild(tfLeft);
			addChild(thumb);
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
		
		protected function mouseMoveHandler(event:MouseEvent):void
		{
			draggedInstance.x = Math.max(0, Math.min(RAILWIDTH, mouseX));
			
			_value = (_max * draggedInstance.x / RAILWIDTH) + (_min * (RAILWIDTH - draggedInstance.x) / RAILWIDTH);
		}
		
		public function set leftText(value:String):void
		{
			tfLeft.text = value.toString();
			tfLeft.x = this.x - tfLeft.textWidth - THUMBDIMENSION - THUMBOFFSET * 2;
		}
		
		public function set rightText(value:String):void
		{
			tfRight.text = value.toString();
			tfRight.autoSize = TextFieldAutoSize.LEFT;
		}

		public function get min():int
		{
			return _min;
		}

		public function set min(value:int):void
		{
			_min = value;
			
			this.value = (max * thumb.x / RAILWIDTH) + (min * (RAILWIDTH - thumb.x) / RAILWIDTH);
		}

		public function get max():int
		{
			return _max;
		}

		public function set max(value:int):void
		{
			_max = value;
			
			this.value = (max * thumb.x / RAILWIDTH) + (min * (RAILWIDTH - thumb.x) / RAILWIDTH);
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