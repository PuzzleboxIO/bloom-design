
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
include <../branch/Branch.scad>


// Rendering quality (calculated via angle in degrees)
$fa=3;
$fn=300;

n=1; // number of petals

// Main

// difference(){
// 	assemble_stems();
// 	assemble_stem_trim();
// }
// assemble_mounting_plate();

assemble_branches();
