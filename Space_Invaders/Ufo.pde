class Ufo {

  //Properties
  private int xPos=1000;
  private int yPos=50;
  private int speed = 2;
  private boolean imageSwitch=false;
  private int deathPosX;
  private int deathPosY;
  private int deathTime;
  private int randomScore;
  private boolean triggerUfo=false;
  private boolean sound = true;


  //Constructor
  Ufo() {
  }


  //Methods
  private void drawUfo() {  //Wenn das Ufo abgeschossen wird, wird imageSwitch auf true gesetzt und die bisherige Zeit in deathTime gespeichert

    if (imageSwitch==false) {

      noTint();
      image(ufo, xPos, yPos, 50, 50);

      deathPosX=xPos;  //die letzte Position bevor das Ufo stirbt wird in deathPosX und deathPosY gespeichert
      deathPosY=yPos;
    } else {

      if (millis()-deathTime<=3000) {  //das Todesbild wird 3000 Millisekunden lang angezeigt        es wird die Differenz zwischen der letzten Zeit(deathTime) und der aktuellen Zeit gebildet
        tint(#FF0000);
        fill(#FF0000);
        image(deathpicture, deathPosX, deathPosY, 50, 50);
        textSize(20);
        text(randomScore, deathPosX+10, deathPosY);
        fill(#FFFFFF);
        noTint();
      } else {
        imageSwitch=false;  //Ufo wird wieder gezeichnet, aber es befindet sich schon außerhalb des Bildes
      }
    }
  }

  private void moveUfo() {

    if (triggerUfo==true) {

      if ((millis()/800)%2==0) {    //Schrift wird angezeigt
        textSize(20);
        fill(#FF0000);
        text("MOTHERSHIP DETECTED", 350, height-17);
        fill(#FFFFFF);
      }  


      if (sound==true) {  //diese if schleife ist, damit der sound nur einmal aufgerufen wird
        ufosound.play();
        sound=false;
      }


      xPos-=speed;  //Ufo bewegt sich nach links

      if (xPos==-50) {
        triggerUfo=false; //Ufo wird nicht ausgelöst
        xPos =width;  // Ufo befindet sich an der Anfangsposition
        sound=true;
      }
    }
  }



  private void killUfo() {

    if (missile.yPos > yPos-25 && missile.yPos < yPos + 25 && missile.xPos > xPos -25 && missile.xPos < xPos+25) { //Wenn die Kugel das Ufo trifft,...

      ufosound.stop();//Ufosound wird gestoppt
      ufosound.cue(0);//Ufosound beginnt von vorne
      sound=true; //Sound kann wieder abgespielt werden
      ufoexplosion.play();  // Ufoexplosion wird abgespielt

      imageSwitch=true;
      deathTime=millis();

      randomScore=floor(random(200)); //Generiert eine Zufallszahl zwischen 0 und 200

      score+=randomScore;

      xPos =width;    // Damit das erzeugte Ufo-Objekt wieder an der Anfangsposition ist 
      triggerUfo=false;

      missile.yPos=602;
      missile.speed=0;
      missile.fire = false;    //Position der Kugel hinter der Gun
    }
  }



  private void triggerUfo() {

    if (millis()%2048==0) {  //die aktuelle Zeit wird modulo 2048 gerechnet. wenn dabei 0 rauskommt, wird das Ufo in gang gesetzt

      triggerUfo=true;
    }
  }
}