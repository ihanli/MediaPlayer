package components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;

	public class DragableItem extends MultiSelectableItem
	{
		private var bitmapData:BitmapData;
		private var proxy:Bitmap;
		private var temp:DragableItem;
		protected static var dragging:Boolean = false;
		
		public function DragableItem()
		{
			
			super();

			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			
			var m:Matrix = new Matrix;
			var bitmapHeight:uint = height;

			temp = event.target as DragableItem;
			
			// set height of proxy according to the number of selected items
			if(numberOfSelected > 0)
				bitmapHeight = height * numberOfSelected;
			else
				return;

			bitmapData = new BitmapData(width + 1, bitmapHeight, false, 0xFFFFFF);
			proxy = new Bitmap(bitmapData, "auto", true);

			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(Event.MOUSE_LEAVE, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			for(var i:uint = 0;i < numberOfSelected;i++)
			{
				// translate along y-axis, except for first item (is at x=y=0 by default)
				if(i > 0)
					m.translate(0, height);
					
				bitmapData.draw(getItemFromContainer(i), m, null, null, null, true);
			}

			// add proxy to stage but don't show it yet
			stage.addChild(proxy);
			proxy.visible = false;
			dragging = false;
		}
		
		protected function mouseUpHandler(e:MouseEvent):void
		{			
			// remove listeners and proxy
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.removeEventListener(Event.MOUSE_LEAVE, mouseUpHandler);
	
			stage.removeChild(proxy);
			temp = null;
		}
		
		protected function mouseMoveHandler(e:MouseEvent):void
		{
			// indicates that dragging started
			dragging = true;
			
			// set proxy to mouse position
			proxy.x = mouseX;
			proxy.y = mouseY + temp.parent.y + temp.y;
			
			// now that dragging started, proxy can be shown
			proxy.visible = true;
		}
	}
}