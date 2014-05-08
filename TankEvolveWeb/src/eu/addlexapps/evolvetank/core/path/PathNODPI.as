package eu.addlexapps.evolvetank.core.path
{
	public class PathNODPI implements IPath
	{
		private static const ASSET_ROOT_PATH:String = "assets/gfx/";
		
		private static const NODPI_ASSET_FOLDER_PATH:String = ASSET_ROOT_PATH + "NODPI/";
		
		public function PathNODPI()
		{
		}
		
		public function getPath(key:String):String{
			return NODPI_ASSET_FOLDER_PATH + key;
		} 
		
	}
}