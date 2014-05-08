package eu.addlexapps.evolvetank.game
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class GameObject
	{
		private var position:Point;
		public var bounds:Rectangle;
		public var active:Boolean = true;
		public var rotation:Number = 0;
		
		public function GameObject (x:Number, y:Number, width:Number, height:Number) {
			this.position = new Point(x, y);
			this.bounds = new Rectangle(x - width / 2, y - height / 2, width, height);
		}
		
		public function set x (val:Number):void {
			if( val <  0){
				val += World.WORLD_WIDTH;
			}else if( val > World.WORLD_WIDTH){
				val -= World.WORLD_WIDTH;
			}
			position.x = val;
		} 
		
		public function get x ():Number {
			return position.x;
		}
		
		public function set y (val:Number):void {
			if( val <  0){
				val += World.WORLD_HEIGHT;
			}else if( val > World.WORLD_WIDTH){
				val -= World.WORLD_HEIGHT;
			}
			position.y = val;
		} 
		
		public function get y ():Number {
			return position.y;
		}
		
		public function update(elapsed:Number):void{
			throw new Error("Not defined: override in subclassed");
		}
		
	}
}