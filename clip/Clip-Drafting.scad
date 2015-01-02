//
// Puzzlebox Bloom
//
// component: Clip
//
// edition: Drafting
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
// build_base_socket=false;
build_base_socket=true;
build_inner_support_walls=false;


// Rendering quality (calculated via angle in degrees)
$fa=6;
$fn=60;
//$fs=1;


// Main
assemble_clip();