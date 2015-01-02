
// Puzzlebox Bloom
//
// component: Socket
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Modules

module build_socket(){
	
	difference(){
		
		build_base_socket();
		
		// Crop top section of socket to fit under lip of rotate_extruded stand
		// 		translate([0,0,50+stand_socket_height-stand_socket_crop_top])
		// 		cube([100,100,100], center=true);
		
		// crop a section for the piston's mount platform to rest inside socket
		translate([0,0,8.25 + 0.02])
		cylinder(h=piston_mount_platform_height+1, d=piston_mount_platform_length+4.1, center=true);
		
		// crop extra room for screw connecting Piston to Bloom
		translate([0,1.5,5.25 + 0.04-1])
		rotate([0,0,rotation_correction*2])
		translate([0,11.25,0])
		cube([5,8.4+1,piston_mount_platform_height+5+2.5],center=true);
		
		// crop corner edge up from bottom of socket to make room for top of servo
// 		translate([-9,15,-12.5])
// 		rotate([0,0,360*(2/3)])
// 		rotate([0,0,-rotation_correction*2])
// 		rotate([90,45,90])
// 		cube([11,11,8],center=true);
	}
	
	piston_cable_run();
	
}


module build_base_socket(){
	
	union(){
		difference(){
			
			translate([0,0,-25])
			difference(){
				assemble_base_socket();
				// 			translate(v=[0,0,-12.5+25])cube(size=[200, 200, 25], center=true); // 
			}
			
			if (piston_mount_platform_crop)
				// Piston Mount Platform Crop
				translate([0,0,10-piston_mount_platform_height/2])
				cube([piston_mount_platform_length+1, piston_mount_platform_width+1, piston_mount_platform_height + 0.5], center=true);
			
			screw_holes();
			
		}
		
		// removed as these seem to extend down below bottom of socket
		// 		translate([0,0,30])
		// 		support_wall_extensions_socket();
	}
	
}


module assemble_base_socket(){
	difference() {
		
		difference(){
			
			if (build_base_socket){
				translate([0,0,0]) // increase this z value to edit socket while floating above base
				stand_socket(); // Insert plastic to hold up bottom of Bloom module
			}
			
			translate([0,0,-10])cylinder(r2=10.25/2,r1=9.75/2,h=80); // cut center hold in stand_socket
			
		}
		
		// 		translate([0,0,-55])cylinder(r=100,h=80); //  trim up from the bottom to minimum required plastic
		
	}
	
}


module piston_cable_run() {
	
	translate([0,7,0])
	rotate([0,0,rotation_correction])
	translate([-20,-12,-piston_cable_run_height/2])
	
	difference(){
		
		difference(){
			cylinder(h=piston_cable_run_height, d=piston_cable_run_diamter, center=true);
			cylinder(h=piston_cable_run_height + 0.02, d=piston_cable_run_diamter-piston_cable_run_wall_width, center=true);
		}
		
		// crop cable run holder at angle
// 		translate([-8,0,0])
// 		rotate([0,-10,30])
// 		rotate([0,0,rotate_screw_holes])
// 		cube([5,30,piston_cable_run_height + 10.02], center=true);
		
	}
}


module support_wall_extensions_socket($fa=4.5)
translate([0,0,-100-25-25-2.5]){
	difference(){
		
		// Inner support walls
		for(i=[1:3])rotate([0,0,i*120])translate([0,-1,0]){
			
			difference(){
				// 				cube([45-2,2,132.5]);
				// 				cube([45-2-12,2,132.5]);
				cube([45-2-12-1,2,132.5]); // bring in to be flush with outside of socket
				
				// 				translate([28,-90,125+2.5])
				// 				rotate([90,0,90])
				// 				translate([0,0,10])
				// 				rotate(a=[0,90,0])
				// 				translate([0,0,90])
				// 				cylinder(d=cage_screw_diameter, h=20, center=true);
			}
		}
		
		translate([0,0,1.5*50])cylinder(r=10.25/2,h=141.51);
		
		color("Red")
		translate(v=[0,0,slice_socket_up_from_bottom]) { // trim socket up from bottom
			cube(size=[2000, 2000, 200], center=true);
		}
	}
	
}
