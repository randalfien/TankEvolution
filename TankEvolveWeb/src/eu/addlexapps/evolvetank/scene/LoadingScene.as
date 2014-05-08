package eu.addlexapps.evolvetank.scene
{
	import eu.addlexapps.evolvetank.core.Game;
	
	import flash.system.System;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.TextField;

	public class LoadingScene extends Scene
	{
		private var backgroundImage:Image;

		private var infoText:TextField;
		private var progressQuad:Quad;
		
		public function LoadingScene(game:Game)
		{
			super(game);
			
			trace("LoadingScene created");
			addEventListener(Event.ADDED_TO_STAGE, onLoadingSceneAdded);
		}
		
		private function onLoadingSceneAdded(event:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onLoadingSceneAdded);

			progressQuad = new Quad(stageWidth, 25 );
			progressQuad.y = stageHeight * 0.7;
			progressQuad.scaleX = 0.05;
			addChild(progressQuad);
			
			game.settings.load();
			game.config.load();
			game.assets.loadAssets(onProgress);
		}
		
		private function onProgress(ratio:Number):void
		{
			progressQuad.scaleX = ratio;
			if( ratio == 1 ){
				System.pauseForGCIfCollectionImminent(0);
				System.gc();
				Starling.juggler.delayCall( loadedHandler, 0.15 );
			}	
		}
				
		private function loadedHandler():void{
			trace("LoadingScene loadedHandler");
			game.switchToScene(new TitleScene(game));
		}
	}
}