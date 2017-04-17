package 
{
import flash.text.TextFormat;
import flash.display.Sprite;
import flash.text.TextField;



	public class ButtonState extends Sprite{
		private var bgColor:uint;
		
		public function ButtonState(bgColor:uint, label:String){
			this.bgColor=bgColor;
			var words:TextField = new TextField;
			var format:TextFormat = new TextFormat;
			format.align = "center";
			format.font = "Arial";
			format.bold = true;
			format.size = 23;
			words.defaultTextFormat = format;
			words.text = label;
			words.textColor = 0xCE201F;
			words.width = 150;
			words.height = 30;
			//words.autoSize="center";
			graphics.beginFill(bgColor);
			graphics.drawRect(0, 0, 150, 30);
			addChild(words);
			graphics.endFill();
		}
	}
}