ArrayList<Rectangle> rectangles = new ArrayList<>(); // Список для хранения объектов
ArrayList<Shipi> ship = new ArrayList<>(); // Список для хранения объектов

int limit_board = 4;
float board_x = size_x / 100 * 17; //170
float board_y = board_x / 17; //10
float board_gran = size_x/100*8; //80

int limit_shipi = 2;

void clearRectangles() {
  rectangles.clear(); // Полностью очищаем список
}

class Rectangle {
  float x, y, w, h, col_kasaniy;
  int col;

  Rectangle(float x, float y) {
    this.x = x;
    this.y = y;
    this.col_kasaniy = 0;
  }

  void display() {
    fill(153);
    noStroke();
    rect(x, y, board_x, board_y);
  }
}

void new_pl(float n1,float n2){
    float x = random(10, size_x-10);
    float y = random(n2, n1);
    rectangles.add(new Rectangle(x, y));
    
    if (int(random(1,patron_ch)) == patron_ch/2){
      pts.add(new Pt(x, y));
    }
}







class Shipi {
  float x1, y1, w, h, col_kasaniy;
  int col;

  Shipi(float x, float y) {
    this.h = board_y*8; //80
    this.w = board_x;
    this.x1 = x;
    this.y1 = y-this.h;
    
  }

  void display() {
    image(Sh, x1, y1, this.w, this.h); // Рисуем Шипы
  }
}

void shipi(float limit, float x, float y){
  if (limit == limit_shipi){
    ship.add(new Shipi(x, y));
  } 
  else if (limit == limit_shipi+1){
    gameOver = true;
  }
}


void shipi_run(){
  for (int i = ship.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Shipi sh = ship.get(i);

    sh.display();
    
    if (sh.y1 > height) {
        ship.remove(i); // Удаляем объект из списка
    }
  }
}

void clearShipi() {
  ship.clear(); // Полностью очищаем список
}
