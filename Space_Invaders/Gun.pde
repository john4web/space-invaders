class Gun {

  //Properties
  private int xPos=470;
  private int yPos=600;
  private boolean death = false;
  private int speed = 10;
  private int deathTime;
  private int deathPosX;
  private int deathPosY;
  private boolean sound = true;


  //Constructor
  Gun() {
  }


  //Methods
  public void drawGun() {

    image(gun, xPos, yPos, 53, 33);

    deathPosX = xPos;
    deathPosY = yPos;
  }

  public void moveGun() {


    if (keyCode==RIGHT) {
      xPos+=speed;
    }

    if (keyCode==LEFT) {
      xPos-=speed;
    }

    if (xPos>=width-60) {
      xPos=width-60;
    }

    if (xPos<=10) {
      xPos=10;
    }
  }




  public void killGun() {

    if (death==true && millis()-deathTime<=2000) { // Passiert wenn die Gun getroffen wird
      stopGame=true;
      //Gun-Tod-Gif aufrufen
      deadGun.play();
      image(deadGun, deathPosX-20, deathPosY-35, 100, 100);

      if (sound==true) {  //damit sound nur einmal abgespielt wird
        gundeath.play();
        sound=false;
      }

      xPos=470;
      yPos=600;
    } else {
      sound=true;
      stopGame=false;
      if (gunLifes<=0) {
        state=6;
      }
    }
  }



  public int getGunPosX() {    //Getter-Methode, um die x-Position der Gun an Bullet weiterleiten zu können
    return this.xPos;
  }
  
  
  
}