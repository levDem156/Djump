String keys = "";  
String targetCheat = "boost";  
float cheat_code_time;
boolean ch_active = false;
float cheat_speed = 250;
float boost_cheat = 3;

boolean q_cheat = false;

void cheat_key(){
  keys += key;  // Добавляем нажатую клавишу к последовательности
  
  // Если последовательность превышает длину целевой, обрезаем её
  if (keys.length() > targetCheat.length()) {
    keys = keys.substring(1);
  }
  
  // Проверяем, совпадает ли последовательность с целевой
  if (keys.equals(targetCheat)) {
    CheatCode();  // Вызываем функцию
  }
}

void CheatCode(){
  println("CheatCode is activated");
  cheat_code_time = cheat_speed;
}

void cheat_check(){
  if (cheat_code_time > 0){
    if (ch_active == false){
      ch_active = true;
      jump_power *= boost_cheat;
    }
    cheat_code_time -= 1;
    
    if(cheat_code_time == 0 && ch_active == true){
      ch_active = false;
      jump_power /= boost_cheat;
      clearConsole();
    }
  }
  
}
