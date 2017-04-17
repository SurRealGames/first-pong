package 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MuteState extends Sprite{
		public var on:Loader = new Loader;
		public var off:Loader = new Loader;
		
		public function MuteState():void{
			on.load(new URLRequest("https://opengameart.org/sites/default/files/soundOnWhite_0.png"));
			off.load(new URLRequest("https://opengameart.org/sites/default/files/soundOffWhite_0.png"));
		
		}
	}
}