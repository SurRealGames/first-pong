package
{
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import Ball;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.MouseEvent;
import Items;
import MenuButton;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
	
	
	
	
	/**
	 * ...
	 * @author SurReal Games
	 */
	public class Main extends MovieClip{
	
		public var cpuPaddle:Sprite = new Sprite;
		public var credits:TextField = new TextField;
		public var userPaddle:Sprite = new Sprite;
		public var playing:Boolean = true;
		public var gB:Ball = new Ball();
		public var back:Boolean = false;
		public var forward:Boolean = true;
		public var start:Boolean = true;
		public var uScore:int = 0;
		public var cScore:int = 0;		
		public var uScoreText:TextField = new TextField;
		public var cScoreText:TextField = new TextField;
		public var format:TextFormat=new TextFormat;
		public var repeat:uint=3;
		public var count:TextField=new TextField;
		public var cpspeed:int = 2;
		public var gameMode:uint=0;
		public static var eButton:MenuButton;
		public static var mButton:MenuButton;	
		public static var iButton:MenuButton;
		public static var title:TextField = new TextField;
		public var times:uint = new uint;
		public var menu:MenuButton = new MenuButton("MENU");
		public var timer:Timer = new Timer(1000, repeat);
		public var soundButton:SimpleButton = new SimpleButton;
		public var muteButton:MuteButton = new MuteButton;
		public var logo:Loader = new Loader;
		
		
		
		public function Main(){
			logo.load(new URLRequest("https://github.com/SurRealGames/first-pong/blob/master/SmallLogo.png?raw=true"));
			logo.y = 340;
			logo.x = 231;
			loadMusic();
			displayMenu();
			
		}
		
		private function draw():void{
			format.size=50;
			format.font="Arial Black";
			format.color=0xCE201F;
			
			
			gB.drawBall();
			gB.x=275;
			gB.y=200;
			addChild(gB);
			drawUP();
			drawCP();
			drawScoreUser();
			drawScoreCPU();
			countDown();
			
		}
		
		private function loop(e:Event):void{
			
		}
		
		
		public function drawUP():Sprite{
			userPaddle.graphics.beginFill(0x1D7A9C, 1);
			userPaddle.graphics.drawRect(5, 0, 10, 60);
			userPaddle.graphics.endFill();
			addChild(userPaddle);
			return userPaddle;	
		}
		
		public function drawCP():Sprite{
			cpuPaddle.graphics.beginFill(0x1D7A9C, 1);
			cpuPaddle.graphics.drawRect(0, 0, 10, 60);
			cpuPaddle.graphics.endFill();
			cpuPaddle.x = 535;
			cpuPaddle.y = stage.stageHeight/2-30;
			addChild(cpuPaddle);
			return cpuPaddle;
		}	
		
		public function gameLoop(e:Event):void{
			times = 1;
			userPaddle.y = mouseY-30;
			gB.x += gB.ballSpeedx;
			gB.y += gB.ballSpeedy;
			if (userPaddle.y - userPaddle.height +60< 0){
				userPaddle.y = 0;
			}
			else if (userPaddle.y + userPaddle.height >= 400){
				userPaddle.y = 400 - userPaddle.height;
			}
			if (cpuPaddle.y + cpuPaddle.height > 400){
				cpuPaddle.y = 400 - cpuPaddle.height-4;
			}
			if (cpuPaddle.y<2){
				cpuPaddle.y =2;
			}
			
			if (gB.y < cpuPaddle.y+10){
				cpuPaddle.y -= cpspeed;
			}
			else if (gB.y > cpuPaddle.y+20){
				cpuPaddle.y += cpspeed;
			}
			if (gB.y - 2.5 <= 2){
				gB.y = 5;
				gB.ballSpeedy *=-1;
			}
			if (gB.y + 2.5 >= 400){
				gB.y = 395;
				gB.ballSpeedy *=-1;
			}
			
			if (gB.hitTestObject(cpuPaddle)){
				gB.ballSpeedx *=-1;
				setAngle(2);
			}
			if (gB.hitTestObject(userPaddle)){
				gB.ballSpeedx *=-1;
				setAngle(1);
			}
			if (gB.x<=5+(userPaddle.width/2) && gB.x!=0){
				cScore+=1;
				drawScoreCPU();
				gB.x = 275;
				gB.y = 200;
				gB.ballSpeedx *=-1;
				removeChild(gB);
				stage.removeEventListener(Event.ENTER_FRAME, gameLoop);
				countDown();
			}
			
			if (gB.x>=cpuPaddle.x+(cpuPaddle.width/2)){
				uScore+=1;
				drawScoreUser();
				gB.x = 275;
				gB.y = 200;
				gB.ballSpeedx*=-1;
				removeChild(gB);
				stage.removeEventListener(Event.ENTER_FRAME, gameLoop);
				countDown();
			}
		}	
		public function drawBorders():void{
			var outline:Items = new Items();
			outline.graphics.lineStyle(2, 0x1D7A9C);
			outline.graphics.lineTo(550,0);
			outline.graphics.lineTo(550, 400);
			outline.graphics.lineTo(0, 400);
			outline.graphics.lineTo(0, 0);
			addChild(outline);
		}
		
		public function setAngle(mode:int):void{
			if (mode==1){
				gB.ballSpeedy=3*(((gB.y-30-userPaddle.y)/30));
			}
			else if (mode==2){
				gB.ballSpeedy=3*(((gB.y-30-cpuPaddle.y)/30));
			}
			if (gB.ballSpeedy==0){
			gB.ballSpeedy=(Math.floor(Math.random()*2)+1);
			}
		}
		public function drawScoreUser():void{
			uScoreText.defaultTextFormat=format;
			uScoreText.text=String(uScore);
			uScoreText.textColor=0xCE201F;
			uScoreText.x=(546/3);
			uScoreText.y=150;
			uScoreText.width=500;
			uScoreText.height=500;
			addChild(uScoreText);
		}
		public function drawScoreCPU():void{
			cScoreText.defaultTextFormat=format;
			cScoreText.text=String(cScore);
			cScoreText.textColor=0xCE201F;
			cScoreText.x=(546/3)*2;
			cScoreText.y=150;
			cScoreText.width=500;
			cScoreText.height=500;
			addChild(cScoreText);
		}
		public function countDown():void{
			repeat=3;
			count.defaultTextFormat=format;
			count.x=270;
			count.y=75;
			
			count.text=String(repeat);
			addChild(count);
			menu.x = 250;
			menu.y = 180;
			menu.width = 75;
			addChild(menu);
			timer.start();
			
			addChild(muteButton);
			muteButton.x = 275;
			muteButton.y = 230;
			
			menu.addEventListener(MouseEvent.MOUSE_OVER, countPause);
			muteButton.addEventListener(MouseEvent.MOUSE_OVER, countPause);
			menu.addEventListener(MouseEvent.CLICK, toMain);
			timer.addEventListener(TimerEvent.TIMER, down);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timeDone);
			
		}
		public function down(e:TimerEvent):void{
			repeat--;
			count.text = String(repeat);
			
		}
		public function timeDone(e:TimerEvent):void{
			removeChild(count);
			menu.removeEventListener(MouseEvent.MOUSE_OVER, countPause);
			menu.removeEventListener(MouseEvent.MOUSE_OUT, countResume);
			muteButton.removeEventListener(MouseEvent.MOUSE_OVER, countPause);
			muteButton.removeEventListener(MouseEvent.MOUSE_OUT, countResume);
			removeChild(menu);
			removeChild(muteButton);
			cpuPaddle.y=170;
			addChild(gB);
			gB.x=275;
			gB.y = 200;
			timer.reset();
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		public function countPause(e:MouseEvent):void{
			timer.stop();
			menu.addEventListener(MouseEvent.MOUSE_OUT, countResume);
			muteButton.addEventListener(MouseEvent.MOUSE_OUT, countResume);
		}
		public function countResume(e:MouseEvent):void{
			timer.start();
		}
		public function toMain(e:MouseEvent):void{
			cpuPaddle.parent.removeChild(cpuPaddle);
			userPaddle.parent.removeChild(userPaddle);
			menu.removeEventListener(MouseEvent.MOUSE_OVER, countPause);
			menu.removeEventListener(MouseEvent.MOUSE_OUT, countResume);
			menu.parent.removeChild(menu);
			muteButton.parent.removeChild(muteButton);
			cScoreText.parent.removeChild(cScoreText);
			uScoreText.parent.removeChild(uScoreText);
			timer.removeEventListener(TimerEvent.TIMER, down);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timeDone);
			timer.reset();
			count.parent.removeChild(count);
			displayMenu();
		}
		public function displayMenu():void{
			drawBorders();
			
			addChild(logo);
			credits.textColor = 0xCE201F;
			credits.y = 380;
			credits.width = 250;
			credits.htmlText = "<a href='https://opengameart.org/content/hero-immortal'>Music by Trevor Lentz</a>";
			addChild(credits);
			addChild(muteButton);
			muteButton.x = 500;
			muteButton.y = 350;
			muteButton.addEventListener(MouseEvent.CLICK, muteMusic);
			
			cScore = 0;
			uScore = 0;
			var titleFormat:TextFormat=new TextFormat;
			titleFormat.size=70;
			title.width=550;
			title.height=200;
			titleFormat.align="center";
			title.y=40;
			titleFormat.font="Arial Black";
			titleFormat.color=0xCE201F;
			title.defaultTextFormat=titleFormat;
			title.text="ImPawngible";
			title.selectable=false;
			addChild(title);
			
			eButton = new MenuButton("EASY");
			eButton.x=200;
			eButton.y = 180;

			mButton=new MenuButton("MEDIUM");
			mButton.x=200;
			mButton.y=240
			
			iButton=new MenuButton("IMPOSSIBLE");
			iButton.x=200;
			iButton.y=300;
			
			eButton.name = "easy";
			mButton.name = "medium";
			iButton.name = "impossible";
			
			
			addChild(eButton);
			addChild(mButton);
			addChild(iButton);
			
			
			eButton.addEventListener(MouseEvent.CLICK, settings(1));
			mButton.addEventListener(MouseEvent.CLICK, settings(2));
			iButton.addEventListener(MouseEvent.CLICK, settings(3));
			
			
			function settings(gameMode:uint):Function{
			
			return function(e:MouseEvent):void{
			
			var eButton:MenuButton = getChildByName("easy") as MenuButton;
			var mButton:MenuButton = getChildByName("medium") as MenuButton;
			var iButton:MenuButton = getChildByName("impossible") as MenuButton;
			
			
			if (contains(title)){
				removeChild(title);
			}
			if (contains(eButton)) {
				removeChild(eButton);
				eButton.removeEventListener(MouseEvent.CLICK, settings);
			}
			if (contains(mButton)){
				removeChild(mButton);
				mButton.removeEventListener(MouseEvent.CLICK, settings);
			}
			if (contains(iButton)){
				removeChild(iButton);
				iButton.removeEventListener(MouseEvent.CLICK, settings);
			}
			if (contains(muteButton)){
				removeChild(muteButton);
			}
			if (contains(credits)){
				removeChild(credits);
			}
			removeChild(logo);
			
			cpspeed=1;
			gB.ballSpeedx=4;
			gB.ballSpeedy=2;
			
			if(gameMode==2){
				cpspeed = 3;
				gB.ballSpeedy=4;
			}
			if(gameMode==3){
				cpspeed = 10;
				gB.ballSpeedy=4;
			}
			gB.ballSpeedx*=gameMode;
			draw();
			times = gameMode;
			};
		}
		}
		public var music:Sound = new Sound();
		public function loadMusic():void{
		music.load(new URLRequest("https://opengameart.org/sites/default/files/Hero%20Immortal_0.mp3"));
		music.addEventListener(Event.COMPLETE, playMusic);
		}
		public var isplayingmusic:Boolean = true;
		public var channel:SoundChannel = new SoundChannel(); 
		public function playMusic(e:Event):void{
					muteButton.downState = muteButton.button.off;
					muteButton.upState = muteButton.button.on;
					muteButton.overState = muteButton.button.off;
					muteButton.hitTestState = muteButton.button.on;
					removeChild(muteButton);
					addChild(muteButton);
				
			muteButton.music = true;
			channel = music.play();
			channel.addEventListener(Event.SOUND_COMPLETE, playMusic);
			muteButton.removeEventListener(MouseEvent.CLICK, playMusic);
			muteButton.addEventListener(MouseEvent.CLICK, muteMusic);
		}
		public function muteMusic(e:MouseEvent):void{
					muteButton.upState = muteButton.button.off;
					muteButton.downState = muteButton.button.on;
					muteButton.overState = muteButton.button.on;
					muteButton.hitTestState = muteButton.button.on;
					removeChild(muteButton);
					addChild(muteButton);
				
			muteButton.music = false;
			channel.stop();
			muteButton.removeEventListener(MouseEvent.CLICK, muteMusic);
			muteButton.addEventListener(MouseEvent.CLICK, playMusic);
		}
		public function showError(e:IOErrorEvent):void{
			trace("music");
			trace(e.text);
		}
	}
}	
