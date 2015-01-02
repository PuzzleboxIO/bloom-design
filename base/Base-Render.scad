
// Puzzlebox Bloom
//
// component: Base
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
include <../base/Base.scad>


// Rendering quality (calculated via angle in degrees)
$fa=3; // use 3 for HQ STL
$fn=300;


// Main
scale([print_scale, print_scale, print_scale])
	build_base();
