package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Items;
	import Ball;
	
	/**
	 * ...
	 * @author SurReal Games
	 */
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		var whiteBall:Ball = new Ball();
		whiteBall.drawball();
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}