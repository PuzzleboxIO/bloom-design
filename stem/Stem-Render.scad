
// Puzzlebox Bloom
//
// component: Stem
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
include <../lens/Lens.scad>
include <../branch/Branch.scad>
include <../stem/Stem.scad>


// Rendering quality (calculated via angle in degrees)
$fa=3; // use 3 for HQ STL (compile takes ~20 minutes, render takes ~1.75 hours)
$fn=300;
lens_resolution=360;


// Main
scale([print_scale, print_scale, print_scale])
build_stem();
