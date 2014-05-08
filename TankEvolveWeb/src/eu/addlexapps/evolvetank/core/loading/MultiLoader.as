package eu.addlexapps.evolvetank.core.loading
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class MultiLoader extends EventDispatcher
	{
		private var loaders:Dictionary = new Dictionary();
		
		public function MultiLoader()
		{
		}
		
		public function add(asset:Asset, key:String):void {
			loaders[key] = asset;
			asset.addEventListener( Event.COMPLETE, assetLoadedHandler);
		}
		
		public function load():void{
			for each ( var asset:Asset in loaders){
				if( asset.loaded ) continue;
				asset.load();
			}
		}
		
		protected function assetLoadedHandler(event:Event):void
		{
			event.currentTarget.removeEventListener( Event.COMPLETE, assetLoadedHandler);
			for each ( var asset:Asset in loaders){
				if( asset.loaded == false) return;
			}
			dispatchEvent(event);
		}
		
		public function getAsset(key:String):Asset {
			return loaders[key];
		}
	}
}