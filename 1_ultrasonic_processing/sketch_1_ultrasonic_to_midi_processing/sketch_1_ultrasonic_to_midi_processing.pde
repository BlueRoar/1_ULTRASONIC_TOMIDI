//
// This reads a single Ultrasonic sensor and shits it out to MIDI.
//
// wire connections
// on arduino: red to 5V, yellow to GND, white to DIGITAL ~3
// on ultrasonic sensor: red +5, yellow GND, white PW
//
// WARNING!!! Remember to check the console to verify that you have selected 
// the correct serial and midi buses in the code!
//
// BlueRoar
//

import processing.serial.*;
import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus


Serial myPort;  // Create object from Serial class
int rawdata;      // Data received from the serial port

void setup() 
{
  println("VERIFY YOU HAVE SELECTED THE CORRECT ARDUINO SERIAL PORT #");
  printArray(Serial.list());
  size(200, 200);

  // LOOK AT THE CONSOLE, change the # in Serial.list()[#] to the corresponding Arduino port;
  // usually something like [3] "/dev/tty.usbmodem1421"

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  println();
  println("NOW FOR MIDI BUSSESS!!!!!");
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  myBus = new MidiBus(this, -1, 1); // Create a new MidiBus with no input device and the default IAC Bus. 
  // USE AUDIO MIDI SETUP TO ENABLE YOUR IAC BUS IF YOU HAVE NOT ALREADY
  // YOU CAN ALSO LOOK AT THE CONSOLE TO SEE THE AVAILABLE MIDI BUSES
}

void draw()
{

  int channel = 0;
  int number = 1;
  float mappedvalue = 0;
  mappedvalue = map(rawdata, 36, 600, 127, 0); 
  myBus.sendControllerChange(channel, number, int(mappedvalue)); // Send a controllerChange
  delay(50);

  //
  // DEBUGGGGG!!! Uncomment the below line to see the RAWDATA coming from the ultrasonic and the MAPPEDVALUE
  // println("received value: "+rawdata +" mapped value: "+int(mappedvalue));
  //
  //
}


// serial read function
void serialEvent (Serial myPort) { 

  // reads from serial-port until line-break (ascii 13)
  String line = myPort.readStringUntil(13); 

  // check for nonsense
  if (line != null) {

    // remove whitespace-characters and convert to int
    rawdata = int(line.trim());
  }
}

// midibus functions //
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
