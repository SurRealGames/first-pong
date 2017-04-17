package 
{
import flash.display.Loader;
import flash.display.SimpleButton;
import flash.display.Sprite;
import ButtonState;
import flash.net.URLRequest;


	public class MuteButton extends SimpleButton{
		private var on:Loader = new Loader;
		private var off:Loader = new Loader;
		public var music:Boolean = true;
		public var button:MuteState = new MuteState;
	
			public function MuteButton():void{
				useHandCursor=true;
				
				if (music == true){
					upState = button.on;
					downState = button.off;
					overState=downState;
					hitTestState = downState;
				}
				/*if (music == false){
					upState = button.off;
					downState = button.on;
					overState=downState;
					hitTestState = downState;
				}*/
				visible=true;
			}
	}
}