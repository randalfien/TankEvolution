package eu.addlexapps.evolvetank.game
{
	

	public class Shot extends GameObject
	{
		public static const SHOT_WIDTH:Number = 0.7;
		public static const SHOT_HEIGHT:Number = 0.27;
		
		public static const SHOT_LIFE_SPAN:Number = 0.9;
		
		public static const SHOT_SPEED:Number = 30;
		
		public var speed:Number = 0; 
		
		public var timeActive:Number = 0;
		
		public function Shot(x:Number, y:Number)
		{
			super(x, y, SHOT_WIDTH, SHOT_HEIGHT);
		}
		
		override public function update( time:Number ) : void {
			x += Math.sin( rotation ) * SHOT_SPEED * time;
			y += -1 * Math.cos( rotation ) * SHOT_SPEED * time;
			timeActive += time;
			if( timeActive > SHOT_LIFE_SPAN){
				active = false;
			}
		}
	}
}