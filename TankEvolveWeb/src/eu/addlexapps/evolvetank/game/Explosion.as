package eu.addlexapps.evolvetank.game
{
	

	public class Explosion extends GameObject
	{
		public static const EXPLOSION_LIFE_SPAN:Number = 1;
		
		public var timeActive:Number = 0;
		
		public function Explosion(x:Number, y:Number)
		{
			super(x, y, 5, 5);
		}
		
		override public function update( time:Number ) : void {

			timeActive += time;
			if( timeActive > EXPLOSION_LIFE_SPAN){
				active = false;
			}
		}
	}
}