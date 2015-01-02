
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
include <../branch/Branch.scad>


// Rendering quality (calculated via angle in degrees)
$fa=12;
$fn=30;

n=1; // number of petals

// Main
assemble_branches();
