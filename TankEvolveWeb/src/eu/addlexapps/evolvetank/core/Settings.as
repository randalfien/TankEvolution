package eu.addlexapps.evolvetank.core
{
	import flash.net.SharedObject;

	public class Settings
	{
		private static const PREFS:String  = "FishtronePreferences";
		
		// SETTINGS CONSTANTS
		public static const ENABLE_SOUND:String  = "enableSound";
		
		public static const FIRST_START:String  = "firstStart";
		
		public var enableSound:Boolean;
		
		public var firstStart:Boolean;
		
		public function Settings()
		{
		}
		
		public function save():void
		{
			// Get the shared object.
			var so:SharedObject = SharedObject.getLocal(PREFS);
			
			// Update the age variable.
			so.data[ENABLE_SOUND] = enableSound;
			so.data[FIRST_START] = false;
			
			// And flush our changes.
			so.flush();
			
			// Also, indicate the value for debugging.
			trace("Saved shared object");
		}
		
		public function load():void
		{
			// Get the shared object.
			var so:SharedObject = SharedObject.getLocal(PREFS);
			
			enableSound = so.data[ENABLE_SOUND];
			firstStart = so.data[FIRST_START];
		}
	}
}