package view.Screens 
{
	import starling.display.Sprite;
	
	/**
	 * BASE SCREEN USED BY ALL SCREENS
	 * @author Thomas Gattenhof
	* "If you’re sick of starting over, stop giving up."
	 */
	public class BaseScreen extends Sprite 
	{
		
		protected var _core:Core = Core.getInstance();
		
		
		public function BaseScreen() 
		{
			super();
			
		}
		
	}

}