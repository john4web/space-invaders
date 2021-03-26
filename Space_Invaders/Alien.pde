class Alien {

  protected int time;
  protected int xPos;
  protected int yPos;
  protected int deathTime;

  protected boolean imageSwitch = false;
  protected int deathPosX;
  protected int deathPosY;

  protected int movevariable = 500;
  protected boolean back = false;

  protected color tintColor = #FFFFFF;

  protected int alienSpeed=16;
  public boolean alienDeath=false;


  Alien(int xPos, int yPos) {

    this.xPos = xPos;
    this.yPos = yPos;
  }


  void drawAlien(Gif alienpicture) {  //Wenn ein Alien abgeschossen wird, wird imageSwitch auf true gesetzt und die bisherige Zeit in deathTime gespeichert
    tint(tintColor);

    if (killcounter>15 && killcounter<=30) {//damit die Aliens sich immer schneller bewegen, je mehr abgeschossen werden
      alienSpeed=8;
    }

    if (killcounter>30 && killcounter<=45) {
      alienSpeed=4;
    }

    if (killcounter>45) {
      alienSpeed=1;
    }




    if (imageSwitch==false) {

      alienpicture.play();

      image(alienpicture, xPos, yPos, 50, 50);

      deathPosX=xPos;  //die letzte Position bevor das Alien stirbt wird in deathPosX und deathPosY gespeichert
      deathPosY=yPos;
    } else {

      if (millis()-deathTime<=400) {  //das Todesbild wird 500 Millisekunden lang angezeigt        es wird die Differenz zwischen der letzten Zeit(deathTime) und der aktuellen Zeit gebildet
        image(deathpicture, deathPosX, deathPosY, 50, 50);
      } else {
        imageSwitch=false;  //Alien wird wieder gezeichnet, aber es befindet sich schon außerhalb des Bildes
      }
    }


    noTint();
  }



  void moveAlien() {

    time = millis()/200;


    if (time%alienSpeed==0) {    // Aliens bewegen sich schrittweise

      if (movevariable<466) {    // lässt die Aliens nach links und rechts und nach unten bewegen
        yPos+=20;
        back=false;
      }

      if (movevariable>536) {
        yPos+=20;
        back=true;
      }

      if (back==false) {
        xPos++;
        movevariable++;
      }

      if (back==true) {
        xPos--;
        movevariable--;
      }
    }
  }



  void killAlien(int points) {


    if (missile.yPos > yPos-25 && missile.yPos < yPos + 25 && missile.xPos > xPos -25 && missile.xPos < xPos+25) { //Wenn die Kugel ein Alien trifft,...

      deadalien.play();//Ton wird aufgerufen

      killcounter++;



      imageSwitch=true;
      deathTime=millis();

      score+=points;

      xPos =-1000;    // Damit das erzeugte Alien-Objekt aus dem Bild geworfen wird
      alienDeath=true;  // Damit die AlienBullet weiß, ob ein Alien Tod ist und ob von ihm ein Schuss ausgehen darf

      missile.yPos=602;
      missile.speed=0;
      missile.fire = false;    //Position der Kugel hinter der Gun
    }
  }



  void level() {

    if (killcounter==55) {


      //Alle Aliens kommen wieder auf die Anfangsposition
      for (int i=0; i<=10; i++) {
        bottom[i] = new Alien((i*60+170), 330);  //Die vierte Reihe Aliens wird initialisiert
      }

      for (int i=11; i<=21; i++) {
        bottom[i] = new Alien(((i*60+170)-660), 400);  //Die fünfte Reihe Aliens wird initialisiert
      }



      for (int i=0; i<=10; i++) {
        middle[i] = new Alien((i*60+170), 190);  //Die zweite Reihe Aliens wird initialisiert
      }

      for (int i=11; i<=21; i++) {
        middle[i] = new Alien(((i*60+170)-660), 260);  //Die dritte Reihe Aliens wird initialisiert
      }

      for (int i=0; i<=10; i++) {
        top[i] = new Alien((i*60+170), 120);  //Die erste Reihe Aliens wird initialisiert
      }


      levelcounter++;
      killcounter=0;
    }
  }


  void setAlienColor() {  //Färbt die Aliens grün, wenn sie eine bestimmte yPos überschreiten

    if (yPos>height-200) {
      tintColor=#00FF00;
    }


    if (yPos>540 && xPos>0 && xPos<width) {  //Wenn die Aliens zu weit herunterkommen und noch im Bild sind(also noch nicht gestorben sind)
      yPos=539;  //Damit diese if anweisung nur einmal ausgeführt wird und in deathtime und gameovertime nur einmal die Zeit gespeichert wird
      cannon.death=true;
      gunLifes=0;
      cannon.deathTime=millis();

      mainmenu.gameOverTime=millis();  //Zeit für das Game-Over-Menü wird gespeichert
      noTint();
    }
  }
}