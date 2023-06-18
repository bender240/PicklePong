class MainMenu {
  void display() {
    image(background, 0, 0, width, height);
    fill(#ff4000);
    image(playbutton, x, y, w, h);
    textSize(32);
    textAlign(CENTER, CENTER);
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h) && mousePressed) {
      gameHasStarted = true;
    }
  }
}
