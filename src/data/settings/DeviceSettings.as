package src.data.settings 
{
	import flash.system.Capabilities;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author Thomas Gattenhof
	* "If you’re sick of starting over, stop giving up."
	* *@author (Original) John Stejskal http://johnstejskal.com/
	 */
	public class DeviceSettings 
	{
		
		static public var TOUCH_INPUT_MODE:String = MultitouchInputMode.TOUCH_POINT;
		static public var KEEP_DEVICE_AWAKE:Boolean = false;
		static public var ENABLE_TOUCH:Boolean = true;
		static public var ENABLE_GESTURES:Boolean = false; // Off for now, focus on simple touch mechanics
		static public var ENABLE_ACCELEROMETER:Boolean = false;
		
	}

}