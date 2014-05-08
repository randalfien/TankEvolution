package eu.addlexapps.evolvetank.core.path
{
	public class PathHD implements IPath
	{
		private static const ASSET_ROOT_PATH:String = "assets/gfx/";
		
		private static const HDPI_ASSET_FOLDER_PATH:String = ASSET_ROOT_PATH + "HD/";
		
		public function PathHD()
		{
		}
		
		public function getPath(key:String):String{
			return HDPI_ASSET_FOLDER_PATH + key;
		} 
		
	}
}