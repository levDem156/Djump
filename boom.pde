ArrayList<Boom> booms = new ArrayList<>(); 
float width_boom = size_x / 50;

class Boom {
  float x, y, w, h;
  int col;
  float boom_limit = 1200;
  float boom_speed = 130;

  Boom(float x, float y) {
    this.x = x;
    this.y = y;
    this.h = 0;
    this.w = width_boom;
    
  }

  void display() {
    fill(255);
    noStroke();
    rect(this.x, this.y, this.w, this.h); // Рисуем нож
  }
}

void boom_run(){
  for (int i = booms.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Boom boom = booms.get(i);

    
    boom.h += boom.boom_speed;
    boom.display();
    
    if (boom.h > boom.boom_limit) {
        booms.remove(i); // Удаляем объект из списка
    }
  }
}

void clearBoom() {
  booms.clear(); // Полностью очищаем список
}
