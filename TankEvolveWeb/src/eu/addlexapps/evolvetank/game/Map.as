package eu.addlexapps.evolvetank.game
{
	import eu.addlexapps.evolvetank.core.Game;
	import eu.addlexapps.evolvetank.core.Key;
	
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;

	public class Map extends Sprite
	{	
		
		private var world:World;
		
		private var worldRenderer:WorldRenderer;
		
		private var game:Game;
		
		private var tankImage:Image;
		
		private var playerImage:Image;
		
		private var back:Image;
		
		private var viewportImage:Image;
		
		private var batcher:QuadBatch = new QuadBatch();
		
		
		/** in pixels */
		public static const MAP_WIDTH:Number = 170;
		/** in pixels */
		public static const MAP_HEIGHT:Number = (MAP_WIDTH / World.WORLD_WIDTH) * World.WORLD_HEIGHT;
		
		public function Map(world:World, render:WorldRenderer)
		{
			this.world = world;
			this.worldRenderer = render;
			
			game = Game.getInstance();
			addChild( batcher );

			back = new Image( game.assets.getTexureFromAtlas( Key.mapBackground ) );
			back.width = MAP_WIDTH;
			back.height = MAP_HEIGHT;
			
			tankImage  = new Image( game.assets.getTexureFromAtlas( Key.mapTank ) );
			tankImage.pivotX = tankImage.width /2;
			tankImage.pivotY = tankImage.height /2;
			
			playerImage = new Image( game.assets.getTexureFromAtlas( Key.mapPlayer ) );
			playerImage.pivotX = playerImage.width /2;
			playerImage.pivotY = playerImage.height /2;
			
			viewportImage = new Image ( game.assets.getTexureFromAtlas( Key.mapViewport ));
			
		}

		public function update( time:Number ) : void {
		 	batcher.reset();
			batcher.addImage( back );
			
			var ratioW:Number = MAP_WIDTH / World.WORLD_WIDTH;
			var ratioH:Number = MAP_HEIGHT / World.WORLD_HEIGHT;
			
			//draw player
			playerImage.x = ratioW * world.playerTank.x;
			playerImage.y = ratioH * world.playerTank.y;
			batcher.addImage(playerImage);
			
			//draw tanks
			for( var i:int = 0; i < world.tanks.length; i++){
				if( world.tanks[i].active )	
				{
					tankImage.x = ratioW * world.tanks[i].x;
					tankImage.y = ratioH * world.tanks[i].y;
					batcher.addImage( tankImage );
				}
			}
			
			var cameraWorldRect:Rectangle = worldRenderer.camera.viewportWorldRect;
	
			viewportImage.x = cameraWorldRect.left * ratioW;
			viewportImage.y = cameraWorldRect.top * ratioH;
			viewportImage.width = cameraWorldRect.width * ratioW;
			viewportImage.height = cameraWorldRect.height * ratioH;
			
			batcher.addImage( viewportImage );
		}
	}
}