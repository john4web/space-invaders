class AlienBullet {

  //Properties
  private int xPos;
  private int yPos;
  private int speed=3;
  private color tintColor = #FFFFFF;
  
  //Constructor
  AlienBullet() {
  }



  //Methods
  public void drawAlienBullet() { //Alienbullet wird gezeichnet

    if (yPos==0) {// Damit die erste AlienBullet nicht bei xPos=0 abgeschossen wird, sondern gleich bei einem Alien
      setAlienBulletPosition();
    }

    tint(tintColor);
    image(drop, xPos, yPos, 20, 20);
  }



  public void moveAlienBullet() {  //Alienbullet bewegt sich nach unten
    yPos+=speed;
  }



  public void collideAlienBullet() {

    if (yPos>height-70) {  //Kollision der Alienbullet mit Boden

      //position auf Anfang ändern
      setAlienBulletPosition();
      //Farbe wieder auf weiß setzen
      tintColor=#FFFFFF;
    }

    if (missile.yPos > yPos-10 && missile.yPos < yPos + 10 && missile.xPos > xPos -30 && missile.xPos < xPos) { //Kollision der Alienbullet mit Kugel von Gun

      //position auf Anfang ändern
      setAlienBulletPosition();
      //Farbe wieder auf weiß setzen
      tintColor=#FFFFFF;


      missile.yPos=602;
      missile.speed=0;
      missile.fire = false;    //Position der Kugel hinter der Gun
    }

    if (yPos > cannon.yPos-20 && xPos > cannon.xPos-20 && xPos < cannon.xPos+50) { //Kollision der Alienbullet mit Gun

      //position auf Anfang ändern
      setAlienBulletPosition();
      //Farbe wieder auf weiß setzen
      tintColor=#FFFFFF;

      gunLifes--;
      cannon.death=true;
      cannon.deathTime=millis();

      mainmenu.gameOverTime=millis();  //Zeit für das Game-Over-Menü wird gespeichert
    }
  }



  void setAlienBulletColor() {  //Färbt die Tropfen grün, wenn sie eine bestimmte yPos überschreiten

    if (yPos>height-140) {
      tintColor=#00FF00;
    }
  }



  private void setAlienBulletPosition() {  

    int randomNumber = floor(random(11, 22));

    if (bottom[randomNumber].alienDeath==false) {  //Wenn das ausgewählte Alien aus der untersten Reihe lebt, dann schießt es


      xPos = bottom[randomNumber].xPos + 15;
      yPos = bottom[randomNumber].yPos;
    } else {//Wenn das ausgewählte Alien aus der untersten Reihe tot ist, dann wird nachgeschaut ob das alien dahinter tot ist. Wenn nicht, schießt dieses.


      if (bottom[randomNumber-11].alienDeath==false) {

        xPos = bottom[randomNumber-11].xPos + 15;
        yPos = bottom[randomNumber-11].yPos;
      } else {//Wenn dieses Alien auch tot ist, wird in der nächsten Reihe nachgeschaut. USW.


        if (middle[randomNumber].alienDeath==false) {

          xPos = middle[randomNumber].xPos + 15;
          yPos = middle[randomNumber].yPos;
        } else {

          if (middle[randomNumber-11].alienDeath==false) {

            xPos = middle[randomNumber-11].xPos + 15;
            yPos = middle[randomNumber-11].yPos;
          } else {

            if (top[randomNumber-11].alienDeath==false) {

              xPos = top[randomNumber-11].xPos + 15;
              yPos = top[randomNumber-11].yPos;
            }
          }
        }
      }
    }
  }
  
  
}