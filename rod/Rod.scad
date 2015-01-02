
// Puzzlebox Bloom
//
// component: Rod (Connecting Rod)
//
// designed by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


module assemble_rod(){
	
	// 	translate([-connecting_rod_length_square/2,0,connecting_rod_height/2])
	// 	rotate([0,90,0])
	// 	rod_square();
	
	rod();
	
}


module rod_square(){
	
	difference() {
		
		translate([0,0,connecting_rod_length_square/2])
		cube([connecting_rod_height,connecting_rod_width,connecting_rod_length_square-2.5], center=true);
		
		for(i=[1:connecting_rod_pivot_holes])
			translate([0,0,i*connecting_rod_pivot_spacing])
			rotate([0,90,0])
			cylinder(h=connecting_rod_length_square, d=2.5, center=true, $fn=100);
		
	}
	
}


module rod(){
	
	translate([-connecting_rod_length/2,0,0])
	difference() {
		
		translate([connecting_rod_length/2,0,0])
		union() {
			translate([0,0,connecting_rod_height/2])
			cube([connecting_rod_length-connecting_rod_height-3,connecting_rod_width,connecting_rod_height], center=true);
			
			translate([circle_crop_position,0,connecting_rod_height/2])
			cylinder(h=connecting_rod_height, d=connecting_rod_width, center=true);
			
			translate([-circle_crop_position,0,connecting_rod_height/2])
			cylinder(h=connecting_rod_height, d=connecting_rod_width, center=true);
			
		}
		
		for(i=[1:connecting_rod_pivot_holes])
			translate([i*connecting_rod_pivot_spacing-connecting_rod_height,0,0])
			cylinder(h=connecting_rod_length, d=2.5, center=true, $fn=100);
		
	}
	
}
