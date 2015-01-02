
// Puzzlebox Bloom
//
// component: Lens
//
// by Puzzlebox Productions 
// http://puzzlebox.io/bloom
//
// Copyright: Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Modules

module lens(lens_resolution) {
	// 	difference(){
	// 		translate([0,0,-lens_radius+lens_height])
	// 		sphere(r=lens_radius,$fn=lens_resolution, center=true);
	// 		
	// 		translate([0,0,-crop_cube_size/2])
	// 		cube([crop_cube_size,crop_cube_size,crop_cube_size], center=true);
	// 	}
	
	// 	translate([0,0,0.1])
	translate([0,0,lens_position_adjustment])
	difference(){
		translate([0,0,lens_sphere_position])
		sphere(r=lens_radius,$fn=lens_resolution, center=true);
		
		translate([0,0,lens_crop_position])
		cube([crop_cube_size,crop_cube_size,crop_cube_size], center=true);
	}
}


module lens_crop(lens_resolution) {
	
	// 	translate([0,0,0.1])
	difference(){
		translate([0,0,lens_position_adjustment])
		difference(){
			translate([0,0,lens_sphere_position])
			sphere(r=lens_radius,$fn=lens_resolution, center=true);
			
			translate([0,0,lens_crop_position])
			cube([crop_cube_size,crop_cube_size,crop_cube_size], center=true);
			
		}
		translate([0,0,-10])
// 		cylinder(r=20,h=200,$fn=lens_resolution); // r4 - matches lens_radius = 50 on Ultimaker2
// 		cylinder(r=20.75,h=200,$fn=lens_resolution); // r5, r6
		cylinder(r=20.35,h=200,$fn=lens_resolution); // r7 
	}
}


module lens_inner(lens_resolution) {
	
	difference(){
		lens(lens_resolution);
		lens_crop(lens_resolution);
	}
}


// Main
// lens_inner(lens_resolution);
