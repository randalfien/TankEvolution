package eu.addlexapps.evolvetank.core 
{
	import eu.addlexapps.evolvetank.core.loading.Asset;
	import eu.addlexapps.evolvetank.core.loading.MultiLoader;
	import eu.addlexapps.evolvetank.core.path.IPath;
	import eu.addlexapps.evolvetank.core.path.PathFont;
	import eu.addlexapps.evolvetank.core.path.PathHD;
	import eu.addlexapps.evolvetank.core.path.PathLoading;
	import eu.addlexapps.evolvetank.core.path.PathSD;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	public class Assets
	{       
		
		private var sTextures:Dictionary = new Dictionary();
		
		private var stageWidth:int;
		public var graphicsType:int;
		
		public static var bigFontSize:int;
		public static var mediumFontSize:int;
		public static var smallFontSize:int;
		
		private var atlas:TextureAtlas;
		
		private var _game:Game;
		
		private var _path:IPath;
		
		public var manager:AssetManager;
		
		public function Assets(game:Game)
		{
			stageWidth = Starling.current.viewPort.width;
			_game = game;
			manager = new AssetManager();
			manager.verbose = true;
			/* Set appropriate graphics set */
			if(stageWidth >= 1080){
				graphicsType = 1080; //hd graphics
				_path = new PathHD();
			}else{
				graphicsType = 540; //standart graphics
				_path = new PathSD();
			}
			setFontSizes();
		}
		
		private function setFontSizes():void
		{
			
			var sdFonts:Array = [38,25,12];
			var hdFonts:Array = [100,60,40];
			var fontsSizes:Array;
			switch(graphicsType){
				case 1080: fontsSizes = hdFonts; break;
				case 540:  fontsSizes = sdFonts; break;
			}
			bigFontSize = fontsSizes[0];
			mediumFontSize = fontsSizes[1];
			smallFontSize = fontsSizes[2];
		}
	
		/**
		 * Load all standart assets including sprite sheet(s)
		 */ 
		public function loadAssets(onProgress:Function):void {
			manager.enqueue( _path.getPath( Key.spriteSheet ) );	
			manager.enqueue( _path.getPath( Key.spriteSheetXML ) );
			manager.enqueue( "assets/font/"+Key.fontXml);
			manager.loadQueue( onProgress );
		}
			
		/** 
		 * Assets loaded
		 */ 
		private function onComplete ( e:Event ):void
		{

		}
		

		
		/**
		 * 
		 */ 
		public function getTexure(name:String):Texture {		
			return manager.getTexture(name);
		}
		
		public function getTexureFromAtlas(name:String):Texture {		
			return manager.getTexture(name);
		}
		
		public function getMovieTexuresFromAtlas(prefix:String):Vector.<Texture> {		
			return manager.getTextures(prefix);
		}
		
		public function hasTexture(name:String):Boolean {
			return sTextures[name] != undefined;
		} 
		
		public function addTexture(name:String, texture:Texture):void {
			sTextures[name] = texture;
		}
		


	}
}