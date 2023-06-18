class Paddles {
  void moveAndDrawPlayerPaddle() {
    paddle1Y = mouseY - (PADDLE_HEIGHT/2);
    //adds pickle image as paddle
    image(img, 20, paddle1Y, 10, PADDLE_HEIGHT);
  }

  void moveAndDrawComputerPaddle() {
    if (botActive) {

      float AItargetY = ballY- (PADDLE_HEIGHT/2);

      if (paddle2Y < AItargetY-35.0) {
        paddle2Y += 4.25;
      } else if (paddle2Y > AItargetY+35.0) {
        paddle2Y -= 4.25;
      }
      while (botActive ==false) {
        if (keyPressed ==true && key == 'w')
          PADDLE_HEIGHT =PADDLE_HEIGHT -5;
        if (keyPressed ==true && key =='s') 
          widthpong = widthpong +5;
      }
    }

    // adds images
    image(img, widthpong-30, paddle2Y, 15, PADDLE_HEIGHT);
  }

  void moveAndDrawBall() {
    // move and draw ball
    ballX += ballSpeedX;
    ballY += ballSpeedY;
    // adds garlic as ball 
    image(img2, ballX, ballY, 30, 30);
  }

  void ballReset() {
    // reverse ball heading, so whoever scored a point serves
    ballSpeedX = -ballSpeedX;
    ballSpeedY = 0.0;

    // center ball on screen
    ballX = width/2;
    ballY = height/2;
  }

  // bounce ball off top/bottom edges and paddles
  void boundsAndPaddleCheck() {
    if (ballX > width) { // ball went past right edge

      // if ball is below top of p2 paddle and above bottom...
      if (ballY > paddle2Y &&
        ballY < paddle2Y+PADDLE_HEIGHT) {
        // then p2 hit the ball, so flip its horizontal heading
        ballSpeedX = -ballSpeedX;
        ballsound.trigger();

        // and set y speed based on distance from paddle center
        float deltaY = ballY-(paddle2Y+PADDLE_HEIGHT/2);
        ballSpeedY = deltaY * 0.25;
      } else { // otherwise player 1 scored
        scoreP1++;
        ballReset();
      }
    }

    if (ballX < 0) { // ball went past left edge

      // if ball is below top of p1 paddle and above bottom...
      if (ballY > paddle1Y &&
        ballY < paddle1Y+PADDLE_HEIGHT)
      {
        // then p1 hit the ball, so flip its horizontal heading
        ballSpeedX = -ballSpeedX;

        // and set y speed based on distance from paddle center
        float deltaY = ballY-(paddle1Y+PADDLE_HEIGHT/2);
        ballsound.trigger();
        ballSpeedY = deltaY * 0.35;
      } else { // otherwise player 2 scored
        scoreP2++;
        ballReset();
      }
    }

    if (ballY > height) { // ball bouncing off bottom
      ballSpeedY = -ballSpeedY;
    }
    if (ballY < 0) { // ball bouncing off top
      ballSpeedY = -ballSpeedY;
    }
  }

  // draws the dashed line down the middle
  void drawNet() {
    // the for loop drawing the dashed line, spatially, can be
    // read, "starting at the top of the screen, as long as
    // we're still above the bottom of the screen, draw a
    // 2x20 pixel rectangle at every 40 pixel interval"
    for (int i=0; i<height; i+=40) {
      rect(width/2-1, i, 2, 20);
    }
  }

  // called when either player has enough points to have won
  void resetUponNextClick() {
    if (mousePressed) { // true only when mouse button is down
      scoreP1 = scoreP2 = 0; // reset scores
      ballReset(); // reset the ball
    }
  }
}
