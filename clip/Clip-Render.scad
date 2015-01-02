
// Puzzlebox Bloom
//
// component: Clip
//
// edition: Render
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Libraries
include <../Configuration.scad>
// include <../bottom/Bottom.scad>
include <../clip/Clip.scad>


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
	assemble_clip();
