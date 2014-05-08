package eu.addlexapps.evolvetank.core.loading
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Asset extends EventDispatcher
	{
		
		public static const TYPE_TEXT:int = 1;
		
		public static const TYPE_IMAGE:int = 2;
		
		///public static const EVENT_LOADED:String = "EVENT_LOADED";
		
		private var _urlloader:URLLoader; 
		
		private var _loader:Loader;
		
		private var _url:URLRequest;
		
		public var content:Object;
		
		private var _loaded:Boolean;
		
		public var _type:int;
		
		public function Asset(path:String)
		{
			_url = new URLRequest(path);
			_loaded = false;
			var suffix:String = path.substr( path.lastIndexOf('.') + 1 );
			switch( suffix ){
				case "png":
				case "bmp": _type = TYPE_IMAGE;
							break;
				case "xml":
				case "fnt":
				case "txt": _type = TYPE_TEXT;
							break;
				
				default: throw new Error("Unsupported type "+ suffix); 
			}
		}
		
		public function load():void {
			
			if( _type  == TYPE_IMAGE ){
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);			
				_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
				_loader.load( _url );	
			}else{			
				_urlloader = new URLLoader();
				_urlloader.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				_urlloader.addEventListener(Event.COMPLETE, onCompleteHandler);			
				_urlloader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
				_urlloader.load( _url );
			}
		}
		
		protected function onErrorHandler(event:IOErrorEvent):void
		{
			throw new Error("Asset "+_url.url+" not found."+event.toString()); 
//			dispatchEvent(event);
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			if(_type == TYPE_IMAGE){
				content = _loader.content;
				_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);			
				_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			}else{
				content = _urlloader.data;
				_urlloader.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				_urlloader.removeEventListener(Event.COMPLETE, onCompleteHandler);			
				_urlloader.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			}
			_loaded = true;
			dispatchEvent(event);
		}
		
		protected function onProgressHandler(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}

		public function get loaded():Boolean
		{
			return _loaded;
		}

		public function set loaded(value:Boolean):void
		{
			_loaded = value;
		}

		
	}
}