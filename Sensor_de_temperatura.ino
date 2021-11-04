#include <Wire.h>
#include <SoftwareSerial.h>
#include <Adafruit_MLX90614.h>
Adafruit_MLX90614 mlx = Adafruit_MLX90614();

   void setup() {
  Serial.begin(9600);
  mlx.begin();  
  pinMode(A0, OUTPUT);
  pinMode(11, OUTPUT);
       }
  int value_D0;
  void loop() {

  
 int temp;
 temp = round (mlx.readObjectTempC  ()*10 );
  
    
  if (temp>=290 && temp<=380){
  Serial.print ("temperatura normal ");
  Serial.print(temp ); 
  Serial.println("ºC");
  
  
  digitalWrite(A0, HIGH);

  delay (1000);
  digitalWrite(A0, LOW);


  
 
  } else{
     digitalWrite(A0,LOW);
    
  }
     
  if (temp>=381){
  Serial.print ("temperatura anormal ");
  Serial.print(temp ); 
  Serial.println("ºC");
  digitalWrite(11,HIGH);
  delay (1000);
  digitalWrite(11,LOW);
 
  } else{
     digitalWrite(11,LOW);
    
  }
  
  delay(2500); 
  
}
