
// Puzzlebox Bloom
//
// component: Piston
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
include <../base/Base.scad>
include <../stand/Stand.scad>
include <../stem/Stem.scad>
include <../bulb/Bulb.scad>
use <../library/lamp/Lamp.scad>
include <../piston/Piston.scad>


// Rendering quality (calculated via angle in degrees)
$fa=12;
$fn=30;
lens_resolution=30;

bulb_socket_alternate_joints_position = true;
enable_platform_lens = false;

// Main
assemble_piston();