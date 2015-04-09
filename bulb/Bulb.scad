
// Puzzlebox Bloom
//
// component: Bulb
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014-2015)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


module assemble_bulb(){
	
	// 	assemble_bulb_guide();
	
	difference(){
		
		rotate([0,0,rotation_correction])
		bulb();
		
		// slice top of bulb to visually check wall thickness
		// 		translate([0,0,50])
		// 		cube([bulb_diameter,bulb_diameter,50],center=true);
		
		// slice side of bulb to visually check wall thickness
		// 		translate([bulb_diameter/2,0,50])
		// 		cube([bulb_diameter,bulb_diameter,bulb_diameter],center=true);
		
		// crop a hole for accessing and threading RGB LED wiring
		translate([0,0,-4])
		rotate([-90,0,0])
		translate([0,-bulb_led_wiring_access_hole_z_offset,bulb_led_wiring_access_hole_height/2-8])
		cylinder(h=bulb_led_wiring_access_hole_height-12.5,d=bulb_led_wiring_access_hole_diameter,center=true);
	}
	
}


module bulb(){
	
	// bulb sphere
	difference(){
		
		translate([0,0,bulb_z_offset])
		difference(){
			sphere(d=bulb_diameter, center=true);
			sphere(d=bulb_diameter-bulb_wall_thickness_interior, center=true);
		}
		
		// from light hole sleeve above
		translate([0,0,bulb_sleeve_z_offset])
		cylinder(h=bulb_sleeve_height*10,d=bulb_sleeve_diameter-bulb_wall_thickness,center=true);
	}
	
	
	// sleeve through light hole
	// 	translate([0,0,15])
	translate([0,0,bulb_sleeve_z_offset])
	difference(){
		cylinder(h=bulb_sleeve_height,d=bulb_sleeve_diameter,center=true);
		cylinder(h=bulb_sleeve_height+0.01,d=bulb_sleeve_diameter-bulb_wall_thickness,center=true);
	}
	
	
	// bulb trunk
	bulb_trunk();
	
	
	// trunk reinforcement
	rotate([0,0,-rotation_correction])
	difference(){
		translate([0,0,bulb_trunk_reinforcement_z/2])
		cube([bulb_trunk_reinforcement_x,bulb_trunk_reinforcement_y,bulb_trunk_reinforcement_z],center=true);
		
		translate([0,0,bulb_trunk_height/2])
		// 		cylinder(h=bulb_trunk_height+0.01,d1=bulb_trunk_lower_diamter-bulb_wall_thickness,d2=bulb_trunk_upper_diameter,center=true);
		cylinder(h=bulb_sleeve_height*10,d=bulb_sleeve_diameter-bulb_wall_thickness,center=true);
	}
	
	
	// bulb_mount_screw
	rotate([0,0,-rotation_correction])
	
	translate([0,-10,bulb_mount_screw_plate_height/2]){
		difference(){
			cylinder(h=bulb_mount_screw_plate_height,d=bulb_mount_screw_plate_diameter,center=true);
			cylinder(h=bulb_mount_screw_plate_height+1+20, d=bulb_mount_screw_hole_diameter, center=true, $fn=100);
		}
		
		difference(){
			translate([0,2,0])
			cube([bulb_mount_screw_plate_diameter,5,bulb_mount_screw_plate_height],center=true);
			cylinder(h=5, d=bulb_mount_screw_hole_diameter, center=true, $fn=100);
			
		}
	}
	
	
	// Print support stand for 3D printers such as Printrbot Simple Metal
	if (bulb_enable_support_stand) {
		difference(){
		bulb_support_stand();
		cylinder(h=bulb_led_wiring_access_hole_height,d=bulb_led_wiring_access_hole_diameter / print_scale,center=true);
		}
	}
	
}


module bulb_trunk(){
	translate([0,0,bulb_trunk_height/2])
	difference(){
		cylinder(h=bulb_trunk_height,d1=bulb_trunk_lower_diamter,d2=bulb_trunk_upper_diameter,center=true);
		// 		cylinder(h=bulb_trunk_height+0.01,d1=bulb_trunk_lower_diamter-bulb_wall_thickness,d2=bulb_trunk_upper_diameter,center=true);
		cylinder(h=bulb_sleeve_height*10,d=bulb_sleeve_diameter-bulb_wall_thickness,center=true);
	}
}


module assemble_bulb_guide(){
	
	// 	difference() {
	// 		translate([0,0,P])bloom();
	// 		
	// 		rotate([0,0,-rotation_correction]) 
	// 		translate([0,0,-10]) // lower when not rendering base at same time as stem
	// 		screw_holes();
	// 	}
	
	
	// 	if (enable_platform_lens) {
	// 		translate([0,0,17])
	// 		lens_inner(lens_resolution);
	// 	}
	
	// rotate([0,0,rotation_correction]) // rotate to align solid piece of platform with Y axis
	translate([0,0,P]) {
		
		// Don't render the custom socket when building the lamp or else the pivots will
		// not align with the two varieties of petals and branches
		// 			color("Gold");
		// 			bulb_socket();
		
		// 		color("LimeGreen")
		// 		difference(){
		// 			bulb_platform();
		// 			translate(0,0,-150)
		// 			cylinder(d=light_hole_diameter-1, h=cage_screw_height+150, center=true, $fn=300);
		// 		}
		
		translate([0,0,-4])
		rotate([0,0,-rotation_correction])
		
		
		difference(){
			bulb_pivots();
			
		}
		
		
	}
	
	difference(){
		bulb_pivot_reinforcements();
		
		// Crop yellow bulb_pivot_reinforcements in a circular arc to match the light hole.
		// (leaves the mount points intact)
		translate([0,0,0])
		light_holes(diameter=light_hole_diameter, height=cage_screw_height);
	}
}


module bulb_support_stand() {
	
	rotate([0,0,37.5])
	translate([0,-8,0])
	rotate([0,0,-rotation_correction])
	cube([bulb_support_stand_length,bulb_support_stand_width,bulb_support_stand_height]);
	
	rotate([0,0,180-37.5])
	translate([0,0,0])
	rotate([0,0,-rotation_correction])
	cube([bulb_support_stand_length,bulb_support_stand_width,bulb_support_stand_height]);
	
	rotate([0,0,-rotation_correction])
	translate([-32,16,0])
	cube([bulb_support_stand_length+25,bulb_support_stand_width,bulb_support_stand_height]);

}

