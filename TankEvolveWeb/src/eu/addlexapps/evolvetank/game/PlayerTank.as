package eu.addlexapps.evolvetank.game
{
	public class PlayerTank extends Tank
	{
		private var _controller:Controller;
		
		private var downL:Boolean = false;
		private var downR:Boolean =  false;
		private var downF:Boolean =  false;
		private var downB:Boolean = false;
		
		public function PlayerTank(x:Number, y:Number)
		{
			super(x, y);
		}

		
		override public function update(time:Number):void {
			//trace("speed:"+speed);
			if( downL ) left = true;
			if( downR ) right = true;
			if( downF ) forward = true;
			if( downB ) backward = true;
			super.update(time);
		}
		
		public function set controller(value:Controller):void
		{
			_controller = value;
			_controller.addEventListener(Controller.EVENT_FORWARD_DOWN, forwardHandler);
			_controller.addEventListener(Controller.EVENT_BACKWARD_DOWN, backwardHandler);
			_controller.addEventListener(Controller.EVENT_LEFT_DOWN, leftdHandler);
			_controller.addEventListener(Controller.EVENT_RIGHT_DOWN, rightHandler);
			
			_controller.addEventListener(Controller.EVENT_FORWARD_UP, stopForwardHandler);
			_controller.addEventListener(Controller.EVENT_BACKWARD_UP, stopBackwardHandler);
			_controller.addEventListener(Controller.EVENT_LEFT_UP, stopLeftdHandler);
			_controller.addEventListener(Controller.EVENT_RIGHT_UP, stopRightHandler);
			
			_controller.addEventListener(Controller.EVENT_SHOOT, shootHandler);
		}
		
		private function stopRightHandler():void
		{
			downR = false;
		}
		
		private function stopLeftdHandler():void
		{
			downL = false;
		}
		
		private function stopBackwardHandler():void
		{
			downB = false;
		}
		
		private function stopForwardHandler():void
		{
			downF = false;
		}
		
		private function shootHandler():void
		{
			shoot();
		}
		
		private function forwardHandler():void
		{
			downF = true;
		}
		
		private function backwardHandler():void
		{
			downB = true;
		}
		
		private function leftdHandler():void
		{
			downL = true;
		}
		
		private function rightHandler():void
		{
			downR = true;
		}
		
	}
}