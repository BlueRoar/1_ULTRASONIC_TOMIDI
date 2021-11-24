const int pwPin1 = 3;
long sensor, mm, inches;

void setup() {
  Serial.begin(9600);
  pinMode(pwPin1, INPUT);
}

void read_sensor () {
  sensor = pulseIn(pwPin1, HIGH);
  mm = sensor;
  inches = mm / 25.4;
}

void print_range() {
  //Serial.print("S1");
  //Serial.print("=");
  //Serial.print(mm);
  //Serial.print(" ");
  Serial.print(inches);
  Serial.println(""); //line break
}

void loop() {
  read_sensor();
  print_range();
  delay(50);
}

//min is about 36 max is about 600
