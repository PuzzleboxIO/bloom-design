
// Puzzlebox Bloom
//
// component: Base
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
use <../library/lamp/Lamp.scad> // shape()
include <../base/Base.scad>
include <../socket/Socket.scad>


// Rendering quality (calculated via angle in degrees)
$fa=12; // use 12 for drafting
$fn=30;


// Main
build_socket();
