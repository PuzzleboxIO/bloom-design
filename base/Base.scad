
// Puzzlebox Bloom
//
// component: Base
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0
//
// source credit: "Blossoming Lamp" by emmett [https://www.thingiverse.com/thing:37926]


// Modules

module assemble_base($fa=$fa, $fn=$fn){
	difference() {
		
		difference(){
			
			union(){
				
				difference(){
					
					stand_base();
					cylinder(r=25,h=300); // Crop cyclinder through bottom layer base bottom
				}
				
				if (build_base_socket){
					translate([0,0,0]) // increase this z value to edit socket while floating above base
					stand_socket(); // Insert plastic to hold up bottom of Bloom module
				}
			}
			
			translate([0,0,-10])cylinder(r2=10.25/2,r1=9.75/2,h=80); // cut center hold in stand_socket
			
		}
		
		translate([0,0,-55])cylinder(r=100,h=80); //  trim up from the bottom to minimum required plastic
		
	}
	
}


module assemble_base_and_mount_plate() {
	
	// 	translate([0,0,5+(1.5 / print_scale)])
	translate([0,0,5-0.01])
	import_base();
	
	// 		translate([0,0,6])
	// 		cylinder(d=62, h=3, center=true);
	
	translate([0,0,5]){
		scale([1 / print_scale, 1 / print_scale, 1 / print_scale])
		base_bottom();
		
		color("grey")
		difference(){
			translate([0,0,-2.5])
			cylinder(d=stand_test_brim_diameter / print_scale, h=stand_test_brim_height, center=true);
			
			translate([0,0,-300/2])
			// 			cylinder(r=25,h=300); // Crop cyclinder through bottom layer base bottom
			cylinder(r=28,h=300); // Crop cyclinder through bottom layer base bottom
		}
	}
}


module base_bottom(){
	difference() {
		
		difference(){
			
			union(){
				
				difference(){
					
					stand_base();
					cylinder(r=25,h=300); // Crop cyclinder through bottom layer base bottom
				}
				
				stand_socket(); // Insert plastic to hold up bottom of Bloom module
				
			}
			
			translate([0,0,-10])cylinder(r2=10.25/2,r1=9.75/2,h=80); // cut center hold in stand_socket
			
		}
		
		translate([0,0,1.5])cylinder(r=100,h=80); //  trim up from the bottom to minimum required plastic
		
	}
}


module stand_base($fa=4.5)
render()
difference(){
	difference(){
		shape(r=151,z=0);
		difference(){
			shape(r=155,z=1.5);
			translate([0,0,100])
			difference(){
				cylinder(r=14.25/2,h=50);
				for(i=[1:3])rotate([45,0,i*120-60])translate([5,0,0])cube(10,center=true);
			}
			// Middle support walls (between inner and outer "shape" walls)
			if (build_inner_support_walls)
				for(i=[1:3])rotate([0,0,i*120])translate([0,-1,0])cube([100,2,200]);
		}
		translate([0,0,1.5])cylinder(r=10.25/2,h=150-18.49);
		translate([0,0,150-17])cylinder(r1=10.25/2,r2=9.75/2,h=1.01);
		translate([0,0,150-16])cylinder(r2=10.25/2,r1=9.75/2,h=1.01);
		
		// TODO
		// 		rotate([0,0,-90])writecylinder(text="Puzzlebox",radius=65,h=8,face="bottom",t=1,space=1.2,
		// 												 font="../../../libraries/Write.scad/braille.dxf");
		
	}
	
	translate(v=[0,0,130]) {
		cube(size=[80, 80, 160], center=true);
	}
	
	// cuts 3 inner supports down to level required for Bloom module to socket into place
	translate(v=[0,0,51.5]) {
		cylinder(h=100, d=67.5, center=true, $fn=300);
	}
	
}


module stand_socket($fa=4.5)
translate([0,0,-100]){
	difference(){
		shape(r=151,z=0); // interior hollowing out of base shape
		difference(){
			shape(r=155,z=1.5);
			translate([0,0,100])
			difference(){
				cylinder(r=14.25/2,h=50); // center-most circular cut-out (widen for full-sized glue stick)
				
				// slice up inside corners from bottom
				if (slice_socket_center_from_bottom) {
					translate(v=[0,0,slice_socket_up_from_bottom-1]) // leave a gap to form a stronger arch
					for(i=[1:3])rotate([45,0,i*120-60])translate([5,0,0])cube(10,center=true);
				}
			}
			
			
			// Inner support walls
			for(i=[1:3])rotate([0,0,i*120])translate([0,-1,0]){
				
				difference(){
					cube([45,2,132.5]);
					
					translate([28,-90,125+2.5])
					rotate([90,0,90])
					translate([0,0,10])
					rotate(a=[0,90,0])
					translate([0,0,90])
					cylinder(d=cage_screw_diameter, h=20, center=true);
				}
			}
			
			
		}
		translate([0,0,1.5])cylinder(r=10.25/2,h=150);
// 		translate([0,0,150-15+.01])cylinder(r1=31,r2=34,h=15); // scoop top-most cup
// 		translate([0,0,150-15+.01])cylinder(r1=31+0.1,r2=34+0.1,h=15); // scoop top-most cup
		translate([0,0,150-15+.01])cylinder(r1=31+0.25,r2=34+0.25,h=15); // scoop top-most cup
// 		translate([0,0,150-15+.01])cylinder(r1=31+0.5,r2=34+0.5,h=15); // scoop top-most cup
		
		translate(v=[0,0,slice_socket_up_from_bottom]) { // trimp up socket from bottom
			// 		cube(size=[200, 200, 220], center=true); // before socket
			cube(size=[200, 200, 200], center=true);
		}
		
	}
}


module support_wall_extensions($fa=4.5)
translate([0,0,-100-25-25-2.5]){
	difference(){
		
		// Inner support walls
		for(i=[1:3])rotate([0,0,i*120])translate([0,-1,0]){
			
			difference(){
				cube([45-2,2,132.5]);
				
				translate([28,-90,125+2.5])
				rotate([90,0,90])
				translate([0,0,10])
				rotate(a=[0,90,0])
				translate([0,0,90])
				cylinder(d=cage_screw_diameter, h=20, center=true);
			}
		}
		
		translate([0,0,1.5*50])cylinder(r=10.25/2,h=141.51);
		
		color("Red")
		translate(v=[0,0,slice_socket_up_from_bottom]) { // trim socket up from bottom
			cube(size=[2000, 2000, 200], center=true);
		}
	}
	
}


module support_wall_interior_screw_holes($fa=4.5)
translate([0,0,-100-25-25-2.5]){
	difference(){
		
		// Inner support walls
		for(i=[1:3])rotate([0,0,i*120])translate([0,-1,0])cube([45,2,132.5]);
		
		translate([0,0,1.5*50])cylinder(r=10.25/2,h=141.51);
		
		color("Red")
		translate(v=[0,0,slice_socket_up_from_bottom]) { // trimp up socket from bottom
			cube(size=[2000, 2000, 200], center=true);
		}
	}
	
}


module screw_holes(){
	translate([0,0,70])
	translate([0,0,-60])
	rotate([0,0,60]) // opposite inner walls
	rotate([0,90-cage_screw_tilt_degrees,0])
	translate([0,0,34])
	
	cylinder(d=cage_screw_diameter, h=cage_screw_height, center=true, $fn=300);
	
	translate([0,0,70])
	translate([0,0,-60])
	rotate([0,0,180]) // opposite inner walls
	rotate([0,90-cage_screw_tilt_degrees,0])
	translate([0,0,34])
	
	cylinder(d=cage_screw_diameter, h=cage_screw_height, center=true, $fn=300);
	
	translate([0,0,70])
	translate([0,0,-60])
	rotate([0,0,300]) // opposite inner walls
	rotate([0,90-cage_screw_tilt_degrees,0])
	translate([0,0,34])
	cylinder(d=cage_screw_diameter, h=cage_screw_height, center=true, $fn=300);
}


module build_base(){
	
	
	union(){
		difference(){
			
			translate([0,0,-25])
			difference(){
				assemble_base($fa=$fa, $fn=$fn);
				// shape(r=150,z=0);
				// 	translate(v=[0,0,-5+10])cube(size=[200, 200, 10], center=true); 
				translate(v=[0,0,-12.5+25])cube(size=[200, 200, 25], center=true); // 
				// 	translate(v=[0,0,-2.5+5])cube(size=[200, 200, 5], center=true); // minimum clipped off bottom
			}
			
			if (piston_mount_platform_crop)
				// Piston Mount Platform Crop
				translate([0,0,10-piston_mount_platform_height/2])
				cube([piston_mount_platform_length+1, piston_mount_platform_width+1, piston_mount_platform_height + 0.5], center=true);
			
			screw_holes();
			
		}
		
		
		translate([0,0,30])
		support_wall_extensions();
	}
	
}


module base_outline(){
	
	outline_diameter=100;
	outline_height=25;
	
	color(["LightGrey"])
	translate([0,0,(outline_height/2)])
	cylinder(d=outline_diameter, h=outline_height, center=true, $fn=100);
}
