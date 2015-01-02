
// Puzzlebox Bloom
//
// component: Bulb
//
// edition: Render
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Libraries
include <../Configuration.scad>
include <../bulb/Bulb.scad>


// Rendering quality (calculated via angle in degrees)
$fa=3;
$fn=300;
lens_resolution=360;

bulb_socket_alternate_joints_position = true;

// print_scale = 1.0; // overrides default from Configuration

// Main
scale([print_scale, print_scale, print_scale])
	assemble_bulb();
