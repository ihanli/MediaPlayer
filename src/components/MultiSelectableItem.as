package components
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class MultiSelectableItem extends ToggleButtonBase
	{
		private static var items:Vector.<MultiSelectableItem> = new Vector.<MultiSelectableItem>();
		
		public function MultiSelectableItem()
		{
			super();
		}
		
		override protected function mouseHandler(e:MouseEvent):void
		{
			var clickedInstance:MultiSelectableItem = e.target as MultiSelectableItem;
			var length:uint = 0;
			
			super.mouseHandler(e);
	
			if(e.type == MouseEvent.CLICK)
			{
				if(items.indexOf(clickedInstance) == -1){
					if(!e.ctrlKey && items.length + 1 > 1)
					{	
						for(var i:uint = 0;i < length + 1;i++)				
							items.pop().selected = false;
					}

					items.push(clickedInstance);
					length = items.length;
				}
				else
				{
					length = items.length;

					for(var j:uint = 0;j < length;j++)				
						items.pop().selected = false;

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