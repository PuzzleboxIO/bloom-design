
// Puzzlebox Bloom
//
// component: Bloom
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
include <../base/Base.scad> // screw_holes()
include <../stem/Stem.scad> // bulb_pivots(), bulb_pivot_reinforcements_tapered(), light_holes()
include <../petals/Petals.scad> // thick_petal1(), thick_petal2()
use <../library/lamp/Lamp.scad> // lamp(), cage(), petal1(), petal2(), petal_shape(), joint(), slot()
include <../bloom/Bloom.scad>


// Rendering quality (calculated via angle in degrees)
$fa=3;
$fn=300;
lens_resolution=360;

bulb_socket_alternate_joints_position = true;
enable_platform_lens = false;

// print_scale = 1.0; // overrides default from configuration

// Main
scale([print_scale, print_scale, print_scale])
	assemble_bloom();
