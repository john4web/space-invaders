class Bullet {

  //Properties
  private int xPos;
  private int yPos=602;
  private int speed=0;
  private boolean fire = false;


  //Construcor
  Bullet() {
  }


  //Methods
  void drawBullet() {

    if (fire==true) {        
      noStroke();  
      rect(xPos+24, yPos, 2, 15);
    }    //Kugel wird gezeichnet
  }



  void moveBullet(int xPos) {
    if (fire == false) {
      this.xPos = xPos;
    } // Bullet bekommt nur dann die x-Position von gun,wenn fire == false
    if (fire == true) {
      yPos-=speed;



      if (yPos<=0) {

        yPos=602;    //Wenn die Kugel aus dem Fenster fliegt, wird sie wieder hinter die gun gezeichnet
        speed=0;
        fire = false;
      }
    }
  }



  void triggerBullet() {

    if (key==' ') {  //Wenn man Space drückt, wird die Kugel abgefeuert
      speed=17;
      fire=true;

      gunshot.play();
    }
  }
}