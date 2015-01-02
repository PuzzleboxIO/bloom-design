
// Puzzlebox Bloom
//
// component: Rod
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
include <../rod/Rod.scad>


// Rendering quality (calculated via angle in degrees)
$fa=3;
$fn=300;

// Main
scale([print_scale, print_scale, print_scale])
	assemble_rod();
