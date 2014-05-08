package eu.addlexapps.evolvetank.game
{
	import flash.ui.Keyboard;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	public class Controller extends Sprite
	{
		
		public static const EVENT_FORWARD_DOWN:String = "EVENT_FORWARD";
		public static const EVENT_BACKWARD_DOWN:String = "EVENT_BACKWARD";
		public static const EVENT_LEFT_DOWN:String = "EVENT_LEFT";
		public static const EVENT_RIGHT_DOWN:String = "EVENT_RIGHT";
		
		public static const EVENT_FORWARD_UP:String = "EVENT_FORWARD_UP";
		public static const EVENT_BACKWARD_UP:String = "EVENT_BACKWARD_UP";
		public static const EVENT_LEFT_UP:String = "EVENT_LEFT_UP";
		public static const EVENT_RIGHT_UP:String = "EVENT_RIGHT_UP";
		
		public static const EVENT_SHOOT:String = "EVENT_SHOOT";
		
		public static const EVENT_ZOOM_IN:String = "EVENT_ZOOM_IN";
		public static const EVENT_ZOOM_OUT:String = "EVENT_ZOOM_OUT";
		
		public function Controller()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			// Desktop Logic
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.addEventListener( KeyboardEvent.KEY_UP, keyUpListener);
			// TODO mobile logic
		}
		
		private function keyUpListener(event:Event, keyCode:uint):void
		{
			switch ( keyCode ){
				case Keyboard.UP: dispatchEventWith( EVENT_FORWARD_UP );
					break;
				case Keyboard.DOWN: dispatchEventWith( EVENT_BACKWARD_UP );
					break;
				case Keyboard.LEFT: dispatchEventWith( EVENT_LEFT_UP );
					break;
				case Keyboard.RIGHT: dispatchEventWith( EVENT_RIGHT_UP );
					break;
				case Keyboard.SPACE: dispatchEventWith( EVENT_SHOOT );
					break;
				case Keyboard.O: dispatchEventWith( EVENT_ZOOM_OUT );
					break;
				case Keyboard.I: dispatchEventWith( EVENT_ZOOM_IN );
					break;
			}
		}
		
		private function keyDownListener(event:Event, keyCode:uint):void
		{
			switch ( keyCode ){
				case Keyboard.UP: dispatchEventWith( EVENT_FORWARD_DOWN );
					break;
				case Keyboard.DOWN: dispatchEventWith( EVENT_BACKWARD_DOWN );
					break;
				case Keyboard.LEFT: dispatchEventWith( EVENT_LEFT_DOWN );
					break;
				case Keyboard.RIGHT: dispatchEventWith( EVENT_RIGHT_DOWN );
					break;
				case Keyboard.SPACE: dispatchEventWith( EVENT_SHOOT );
					break;
			}
		}
	}
}