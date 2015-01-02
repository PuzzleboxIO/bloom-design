
// Puzzlebox Bloom
//
// component: Stem
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
include <../lens/Lens.scad>
include <../branch/Branch.scad>
include <../stem/Stem.scad>


// Rendering quality (calculated via angle in degrees)
$fa=12;
$fn=30;
lens_resolution=30;


// Main
build_stem();