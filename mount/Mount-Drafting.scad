
// Puzzlebox Bloom
//
// component: Mount
//
// edition: Drafting
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


// Rendering quality (calculated via angle in degrees)
$fa=12; // use 12 for drafting
$fn=30;


// Main
assemble_mount();
