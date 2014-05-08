package eu.addlexapps.evolvetank.game
{
	import eu.addlexapps.evolvetank.core.Game;

	public class Tank extends GameObject
	{
		protected static const GAME:Game = Game.getInstance(); 
		//PUBLIC
		
		public static const EVENT_SHOOT:String = "Event-shoot";
		
		/** Meters */
		public static const TANK_WIDTH:Number = 4;
		/** Meters */
		public static const TANK_HEIGHT:Number = 4;
		/** Meters per sec */
		public static const TANK_ACCELERATION:Number = Number(GAME.conf("tankAcceleration")); 
		/** Percent per sec */	
		public static const TANK_SPEED_DECAY:Number = Number(GAME.conf("tankSpeedDecay"));  
		/** time between shots */
		public static const RATE_OF_FIRE:Number = Number(GAME.conf("tankRateOfFire")); 
		/** in meters per second */
		public static const TANK_TOP_SPEED:Number = Number(GAME.conf("tankTopSpeed")); 
		/** in radians pre second*/
		public static const TANK_RADIAL_SPEED:Number = Number(GAME.conf("tankRadialSpeed")); 
		public var radialSpeed:Number = 0;
		
		public var speed:Number = 0; 

		//PROTECTED
		
		protected var timeSinceLastShot:Number = Number.MAX_VALUE;
				
		
		//PRIVATE		
		
		/** time for one command, e.g. forward */
		private static const COMMAND_STEP_TIME:Number = 0.1; 
		
		private var _left:Boolean = false;		
		private var _right:Boolean = false;
		private var _forward:Boolean = false;
		private var _backward:Boolean = false;
		
		private var timeTillReset_L:Number = 0;
		private var timeTillReset_R:Number = 0;
		private var timeTillReset_F:Number = 0;
		private var timeTillReset_B:Number = 0;
		
		public function Tank(x:Number, y:Number)
		{
			super(x, y, TANK_WIDTH, TANK_HEIGHT);
		}
		
		override public function update(time:Number):void {
			// FORWARD
			if( _forward && ! _backward){
				if(speed < TANK_TOP_SPEED){
					speed += TANK_ACCELERATION * time;
				}
			}else // BACKWARD	
			if(  _backward && !_forward){
				if(speed > -TANK_TOP_SPEED/2){
					speed -= TANK_ACCELERATION * time;
				}
			}

			//RIGHT
			if( _right && !_left) {
				rotation += time*TANK_RADIAL_SPEED;
			}else //LEFT
			if( _left && !_right ) {
				rotation -= time*TANK_RADIAL_SPEED;
			} 
			
			
			speed *= 1-(TANK_SPEED_DECAY*time); //should be about 0.997
		
			x += Math.sin( rotation ) * speed * time;
			y += -1*Math.cos( rotation )* speed * time;
			
			
			timeTillReset_L -= time;
			if( _left && timeTillReset_L < 0){
				_left = false;
			}
			timeTillReset_R -= time;
			if( _right && timeTillReset_R < 0){
				_right = false;
			}
			timeTillReset_F -= time;
			if( _forward && timeTillReset_F < 0){
				_forward = false;
			}
			timeTillReset_B -= time;
			if( _backward && timeTillReset_B < 0){
				_backward = false;
			}
			
			timeSinceLastShot += time;
		}
		
		protected function shoot():void
		{
			if( timeSinceLastShot > RATE_OF_FIRE ){
				timeSinceLastShot = 0; 
				World.dispatcher.dispatchEventWith( EVENT_SHOOT, false, this);
			}
		}
		
		public function set left(value:Boolean):void
		{
			_left = value;
			timeTillReset_L = COMMAND_STEP_TIME;
		}

		public function set right(value:Boolean):void
		{
			_right = value;
			timeTillReset_R = COMMAND_STEP_TIME;
		}

		public function set forward(value:Boolean):void
		{
			_forward = value;
			timeTillReset_F = COMMAND_STEP_TIME;
		}

		public function set backward(value:Boolean):void
		{
			_backward = value;
			timeTillReset_B = COMMAND_STEP_TIME;
		}

		
	}
}