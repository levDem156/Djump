PImage j1;
PImage j2;
PImage kn;
PImage Sh;
PImage Pt;
PImage DRB;

PImage[] anim_shoot = new PImage[4];

int size_x = 600; //1000     600
int size_y = 900; //1500     900

boolean h;

float last_pos;

float chank_start, chank_end;
float scor = -10;

boolean gameOver = false; // Флаг для завершения игры
int score;
int score_detected = 0;
int record = 0;

float sleep;
float speed_mode;

boolean knife;

int text_time;

boolean red_back;


void clear_all(){
  clearBoom();
  clearKnife();
  clearRectangles();
  clearShipi();
  clearPts();
  clearShots();
}


void start(){
  
  gameOver = false; // Сбрасываем флаг
  clear_all();
  red_back = false;
  knife = false;
  sleep = 500;
  speed_mode = 0.3;
  text_time = 0;
  score = 0;
  chank_start = size_y;
  chank_end = chank_start - (size_y+(size_y/3));
  
  jump_power = size_y / 150 * 6; //50
  cheat_code_time = 0;
  ch_active = false;
  
  pers_y = 500;
  scor = -10;
  
  patrons = 0;
  angle_dorb = 0;
  dorb_time = 0;
  patron_ch = patron_ch_chisl;
  
  q_cheat = false;
  
  for(int i = 0; i<limit_board; i++){
    new_pl(chank_start, chank_end);
  }
  
}

void settings() {
  size(size_x, size_y);
}


void setup() 
{
  background(255,255,255);
  
  j1 = loadImage("DoodleJump1.png");
  j2 = loadImage("DoodleJump2.png");
  kn = loadImage("kn.png");
  Sh = loadImage("shipi.png");
  Pt = loadImage("patron.png");
  DRB = loadImage("dorb.png");
  
  anim_shoot[0] = loadImage("vistrel/VISTREL1_ANIM.png");
  anim_shoot[1] = loadImage("vistrel/VISTREL2_ANIM.png");
  anim_shoot[2] = loadImage("vistrel/VISTREL3_ANIM.png");
  anim_shoot[3] = loadImage("vistrel/VISTREL4_ANIM.png");

  start();

  
}

void draw() { 
  gameover();
  
  if (gameOver) {
    if (score > record){record=score;}
    clearConsole();
    // Если "Game Over", показываем сообщение и прекращаем обновления
    background(0);
    fill(255, 0, 0);
    textSize(size_x / 100 * 15); //150
    textAlign(CENTER, CENTER);
    text("Record: "+record, width / 2, height / 3);
    textSize(size_x / 100 * 7); //70
    text("GAME OVER", width / 2, height / 2);
    textSize(size_x / 10); //100
    text(score, width / 2, height / 5);
    textSize(size_x / 20); //50
    text("Press ENTER to restart", 700, 1300);
    return; // Завершаем функцию, чтобы ничего больше не выполнялось
  }
  
  
  if (red_back == false){ //смена фона
    background(255,255,255);
  }else{
    background(255,0,0);
  }
  shot_run();
  pt_run();
  
  shipi_run();
 
  boom_run();
  knife_run();
  
  score_d();
  pers();
  
  hard_mode();
  
  cheat_check();
  
  Rect_pt(patrons);
  
  dorbash_anim();
  
} 

void score_d() {
  if (score_detected >= 10){
    score+=1;
    score_detected = 0;
  }
  
  fill(255, 0, 0);
  textSize(size_x / 100 * 7); //70
  textAlign(CENTER, CENTER);
  text("Score: " + score, size_x / 100 * 15, size_x / 100 * 6);
}

void hard_mode(){
  sleep -= speed_mode; //0.3
  
  if (sleep <= 0){
    sleep = random(100, 800);
    
    knife_mode();
    
  }
  
  ohdumn();
}


void ohdumn(){
  if (text_time > 61){
    fill(255, 0, 0);
    textSize(size_x/20); //50
    textAlign(CENTER, CENTER);
    text("oh damn", width / 2, height / 4);
    text_time -= 1;
    
  }
  
  if (text_time > 53 && text_time <= 61){
    red_back = true;
    text_time -= 1;
  }
  
  if (text_time > 33 && text_time <= 53){
    red_back = false;
    fill(255, 0, 0);
    textSize(size_x / 100 * 15); //150
    textAlign(CENTER, CENTER);
    text("oh damn", width / 2, height / 4);
    text_time -= 1;
  }
  
  if (text_time > 25 && text_time <= 33){
    red_back = true;
    text_time -= 1;
  }
  
  if (text_time > 0 && text_time <= 25){
    red_back = false;
    fill(255, 0, 0);
    textSize(size_x / 100 * 24); //240
    textAlign(CENTER, CENTER);
    text("oh damn", width / 2, height / 4);
    text_time -= 1;
    if (text_time == 0){
      red_back = true;
    }
    
  }
}

void gravit(float prit) {
  
  if (pers_y > max_high_pers){ //100
    pers_y += scor;
    
  }else if (scor > 0){ 
    pers_y += scor;
    
  }else{
    gravit_objects();
  }
  
  scor+=prit;
}



void gravit_objects(){ // Заносим все, что должно падать

  for (int i = rectangles.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Rectangle rect = rectangles.get(i);
    rect.y -= scor; // Добавляем эффект "гравитации" (ускорение вниз)

    // Если прямоугольник выходит за нижнюю границу экрана, удаляем его
    if (rect.y > height) {
      rectangles.remove(i); // Удаляем объект из списка
      new_pl(chank_end, 0);
      score_detected += 1;
    }
  }
  
  for (int i = knifes.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Knife knife = knifes.get(i);

    knife.y -= scor;
  }
  
  for (int i = ship.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Shipi sh = ship.get(i);

    sh.y1 -= scor;
  }
  
  for (int i = booms.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Boom boom = booms.get(i);

    
    boom.y -= scor;
  }
  
  for (int i = pts.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Pt pt = pts.get(i);

    pt.y -= scor;
  }
  
  for (int i = vstrles.size() - 1; i >= 0; i--) { // Итерируем список с конца
    VSTRL vstrl = vstrles.get(i);

    vstrl.y -= scor/2;
  }
}



//game

void keyPressed() {
  if (gameOver && key == ENTER) {
    restartGame(); // Перезапускаем игру, если нажата клавиша Enter
  }else{
    cheat_key();
    
    if (key == 'q' || key == 'Q') {
      if (q_cheat == false) {
        q_cheat = true;
        patron_ch  = 3;
      }else{
        q_cheat = false;
        patron_ch = patron_ch_chisl;
      }
    }else
    
      if (key == 32) {
        shot();
      }
    
    }
  
 
}

void gameover(){
  if (pers_y > chank_start){
    gameOver = true;
  }
}

void restartGame() {
  start();
  println("Game restarted!"); // Для проверки в консоли
}

void clearConsole() {
  for (int i = 0; i < 50; i++) {
    println();
  }
}






 
 
