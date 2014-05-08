package eu.addlexapps.evolvetank.game
{
	import com.gskinner.motion.GTween;
	
	import eu.addlexapps.evolvetank.core.Game;
	import eu.addlexapps.evolvetank.core.Key;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.RenderSupport;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class WorldRenderer extends Sprite
	{
		
		private var world:World;
		
		public var camera:Camera;
		
		private var game:Game = Game.getInstance();
		
		private var grassImage:Image;
		
		private var tankImage:Image;
		
		private var shotImage:Image;
		
		private var explosionImages:Vector.<Image> = new Vector.<Image>();
		
		/* in meters */
		private static const grassTileWidth:Number = World.WORLD_WIDTH / 15;
		/* in meters */
		private static const grassTileHeight:Number = World.WORLD_HEIGHT / 15;
		
		private var batcher:QuadBatch = new QuadBatch();

		// position helpers
		private var posX:Vector.<Number> = new Vector.<Number>(9);
		
		private var posY:Vector.<Number> = new Vector.<Number>(9);
		private var _controller:Controller;
		
		public function WorldRenderer(world:World, viewport:Rectangle)
		{
			this.touchable = false;
			this.world = world;
			
			//SETUP CAMERA
			this.camera = new Camera( viewport.width, viewport.height);
			camera.viewportWidth = viewport.width;
			camera.viewportHeight = viewport.height;
			//camera.zoom = 2;
			camera.repositionToCoord( World.WORLD_WIDTH/2, World.WORLD_HEIGHT/2 );
			new GTween( camera, 1, {zoom:5});
			// SETUP IMAGES
			grassImage = new Image( game.assets.getTexureFromAtlas(Key.grass) ) ;
			
			tankImage = new Image( game.assets.getTexureFromAtlas(Key.tank) ) ;
			tankImage.pivotX = tankImage.width >> 1;
			tankImage.pivotY = tankImage.height >> 1;
			shotImage = new Image( game.assets.getTexureFromAtlas(Key.shot) ) ;
			shotImage.pivotX = shotImage.width >> 1;
			shotImage.pivotY = shotImage.height >> 1;
			
			var explosionTextures:Vector.<Texture> = game.assets.getMovieTexuresFromAtlas(Key.explosionAnimationPrefix);
			for( var i:int = 0; i < explosionTextures.length; i++ ){
				var img:Image = new Image(explosionTextures[i]);
				img.scaleX = img.scaleY = camera.zoom/2;
				explosionImages.push( img );
			}
			addChild(batcher);	

		}
		
		public function set controller(value:Controller):void
		{
			_controller = value;			
			_controller.addEventListener(Controller.EVENT_ZOOM_IN, zoomInHandler);
			_controller.addEventListener(Controller.EVENT_ZOOM_OUT, zoomOutHandler);
		}
		
		private function zoomInHandler(e:Event):void
		{
			if( camera.zoom < 6 ){
				camera.zoom = camera.zoom+0.5;
			}
		}
		
		private function zoomOutHandler(e:Event):void
		{
			if( camera.zoom > 1.5 ){
				camera.zoom = camera.zoom-0.5;
			}
		}
		
		public function update(time:Number):void {
			batcher.reset();
			
			grassImage.width = camera.getPixels( grassTileWidth )+1;
			grassImage.height = camera.getPixels( grassTileHeight )+1;
			tankImage.rotation = 0; 
			tankImage.width = camera.getPixels( Tank.TANK_WIDTH );
			tankImage.height = camera.getPixels( Tank.TANK_HEIGHT );
			shotImage.rotation = 0; 
			shotImage.width = camera.getPixels( Shot.SHOT_WIDTH );
			shotImage.height = camera.getPixels( Shot.SHOT_WIDTH );
			for( var i:int = 0; i < explosionImages.length; i++ ){
				var img:Image = explosionImages[i];
				img.scaleX = img.scaleY = camera.zoom/2;
			}
			
			var playerTankX:Number = world.playerTank.x;
			var playerTankY:Number = world.playerTank.y;
			camera.repositionToCoord( playerTankX, playerTankY );
			
			var cameraLeft:Number = camera.viewportWorldRect.left;
			var cameraTop:Number = camera.viewportWorldRect.top;
			
			// draw background tiles
			
			var firstTileX:int = Math.ceil(cameraLeft / grassTileWidth) - 1;
			var firstTileY:int = Math.ceil(cameraTop / grassTileHeight) - 1;
			var lastTileX:int = firstTileX + Math.ceil(camera.viewportWorldRect.width / grassTileWidth) + 1 ;
			var lastTileY:int = firstTileY + Math.ceil(camera.viewportWorldRect.height / grassTileHeight) + 1;
			
			
			for ( i = firstTileX; i < lastTileX; i++){
				for ( var j:int = firstTileY; j < lastTileY; j++){
					grassImage.x = camera.getPixels(i * grassTileWidth - cameraLeft);
					grassImage.y = camera.getPixels(j * grassTileHeight - cameraTop);
					batcher.addImage( grassImage );
				}
			}
			// draw player tank
			tankImage.x = camera.getPixels(playerTankX - cameraLeft);
			tankImage.y = camera.getPixels(playerTankY - cameraTop);
			tankImage.rotation =  world.playerTank.rotation;
			batcher.addImage(tankImage);
			
			// draw agent tank

			for ( i = 0; i < world.tanks.length; i++){
				if( world.tanks[i].active == false) continue;
				
				fillPossiblePositions( world.tanks[i].x, world.tanks[i].y);

				for( var k:int = 0; k < 9; k++){
					if( camera.viewportRect.contains( posX[k],  posY[k]) ){
						tankImage.x = posX[k];
						tankImage.y = posY[k];
						tankImage.rotation = world.tanks[i].rotation;
						batcher.addImage( tankImage );
						break;
					}
				}
			}
			
			// draw shots
			
			for ( i = 0; i < world.shots.length; i++){
				if( world.shots[i].active == false) continue;
				
				fillPossiblePositions( world.shots[i].x, world.shots[i].y);
				
				for( k = 0; k < 9; k++){
					if( camera.viewportRect.contains( posX[k],  posY[k]) ){
						shotImage.x = posX[k];
						shotImage.y = posY[k];
						shotImage.rotation = world.shots[i].rotation;
						batcher.addImage( shotImage );
						break;
					}
				}
			}
			
			// draw explosions
			var progress:Number;
			var exploImg:Image;
			var exploHeight:Number = explosionImages[0].height;
			var exploWidth:Number = explosionImages[0].width;
			for ( i = 0; i < world.explosions.length; i++){
				if( world.explosions[i].active == false) continue;
				
				fillPossiblePositions( world.explosions[i].x, world.explosions[i].y);
				
				for( k = 0; k < 9; k++){
					if( camera.viewportRect.contains( posX[k],  posY[k]) ){
						progress =  Explosion(world.explosions[i]).timeActive / Explosion.EXPLOSION_LIFE_SPAN;
						exploImg = explosionImages[ int( (explosionImages.length-1) * progress) ];
						exploImg.x = posX[k] - exploWidth*0.6;
						exploImg.y = posY[k] - exploHeight*0.7;
						batcher.addImage( exploImg );
						break;
					}
				}
			}
		}
		
		private function fillPossiblePositions(x:Number, y:Number):void
		{
			var cameraLeft:Number = camera.viewportWorldRect.left;
			var cameraTop:Number = camera.viewportWorldRect.top;
			
			posX[0] = camera.getPixels( x - cameraLeft);
			posY[0] = camera.getPixels( y - cameraTop);
			
			posX[1] = camera.getPixels( x - World.WORLD_WIDTH - cameraLeft);
			posY[1] = camera.getPixels( y - cameraTop);
			
			posX[2] = camera.getPixels( x + World.WORLD_WIDTH - cameraLeft);
			posY[2] = camera.getPixels( y - cameraTop);
			
			posX[3] = camera.getPixels( x - cameraLeft);
			posY[3] = camera.getPixels( y - World.WORLD_WIDTH - cameraTop);
			
			posX[4] = camera.getPixels( x - cameraLeft);
			posY[4] = camera.getPixels( y + World.WORLD_WIDTH - cameraTop);
			
			posX[5] = camera.getPixels( x - World.WORLD_WIDTH - cameraLeft);
			posY[5] = camera.getPixels( y - World.WORLD_WIDTH - cameraTop);
			
			posX[6] = camera.getPixels( x + World.WORLD_WIDTH - cameraLeft);
			posY[6] = camera.getPixels( y + World.WORLD_WIDTH - cameraTop);
			
			posX[7] = camera.getPixels( x + World.WORLD_WIDTH - cameraLeft);
			posY[7] = camera.getPixels( y - World.WORLD_WIDTH - cameraTop);
			
			posX[8] = camera.getPixels( x - World.WORLD_WIDTH - cameraLeft);
			posY[8] = camera.getPixels( y + World.WORLD_WIDTH - cameraTop);
		}
		
	}
}