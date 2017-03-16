package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author SurReal Games
	 */
	public class Ball extends MovieClip{
		public var whiteBall:Ball = new Ball();
		
		whiteBall.drawBall();
		
		public function drawBall():void{
			whiteBall.graphics.beginFill(0x000000, 1);
			whiteBall.graphics.drawCircle(0, 0, 5);
			whiteBall.graphics.endFill();
			this.addChild(whiteBall);
		}
	}
}