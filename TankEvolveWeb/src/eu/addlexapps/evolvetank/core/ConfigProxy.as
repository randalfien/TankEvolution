package eu.addlexapps.evolvetank.core
{
	import eu.addlexapps.evolvetank.core.loading.Asset;
	
	import flash.events.Event;

	public class ConfigProxy
	{
		private var xml:XML;

		private var loader:Asset;
		
		public function ConfigProxy()
		{
			
		}
		
		public function getConfig(key:String):String {
			if(loader == null || loader.loaded == false) throw new Error("Config not loaded");
			var paramMatch:XML = xml.param.(@name == key)[0];
			if(!paramMatch){
				throw new Error("Config not available: "+key); 
			}
			return paramMatch.@value;	
		}
		
		public function load():void
		{
			loader = new Asset("assets/config.xml");
			loader.addEventListener(Event.COMPLETE, init);
			loader.load();
		}
		
		private function init(e:Event):void{
			loader.removeEventListener(Event.COMPLETE, init);
			xml = new XML(loader.content);
		}
	}
}