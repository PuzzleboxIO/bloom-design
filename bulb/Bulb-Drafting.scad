
// Puzzlebox Bloom
//
// component: Bulb
//
// edition: Drafting
//
// by Puzzlebox Productions, LLC 
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Libraries
include <../Configuration.scad>
include <../stem/Stem.scad>
include <../bulb/Bulb.scad>


// Rendering quality (calculated via angle in degrees)
$fa=12; // use 12 for animation
$fn=30;

bulb_socket_alternate_joints_position = true;

// Main
assemble_bulb();
