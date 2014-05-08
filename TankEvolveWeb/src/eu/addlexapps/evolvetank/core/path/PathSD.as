package eu.addlexapps.evolvetank.core.path
{
	public class PathSD implements IPath
	{
		private static const ASSET_ROOT_PATH:String = "assets/gfx/";
		
		private static const SD_ASSET_FOLDER_PATH:String = ASSET_ROOT_PATH + "SD/";
		
		public function PathSD()
		{
		}
		
		public function getPath(key:String):String{
			return SD_ASSET_FOLDER_PATH + key;
		} 
		
	}
}