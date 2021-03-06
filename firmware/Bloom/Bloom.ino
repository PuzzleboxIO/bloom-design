/*
 * 
 * Puzzlebox - Bloom
 * 
 * Bloom RGB / Servo / Bluetooth LE Sketch
 * 
 * Copyright Puzzlebox Productions, LLC (2014-2015)
 * 
 * This code is released under the GNU Pulic License (GPL) version 3
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * 
 * You should have received a copy of the GNU General Public
 * License along with this code; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 * 
 * For more information about this licence please refer to http://www.gnu.org/copyleft/gpl.html
 * 
 * For more details about the product please check http://puzzlebox.io/bloom
 * 
 * Original Author: Steve Castellotti <sc@puzzlebox.io>
 * 
 * Modified 2015-02-05
 * by Steve Castellotti <sc@puzzlebox.io>
 * 
 */

#include <Servo.h>
#include <SPI.h>
#include <RBL_nRF8001.h>
#include <boards.h>

#define DEBUG_OUTPUT 1 // 1 for debug
// #define DEBUG_BLE_PACKETS 1 // 1 for debug
#define DEBUG_BLE_PACKETS 0 // 1 for debug

#define ENABLE_BLE 1

#define SERVO_PIN_BLOOM 7



#define DIGITAL_OUT_PIN    2
#define DIGITAL_IN_PIN     A4
#define PWM_PIN            3
//#define SERVO_PIN          5
#define SERVO_PIN          7
#define ANALOG_IN_PIN      A5


#define RGB_PIN_RED 3
#define RGB_PIN_GREEN 5
#define RGB_PIN_BLUE 6

// Counter-clockwise Open
#define POSITION_BLOOM_OPEN 50
#define POSITION_BLOOM_CLOSED 135

// Clockwise Open
//#define POSITION_BLOOM_OPEN 150
//#define POSITION_BLOOM_CLOSED 31

#define POSITION_BLOOM_SETUP 70 // Percentage

// #define POSITION_BLOOM_OPEN 54 // Wood
// #define POSITION_BLOOM_CLOSED 144 // Wood
// #define POSITION_BLOOM_SETUP 100 // Wood


#define TIME_BLOOM_OPEN 3000 // Open the Bloom for three seconds and then close it
#define TIME_BLOOM_CYCLE 3000
#define TIME_BLOOM_CYCLE_SLOW_STEPS 60 // time for each percentage step
#define TIME_BLOOM_DEMO_CYCLE 2500
#define TIME_BLOOM_RGB_CYCLE 10
#define TIME_BLOOM_TRANSITION_FRAME 1000 // milliseconds between updates (ThinkGear)
//#define TIME_BLOOM_TRANSITION_FRAME 100 // milliseconds between updates (MuseIO)

// Uncomment the line below if using a Common Anode LED
// such as the "T-1 3/4 5mm Full Color LED" from Radioshack [276-028]:
// https://www.radioshack.com/product/index.jsp?productId=3020765
//#define COMMON_ANODE

Servo servoBloom;
// Servo myservo;

char _command;
char lastCommand = '0'; // closed

char message[] = "Bloom";


unsigned char buf[16] = {0};
unsigned char len = 0;

int index;

int percentage;
int degrees;

int colorR = 0;
int colorG = 0;
int colorB = 0;


// ################################################################

/////////
//SETUP//
/////////

void setup_bloom() {
// void setup() {
	
	// Start off with the LED off.
// 	setColourRgb(0,0,0);
	setColourRgb(colorR, colorG, colorB);
	
	// For BLE Shield or Blend:
	//   Default pins set to 9 and 8 for REQN and RDYN
	//   Set your REQN and RDYN here before ble_begin() if you need
	//
	// For Blend Micro:
	//   Default pins set to 6 and 7 for REQN and RDYN
	//   So, no need to set for Blend Micro.
	#if ENABLE_BLE
		ble_set_pins(9, 8);
	
	
	// Set your BLE Shield name here, max. length 10
		ble_set_name("Bloom");
	#endif
	
// 	// Init. and start BLE library.
// 	ble_begin();
	
	// Enable serial debug
	Serial.begin(57600);
// 	Serial.begin(115200);
	
	
	servoBloom.attach(SERVO_PIN_BLOOM);
	
	servoBloom.write(POSITION_BLOOM_CLOSED);
	
	delay(2000);
	
	
	// White
	colorR=255;
	colorG=255;
	colorB=255;
// 	setColourRgb(255, 255, 255);
	setColourRgb(colorR, colorG, colorB);
	servoTransition(0, POSITION_BLOOM_SETUP);
	
		// Init. and start BLE library.
	#if ENABLE_BLE
		ble_begin();
	#endif
	
	
}


// ################################################################

// void setup_default()
void setup()
{
  // Default pins set to 9 and 8 for REQN and RDYN
  // Set your REQN and RDYN here before ble_begin() if you need
  //ble_set_pins(3, 2);
  
  // Set your BLE Shield name here, max. length 10
  //ble_set_name("My Name");
  
  // Init. and start BLE library.
	#if ENABLE_BLE
		ble_begin();
	#endif
  
  // Enable serial debug
  Serial.begin(57600);
  
  pinMode(DIGITAL_OUT_PIN, OUTPUT);
  pinMode(DIGITAL_IN_PIN, INPUT);
  
  // Default to internally pull high, change it if you need
  digitalWrite(DIGITAL_IN_PIN, HIGH);
  //digitalWrite(DIGITAL_IN_PIN, LOW);
  
//   myservo.attach(SERVO_PIN);
  servoBloom.attach(SERVO_PIN);
  
  servoBloom.write(POSITION_BLOOM_CLOSED);
	
  delay(2000);
	
  // White
  setColourRgb(255, 255, 255);
  servoTransition(0,POSITION_BLOOM_SETUP);
  
}


// ################################################################


/////////////
//MAIN LOOP//
/////////////

void loop() {
	
	parseSerialInput();
	#if ENABLE_BLE
		parseBLE();
	#endif
} // Main loop


// ################################################################

void parseSerialInput() {
	
	if (Serial.available() > 0)  {
		
		_command = Serial.read();
		
		#if DEBUG_OUTPUT
		Serial.print("Serial.read(): ");
		Serial.println(_command);
		#endif
		
		parseCommand(_command);
		
		//    if (_command != '0') {
		//      // Don't directly set lastCommand to "closed"
		lastCommand = _command;
		//    }
		
	}
	
} // parseSerialInput()


// ################################################################

int parseValue() {
	
	char inByte=0;
	int a=0;
	int b=0;
	int c=0;
	int newValue=0;
	
	while (Serial.available() == 0);
	inByte = Serial.read() - '0';
	a = inByte;
	
	while (Serial.available() == 0);
	inByte = Serial.read() - '0';
	b = inByte;
	
	while (Serial.available() == 0);
	inByte = Serial.read() - '0';
	c = inByte;
	
	newValue = (a * 100) + (b * 10) + c;
	
	return(newValue);
	
} // parseValue


// ################################################################

void parseBLE(){
	
// 		test_loop();
	
	
	// 	if ( ble_connected() ) {
	// 		writeMessage();
	// 		loopRGBServo();
	// 		
	// 	}
	
	
	static boolean analog_enabled = false;
	static byte old_state = LOW;
	
	// If data is ready
	while(ble_available())
	{
		// read out command and data
		byte data0 = ble_read();
		byte data1 = ble_read();
		byte data2 = ble_read();
		
		#if DEBUG_BLE_PACKETS
		Serial.write("data0: ");
		Serial.write(data0);
		Serial.write("\ndata1: ");
		Serial.write(data1);
		Serial.write("\ndata2: ");
		Serial.write(data2);
		Serial.write("\n");
		#endif
		
		if (data0 == 0x00)  // Command is to control Servo pin
		{
			#if DEBUG_BLE_PACKETS
			Serial.write("data0 == 0x00\n");
			#endif
			bloomClose();
		}
		else if (data0 == 0x01)  // Command is to control Servo pin
		{
			#if DEBUG_BLE_PACKETS
			Serial.write("data0 == 0x01\n");
			#endif
			bloomOpen();
		}
		else if (data0 == 0x03)  // Command is to control Servo pin
		{
			#if DEBUG_BLE_PACKETS
			Serial.write("data0 == 0x03\n");
			#endif
			
// 			if (data1 > 100)
// 				data1 = 100;
// 			if (data1 < 0)
// 				data1 = 0;
			
// 			servoBloom.write(data1);
			servoSetPercentage(data1);
		}
		else if (data0 == 0x04)
		{
			#if DEBUG_BLE_PACKETS
			Serial.write("data0 == 0x04\n");
			#endif
			analog_enabled = false;
			servoBloom.write(0);
		}
		else if (data0 == 0x05)
		{
			#if DEBUG_BLE_PACKETS
			Serial.write("data0 == 0x05\n");
			#endif
			loopRGBServo();
		}
		else if (data0 == 0x06)
		{
			#if DEBUG_BLE_PACKETS
			Serial.write("data0 == 0x06\n");
			#endif
			loopRGB();
		}
		
		else if (data0 == 0x0A)
		{
			if (data1 == 0x00)
				colorR=int(data2);
			else if (data1 == 0x01)
				colorG=int(data2);
			else if (data1 == 0x02)
				colorB=int(data2);
			
			#if DEBUG_BLE_PACKETS
			Serial.write("data0 == 0x0A\n");
			
			Serial.write("data1 == ");
			Serial.write(data1);
			Serial.write("\n");
			
			String str;
			char output[4];
			
			str = String(colorR);
			str.toCharArray(output,4);
			
			Serial.write("R: ");
			Serial.write(output);
			
			str = String(colorG);
			str.toCharArray(output,4);
			
			Serial.write("G: ");
			Serial.write(output);
			
			str = String(colorB);
			str.toCharArray(output,4);

			Serial.write("B: ");
			Serial.write(output);
			Serial.write("\n");
			
			#endif
			
			setColourRgb(colorR, colorG, colorB);
			
		}
		
	}
	
	ble_do_events();
	
	// 	if ( ble_available() )
	// 	{
	// 		while ( ble_available() )
	// 		{
	// 			Serial.write(ble_read());
	// 		}
	// 		
	// 		Serial.println();
	// 	}
	// 	
	// 	delay(1000);
	
}


// ################################################################

void test_loop()
{
	static boolean analog_enabled = false;
	static byte old_state = LOW;
	
	// If data is ready
	while(ble_available())
	{
		// read out command and data
		byte data0 = ble_read();
		byte data1 = ble_read();
		byte data2 = ble_read();
		
		//     if (data0 == 0x01)  // Command is to control digital out pin
		//     {
		//       if (data1 == 0x01)
		//         digitalWrite(DIGITAL_OUT_PIN, HIGH);
		//       else
		//         digitalWrite(DIGITAL_OUT_PIN, LOW);
		//     }
		//     else if (data0 == 0xA0) // Command is to enable analog in reading
		//     {
		//       if (data1 == 0x01)
		//         analog_enabled = true;
		//       else
		//         analog_enabled = false;
		//     }
		//     else if (data0 == 0x02) // Command is to control PWM pin
		//     {
		//       analogWrite(PWM_PIN, data1);
		//     }
		//     else if (data0 == 0x03)  // Command is to control Servo pin
		if (data0 == 0x03)  // Command is to control Servo pin
		{
// 			myservo.write(data1);
			servoBloom.write(data1);
		}
		else if (data0 == 0x04)
		{
			analog_enabled = false;
// 			myservo.write(0);
			servoBloom.write(0);
			//       analogWrite(PWM_PIN, 0);
			//       digitalWrite(DIGITAL_OUT_PIN, LOW);
		}
	}
	
	//   if (analog_enabled)  // if analog reading enabled
	//   {
	//     // Read and send out
	//     uint16_t value = analogRead(ANALOG_IN_PIN); 
	//     ble_write(0x0B);
	//     ble_write(value >> 8);
	//     ble_write(value);
	//   }
	//   
	//   // If digital in changes, report the state
	//   if (digitalRead(DIGITAL_IN_PIN) != old_state)
	//   {
	//     old_state = digitalRead(DIGITAL_IN_PIN);
	//     
	//     if (digitalRead(DIGITAL_IN_PIN) == HIGH)
	//     {
	//       ble_write(0x0A);
	//       ble_write(0x01);
	//       ble_write(0x00);    
	//     }
	//     else
	//     {
	//       ble_write(0x0A);
	//       ble_write(0x00);
	//       ble_write(0x00);
	//     }
	//   }
	
	//   if (!ble_connected())
	//   {
	//     analog_enabled = false;
	//     digitalWrite(DIGITAL_OUT_PIN, LOW);
	//   }
	
	// Allow BLE Shield to send/receive data
	ble_do_events();  
}


// ################################################################

void writeMessage() {
	
	for (index = 0; index < sizeof(message) - 1; index++) {
		Serial.print(message[index]);
		ble_write(message[index]);
	} 
	
	Serial.println();
	
}


// ################################################################


void setDegrees() {
	
	#if DEBUG_OUTPUT
	Serial.println("setDegrees()");
	#endif
	
	int degrees = parseValue();
	
	servoBloom.write(degrees);
	
}


// ################################################################

void setRGB() {
	
	#if DEBUG_OUTPUT
	Serial.println("setRGB()");
	#endif
	
	unsigned int rgbColour[3];
	
	// Start off with red.
	rgbColour[0] = parseValue();
	rgbColour[1] = parseValue();
	rgbColour[2] = parseValue();  
	
	setColourRgb(rgbColour[0], rgbColour[1], rgbColour[2]);
	
}


// ################################################################

void setColourRgb(unsigned int red, unsigned int green, unsigned int blue) {
	
	// 	#if DEBUG_OUTPUT
	// 	Serial.println("setColourRgb([" + String(red) + ", " + String(green) + ", " + String(blue) + "])");
	// 	#endif
	
	#ifdef COMMON_ANODE
	red = 255 - red;
	green = 255 - green;
	blue = 255 - blue;
	#endif
	
	analogWrite(RGB_PIN_RED, red);
	analogWrite(RGB_PIN_GREEN, green);
	analogWrite(RGB_PIN_BLUE, blue);
	
}

// ################################################################

// int BitShiftCombine( unsigned char x_high, unsigned char x_low)
// {
//   int combined; 
//   combined = x_high;              //send x_high to rightmost 8 bits
//   combined = combined<<8;         //shift x_high over to leftmost 8 bits
//   combined |= x_low;                 //logical OR keeps x_high intact in combined and fills in                                                             //rightmost 8 bits
//   return combined;
// }

// ################################################################

void loopRGB() {
	unsigned int rgbColour[3];
	
	// Start off with red.
	rgbColour[0] = 255;
	rgbColour[1] = 0;
	rgbColour[2] = 0;  
	
	while (1) {
		
		// Choose the colours to increment and decrement.
		for (int decColour = 0; decColour < 3; decColour += 1) {
			int incColour = decColour == 2 ? 0 : decColour + 1;
			
			// cross-fade the two colours.
			for(int i = 0; i < 255; i += 1) {
				rgbColour[decColour] -= 1;
				rgbColour[incColour] += 1;
				
				setColourRgb(rgbColour[0], rgbColour[1], rgbColour[2]);
				delay(TIME_BLOOM_RGB_CYCLE);
			}
		}
		
		// Quit loop if a new control command has been issued
// 		if (Serial.available() > 0) { 

		Serial.write("ble_available(): ");
		Serial.write(ble_available());

// 		if ((Serial.available() > 0) || ( ble_available() > 0)) {  
		if ((Serial.available() > 0) || ( ble_connected()) ) {  
			break;
		}
	}
}


// ################################################################

void loopRGBServo() {
	
	// 	int percentage = 0;
	percentage = 0;
	
	boolean direction_open = true;
	
	servoBloom.write(POSITION_BLOOM_CLOSED);
	
	int countRGB = 0;
	
	unsigned int rgbColour[3];
	
	// Start off with red.
	rgbColour[0] = 255;
	rgbColour[1] = 0;
	rgbColour[2] = 0;  
	
	
	while (1) {
		
		
		// Choose the colours to increment and decrement.
		for (int decColour = 0; decColour < 3; decColour += 1) {
			int incColour = decColour == 2 ? 0 : decColour + 1;
			
			// cross-fade the two colours.
			for(int i = 0; i < 255; i += 1) {
				rgbColour[decColour] -= 1;
				rgbColour[incColour] += 1;
				
				setColourRgb(rgbColour[0], rgbColour[1], rgbColour[2]);
				delay(TIME_BLOOM_RGB_CYCLE);
				
				countRGB = countRGB + TIME_BLOOM_RGB_CYCLE;
				if (countRGB >= TIME_BLOOM_CYCLE_SLOW_STEPS){
					
					countRGB = 0;
					
					if (direction_open) {
						percentage++;
						servoSetPercentage(percentage);
						if (percentage == 100)
							direction_open = false;
					} else {
						percentage--;
						servoSetPercentage(percentage);
						if (percentage == 0)
							direction_open = true;
					}
				}
			}
		}
		
		Serial.write("ble_available(): ");
		Serial.write(ble_available());
		
		// Quit loop if a new control command has been issued
		if (Serial.available() > 0) {  
// 		if ((Serial.available() > 0) || ( ble_available() > 0)) {  
// 		if ((Serial.available() > 0) || ( ble_connected()) ) {  
			break;
		}
		
	}
	
}


// ################################################################

void servoSetPercentage(int new_percent) {
	
	// 	#if DEBUG_OUTPUT
	// 		Serial.println("servoSetPercentage()");
	// 	#endif
	
	//  int percent = parseValue();
	
	// 	#if DEBUG_OUTPUT
	// 		Serial.print("--> Percentage: ");
	// 		Serial.println(percent);
	// 	#endif
	
	if (new_percent > 100)
		new_percent = 100;
	else if (new_percent < 0)
		new_percent = 0;
	
	// 	int degrees = POSITION_BLOOM_CLOSED;
	degrees = POSITION_BLOOM_CLOSED;
	
	// convert percentage to servo degrees
	if (POSITION_BLOOM_CLOSED >= POSITION_BLOOM_OPEN) {
		degrees = POSITION_BLOOM_CLOSED - (new_percent * (POSITION_BLOOM_CLOSED - POSITION_BLOOM_OPEN) / 100);
	} else {
		degrees = (new_percent * (POSITION_BLOOM_OPEN - POSITION_BLOOM_CLOSED) / 100) + POSITION_BLOOM_CLOSED;
	}
	
	// 	#if DEBUG_OUTPUT
	// 		Serial.print("--> Position: ");
	// 		Serial.println(degrees);
	// 	#endif
	
	servoBloom.write(degrees);
	
}


// ################################################################

void bloomClose() {
	
	#if DEBUG_OUTPUT
	Serial.println("bloomClose()");
	#endif
	
	servoBloom.write(POSITION_BLOOM_CLOSED);
	
}


// ################################################################

void bloomOpen() {
	
	#if DEBUG_OUTPUT
	Serial.println("bloomOpen()");
	#endif
	
	servoBloom.write(POSITION_BLOOM_OPEN);
	
}


// ################################################################

void bloomOpenAndClose() {
	
	#if DEBUG_OUTPUT
	Serial.println("bloomOpenAndClose()");
	#endif
	
	servoBloom.write(POSITION_BLOOM_OPEN);
	
	delay(TIME_BLOOM_OPEN);
	
	servoBloom.write(POSITION_BLOOM_CLOSED);
	
}


// ################################################################

void bloomCycle() {
	
	#if DEBUG_OUTPUT
	Serial.println("bloomCycle()");
	#endif
	
	while (1) {
		
		servoBloom.write(POSITION_BLOOM_OPEN);
		
		delay(TIME_BLOOM_CYCLE);
		
		servoBloom.write(POSITION_BLOOM_CLOSED);
		
		delay(TIME_BLOOM_CYCLE);
		
		if (Serial.available() > 0) {
			
			break;
			
		}
		
	}
	
}


// ################################################################

void bloomCycleSlow() {
	
	#if DEBUG_OUTPUT
	Serial.println("bloomCycleSlow()");
	#endif
	
	// 	int degrees = POSITION_BLOOM_CLOSED;
	degrees = POSITION_BLOOM_CLOSED;
	// 	int percentage = 0;
	percentage = 0;
	
	while (1) {
		
		
		servoTransition(0, 100);
		
		
		#if DEBUG_OUTPUT
		Serial.println("--> Position: Opened");
		#endif
		
		delay(TIME_BLOOM_CYCLE);
		
		
		servoTransition(100, 0);
		
		
		#if DEBUG_OUTPUT
		Serial.println("--> Position: Closed");
		#endif
		
		
		delay(TIME_BLOOM_CYCLE);
		
		
		// Quit loop if a new control command has been issued
		if (Serial.available() > 0) {  
			break;
		}
		
	}
	
}


// ################################################################

void servoTransition(int start_percentage, int end_percentage) {
	
	
	// 	int degrees = POSITION_BLOOM_CLOSED;
	degrees = POSITION_BLOOM_CLOSED;
	// 	int percentage = 0;
	percentage = 0;
	
	int slice = TIME_BLOOM_CYCLE_SLOW_STEPS;
	
	
	if (start_percentage < end_percentage) {
		
		slice = TIME_BLOOM_TRANSITION_FRAME / (end_percentage - start_percentage);
		
		for (percentage=start_percentage;percentage<=end_percentage;percentage++) {
			
			// convert percentage to servo degrees
			if (POSITION_BLOOM_CLOSED >= POSITION_BLOOM_OPEN) {
				degrees = POSITION_BLOOM_CLOSED - (percentage * (POSITION_BLOOM_CLOSED - POSITION_BLOOM_OPEN) / 100);
			} else {
				degrees = (percentage * (POSITION_BLOOM_OPEN - POSITION_BLOOM_CLOSED) / 100) + POSITION_BLOOM_CLOSED;
			}
			
			servoBloom.write(degrees);
// 			delay(TIME_BLOOM_CYCLE_SLOW_STEPS);
			delay(slice);
			
		}
	}
	
	
	else if (start_percentage > end_percentage) {
		
		
		for (percentage=start_percentage;percentage>=end_percentage;percentage--) {
			
			slice = TIME_BLOOM_TRANSITION_FRAME / (start_percentage - end_percentage);
			
			// convert percentage to servo degrees
			if (POSITION_BLOOM_CLOSED >= POSITION_BLOOM_OPEN) {
				degrees = POSITION_BLOOM_CLOSED - (percentage * (POSITION_BLOOM_CLOSED - POSITION_BLOOM_OPEN) / 100);
			} else {
				degrees = (percentage * (POSITION_BLOOM_OPEN - POSITION_BLOOM_CLOSED) / 100) + POSITION_BLOOM_CLOSED;
			}
			
			servoBloom.write(degrees);
// 			delay(TIME_BLOOM_CYCLE_SLOW_STEPS);
			delay(slice);
			
		}
		
		
	}
	
}


// ################################################################

void rgbTransitionManual() {
	
	#if DEBUG_OUTPUT
	Serial.println("rgbTransitionManual()");
	#endif
	
	unsigned int rgbStart[3];
	
	rgbStart[0] = parseValue();
	rgbStart[1] = parseValue();
	rgbStart[2] = parseValue();
	
	
	unsigned int rgbEnd[3];
	
	rgbEnd[0] = parseValue();
	rgbEnd[1] = parseValue();
	rgbEnd[2] = parseValue();  
	
	
	rgbTransition(rgbStart[0], rgbStart[1], rgbStart[2], 
					  rgbEnd[0], rgbEnd[1], rgbEnd[2]);
	
}


// ################################################################

void rgbTransition(unsigned int start_red, unsigned int start_green, unsigned int start_blue,
						 unsigned int end_red, unsigned int end_green, unsigned int end_blue) {
	
	unsigned int rgbColour[3];
	
	#if DEBUG_OUTPUT
	Serial.println("rgbTransition()");
	Serial.println(String(start_red) + ", " + String(start_green) + ", " + String(start_blue));
	Serial.println(String(end_red) + ", " + String(end_green) + ", " + String(end_blue));
	#endif
	
	// Begin with entered start values
	rgbColour[0] = start_red;
	rgbColour[1] = start_green;
	rgbColour[2] = start_blue;
	
	setColourRgb(rgbColour[0], rgbColour[1], rgbColour[2]);
	
	
	// Find largest different between start and end colors
	int steps_red = start_red - end_red;
	int steps_green = start_green - end_green;
	int steps_blue = start_blue - end_blue;
	
	int red_step = 1;
	int green_step = 1;
	int blue_step = 1;
	
	
	// 	Serial.println("red_step: " + String(red_step) + ", steps_red: " + String(steps_red));         
	// 	Serial.println("green_step: " + String(green_step) + ", steps_green: " + String(steps_green));         
	// 	Serial.println("blue_step: " + String(blue_step) + ", steps_blue: " + String(steps_blue));   
	
	if (steps_red < 0)
		steps_red = end_red - start_red;
	if (steps_green < 0)
		steps_green = end_green - start_green;
	if (steps_blue < 0)
		steps_blue = end_blue - start_blue;
	
	
	int total_steps = steps_red;
	if (total_steps < steps_green)
		total_steps = steps_green;
	else if (total_steps < steps_blue)
		total_steps = steps_blue;
	
	
	// 	Serial.println("red_step: " + String(red_step) + ", steps_red: " + String(steps_red));         
	// 	Serial.println("green_step: " + String(green_step) + ", steps_green: " + String(steps_green));         
	// 	Serial.println("blue_step: " + String(blue_step) + ", steps_blue: " + String(steps_blue));
	// 	Serial.println("total_steps: " + String(total_steps));        
	
	// cross-fade the two colours.
	for(int i = 0; i < total_steps; i += 1) {
		
		if (rgbColour[0] == 255)
			red_step = -1;
		else if ((rgbColour[0] ==  0) || (rgbColour[0] >  255))
			red_step = 1;
		
		if (rgbColour[1] == 255)
			green_step = -1;
		else if ((rgbColour[1] ==  0) || (rgbColour[1] >  255))
			green_step = 1;                        
		
		if (rgbColour[2] == 255)
			blue_step = -1; 
		else if ((rgbColour[2] ==  0) || (rgbColour[2] >  255))
			blue_step = 1;   
		
		if (steps_red > 0) {
			rgbColour[0] = rgbColour[0] + red_step;
			steps_red = steps_red - 1;
		}
		if (steps_green > 0) {
			rgbColour[1] = rgbColour[1] + green_step;
			steps_green = steps_green - 1;
		}
		if (steps_blue > 0) {
			rgbColour[2] = rgbColour[2] + blue_step;
			steps_blue = steps_blue - 1;
		}
		
		
		setColourRgb(rgbColour[0], rgbColour[1], rgbColour[2]);
		
		delay(TIME_BLOOM_RGB_CYCLE);
	}
	
}


// ################################################################

void loopDemoSocial() {
	
	#if DEBUG_OUTPUT
	Serial.println("loopDemoSocial()");
	#endif
	
	// 	int percentage = 0;
	percentage = 0;
	
	while (1) {
		
		// Red
		setColourRgb(255, 0, 0);
		//  servoSetPercentage(80);
		servoTransition(0,80);
		
		
		delay(TIME_BLOOM_DEMO_CYCLE);
		
		// Green
		setColourRgb(0, 255, 0);
		//  servoSetPercentage(30);
		servoTransition(80,40);
		
		
		
		delay(TIME_BLOOM_DEMO_CYCLE);
		
		// Blue
		setColourRgb(0, 0, 255);
		//  servoSetPercentage(100);
		servoTransition(40,100);
		
		delay(TIME_BLOOM_DEMO_CYCLE);
		
		
		// Cyan
		setColourRgb(0, 255, 255);
		//  servoSetPercentage(50);
		servoTransition(100,50);
		
		delay(TIME_BLOOM_DEMO_CYCLE);
		
		// White
		setColourRgb(255, 255, 255);
		servoTransition(50,0);
		
		
		if (Serial.available() > 0) {
			
			break;
			
		}
		
	}
	
}


// ################################################################

void parseCommand(char command) {
	
	// 	int percentage = 0;
	percentage = 0;
	
	switch (command) {
		
		case '0':  bloomClose(); break;
		case '1':  bloomOpen(); break;
		case '2':  bloomOpenAndClose(); break;
		case '3':  bloomCycle(); break;
		case '4':  bloomCycleSlow(); break;
		case '5':  loopRGBServo(); break;
		case '6':  loopRGB(); break;
		
		case 'Q':  setDegrees(); break;
		case 'R':  setRGB(); break;
		case 'S':  percentage = parseValue(); servoSetPercentage(percentage); break;
		case 'T':  rgbTransitionManual(); break;
		
		case 'D':  loopDemoSocial(); break;
		
	}
}


// ################################################################
// ################################################################
