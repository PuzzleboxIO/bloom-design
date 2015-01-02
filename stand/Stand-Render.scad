
// Puzzlebox Bloom
//
// component: Stand
//
// edition: Render
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Libraries
// use <../library/WriteScad/Write.scad>
include <../Configuration.scad>
use <../library/lamp/Lamp.scad> // petal_shape()
include <../socket/Socket.scad>
include <../base/Base.scad> // screw_holes
include <../servo/Servo.scad> // mount_screws
include <../mount/Mount.scad>
include <../stand/Stand.scad>


// Configuration
build_base_socket=false;
build_inner_support_walls=false;


// Rendering quality (calculated via angle in degrees)
$fa=3;
$fn=300;

// print_scale = 0.8; // NOTE: The base stand socket and mount are 
                      //       pre-scaled to global print_scale value
                      //       in Configuration module 

// Main
rotate([0,0,180])
//scale([print_scale, print_scale, print_scale])
	assemble_stand();
