package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author SurReal Games
	 */
	public class Ball extends Sprite{
		public var ballSpeedx:int = 3;
		public var ballSpeedy:Number = 2;
		
		public function drawBall():Sprite{
			var gameBall:Sprite = new Sprite;
			gameBall.graphics.beginFill(0x1D7A9C, 1);
			gameBall.graphics.drawCircle(0, 0, 5);
			gameBall.graphics.endFill();
			addChild(gameBall);
			return gameBall;
		}
	}
}
