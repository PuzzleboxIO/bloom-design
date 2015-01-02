
// Puzzlebox Bloom
//
// component: Clip
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Modules

module assemble_clip() {
	
	lid_mount_clip();
	
}


module lid_mount_clip(){
	
	
	translate([lid_mount_bolt_spacer,0,lid_mount_bolt_spacer])
	
	translate([-10,-5,4])
	rotate([0,0,180])
	
	difference(){
		
		union(){
			
			// horizontal
			translate([11,0,-1])
			cube([18,10,3],center=true);
			
			
			// vertical
			translate([18.5,0,5+1+2-1.25])
			cube([3,10,15-2.5],center=true);
			
			// diagonal reinforcement
			translate([16.8,0,0.45])
			rotate([0,60,0])
			cube([3,10,5],center=true);
			
			
			// 			translate([10,0,0])
			// 			cylinder(h=10, d=lid_mount_screw_diameter, center=true);
			
		}
		
		// vertical
		translate([18.5,0,10+1-lid_mount_bolt_spacer])
		rotate([0,90,0])
		cylinder(h=10, d=lid_mount_screw_diameter, center=true);
		
		
		// horizontal
		translate([7.5,0,0])
		cylinder(h=10, d=lid_mount_screw_diameter, center=true);
		
		
		
	}
	
	
}


module lid_mount_alignment_screw(){
	
	translate([-15,0,-10])
	
	translate([lid_mount_bolt_spacer,0,lid_mount_bolt_spacer])
	translate([-10,-5,4])
	translate([7.5,0,0])
	cylinder(h=25, d=lid_mount_screw_diameter, center=true);
	
	
}

