//Переменные для дорбовика
float dorbash_power = size_y / 150 * 6; //60
float dorb_time = 0;
boolean dorb_anim = false;
float angle_dorb;

float dorb_x = size_x / 100 * 25; //250
float dorb_y = dorb_x / 2; //125

int patron_ch;
int patron_ch_chisl = 35; 


//Переменные для патронов
ArrayList<Pt> pts = new ArrayList<>(); 
float pt_gran = size_y / 100; //15
int patrons;
int patron_limit = 3;



//Логика дорбовика

void shot(){
  angle_dorb = 0;
  dorb_time = 0;
  if (patrons > 0){
    dorb_time = 10;
    patrons -= 1;
  }
}

void dorbash_anim(){
    if (dorb_time > 0){
      dorb_anim = true;
      
      pushMatrix();
      translate(mouseX, pers_y + (pers_size/2)); 
      rotate(angle_dorb); //1.5
      image(DRB, -dorb_x/6.25, -dorb_y/4.1, dorb_x, dorb_y);
      popMatrix();
      
      if (dorb_time > 3){
          angle_dorb += 0.25;
      }else{
        angle_dorb -= 0.50;
      }
     
      
      dorb_time -= 1;
      
      if (dorb_time == 3){
        scor -= dorbash_power;
        new_shot();
      }
      
      if (dorb_time == 0 && dorb_anim == true){
        angle_dorb = 0;
        dorb_anim = false;
        //scor -= dorbash_power;
      }
    }
}



//Выстрел

ArrayList<VSTRL> vstrles = new ArrayList<>(); 

class VSTRL {
  float x, y, h, w;
  float sleep = 0;
  PImage[] imgs;

  VSTRL(float x, float y, PImage[] imgs) {
    this.x = x;
    this.y = y;
    this.h = size_x/10;
    this.w = this.h;
    this.imgs = imgs;
  }

  void display() {
    String sleepStr = str(sleep); //
    int dotIndex = sleepStr.indexOf('.'); 
    if (dotIndex != -1) {
      sleepStr = sleepStr.substring(0, dotIndex); 
    }
    
    int sleepIndex = int(sleepStr);
    
    pushMatrix();
    translate(this.x + size_x/100*6, this.y + size_x/10*2); // +60, +200
    rotate(HALF_PI); 
    image(imgs[sleepIndex], 0, 0, this.w, this.h);
    popMatrix();
  }
}

void new_shot(){
  float x = mouseX;
  float y = pers_y;
  vstrles.add(new VSTRL(x, y, anim_shoot));
}

void shot_run(){
  for (int i = vstrles.size() - 1; i >= 0; i--) { // Итерируем список с конца
    VSTRL vstrl = vstrles.get(i);

    vstrl.display();
    vstrl.sleep += 0.4;
    
    if (vstrl.y > height || vstrl.sleep >= 4) {
        vstrles.remove(i); // Удаляем объект из списка
    }
  }
}

void clearShots() {
  vstrles.clear(); // Полностью очищаем список
}






//Логика патронов

void Rect_pt (int size){
  for (int i = 1; i < size+1; i++){
    fill(0, 0, 0);
    noStroke();
    rect(size_x/14 * i, size_y - (size_y/7.5), size_x / 20, size_x/10); //y200, w50, h100
  }
}

class Pt {
  float x, y, h, w;
  int col;

  Pt(float x, float y) {
    this.h = size_x/10;
    this.w = this.h;
    this.x = x + this.w/2.3;
    this.y = y - this.h * 1.3;
  }

  void display() {
    image(Pt, this.x, this.y, this.w, this.h); 
  }
}

void pt_run(){
  for (int i = pts.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Pt pt = pts.get(i);

   
    pt.display();
    
    if (pt.y > height) {
        pts.remove(i); 
    }

    if ( ((pt.y + pt.h) > pers_y-pt_gran && pt.y + pt.h < (pers_y + pers_size + pt_gran)) && ((pt.x + (pt.w/2)) > (mouseX-pers_size/2) - pt_gran && (pt.x + (pt.w/2)) < (mouseX + pers_size/2)+pt_gran )){
      pts.remove(i);
      
      if (patrons < 3){
        patrons += 1;
      }
      
    }
  }
}

void clearPts() {
  pts.clear(); // Полностью очищаем список
}
