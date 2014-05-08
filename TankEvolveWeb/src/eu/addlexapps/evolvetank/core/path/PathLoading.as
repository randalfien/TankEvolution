package eu.addlexapps.evolvetank.core.path
{
	public class PathLoading implements IPath
	{
		private static const ASSET_ROOT_PATH:String = "assets/gfx/";
		
		private static const LOADING_ASSET_FOLDER_PATH:String = ASSET_ROOT_PATH + "Loading/";
		
		public function PathLoading()
		{
		}
		
		public function getPath(key:String):String{
			return LOADING_ASSET_FOLDER_PATH + key;
		} 
		
	}
}