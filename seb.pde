import java.util.Arrays;
String str ="Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.";
int x = 20;
int y = 20;
int w = 250;
float h = 290;
 
String[] words;
float currentSize = 5;
float bestSize = 5;
float sizeIncrement = 0.5;
ArrayList<WordPosition> wordIn= new ArrayList();
int SizeX=850;
int SizeY=550;
color mygrey=color(170, 170, 170);
color myblue=color(203, 203, 255);
color myblue2=color(100, 100, 180);
  float bestW=0;
  int beginsp=2;
String messages []={"ProjectManagement","BIGDATA","JAVA","PYTHON","CRAN-R","agile","scrum","J2EE","ANALYSE","ANALYTiCS","prediction","machinelearning","deeplearning","pca","regression"
,"discrimantanalisys","gradiantdescend","decisiontrees","forest","neuralnetwork","spark","pathmodel","associationrules","regularizedregression","pca","c","c#","Visualization",
"lasso","ridge","elasticnet","svm","sas","c++","survival","quality","spatial","architecture","prediction","development","Optimization","TimeSeries","finance","risk","ExperimentalDesign","mixedeffectsmodels"};
void setup() {
  
  
  PFont font = createFont("Roboto-Thin.ttf", 32);
  textFont(font, 32);
  text("word", 10, 50);
  int minchar=10;
  for (int i =0; i< messages.length;i++ ){
    if(messages[i].length()<minchar){
      minchar=messages[i].length();
    }
  }
  background(255);
  size(850, 550);  
  textSize(15);
  words = str.split(" ");
   textSize(30);
   text(textWidth("Software"), 400, 400);
  boolean searching = true;  
  
  println("Best size: "+ bestSize);
  char[] alphabet = "abcdefghijklmnopqrstuvwxyz".toUpperCase().toCharArray();
 
  h=textAscent();

  for (char a : alphabet ){
  float w=textWidth(a);
  if(w>bestW){
    bestW=w;
  }
  }
  bestW=(float)(int)bestW-2;
  ArrayList mess=new ArrayList();
  mess.addAll(Arrays.asList(messages));
  wordIn.add(new WordPosition(" Software And data intelligence ",(int)(0*bestW+2),(int)(2*h+1),myblue2));
  
  //wordIn.add(new WordPosition("DEVELOPMENT",(int)(20*bestW+2),(int)(12*h+1),myblue2));
  //wordIn.add(new WordPosition("ANALITYCS",(int)(20*bestW+2),(int)(17*h+1),myblue2));
  //wordIn.add(new WordPosition("PREDICTION",(int)(20*bestW+2),(int)(22*h+1),myblue2));
  wordIn.add(new WordPosition(" Buisson Diaz CONSEIL ",(int)(6*bestW+2),(int)(17*h+1),myblue2));
  int xo=beginsp;
  int yo=1+(int)h;
  String prevWord="";
  for (int i =0; i< 20000;i++ ){
    String word = (String)mess.get((int)random(mess.size()));
    if( prevWord.equals(word))
    continue;
    if(xo>849){
      xo=beginsp;yo+=h;
      println("End line "+i);
    }
    if(yo>550-1) {
      println("End "+i);
    break;
    }
    
    boolean added=addAWord(new WordPosition(word,(int)(xo),yo,mygrey));
    if(added){
    xo=(int)(xo+bestW*word.length());
    prevWord=word;
    }
    else
    
    for(WordPosition wPos:wordIn)
      if(wPos.x>=xo &&yo==wPos.y){
        println("Ouch "+wPos.word+" "+i+" "+minchar + " "+ (wPos.x-xo)/bestW + " "+word);
      
      if(xo+bestW*word.length()<=wPos.x){
        wordIn.add(new WordPosition(word,(int)(xo),yo,mygrey));
        xo=(int)(xo+bestW*word.length());
      }else{
        if(wPos.x-xo==0||xo>=wPos.x-1)
        xo=(int)(wPos.x+bestW*wPos.word.length());
        println("Ouch ");
      }
        break;
      
      }
    
  }
 
  fill(0);
  //text(str, x, y, w, h);
  noFill();
  //rect(x, y, bestW, h); 
  int marX=0;
  for (char a : alphabet ){
    float act=textWidth(a);
    //text(a, x+marX+(bestW-act)*0.5, y);
    //rect(x+marX, y-h+2, bestW, h); 
    marX=marX+(int)bestW;
  }
  for(WordPosition wPos:wordIn)
  drawWord(wPos);
  save("choco.png");
  //text(textWidth("Software"), 400, 400);
  
}

void drawText(String message,float bestW,int x, int y,float h){
  char[] alphabet = message.toUpperCase().toCharArray();
 
int marX=0;
  for (char a : alphabet ){
    float act=textWidth(a);
    float charX=(x+marX+(bestW-act)*0.5);
    if(charX+bestW<849){
    text(a, charX, y);
    //rect(x+marX, y-h+2, bestW, h); 
    }
    marX=marX+(int)bestW;
  }
}

void drawWord(WordPosition word){
  fill(word.c);
  drawText(word.word,bestW,word.x,word.y,h);
}

boolean addAWord(WordPosition word){
  
  for(WordPosition wPos:wordIn)
    if(isInBox(wPos,word))
      return false;
  wordIn.add(word);
  return true;
}

boolean isInBox(WordPosition ref,WordPosition check){
  int largRef=(int)(ref.word.length()*bestW);
  int largChe=(int)(check.word.length()*bestW);
  int hautRef=(int)h;
  int hautChe=(int)h;
  //rect(ref.x, ref.y, largRef, hautRef); 
  //rect(check.x, check.y, largChe, hautRef); 
 
  /*rect1.x < rect2.x + rect2.width &&
   rect1.x + rect1.width > rect2.x &&
   rect1.y < rect2.y + rect2.height &&
   rect1.height + rect1.y > rect2.y*/
  if (
      ref.x < check.x*largChe && 
      ref.x + largRef > check.x && 
      ref.y < check.y + hautRef && 
      ref.y + hautChe > check.y
    )
    return true;
  return false;
    

}

class WordPosition {
  String word;
  int x,y;
  color c;
  WordPosition(String word,int x, int y,color c){
    this.word=word;
    this.x=x;
    this.y=y;
    this.c=c;
  }
}

 
