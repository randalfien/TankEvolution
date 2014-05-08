package eu.addlexapps.evolvetank.core 
{  
    
    import eu.addlexapps.evolvetank.scene.LoadingScene;
    import eu.addlexapps.evolvetank.scene.Scene;
    
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;

    public class Game extends Sprite
    {

        private var _currentScene:Scene;
		
        public var assets:Assets;
        
		public var settings:Settings;
		
		public var config:ConfigProxy;
		
		private static var _instance:Game;
		
		public static var starter:Object;

		
        public function Game()
        {    
			trace("Game created");
			_instance = this;
            
			assets = new Assets(this);
            
			settings = new Settings();
			
			config = new ConfigProxy();
			
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
          	
			// show information about rendering method (hardware/software)
			Starling.current.showStats = true;
        }
        
        private function onAddedToStage(event:Event):void
        {
			trace("Game on stage");

			switchToScene(new LoadingScene(this));
        }
		
		public function switchToScene(scene:Scene):void
		{
			trace("scene switched "+getQualifiedClassName(scene));
			if(currentScene) currentScene.removeFromParent(true);
			_currentScene = scene;
			addChild(scene);
		}
		
        private function onRemovedFromStage(event:Event):void
        {
           
        }
		
        private function showScene(name:String):void
        {
            if (_currentScene) return;
            
            var sceneClass:Class = getDefinitionByName(name) as Class;
            _currentScene = new sceneClass() as Scene;
            addChild(_currentScene);
        }

		public function onPause():void{
			currentScene.onPause();
		}
		
		public function onResume():void{
			currentScene.onResume();
		}
		
		public static function getInstance():Game
		{
			return _instance;
		}
		
		public function dispatchNotification(name:String):void{
			this.dispatchEventWith(name); // better than just dispatch event, pools event objects
		}

		public function get currentScene():Scene
		{
			return _currentScene;
		}

		public function conf(name:String):String{
			return config.getConfig(name);
		}

    }
}