package eu.addlexapps.evolvetank.scene
{
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Elastic;
	
	import eu.addlexapps.evolvetank.core.Assets;
	import eu.addlexapps.evolvetank.core.Game;
	import eu.addlexapps.evolvetank.core.Key;
	
	import flash.ui.Keyboard;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	
	public class TitleScene extends Scene
	{
		private var titleImage:Image;
		private var btnPlay:Button;
		private var info:TextField;
		
		public function TitleScene(game:Game)
		{
			trace("TitleScene created");
			super(game);
		}

		
		override protected function drawScene():void{
			drawTitle();
			drawButtons();
			drawInfo();
			this.addEventListener(Event.TRIGGERED, onButtonClick);
			game.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
		}
		
		private function drawInfo():void
		{
			info = new TextField(stageWidth*0.5, stageHeight*0.2, game.assets.graphicsType.toString() );
			info.fontName = Key.fontName;
			info.fontSize = Assets.mediumFontSize;
			info.color = 0;
			info.x = stageWidth - info.width;
			info.y = stageHeight - info.height;
			addChild(info);
		}
		
		private function keyHandler(e:KeyboardEvent):void
		{
			switch( e.keyCode){
				case Keyboard.BACK:
					Game.starter.exitApp();
					break;
			}
		}
		
		private function drawButtons():void
		{
			btnPlay = new Button( game.assets.getTexureFromAtlas(Key.btnPlay) );
			btnPlay.x = (stageWidth - btnPlay.width)>>1;
			btnPlay.y = (stageHeight - btnPlay.height)>>1;
			addChild(btnPlay);
			new GTween(btnPlay, 1.2, {y:0, alpha:0},{swapValues:true, ease:Elastic.easeOut});	

	/*		btnSettings = new Button( game.assets.getTexureFromAtlas(Key.btnSettings) );
			positionSetter.setToCenter( btnSettings );
			btnSettings.y += btnPlay.height*1.5;
			addChild(btnSettings);
			new GTween(btnSettings, 1.2, {y:100, alpha:0},{swapValues:true, ease:Elastic.easeOut});	
*/
			
			addEventListener(Event.TRIGGERED, onButtonClick);
		}
		
		private function drawTitle():void
		{
			titleImage = new Image( game.assets.getTexureFromAtlas( Key.heading ) );
			titleImage.x = (stageWidth - titleImage.width) >> 1;
			titleImage.touchable = false;
			addChild(titleImage);
		}
		
		private function onButtonClick(event:Event):void
		{
			if(event.target == btnPlay)
			{
				removeEventListener(Event.TRIGGERED, onButtonClick);	
				game.switchToScene(new GameScene(game));
			}
		/*	if(event.target == btnSettings)
			{
				removeEventListener(Event.TRIGGERED, onButtonClick);	
				game.switchToScene(new SettingsScene(game));
			}*/
		}
		
		private function disposeContent():void
		{
			titleImage = null;
			btnPlay = null;
			info = null;
		}
		
		override public function dispose():void{
			disposeContent();
			super.dispose();
		}
		
	}
}