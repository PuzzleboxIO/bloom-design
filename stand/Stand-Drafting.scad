//
// Puzzlebox Bloom
//
// component: Stand
//
// edition: Drafting
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
include <../piston/Piston.scad>
include <../base/Base.scad> // screw_holes
include <../servo/Servo.scad> // mount_screws
include <../mount/Mount.scad>
include <../stand/Stand.scad>


// Configuration
// build_base_socket=false;
build_base_socket=true;
build_inner_support_walls=false;


// Rendering quality (calculated via angle in degrees)
$fa=6;
$fn=60;
//$fs=1;


// Main
assemble_stand();