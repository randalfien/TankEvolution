package eu.addlexapps.evolvetank.game
{
	import eu.addlexapps.evolvetank.core.Game;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class World
	{
		public static const STATE_RUNNING:int = 1;
		public static const STATE_PAUSED:int = 2;
		
		
		private static const GAME:Game = Game.getInstance();
		/** In meters */
		public static const WORLD_WIDTH:Number = Number( GAME.conf("worldWidth") );
		/** In meters */
		public static const WORLD_HEIGHT:Number = Number( GAME.conf("worldHeight") );
		
		public var state:int;
		
		public var tanks:Vector.<GameObject> = new Vector.<GameObject>();
		
		public var shots:Vector.<GameObject> = new Vector.<GameObject>();
		
		public var explosions:Vector.<GameObject> = new Vector.<GameObject>();
		
		public var playerTank:PlayerTank;
		
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		
		private static const PURGE_LIMIT:int = 50;
		
		public function World()
		{
			state = STATE_RUNNING;
			playerTank = new PlayerTank(WORLD_WIDTH/2, WORLD_HEIGHT/2);
			for (var i:int = 0; i < 25; i++) 
			{
				addTank();			
			}
			
			dispatcher.addEventListener( Tank.EVENT_SHOOT, addShot );
		}
		
		public function update(time:Number):void {
			//Update player tank
			playerTank.update(time);
			
			//Update agent tanks
			updateList( tanks , time);
			
			//Update shots
			updateList( shots , time);
			
			//Update explosions
			updateList( explosions , time);
			
			// Detect collisions
			
			for( var i:int = 0; i < shots.length; i++){
				if( shots[i].active ){
					for ( var k:int = 0; k < tanks.length; k++){
						if( tanks[k].bounds.contains( shots[i].x, shots[i].y ) ){
							tanks[k].active = false;
							shots[i].active = false;
							addExplosion( tanks[k].x, tanks[k].y );
							break;
						}
					}
				}
			}
		}

		
		private function updateList( list:Vector.<GameObject>, time:Number):void {
			var deactivated:int = 0;
			for( var i:int = 0; i < list.length; i++){
				if( list[i].active ){
					list[i].update( time );
				}else{
					deactivated++;
				}
			}
			if( deactivated > PURGE_LIMIT ){
				purgeDeactivated(list);
			}
		}
		
		private function purgeDeactivated(list:Vector.<GameObject>):void
		{
			var active:Vector.<GameObject> = new Vector.<GameObject>();
			for( var i:int = 0; i < list.length; i++){
				if( list[i].active ){
					active.push ( list[i] );
				}
			}
			shots = active;
		}
		private function addShot(e:Event, tank:Tank):void
		{
			var shot:Shot = new Shot ( tank.x, tank.y );
			shot.rotation = tank.rotation;
			shot.update( 0.05 ); //get it away from the source tank
			shots.push(shot);
		}
		
		private function addTank():void
		{
			var t:Tank = new Tank(Math.random()*WORLD_WIDTH, Math.random()*WORLD_HEIGHT);
			tanks.push(t);
		}
		
		
		private function addExplosion(x:Number, y:Number):void
		{
			var expl:Explosion = new Explosion( x, y);
			explosions.push( expl );
		}
		
		public function set controller ( controller:Controller):void{
			playerTank.controller = controller;
		}
	}
}