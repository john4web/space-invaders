class Menu {


  // Properties
  private int time;
  private int gameOverTime;
  private boolean sound =true;
  private boolean gameoversoundSwitch=true;
  private boolean titlemusicSwitch=true;


  //Constructor
  Menu() {
  }


  //Methods

  public void drawMenu() {
    noTint();
    textFont (font);
    textSize(40);


    if (state==1) {  // Hier wird das Titelmenü gezeichnet
    
      highscoreManager.readTextDocument(); //Jedes mal, wenn das Titelmenü angezeigt wird, wird der Wert aus dem Textdokument in die Variable highScore gespeichert.

      image(title, 110, 50);


      time = millis()/800;
      if (time%2==0) {
        fill(#FFFFFF);
        text("PRESS SPACE", 350, 600);
      }

      if (titlemusicSwitch==true) {  //damit titlemusic nur einmal abgespielt wird
        titlemusic.play();
        titlemusicSwitch=false;
      }
    }


    if (state==2) { //Hier wird das Modus-Auswahl-Menü gezeichnet

      if (mouseX>434 && mouseX<549 && mouseY>212 && mouseY<250) {//Bedingungen, dass Hover: Grün
        fill(#00FF00);

        if (sound==true) {  //damit sound nur einmal abgespielt wird
          menusound2.play();
          sound=false;
        }
      } else {
        fill(#FFFFFF);
      }
      text("PLAY", 430, 250);

      if (mouseX>324 && mouseX<675 && mouseY>363 && mouseY<400) {
        fill(#00FF00);
        if (sound==true) {  //damit sound nur einmal abgespielt wird
          menusound2.play();
          sound=false;
        }
      } else {
        fill(#FFFFFF);
      }
      text("INSTRUCTIONS", 320, 400);

      if (mouseX>384 && mouseX<617 && mouseY>514 && mouseY<550) {
        fill(#00FF00);

        if (sound==true) {  //damit sound nur einmal abgespielt wird
          menusound2.play();
          sound=false;
        }
      } else {
        fill(#FFFFFF);
        sound=true;

        if (mouseX>324 && mouseX<675 && mouseY>363 && mouseY<400 || mouseX>434 && mouseX<549 && mouseY>212 && mouseY<250) {
          sound=false;
        }
      }
      text("HI-SCORE", 380, 550);
    }


    if (state==3) {//Hier wird das Play-Menü gezeichnet
      fill(#FFFFFF);
    }

    if (state==4) {//Hier wird das Instructions-Menü gezeichnet

      image(instructions, 0, 0);

      fill(#FFFFFF);



      if (mouseX>24 && mouseX<305 && mouseY>650 && mouseY<672) { //Bedingung, dass Hover: Grün
        fill(#00FF00);

        if (sound==true) {  //damit sound nur einmal abgespielt wird
          menusound2.play();
          sound=false;
        }
      } else {
        sound=true;
        fill(#FFFFFF);
      }

      textSize(20);
      text("<-- BACK TO MAIN MENU", 25, 670);
    }

    if (state==5) {//Hier wird das Hi-Score-Menü gezeichnet
      fill(#FFFFFF);
      textSize(50);
      text("HI-SCORE", 370, 70);
      fill(#00FF00);
      text("" + highScore, 440, 400);  //Highscore wird ausgegeben
      fill(#FFFFFF);

      if (mouseX>24 && mouseX<305 && mouseY>650 && mouseY<672) { //Bedingung, dass Hover: Grün
        fill(#00FF00);

        if (sound==true) {  //damit sound nur einmal abgespielt wird
          menusound2.play();
          sound=false;
        }
      } else {
        fill(#FFFFFF);
        sound=true;
      }

      textSize(20);
      text("<-- BACK TO MAIN MENU", 25, 670);
    }



    if (state==6) {//Hier wird das Game-Over-Menü gezeichnet

      if (millis()-gameOverTime<=8000) {    //Game-Over-Menü wird nur kurze Zeit lang gezeichnet
        textSize(100);
        text("GAME OVER", 170, height/2-50);
        textSize(50);
        text("SCORE  " + score, 340, height/2+100);
        ufosound.stop();//Ufosound wird gestoppt
        ufosound.cue(0);//Ufosound beginnt von vorne

        if (gameoversoundSwitch==true) {  //damit der gameoversound nur einmal abgespielt wird
          gameoversound.play();
          gameoversoundSwitch=false;
        }


        if (highscoreManager.writeConfirmedHighScore()==true) {  // Wird nur geschrieben wenn auch wirklich ein neuer highscore erreicht wurde
          fill(#FF0000);
          text("!! NEW HI-SCORE !!", 250, height/2+250);
          fill(#FFFFFF);
        }

        textSize(20);
      } else {
        gameoversoundSwitch=true;
        highscoreManager.writeTextDocument();    //Es wird geschaut, ob der erreichte Score größer ist, als der aktuelle highScore. Wenn das so ist, wird der score in das Textdokument geschrieben.

        state=1;    //Danach kommt man wieder ins Hauptmenü
        titlemusicSwitch=true; // Titelmusik kann wieder abgespielt werden

        killcounter=0;        //Alle Spielvarianten Variablen werden auf Anfang gesetzt
        cannon.death=false;
        levelcounter=1;
        score=0;
        gunLifes=3;
        mothership.triggerUfo=false; 
        mothership.xPos =width;
        mothership.sound=true;

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
      }
    }
  }


  public void triggerMenu() {

    if (state==2 && mouseX>434 && mouseX<549 && mouseY>212 && mouseY<250) { //Hier wird das Play-Menü aufgerufen
      state = 3;
      menusound1.play();
    }

    if (state==2 && mouseX>324 && mouseX<675 && mouseY>363 && mouseY<400) { //Hier wird das Instructions-Menü aufgerufen
      state = 4;
      menusound1.play();
    }

    if (state==2 && mouseX>384 && mouseX<617 && mouseY>514 && mouseY<550) { //Hier wird das Hi-Score-Menü aufgerufen
      state = 5;
      menusound1.play();
    }

    if ((state==4 || state==5) && mouseX>24 && mouseX<305 && mouseY>650 && mouseY<672) { //Hier wird das Hauptmenü vom Instructions-Menü oder vom Hi-Score Menü aus aufgerufen
      state = 2;
      menusound1.play();
    }
    
  }
  
  
}