
// Puzzlebox Bloom
//
// component: Lens
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright: Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Rendering quality (calculated via angle in degrees)
$fa=3;
$fn=300;
lens_resolution=360;


// Libraries
include <../Configuration.scad>
include <../lens/Lens.scad>


// Main
lens_inner(lens_resolution);
