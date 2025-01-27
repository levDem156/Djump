ArrayList<Knife> knifes = new ArrayList<>(); 

class Knife {
  float x, y, sc, run, atack, h, w;
  int col;

  Knife(float x, float y, float run, float atack) {
    this.x = x;
    this.y = y;
    this.sc = -10;
    this.run = run;
    this.atack = atack;
    this.h = size_y/5;
    this.w = this.h/3;
  }

  void display() {
    image(kn, this.x, this.y, this.w, this.h); // Рисуем нож
  }
}

void knife_add(int c){
  for(int i = 0; i<c; i++){
    float x = random(0, 1000);
    float y = random(1000, 10000);
    float p = random(0.5, 2);
    float score_n = (score+2) / 40;
    if (score <= 20) {
      p = random(score_n, score_n*20);
    }else{
      p = random(score_n/40, score_n*5);
    }
    
    float atack = score * 2;
    knifes.add(new Knife(x, -y, p, atack));
  }
}

void knife_run(){
  for (int i = knifes.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Knife knife = knifes.get(i);

    
    knife.y -= knife.sc;
    knife.sc -= knife.run;
    knife.display();
    
    if (knife.y > height) {
        knifes.remove(i); // Удаляем объект из списка
        knife_add(1);
    }

    if ( ((knife.y + knife.h) > pers_y && knife.y + knife.h < (pers_y + pers_size)) && ((knife.x + (knife.w/2)) > (mouseX-pers_size/2) && (knife.x + (knife.w/2)) < (mouseX + pers_size/2) )){
      scor += knife.atack;
      float b_x = ( knife.x + (knife.w/2 - (width_boom/2)) );
      booms.add(new Boom(b_x, knife.y + (knife.h/2)));
    }
  }
}

float sredneor(float x, float y) {
  float o = (x + y) / 2;
  return o;
}

void clearKnife() {
  knifes.clear(); // Полностью очищаем список
}



void knife_mode(){
  if (knife == false){
    knife = true;
    knife_add((score+2)/2);
    text_time = 76;
  }else{
    knife = false;
    red_back = false;
    clearKnife();
  }
}
