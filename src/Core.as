package 
{
	import starling.animation.Juggler;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Thomas Gattenhof
	* "If you’re sick of starting over, stop giving up."
	 */
	public class Core 
	{
		
		static private var instance:Core;
		private static var _privateNumber:Number = Math.random();
		
		public var main:Main;
		public var starling:Starling;
		public var juggler:Juggler;
		
		//===============================================o
		//
		//===============================================o
		public function Core(num:Number=NaN) 
		{
			if(num !== _privateNumber){
				throw new Error("An instance of Singleton already exists. Try Core.getInstance()");
			}
		}
		
		//===============================================o
		//
		//===============================================o
		public static function getInstance() : Core {
			if ( instance == null ) instance = new Core(_privateNumber);
			return instance as Core;
		} 
	}

}