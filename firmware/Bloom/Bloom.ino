/*
 * 
 * Puzzlebox - Bloom
 * 
 * Bloom RGB / Servo Sketch
 * 
 * Copyright Puzzlebox Productions, LLC (2014)
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
 * Modified 2014-12-30
 * by Steve Castellotti <sc@puzzlebox.io>
 * 
 */

#include <Servo.h>

#define DEBUG_OUTPUT 0 
//#define DEBUG_OUTPUT 1 // 1 for debug

#define SERVO_PIN_BLOOM 7

#define RGB_PIN_RED 3
#define RGB_PIN_GREEN 5
#define RGB_PIN_BLUE 6

// Counter-clockwise Open
#define POSITION_BLOOM_OPEN 31
#define POSITION_BLOOM_CLOSED 150

// Clockwise Open
//#define POSITION_BLOOM_OPEN 150
//#define POSITION_BLOOM_CLOSED 31

#define POSITION_BLOOM_SETUP 70 // Percentage

#define TIME_BLOOM_OPEN 3000 // Open the Bloom for three seconds and then close it
#define TIME_BLOOM_CYCLE 3000
#define TIME_BLOOM_CYCLE_SLOW_STEPS 60 // time for each percentage step
#define TIME_BLOOM_DEMO_CYCLE 2500
#define TIME_BLOOM_RGB_CYCLE 10

// Uncomment the line below if using a Common Anode LED
// such as the "T-1 3/4 5mm Full Color LED" from Radioshack [276-028]:
// https://www.radioshack.com/product/index.jsp?productId=3020765
//#define COMMON_ANODE

Servo servoBloom;

char _command;
char lastCommand = '0'; // closed

char message[] = "Bloom";


unsigned char buf[16] = {0};
unsigned char len = 0;

int index;

int percentage;
int degrees;


// ################################################################

/////////
//SETUP//
/////////

void setup() {
	
	// Start off with the LED off.
	setColourRgb(0,0,0);
	
	
	Serial.begin(115200);
	
	servoBloom.attach(SERVO_PIN_BLOOM);
	
	servoBloom.write(POSITION_BLOOM_CLOSED);
	
	delay(2000);
	
	// White
	setColourRgb(255, 255, 255);
	servoTransition(0,POSITION_BLOOM_SETUP);
	
} // setup


// ################################################################

/////////////
//MAIN LOOP//
/////////////

void loop() {
	
	parseSerialInput();
	
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
		if (Serial.available() > 0) {  
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
		
		// Quit loop if a new control command has been issued
		if (Serial.available() > 0) {  
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
	
	
	if (start_percentage < end_percentage) {
		
		for (percentage=start_percentage;percentage<=end_percentage;percentage++) {
			
			// convert percentage to servo degrees
			if (POSITION_BLOOM_CLOSED >= POSITION_BLOOM_OPEN) {
				degrees = POSITION_BLOOM_CLOSED - (percentage * (POSITION_BLOOM_CLOSED - POSITION_BLOOM_OPEN) / 100);
			} else {
				degrees = (percentage * (POSITION_BLOOM_OPEN - POSITION_BLOOM_CLOSED) / 100) + POSITION_BLOOM_CLOSED;
			}
			
			servoBloom.write(degrees);
			delay(TIME_BLOOM_CYCLE_SLOW_STEPS);
			
		}
	}
	
	
	else if (start_percentage > end_percentage) {
		
		
		for (percentage=start_percentage;percentage>=end_percentage;percentage--) {
			
			// convert percentage to servo degrees
			if (POSITION_BLOOM_CLOSED >= POSITION_BLOOM_OPEN) {
				degrees = POSITION_BLOOM_CLOSED - (percentage * (POSITION_BLOOM_CLOSED - POSITION_BLOOM_OPEN) / 100);
			} else {
				degrees = (percentage * (POSITION_BLOOM_OPEN - POSITION_BLOOM_CLOSED) / 100) + POSITION_BLOOM_CLOSED;
			}
			
			servoBloom.write(degrees);
			delay(TIME_BLOOM_CYCLE_SLOW_STEPS);
			
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
		
	}
}


// ################################################################
// ################################################################

