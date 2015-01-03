
// Puzzlebox Bloom
//
// component: Bloom
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0
//
// source credit: "Blossoming Lamp" by Emmett Lalish [https://www.thingiverse.com/thing:37926]
// creative credit: Patrick Jouin [http://www.mgxbymaterialise.com/limited-editions/mgxmodel/detail/detail/71]


module assemble_bloom(){
	
	translate([0,0,P])
	bloom();
	
	// Lens
	if (enable_platform_lens) {
		translate([0,0,17])
		lens_inner(lens_resolution);
	}
	
	// rotate([0,0,rotation_correction]) // rotate to align solid piece of platform with Y axis
	translate([0,0,P]) {
		
		// Don't render the custom socket when building the lamp or else the pivots will
		// not align with the two varieties of petals and branches
		// 	color("Gold");
		// 	bulb_socket();
		
		if (enable_bulb_platform)
			color("LimeGreen")
			difference(){
				bulb_platform();
				translate(0,0,-150)
				cylinder(d=light_hole_diameter-1, h=cage_screw_height+150, center=true, $fn=300);
				// 			cylinder(d=light_hole_diameter-1, h=cage_screw_height+150+35, center=true, $fn=300);
			}
			
			translate([0,0,-4])
			rotate([0,0,-rotation_correction])
				bulb_pivots();
	
	}
	
	difference(){
		if (! bulb_pivots_tapered)
			bulb_pivot_reinforcements();
		else
			bulb_pivot_reinforcements_tapered();
		
		// Crop yellow bulb_pivot_reinforcements in a circular arc to match the light hole.
		// (leaves the mount points intact)
		translate([0,0,0])
		light_holes(diameter=light_hole_diameter, height=cage_screw_height);
	}
}


module build_petals() {
		for(i=[1:n]){
			color([0,1,0])rotate([0,0,i*360/n])petal1();
			
			color([1,0,0])rotate([0,0,i*360/n+180/n])petal2();
		}
}


module build_petals_thick() {
		for(i=[1:n]){
			color([0,1,0])rotate([0,0,i*360/n])petal1();
			color([1,0,1])rotate([0,0,i*360/n])thick_petal1();
			
			color([1,0,0])rotate([0,0,i*360/n+180/n])petal2();
			color([1,1,1])rotate([0,0,i*360/n+180/n])thick_petal2();
		}
}


module bloom(){
	
	difference(){
		
		lamp();
		
		color([1,0,1])
		translate([0,0,lamp_crop_pos_z])
		cube([100, 100, height_of_lamp_crop], center=true);
	}
	
	
	// Cage
	translate([0,0,-P])
	difference() {
		color([0,1,1])
		translate([0,0,P])
		cage();
		
		// NOTE should only crop screw holes in cage(), should not be possible to overshoot and hit bulb_platform()
		rotate([0,0,-rotation_correction]) 
		translate([0,0,-10]) // lower when not rendering base at same time as stem
		screw_holes();
	}
	
	
	// Petals
	if (build_bloom_petals_thick)
		build_petals_thick();
	else
		build_petals();
	
}
