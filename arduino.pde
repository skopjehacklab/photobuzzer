int photoRPin = 0; 
int minLight;
int maxLight;
int lightLevel;
int adjustedLightLevel;
int oldLightLevel;
int arrayof16nicetones[] = {131,165,196,262,330,392,523,659,784,1047,1319,1568,2093,2637,3136,4186};

void setup() {
  //Serial.begin(9600);
  
  //Setup the starting light level limits
  lightLevel=analogRead(photoRPin);
  minLight=lightLevel-60;
  maxLight=lightLevel;
  oldLightLevel=lightLevel;  
}

void loop(){
   lightLevel=analogRead(photoRPin);
   //Serial.print("Analog: ");
   //Serial.println(lightLevel);
   //delay(50);
  
  //auto-adjust the minimum and maximum limits in real time   
   if(minLight>lightLevel){
     minLight=lightLevel;
   }
   if(maxLight<lightLevel){
     maxLight=lightLevel;
   }
   
   //Map the light level to produce a result between 1 and 28.
   adjustedLightLevel = map(lightLevel, (minLight+20), (maxLight-20), 1, 28); 
   //Serial.print("AdjustetLevel: ");
   //Serial.println(adjustedLightLevel);
   
   adjustedLightLevel = constrain (adjustedLightLevel, 1,28);
   //Serial.print("AdjustetLevel posle constrain: ");
   //Serial.println(adjustedLightLevel);
   
   /*Only send a new value to the Serial Port if the 
     adjustedLightLevel value changes.*/
   if(oldLightLevel==adjustedLightLevel){
     //do nothing if the old value and the new value are the same.
   }else{
     //Update the oldLightLevel value for the next round
     oldLightLevel=adjustedLightLevel;
     
     /*Send the adjusted Light level result 
       to Serial port (processing)*/
     //Serial.println(adjustedLightLevel);
     
   } 

   if (adjustedLightLevel<28)
   tone(2, arrayof16nicetones[(adjustedLightLevel-1)/2],  100.5);

 // delay(500);
}
