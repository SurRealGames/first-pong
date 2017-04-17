package 
{
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.text.TextFormat;
import ButtonState;


	public class MenuButton extends SimpleButton{
	
		public var words:String;
		
		private var upColor:int=0xdcdddf;
		private var overColor:uint=0x1c1c1e;
		private var downColor:uint=0x000000;
		private var label:String = new String;
		
		/*private var format:TextFormat=new TextFormat;
		
		//format.align="center";
		format.color=0x000000;
		format.font="Arial Black";
		//format.size=15;*/
	
			public function MenuButton(words:String):void{
				label = words;
				useHandCursor=true;
				upState=new ButtonState(upColor, label);
				overState=new ButtonState(overColor, label);
				downState=new ButtonState(downColor, label);
				hitTestState=upState;
			}
	}
}