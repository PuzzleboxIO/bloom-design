
// Puzzlebox Bloom
//
// component: Pin
//
// edition: Render
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Libraries
use <../library/Pin_Connectors_V3/pins.scad>
include <../library/OpenSCAD-Arduino-Mounting-Library/arduino.scad>
include <../Configuration.scad>
include <../mount/Mount.scad>
include <../pin/Pin.scad>


// Rendering quality (calculated via angle in degrees)
$fa=3;
$fn=300;


print_scale = 1.0; // overrides default from Configuration

// Main
scale([print_scale, print_scale, print_scale])
assemble_pin();
