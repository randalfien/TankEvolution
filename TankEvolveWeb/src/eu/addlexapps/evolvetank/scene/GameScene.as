package eu.addlexapps.evolvetank.scene
{
	import eu.addlexapps.evolvetank.core.Game;
	import eu.addlexapps.evolvetank.game.Controller;
	import eu.addlexapps.evolvetank.game.Map;
	import eu.addlexapps.evolvetank.game.World;
	import eu.addlexapps.evolvetank.game.WorldRenderer;
	
	import flash.geom.Rectangle;
	
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class GameScene extends Scene
	{
		
		/** Time calculation for animation. */
		private var _elapsed:Number = 0;
		
		private var _world:World;
		
		private var _renderer:WorldRenderer;
		
		private var _controller:Controller;
		
		private var _map:Map;
		
		public function GameScene(game:Game)
		{
			trace("TitleScene created");
			super(game);
		}

		
		override protected function drawScene():void{
			//WORLD
			_world = new World();
			
			//RENDERER
			_renderer = new WorldRenderer(_world,new Rectangle(0,0,stageWidth, stageHeight));
			addChild(_renderer);
			
			//MAP
			_map = new Map( _world, _renderer );
			_map.x = stage.stageWidth - Map.MAP_WIDTH;
			addChild( _map );
			
			//CONTROLLER
			_controller = new Controller();
			addChild(_controller);
			_world.controller = _controller;
			_renderer.controller = _controller;
			
			addEventListener( Event.ENTER_FRAME, run);
		}
		
		
		
		private function run(e:EnterFrameEvent):void
		{
			_elapsed = e.passedTime;

			_world.update(_elapsed );
			_renderer.update(_elapsed );
			_map.update( _elapsed );
			
		}
		
		
		
		private function showGameOverDialog():void
		{
	/*		var message:GameOverDialog = new GameOverDialog();
			positionSetter.setToCenter(message);
			message.name = "gameOver";
			message.x += message.width/2;
			message.y += message.height/2;
			addChild(message);
			message.appear();
			message.addEventListener(Event.TRIGGERED, gameOverReplyHandler);*/
		}
		
		private function gameOverReplyHandler(e:Event):void
		{
		/*	e.target.removeEventListeners(Event.TRIGGERED);
			if(Button(e.target).name == "restart"){
				restart();
			}else{
				Starling.juggler.delayCall( switchToTitleScene, 1);
			}	
			BaseDialog(getChildByName("gameOver")).disappear();*/
		}
		
		private function switchToTitleScene():void
		{
			game.switchToScene(new TitleScene(game) );
		}
		
		private function restart():void
		{
			
		}
		
		

		override public function dispose():void{
			removeEventListener( Event.ENTER_FRAME, run);
			super.dispose();
		} 
		

	}
}