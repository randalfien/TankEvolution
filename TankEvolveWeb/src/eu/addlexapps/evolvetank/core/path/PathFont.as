package eu.addlexapps.evolvetank.core.path
{
	public class PathFont implements IPath
	{
		private static const ASSET_FONT_PATH:String = "assets/font/";
		
		public function PathFont()
		{
		}
		
		public function getPath(key:String):String{
			return ASSET_FONT_PATH + key;
		} 
		
	}
}