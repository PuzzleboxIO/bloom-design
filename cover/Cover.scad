
// Puzzlebox Bloom
//
// component: Cover
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Modules

module assemble_cover() {
	
	// Draft - Mockup Screw
	mockup_cover_screw();
	
	// 	rotate([0,-90,0])
	difference(){
		cover();
		
		scale([1.02,1.02,1.02])
		mockup_cover_screw();
	}
}


module cover(){
	
	difference(){
		union(){
			rotate([0,90,0])
			cylinder(h=cover_width, d=cover_diameter, center=true);
			
			translate([0.75,0,0])
			scale([0.66,1,1])
			difference(){
				sphere(d=cover_sphere_diameter, center=true);
				
				translate([-0.1,0,0])
				rotate([0,90,0])
				cylinder(h=cover_width, d=cover_sphere_diameter+1, center=true);
				
				translate([-3,0,0])
				rotate([0,90,0])
				cylinder(h=6, d=cover_sphere_diameter+1, center=true);
			}
		}
		
		translate([0,0,-cover_screw_head_diameter/2])
		cube([cover_screw_head_width,cover_screw_head_diameter,cover_screw_head_diameter],center=true);
		
		translate([-cover_screw_head_width/2 - 0.1,0,-cover_screw_head_diameter/2])
		cube([cover_screw_head_width,cover_screw_diameter+0.1,cover_screw_head_diameter],center=true);
	}
	
	
	
}


module mockup_cover_screw(){
	
	translate([-cover_screw_length/2+cover_screw_head_width/2,0,0])
	
	color([0.4,0.4,0.4])
	rotate([0,90,0]){
		cylinder(h=cover_screw_length, d=cover_screw_diameter, center=true);
		
		translate([0,0,cover_screw_length/2-cover_screw_head_width/2])
		cylinder(h=cover_screw_head_width, d=cover_screw_head_diameter, center=true);
	}
	
}
