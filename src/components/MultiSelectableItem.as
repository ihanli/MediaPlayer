package components
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class MultiSelectableItem extends ToggleButtonBase
	{
		// container for selected items
		private static var items:Vector.<MultiSelectableItem> = new Vector.<MultiSelectableItem>();
		
		public function MultiSelectableItem()
		{
			super();
		}
		
		public function get numberOfSelected():uint
		{
			return items.length;
		}
		
		public function getItemFromContainer(value:uint):MultiSelectableItem
		{
			return items[value];
		}
		
		override protected function mouseHandler(e:MouseEvent):void
		{
			var clickedInstance:MultiSelectableItem = e.target as MultiSelectableItem;
			var length:uint = 0;
			
			super.mouseHandler(e);
	
			if(e.type == MouseEvent.CLICK)
			{
				// if the clicked item is not already in the container
				if(items.indexOf(clickedInstance) == -1)
				{
					// remove every selected item (except for clicked item) if control key wasn't pressed while click
					if(!e.ctrlKey && items.length + 1 > 1)
					{	
						for(var i:uint = 0;i < length + 1;i++)				
							items.pop().selected = false;
					}

					// add clicked item to container
					items.push(clickedInstance);
					length = items.length;
				}
				// if clicked item was added earlier
				else
				{
					if(!e.ctrlKey)
					{
						length = items.length;
	
						// if click without ctrl-key -> deselect every item
						for(var j:uint = 0;j < length;j++)				
							items.pop().selected = false;
	
						// add clicked item if more than one item was selected
						if(length > 1)
						{
							items.push(clickedInstance);
							clickedInstance.selected = true;						
						}	
					}
				}
			}
		}
	}
}