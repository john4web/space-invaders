import gifAnimation.*;
import processing.sound.*;

SoundFile gunshot; 
String path1;

SoundFile deadalien; 
String path2;

SoundFile ufosound; 
String path3;

SoundFile ufoexplosion; 
String path4;

SoundFile titlemusic; 
String path5;

SoundFile menusound1; 
String path6;

SoundFile menusound2; 
String path7;

SoundFile gundeath; 
String path8;

SoundFile gameoversound; 
String path9;


PImage title;
PImage instructions;
PImage gun;
PFont font;
PImage deathpicture;
PImage drop;
PImage ufo;

int state = 1;
int gunPosX;
int gunPosY;
int killcounter=0; //zählt die anzahl der abgeschossenen Aliens
int levelcounter=1; //zählt das aktuelle Level
boolean stopGame=false;


long score=0;
long highScore=0;
int gunLifes=3;

Gif alien1;
Gif alien2;
Gif alien3;
Gif deadGun;

Menu mainmenu = new Menu();
Menu trigger = new Menu(); //trigger wird nur in mousePressed aufgerufen
Gun cannon = new Gun();
Bullet missile = new Bullet();
UserInterface desktop = new UserInterface();
Ufo mothership = new Ufo();
Highscore highscoreManager = new Highscore();
AlienBullet alienmissile = new AlienBullet();


Alien[] bottom = new Alien[22];    //Array der untersten Aliens wird deklariert
Alien[] middle = new Alien[22];    //Array der mittleren Aliens wird deklariert
Alien[] top = new Alien[11];    //Array der obersten Aliens wird deklariert





void settings() {
  size(1000, 700);
}


void setup() {
alien1 = new Gif(this, "1.gif");
alien2 = new Gif(this, "2.gif");
alien3 = new Gif(this, "3.gif");

deadGun = new Gif(this, "deadgun.gif");

path1 = sketchPath("data/lasergun.mp3");
gunshot = new SoundFile(this, path1);

path2 = sketchPath("data/deadalien.mp3");
deadalien = new SoundFile(this, path2);

path3 = sketchPath("data/ufosound.mp3");
ufosound = new SoundFile(this, path3);

path4 = sketchPath("data/ufoexplosion.mp3");
ufoexplosion = new SoundFile(this, path4);

path5 = sketchPath("data/titlemusic.mp3");
titlemusic = new SoundFile(this, path5);

path6 = sketchPath("data/menusound1.mp3");
menusound1 = new SoundFile(this, path6);

path7 = sketchPath("data/menusound2.mp3");
menusound2 = new SoundFile(this, path7);

path8 = sketchPath("data/gundeath.mp3");
gundeath = new SoundFile(this, path8);

path9 = sketchPath("data/gameoversound.mp3");
gameoversound = new SoundFile(this, path9);



  
  title = loadImage("title.png");
  instructions = loadImage("instructions.jpg");
  font=loadFont("Space-Invaders-48.vlw");
  gun=loadImage("gun.png");
  deathpicture=loadImage("death.jpg");
  drop=loadImage("drop.jpg");
  ufo=loadImage("ufo.jpg");
 
  
  for(int i=0; i<=10; i++){
    bottom[i] = new Alien((i*60+170),330);  //Die vierte Reihe Aliens wird initialisiert
  }
  
   for(int i=11; i<=21; i++){
    bottom[i] = new Alien(((i*60+170)-660),400);  //Die fünfte Reihe Aliens wird initialisiert
  }
  
  
  
  for(int i=0; i<=10; i++){
    middle[i] = new Alien((i*60+170),190);  //Die zweite Reihe Aliens wird initialisiert
  }
  
   for(int i=11; i<=21; i++){
    middle[i] = new Alien(((i*60+170)-660),260);  //Die dritte Reihe Aliens wird initialisiert
  }
  
   for(int i=0; i<=10; i++){
    top[i] = new Alien((i*60+170),120);  //Die erste Reihe Aliens wird initialisiert
  }
   
}




void draw() {

  background(#000000);

  mainmenu.drawMenu();


  if (state==3) {
 missile.drawBullet();
    
    mothership.moveUfo();
    mothership.triggerUfo();
    
  if(stopGame==false){//Wird nur ausgeführt wenn das Spiel nicht pausiert wurde
    
    cannon.drawGun();
mothership.killUfo();


alienmissile.drawAlienBullet();
alienmissile.moveAlienBullet();
alienmissile.collideAlienBullet();
alienmissile.setAlienBulletColor();


}
    
    mothership.drawUfo();
    
    cannon.killGun();
   
    missile.moveBullet(cannon.getGunPosX());
    

    
    for(int i=0; i<=21; i++){
    bottom[i].drawAlien(alien1);      // Alle bottom-Aliens werden gezeichnet
  }
  
  for(int i=0; i<=21; i++){
    middle[i].drawAlien(alien2);      // Alle middle-Aliens werden gezeichnet
  }
  
  for(int i=0; i<=10; i++){
    top[i].drawAlien(alien3);      // Alle top-Aliens werden gezeichnet
  }
  
  
    
  
   for(int i=0; i<=21; i++){
    bottom[i].killAlien(10);      // Kill-Option der bottom-Aliens wird aufgerufen
  }
  
  for(int i=0; i<=21; i++){
    middle[i].killAlien(20);      // Kill-Option der middle-Aliens wird aufgerufen
  }
  
  for(int i=0; i<=10; i++){
    top[i].killAlien(30);      // Kill-Option der top-Aliens wird aufgerufen
  }
  
  
  if(stopGame==false){ //Wird nur ausgeführt wenn das Spiel nicht pausiert wurde
  
   for(int i=0; i<=21; i++){
    bottom[i].moveAlien();      // Move-Option der bottom-Aliens wird aufgerufen
  }
  
  for(int i=0; i<=21; i++){
    middle[i].moveAlien();      // Move-Option der middle-Aliens wird aufgerufen
  }
  
  for(int i=0; i<=10; i++){
    top[i].moveAlien();      // Move-Option der top-Aliens wird aufgerufen
  }
  
  }
  
  
  for(int i=0; i<=21; i++){
    bottom[i].level();      // Level-Option der bottom-Aliens wird aufgerufen
  }
  
  for(int i=0; i<=21; i++){
    middle[i].level();      // Level-Option der middle-Aliens wird aufgerufen
  }
  
  for(int i=0; i<=10; i++){
    top[i].level();      // Level-Option der top-Aliens wird aufgerufen
  }
  
  
  
  for(int i=0; i<=21; i++){
    bottom[i].setAlienColor();      // setAlienColor-Option der bottom-Aliens wird aufgerufen
  }
  
  for(int i=0; i<=21; i++){
    middle[i].setAlienColor();      // setAlienColor-Option der middle-Aliens wird aufgerufen
  }
  
  for(int i=0; i<=10; i++){
    top[i].setAlienColor();      // setAlienColor-Option der top-Aliens wird aufgerufen
  }


  desktop.drawLine();
  desktop.drawScore();
  desktop.drawGunLifes();
  
     
  }
}

void keyPressed() {

  if (state==1 && key==' ') { //Hier wird das Modus-Auswahl-Menü aufgerufen
    state = 2;
    menusound1.play();
    titlemusic.stop();//titlemusic wird gestoppt
 titlemusic.cue(0);//titlemusic beginnt von vorne
  }


  if (state==3 && stopGame==false) { //Wird nur ausgeführt wenn man sich im zustand  befindet und das Spiel nicht pausiert wurde
    cannon.moveGun();

    missile.triggerBullet();
    
  }
}


void mousePressed() {

  trigger.triggerMenu();
}