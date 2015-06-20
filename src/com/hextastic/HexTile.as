package com.hextastic 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Thomas Gattenhof
	 */
	public class HexTile extends MovieClip 
	{
		public var posX:int;
		public var posY:int;
		public var isClicked:Boolean = false;
		public var overlayMC:MovieClip;
		
		public function HexTile(_x:int, _y:int) 
		{
			posX = _x;
			posY = _y;
			this.mouseChildren = false;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			(this.getChildByName("txt") as TextField).text = String(posX) + "," + String(posY);
			overlayMC = this.getChildByName("overlayMC") as MovieClip;
			overlayMC.visible = false;
		}
		
		public function setOverlay(string:String):void 
		{
			switch(string)
			{
				case "NULL":
					overlayMC.visible = false;
					break;
				case "KEY":
					overlayMC.visible = true;
					overlayMC.gotoAndStop(2);
					break;
				case "PATH":
					overlayMC.visible = true;
					overlayMC.gotoAndStop(1);
					break;
			}
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			trace("i have been clicked");
			dispatchEvent(new Event("CLICKNODE", true));
		}
		
	}

}