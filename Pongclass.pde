import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
boolean gameHasStarted;
boolean botActive = true;
//button values for main menu 
// ball values
float ballX = 100, ballY = 100;
float ballSpeedX = 10.0, ballSpeedY = 4.0;
float x; 
float y;
float w;
float h;
float widthpong = width;
// paddle values
float paddle1Y = 100.0, paddle2Y = 100.0;
float PADDLE_HEIGHT = 100.0;

// score values
int scoreP1 = 0, scoreP2 = 0;
int PLAY_TIL_SCORE = 3;
// adds pimages
PImage img;
PImage img2;
PImage background;
PImage playbutton;
Minim minim;
AudioSample ballsound;
AudioPlayer music;
MainMenu mainMenu = new MainMenu();
Paddles paddles = new Paddles();
void setup() {
  
  minim = new Minim(this);
  ballsound = minim.loadSample("ballhit.mp3");
  music =minim.loadFile("theme.mp3");
  size(800, 600, P2D);
  x = width/2-100;    // top left corner x position
  y = height/2-45;    // top left corner y position
  w = width/4;    // width of button
  h = height/4;    // height of button
  img = loadImage("leftpaddle.png");
  img2 = loadImage("ball.png");
  background = loadImage("background.jpg");
  playbutton = loadImage("playbutton.png");
  // by default text() calls left align, but this next call
  // means all text() calls in the program will center text
  textAlign(CENTER);
  music.loop();
  gameHasStarted = false;
}

void draw() {
  mainMenu.display();
  
  if (!gameHasStarted) {
  } else
  {
    // erase what the previous frame drew
    fill(0, 0, 0); // set fill color to black
    image(background, 0, 0, width, height); // then wipe the screen with the black
    fill(255, 255, 255); // set fill to white for remaining graphics
    // note that background(0); achieves the same effect as the
    // above without altering the fill color for later calls.
    // though convenient it also hides what's going on, so I've
    // opted to use the above approach to be more explicit.
    if (key =='f') {
      botActive =false;
    }
    //bot or player control of paddles
    if (key =='p') {
      botActive=true;
    }
    paddles.drawNet();

    if (scoreP1 >= PLAY_TIL_SCORE) {
      text("Player 1 Wins!\nClick to restart", 
        width/2, height/2);
      paddles.resetUponNextClick();
    } else if (scoreP2 >= PLAY_TIL_SCORE) {
      text("Player 2 Wins!\nClick to restart", 
        width/2, height/2);
      paddles.resetUponNextClick();
    } else { // neither player has enough points, keep playing
      paddles.moveAndDrawPlayerPaddle();

      paddles.moveAndDrawComputerPaddle();

      paddles.moveAndDrawBall();
    }

    // display scores
    text(scoreP1, width/2-10, 15);
    text(scoreP2, width/2+10, 15);

    // check the ball against the screen edges
    paddles.boundsAndPaddleCheck();

  }
}
