
// Puzzlebox Bloom
//
// component: Bloom
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
include <../base/Base.scad> // screw_holes2()
include <../stem/Stem.scad> // bulb_pivots(), bulb_pivot_reinforcements_tapered(), light_holes()
include <../petals/Petals.scad> // thick_petal1(), thick_petal2()
use <../library/lamp/Lamp.scad> // lamp(), cage(), petal1(), petal2(), petal_shape(), joint(), slot()
include <../bloom/Bloom.scad>


// Rendering quality (calculated via angle in degrees)
$fa=12;
$fn=30;
lens_resolution=30;

bulb_socket_alternate_joints_position = true;
enable_platform_lens = false;
// enable_platform_lens = true;

// Main
scale([print_scale, print_scale, print_scale])
assemble_bloom();
