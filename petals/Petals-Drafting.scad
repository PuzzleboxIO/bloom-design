
// Puzzlebox Bloom
//
// component: Petals
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
use <../library/lamp/Lamp.scad> // petal_shape() petal2() base()
include <../petals/Petals.scad>


// Rendering quality (calculated via angle in degrees)
$fa=12;
$fn=30;

bulb_socket_alternate_joints_position = false;
enable_platform_lens = false;

n=1; // number of petals

// Main
assemble_petals();