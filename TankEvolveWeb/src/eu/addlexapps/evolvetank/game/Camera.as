package eu.addlexapps.evolvetank.game
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Camera
	{
		/** in PIXELS */
		public var viewportRect:Rectangle = new Rectangle();
		
		/** the viewport width in PIXELS */
		public var viewportWidth:Number = 0;
		/** the viewport height in PIXELS  */
		public var viewportHeight:Number = 0;
		
		/**position in the world in meters */
		public var position:Point =  new Point();
	
		private var _zoom:Number = 1;
		
		/** position and size in the world in meters */
		public var viewportWorldRect:Rectangle = new Rectangle();
		
		private var metersToPixelWithZoom1:Number;
		
		public function Camera(viewportwidth:Number, viewportheight:Number)
		{
			this.viewportWidth = viewportwidth;
			this.viewportHeight = viewportheight;
			viewportRect.width = viewportwidth;
			viewportRect.height = viewportheight;
			
			metersToPixelWithZoom1 = viewportwidth / World.WORLD_WIDTH;
		}
		
		public function repositionToCoord( x:Number , y:Number ):void {
			position.x = x;
			position.y = y;
			recalculateViewportWorldRect();
		}
		
		private function recalculateViewportWorldRect():void
		{
			var meterWidth:Number = getMeters( viewportWidth );
			var meterHeight:Number = getMeters( viewportHeight );
			viewportWorldRect.x = position.x - meterWidth/2;
			viewportWorldRect.y = position.y - meterHeight/2;
			viewportWorldRect.width = meterWidth;
			viewportWorldRect.height = meterHeight;
		}
		
		public function getPixels(pixels:Number):Number {
			return pixels * zoom * metersToPixelWithZoom1;
		}
		
		public function getMeters(meters:Number):Number {
			return  meters / (zoom * metersToPixelWithZoom1);
		}

		public function get zoom():Number
		{
			return _zoom;
		}

		public function set zoom(value:Number):void
		{
			_zoom = value;
			recalculateViewportWorldRect();
		}

	}
}