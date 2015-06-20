package
{
	import com.aStar.AStar;
	import com.aStar.Grid;
	import com.hextastic.HexMap;
	import data.constants.AppConstants;
	import data.settings.PublicSettings;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import data.AppData;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.events.ResizeEvent;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import view.StarlingStage;
	
	/**
	 * ...
	 * @author Thomas Gattenhof
	 */
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		private var _core:Core;
		
		//===============================================o
		//
		//===============================================o
		public function Main() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0 , true);
			
			/*hexMap = new HexMap(5,5);
			this.addChild(hexMap);
			hexMap.x = 200;
			hexMap.y = 400;
			
			var btn:MovieClip = this.getChildByName("btn") as MovieClip;
			(btn.getChildByName("txt") as TextField).text = "new map";
			btn.mouseChildren = false; btn.buttonMode = true;
			btn.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);*/
		}
		
		//===============================================o
		//
		//===============================================o
		private function init(e:Event):void 
		{
			trace("+ Main.init()");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_core = Core.getInstance();
			_core.main = this;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initStarling();
			configure();
		}
		
		//===============================================o
		//-- Boot up the Starling Engine
		//===============================================o
		private function initStarling():void 
		{
			trace("++ Main.initStarling()");
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			_starling = new Starling(StarlingStage, stage);
			_starling.simulateMultitouch = true;
			_starling.antiAliasing = 1;
			_starling.enableErrorChecking = false;
			_starling.start();
			_starling.stage.stageWidth = stage.stageWidth;
			_starling.stage.stageHeight = stage.stageHeight;
			
			if (PublicSettings.SHOW_STARLING_STATS)
			{
				_starling.showStats = true;
				_starling.showStatsAt(HAlign.RIGHT, VAlign.TOP);
			}
			
			_core.starling = _starling;
			_core.juggler = new Juggler();
		}
		
		//===============================================o
		//-- Configure the AppData settings based on Device resolution
		//===============================================o
		private function configure():void 
		{
			trace("++ Main.configure()");
			
			AppData.deviceResX = stage.stageWidth;
			AppData.deviceResY = stage.stageHeight;
			
			AppData.baseResX = AppConstants.BASE_RES_X;
			AppData.baseResY = AppConstants.BASE_RES_Y;		
			
			AppData.deviceScaleX = AppData.deviceResX / AppData.baseResX;
			AppData.deviceScaleY = AppData.deviceResY / AppData.baseResY;
			
			if (AppData.deviceScaleX < AppData.deviceScaleY) {
				AppData.usedScale = AppData.deviceScaleX;
				AppData.offsetY = (AppData.deviceResY  - (AppData.baseResY * AppData.usedScale)) >> 1;
			}else {
				AppData.usedScale = AppData.deviceScaleY;
				AppData.offsetX = (AppData.deviceResX  - (AppData.baseResX * AppData.usedScale)) >> 1;
			}
			
			trace("+++ Resolution: " + AppData.deviceResX + "x" + AppData.deviceResY);
			trace("+++ Scaling: X * " + AppData.deviceScaleX + ", Y * " + AppData.deviceScaleY);
		}
		
	}

}