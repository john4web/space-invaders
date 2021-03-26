class UserInterface {

  //Properties

  //Constructor
  UserInterface() {
  }


  //Methods 

  private void drawLine() {  //Zeichnet die Linie unterhalb der Gun
    stroke(#00FF00);
    strokeWeight(2);
    line(0, height-50, width, height-50);
  }



  private void drawScore() {  //Zeichnet die Score und HI-Score Fenster

    textSize(20);
    text("SCORE  " + score, 10, 30);
    text("HI - SCORE  " + highScore, width-320, 30);


    if (highScore>999999999999999L) {  //Damit sich die Zahl im Fenster noch ausgeht
      highScore=0;
    }
  }




  private void drawGunLifes() { //Zeichnet die Leben der Gun

    fill(#00FF00);
    text(gunLifes, 20, height-17);

    if (gunLifes==3) {  //Wenn die Gun 3 Leben hat, werden zwei guns gezeichnet
      image(gun, 50, height-36, 27, 17);
      image(gun, 90, height-36, 27, 17);
    }

    if (gunLifes==2) {
      image(gun, 50, height-36, 27, 17);
    }

    if (gunLifes<=0) {
      gunLifes=0;
    }


    text("LEVEL " + levelcounter, 850, height-17);
  }
}