
// Puzzlebox Bloom
//
// component: Piston
//
// by Puzzlebox Productions 
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


module assemble_piston(){
	
	// Draft - Display bulb_pivots() mount for alignment
	// 	rotate([180,0,90])
	// 	piston_upper_mount();
	
	
	// Draft - Display socket and example stand for alignment
	// 	rotate([180,0,0])
	// 	translate([0,0,-10])
	// 	import_base();
	
	
	// Draft - Display bulb for alignment
	// 	rotate([180,0,90])
	// 	assemble_bulb();
	
	
	// Render Piston
	rotate([180,0,90])
	piston();
	
	
	
	
	
}


module piston(){
	
	difference() {
		
		union() {
			piston_platform();
			
			translate([0,0,(-piston_rod_height/2)])
			// 			cylinder(h=piston_rod_height, d=piston_rod_diameter, center=true, $fn=100);
			difference(){
				cylinder(h=piston_rod_height, d=piston_rod_diameter, center=true, $fn=100);
				translate([0,0,-piston_rod_height+10])
				cylinder(h=piston_rod_height+0.02, d=piston_rod_diameter+0.02, center=true, $fn=100);
				
			}
		}
		
		translate([piston_rod_width,0,-piston_rod_height])
		cube([piston_rod_width,10,piston_rod_height-27.5], center=true);
		
		translate([-piston_rod_width,0,-piston_rod_height])
		cube([piston_rod_width,10,piston_rod_height-27.5], center=true);
		
		translate([0,0,-6]){
			// 			translate([0,0,((-piston_rod_height)*3)/4])
			translate([0,0,   (((-piston_rod_height)*3)/4)+piston_rod_height_extension   ])
			rotate([0,90,0])
			cylinder(h=piston_rod_height, d=2.5, center=true, $fn=100);
			
			
			// 	translate([0,0,((-piston_rod_height-8)*3)/4])
			// 		rotate([0,90,0])
			// 			cylinder(h=piston_rod_height, d=2.5, center=true, $fn=100);
			
		}
		
	}
	
	difference(){
		translate([0,0,-6])
		// 		translate([0,0,((-piston_rod_height-8)*3)/4])
		translate([0,0,((-piston_rod_height)*3)/4])
		rotate([0,90,0])
		// 			cylinder(h=piston_rod_height, d=2.5, center=true, $fn=100);
		cylinder(h=piston_rod_width, d=10-1, center=true, $fn=100);
		
		
		
		translate([0,0,-6]){
			// 			translate([0,0,((-piston_rod_height)*3)/4])
			translate([0,0,   (((-piston_rod_height)*3)/4)+piston_rod_height_extension    ])
			rotate([0,90,0])
			cylinder(h=piston_rod_height, d=2.5, center=true, $fn=100);
		}
		
	}
	
	// Extend Piston platform to attached Bulb
	rotate([-180,0,-90])
	piston_bulb_screw_mount();
	
}


module piston_platform() {
	
	rotate(connecting_rod_rotation)
	difference() {
		
		translate([0,0,-piston_mount_platform_height/2])
		cube([piston_mount_platform_length, piston_mount_platform_width, piston_mount_platform_height], center=true);
		
		// Pivot Bolt Screw Hole (Violet)
		translate(v=[bulb_pivot_offset_x_purple,0,-piston_mount_platform_height/2])
		cylinder(h=piston_mount_platform_height+1, d=pivot_bolt_screw_hole_diameter, center=true, $fn=100);
		
		// Pivot Bolt Screw Hole (Purple)
		translate(v=[bulb_pivot_offset_x_violet,0,-piston_mount_platform_height/2])
		cylinder(h=piston_mount_platform_height+1, d=pivot_bolt_screw_hole_diameter, center=true, $fn=100);
		
	}
	
}


module piston_bulb_screw_mount(){
	
	rotate(connecting_rod_rotation)
	rotate([0,0,-90])
	
	translate([0,-10,piston_mount_platform_height/2]){
		difference(){
			cylinder(h=piston_mount_platform_height,d=bulb_mount_screw_plate_diameter,center=true);
			cylinder(h=piston_mount_platform_height+1+20, d=bulb_mount_screw_hole_diameter, center=true, $fn=100);
			
			if (piston_mount_platform_screw_mount_bolt_crop)
				translate([0,0,-2.25+1.25])
				cylinder(h=2.5, d=bulb_mount_screw_hole_diameter + (1.25 / print_scale), center=true, $fn=100);
		}
		
		difference(){
			translate([0,2,0])
			cube([bulb_mount_screw_plate_diameter,5,piston_mount_platform_height],center=true);
			cylinder(h=5, d=bulb_mount_screw_hole_diameter, center=true, $fn=100);
			
			if (piston_mount_platform_screw_mount_bolt_crop)
				translate([0,0,-2.25+1.25])
				cylinder(h=2.5, d=bulb_mount_screw_hole_diameter + (1.25 / print_scale), center=true, $fn=100);
			
		}
	}
}


module piston_upper_mount() {
	
	import_bulb_pivots();
	
	rotate([0,0,rotation_correction])
	// 	bulb_pivot_reinforcements();
	bulb_pivot_reinforcements_tapered();
	
}


module import_bulb_pivots() {
	translate([0,0,P-4])
	// 		rotate([0,0,-rotation_correction])
	difference(){
		bulb_pivots();
		translate([0,0,10])
		bulb_pivots();
	}
}

