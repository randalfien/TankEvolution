package
{	
	import eu.addlexapps.evolvetank.core.Game;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#FFFFFB")]
	
	/*
		https://github.com/joshtynjala/starling-preloader	
	*/
	public class EvolveTankWeb extends MovieClip
	{
		/**
		 * This is typed as Object so that the compiler doesn't include the
		 * starling.core.Starling class in frame 1. We'll access the Starling
		 * class dynamically once the SWF is completely loaded.
		 */
		private var _starling:Object;
		
		public function EvolveTankWeb()
		{
			this.stop();
			//the two most important events for preloading
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);	

		}
		
		protected function loaderInfo_completeHandler(event:flash.events.Event):void
		{	
			//go to frame two because that's where the classes we need are located
			this.gotoAndStop(2);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			Game.starter = this;
			
			Starling.multitouchEnabled = false; // (true - useful on mobile devices)
			Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
			
			_starling = new Starling(Game, this.stage);
			_starling.simulateMultitouch = false;
			_starling.enableErrorChecking = false;
			_starling.start();
			_starling.addEventListener("EXIT", exitApp);
		}
		
		public function exitApp(e:Event):void{
			trace("EXIT");
		}
	}
}