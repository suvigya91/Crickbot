int lp=5;
int ln=6;
int rn=9;
int rp=10;
int var=0;
int pre=10;
int diff=0;
int shutp=14;
int shutn=15;
int pushp=17;
int pushn=16;

void setup()
{
  pinMode(lp,OUTPUT);
  pinMode(ln,OUTPUT);
  pinMode(rp,OUTPUT);
  pinMode(rn,OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  Serial.flush();
  if(Serial.available())
  {
  var=Serial.read();
  
  if (var>0)
  {
  if (var==1)
  {
    analogWrite(lp,200);      //move staright
    analogWrite(ln,0);
    analogWrite(rp,210);
    analogWrite(rn,0);
    
    delay(300);
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
    
  }
  else if(var==2)
  {
    analogWrite(lp,0);      //move back
    analogWrite(ln,200);
    analogWrite(rp,0);
    analogWrite(rn,200);
  }
  else if (var==3)
  {
    analogWrite(lp,200);      //move staright
    analogWrite(ln,0);
    analogWrite(rp,210);
    analogWrite(rn,0);
    
    delay(200);
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
    
  }
  else if(var==4)
  {
    analogWrite(lp,185);      //move right
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,185);
    delay(200);
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
   
  }
  else if(var==5)
  {
    analogWrite(lp,180);      //move right
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,180);
    delay(200);
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
  }
  else if (var==6)
  {
    analogWrite(lp,150);      //move staright
    analogWrite(ln,0);
    analogWrite(rp,160);
    analogWrite(rn,0);
    
    delay(220);
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
    
  }
  else if(var==8)
  {
    analogWrite(lp,0);      //move left
    analogWrite(ln,185);
    analogWrite(rp,185);
    analogWrite(rn,0);
    delay(200);
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
  }
  else if(var==9)
  {
    analogWrite(lp,0);      //move left
    analogWrite(ln,180);
    analogWrite(rp,180);
    analogWrite(rn,0);
    delay(200);
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
  }
  
  else if(var==11)
  {
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
    analogWrite(shutp,1023);
    analogWrite(shutn,0);
    delay(500);
    analogWrite(shutp,0);
    analogWrite(shutn,0);
    //analogWrite(pushp,1023);
    //analogWrite(pushn,0);
    //delay(300);
    //analogWrite(pushp,1023);
    //analogWrite(pushn,0);
    
    
  }
  else if(var==13)
  {
  analogWrite(pushp,1023);
    analogWrite(pushn,0);
    delay(1000);
    analogWrite(pushp,0);
    analogWrite(pushn,0);
  }
    
  else if(var==10)
  {
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
    analogWrite(shutp,0);
    analogWrite(shutn,1023);
    delay(400);
    analogWrite(shutp,0);
    analogWrite(shutn,0);
    
  }
  else
  {
    analogWrite(lp,0);      //move left
    analogWrite(ln,0);
    analogWrite(rp,0);
    analogWrite(rn,0);
    delay(120);
  }
  pre=var;
  }
}

}
