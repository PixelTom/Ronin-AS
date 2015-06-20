package com.hextastic
{
	import com.aStar.AStar;
	import com.aStar.Grid;
	import com.aStar.Node;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * HexMap
	 * Hold the data and visual map information
	 * @author Thomas Gattenhof
	 */
	public class HexMap extends Sprite 
	{
		private var mapWidth:int;
		private var mapHeight:int;
		
		private var tileArray:Array;
		private var hexGrid:Grid;
		private var astar:AStar = new AStar();
		private var setClear:Boolean;
		
		/**
		 * 
		 * @param	_w
		 * @param	_h
		 */
		public function HexMap(_w:int = 10, _h:int = 10) 
		{
			setClear = false;
			mapWidth = _w;
			mapHeight = _h;
			
			buildMap();
			addEventListener("CLICKNODE", nodeClicked, false, 0, true);
		}
		
		/**
		 * Build the Map, 
		 * Map has 2 versions
		 * hexGrid: Map for pathfinding
		 * tileArray: Map for visual display
		 */
		private function buildMap():void
		{
			// Build the Grid object used for pathfinding
			hexGrid = new Grid(mapWidth, mapHeight);
			
			// Build the hexgrid display objects, used for display
			tileArray = new Array();
			for (var runningX:int = 0; runningX < mapWidth; runningX++)
			{
				var colArray:Array = new Array();
				for (var runningY:int = 0; runningY < mapHeight; runningY++)
				{
					var hexTile:HexTile = new HexTile(runningX, runningY);
					hexTile.x = (runningX * hexTile.width * 0.75) + (runningY * hexTile.width * 0.75);
					hexTile.y = (runningY * hexTile.height * 0.5) - (runningX * hexTile.height * 0.5);
					
					// Assign a random tile type to it
					// 1 = field
					// 2 = forest
					// 3 = mountain
					var tNode:Node = hexGrid.getNode(hexTile.posX, hexTile.posY) as Node;
					switch(Math.ceil(Math.random() * 3))
					{
						case 1:
							hexTile.gotoAndStop(1);
							break;
						case 2:
							hexTile.gotoAndStop(2);
							tNode.costMultiplier = 1.5;
							break;
						case 3:
							hexTile.gotoAndStop(3);
							tNode.walkable = false;
							break;
					}
					
					colArray.push(hexTile);
					this.addChild(hexTile);
				}
				tileArray.push(colArray);
			}
		}
		
		/**
		 * Click a node
		 * If no nodes clicked, assign start
		 * If start node clicked, clear nodes
		 * If other node clicked after start, assign end, begin pathfinding
		 * @param	e
		 */
		private function nodeClicked(e:Event):void
		{
			if (setClear) clearNodes();
			var hextile:HexTile = e.target as HexTile;
			
			var testNode:Node = hexGrid.getNode(hextile.posX, hextile.posY);
			trace("testNode", testNode.x, testNode.y, testNode.costMultiplier);
			
			if (hexGrid.startNode != null)
			{
				if (hextile.isClicked)
				{
					hextile.setOverlay("NULL");
					hexGrid.clearNodes();
				}
				else
				{
					hextile.setOverlay("KEY");
					hexGrid.setEndNode(hextile.posX, hextile.posY);
					findPath();
					setClear = true;
				}
				hextile.isClicked = !hextile.isClicked;
			}
			else
			{
				hextile.setOverlay("KEY");
				hexGrid.setStartNode(hextile.posX, hextile.posY);
				hextile.isClicked = true;
			}
		}
		
		/**
		 * Reset the Start and End nodes, remove all overlays
		 */
		private function clearNodes():void 
		{
			setClear = false;
			hexGrid.clearNodes();
			for (var runningX:int = 0; runningX < tileArray.length; runningX++)
			{
				var colArray:Array = tileArray[runningX];
				for (var runningY:int = 0; runningY < colArray.length; runningY++)
				{
					var hexTile:HexTile = colArray[runningY] as HexTile;
					hexTile.isClicked = false;
					hexTile.setOverlay("NULL");
				}
			}
		}
		
		/**
		 * Find the path from start to end node, apply visual overlay
		 */
		private function findPath():void
		{
			if (astar.findPath(hexGrid))
			{
				var path:Array = astar.path;
				for (var i:int = 0; i < path.length; i++)
				{
					var tNode:Node = path[i] as Node;
					var hextile:HexTile = tileArray[tNode.x][tNode.y];
					hextile.setOverlay("PATH");
				}
			}
			else
			{
				clearNodes();
			}
			
		}
		
		/**
		 * Reset the nodes,
		 * make a new hexGrid
		 * keep the display grid, just change the frames and apply node info accordingly
		 */
		public function reset():void
		{
			clearNodes();
			hexGrid = new Grid(mapWidth, mapHeight);
			
			for (var runningX:int = 0; runningX < mapWidth; runningX++)
			{
				var colArray:Array = tileArray[runningX];
				for (var runningY:int = 0; runningY < mapHeight; runningY++)
				{
					var hexTile:HexTile = colArray[runningY] as HexTile;
					
					// Assign a random tile type to it
					// 1 = field
					// 2 = forest
					// 3 = mountain
					var tNode:Node = hexGrid.getNode(hexTile.posX, hexTile.posY) as Node;
					switch(Math.ceil(Math.random() * 3))
					{
						case 1:
							hexTile.gotoAndStop(1);
							break;
						case 2:
							hexTile.gotoAndStop(2);
							tNode.costMultiplier = 1.5;
							break;
						case 3:
							hexTile.gotoAndStop(3);
							tNode.walkable = false;
							break;
					}
					
				}
			}
		}
	}

}