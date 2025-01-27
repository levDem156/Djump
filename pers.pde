float max_high_pers = size_x * 0.2;
float pers_x, pers_y;
float pers_size = size_x / 100 * 15; //150
float pers_otclon =  size_x / -10; //-100
float pers_left = (pers_otclon/2 + pers_otclon) / 2 * -1;

float jump_power;

void pers(){
  jump();
  
  for (int i = rectangles.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Rectangle rect = rectangles.get(i);
    rect.display();
  }
  
  gravit(0.4);
  
  if (h == false) {
    pushMatrix();
    translate(mouseX, pers_y);
    fill(0);  
    image(j1, pers_otclon/2, 0, pers_size, pers_size);
    popMatrix();
    
  } else {
    pushMatrix();
    translate(mouseX, pers_y);
    fill(0);  
    image(j2, pers_otclon, 0, pers_size, pers_size);
    popMatrix();
  }
  
  if (last_pos > mouseX) {
    h = true;
  } else if (last_pos < mouseX){
    h = false;
  }
  
  last_pos = mouseX;
}

void jump(){
  for (int i = rectangles.size() - 1; i >= 0; i--) { // Итерируем список с конца
    Rectangle rect = rectangles.get(i);
  
    if ( ((pers_y+pers_size) > rect.y && pers_y < (rect.y + board_y)) && (mouseX-pers_left > (rect.x - board_gran) && (mouseX-pers_left)+pers_size < (rect.x + board_x + board_gran)) && (scor > 0) ){
      scor -= jump_power;
      rect.col_kasaniy += 1;
      shipi(rect.col_kasaniy, rect.x, rect.y);
    }
  }
}
