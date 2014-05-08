package eu.addlexapps.evolvetank.scene
{
    
    import eu.addlexapps.evolvetank.core.Game;
    
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;
    
    public class Scene extends Sprite
    {
		protected var game:Game;
		/**
		 * The pixel width of the current display
		 */
		public var stageWidth:Number;
		/**
		 * The pixel height of the current display
		 */
		public var stageHeight:Number;
		
		
        public function Scene(game:Game)
        {
           this.game = game;
		   stageWidth = Starling.current.viewPort.width;
		   stageHeight = Starling.current.viewPort.height;
		   trace("stage width: "+stageWidth);
		   trace("stage height: "+stageHeight);
		   addEventListener( Event.ADDED_TO_STAGE, onLoadingSceneAdded );
        }
		
		private function onLoadingSceneAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onLoadingSceneAdded);
			drawScene();
		}
		
		protected function drawScene():void{
		
		}
		
		public function onPause():void{
		
		}
		
		public function onResume():void{
			
		}
		
		override public function dispose():void{
			game = null;
			super.dispose();
		}
		
    }
}