class Highscore {

  //Properties
  public BufferedReader input;
  public PrintWriter output;
  public String textline;

  //Constructor
  Highscore() {
  }



  //Methods
  
  public void readTextDocument() {

    input = createReader("highscore.txt");

    try {
      textline = input.readLine();  //Zeile wird aus dem Textdokument gelesen und in den String textline gespeichert
    } 
    catch (IOException e) {    //Wenn die Fehlermeldung IOException e kommt, wird e.printStacktrace(); und textline=null; ausgeführt
      e.printStackTrace();
      textline = null;
    }



    if (textline != null) {  //Wenn etwas im Textdokument steht,...

      highScore=parseInt(textline);  //... wird der Inhalt des Textdokuments in highScore gespeichert.
      // parseInt() wandelt String in Integer um
    } else {  //Wenn nichts im Textdokument steht,...

      output = createWriter("highscore.txt");   //... wird der aktuelle score hineingespeichert
      output.println(score);
      output.flush();
      output.close();
    }
  }






  public void writeTextDocument() {

    if (textline != null) {  //Wenn etwas im Textdokument steht,...



      if (score>highScore) { //...wird geschaut, ob score größer ist als der aktuelle highScore

        output = createWriter("highscore.txt");   
        output.println(score);    //...wenn ja, wird score in das Textdokument gespeichert
        output.flush();
        output.close();
      }
    } else {  //Wenn nichts im Textdokument steht,...

      output = createWriter("highscore.txt"); 
      output.println(score);  //...wird score in das Textdokument gespeichert
      output.flush();
      output.close();
    }
  }






  public boolean writeConfirmedHighScore() {

    if (score>highScore) {
      return true;
    }

    return false;
  }
}