
// Puzzlebox Bloom
//
// component: Branch
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


module assemble_branches() {
	difference(){
		assemble_stems();
		assemble_stem_trim();
		angle_crop_behind_mounting_plate();
	}
	color("LightBlue")
	assemble_mounting_plate();
	color("LightYellow")
	assemble_mounting_plate_upper();
}


module assemble_stems() {
	for(i=[1:n]){
		color(["green"])rotate([0,0,i*360/n])stem1_level();
		color("red")rotate([0,0,i*360/n+180/n])stem1_level();
	}
}


module assemble_stem_trim() {
	for(i=[1:n]){
		color(["green"])rotate([0,0,i*360/n])trim_stem();
		color("red")rotate([0,0,i*360/n+180/n])trim_stem();
	}
}


module assemble_mounting_plate(center_hole=true) {
	// 	translate([0,7.5,-19.5])
	
	
	for(i=[1:n]){
		// 		color(["Green"])
		rotate([0,0,i*360/n]){
			translate([0,9,-22.25])
			rotate([-10,0,0])
			translate([0,5,-1]) // allign to inside of stem
			stem_mounting_plate_round(center_hole);
		}
		
		// opposite side
		// 		color("Red")
		rotate([0,0,i*360/n+180/n]){
			translate([0,9,-22.25])
			rotate([-10,0,0])
			translate([0,5,-1]) // allign to inside of stem
			stem_mounting_plate_round(center_hole);
		}
	}
	
	
}


module assemble_mounting_plate_cores() {
	for(i=[1:n]){
		// 		color(["Green"])
		rotate([0,0,i*360/n]){
			translate([0,9,-22.25])
			rotate([-10,0,0])
			translate([0,5,-1]) // allign to inside of stem
			// 			stem_mounting_plate_supports();
			union(){
				assemble_mounting_plate();
				stem_mounting_plate_round2();
			}
		}
		
		// opposite side
		// 		color("Red")
		rotate([0,0,i*360/n+180/n]){
			translate([0,9,-22.25])
			rotate([-10,0,0])
			translate([0,5,-1]) // allign to inside of stem
			// 			stem_mounting_plate_supports();
			union(){
				assemble_mounting_plate();
				stem_mounting_plate_round2();
			}
		}
	}
}


module assemble_mounting_plate_upper() {
// 	translate([0,-0.285,6])
	translate([0,0.25,6])
	assemble_mounting_plate();
	
// 	translate([0,-0.15,3])
	translate([0,0.21,3])
	difference(){
// 		scale([0.9,1])
		assemble_mounting_plate(center_hole=false);
		
		translate([0,0,(mount_plate_screw_diameter / print_scale)/2], center=true)
		assemble_mounting_plate_cores();
		
		translate([0,0,-(mount_plate_screw_diameter / print_scale)/2], center=true)
		assemble_mounting_plate_cores();
	}
	
	
// 	for(i=[1:n]){
// 		// 		color(["Green"])
// 		rotate([0,0,i*360/n]){
// 			translate([0,9,-22.25])
// 			rotate([-10,0,0])
// 			translate([0,5,-1]) // allign to inside of stem
// 			// 			stem_mounting_plate_supports();
// 			union(){
// 				assemble_mounting_plate();
// 				stem_mounting_plate_round2();
// 			}
// 		}
// 		
// 		// opposite side
// 		// 		color("Red")
// 		rotate([0,0,i*360/n+180/n]){
// 			translate([0,9,-22.25])
// 			rotate([-10,0,0])
// 			translate([0,5,-1]) // allign to inside of stem
// 			// 			stem_mounting_plate_supports();
// 			union(){
// 				assemble_mounting_plate();
// 				stem_mounting_plate_round2();
// 			}
// 		}
// 	}
	
	
	// 	for(i=[1:n]){
	// 		// 		color(["Green"])
	// 		rotate([0,0,i*360/n]){
	// 			translate([0,9,-22.25])
	// 			rotate([-10,0,0])
	// 			translate([0,5,-1]) // allign to inside of stem
	// 			stem_mounting_plate_supports();
	// 		}
	// 		
	// 		// opposite side
	// 		// 		color("Red")
	// 		rotate([0,0,i*360/n+180/n]){
	// 			translate([0,9,-22.25])
	// 			rotate([-10,0,0])
	// 			translate([0,5,-1]) // allign to inside of stem
	// 			stem_mounting_plate_supports();
	// 		}
	// 	}
	
	
}


module stem1_level()
render()
union() {
	difference(){
		difference(){
			intersection(){
				union(){
					difference(){
						rotate([100,0,0])linear_extrude(height=2*R)scale(0.55)petal_shape();
						translate([0,-R,0])rotate([0,0,4])translate([0,R,0])base(t=1);
					}
					translate([0,-40,-51])rotate([40,0,0])cube([w,30,100],center=true); // removing this removes stem
				}
				translate([0,-R,0])rotate([0,0,4])translate([0,R,0])base(t=0);
			}
			base(t=9); // edge behind stem
			translate([0,-y,z1-P])joint(); // stem joint holes
			translate([0,-yU,zU-P])rotate([atan((yU-y)/(zU-z1))-90,0,0])
			slot(L=sqrt((yU-y)*(yU-y)+(zU-z1)*(zU-z1))-(yU-y)); // slots along stem
		}
		
		// Left Clip
		translate(v=[52.5,0,0]) {
			cube(size=[100, 120, 100], center=true);
		}
		
		// Right Clip
		translate(v=[-52.5,0,0]) {
			cube(size=[100, 120, 100], center=true);
		}
		
		// 		// Top Clip
		// 		translate(v=[0,0,50]) {
		// 			cube(size=[100, 120, 100], center=true);
		// 		}
		
		// Stem Matching Crop
		stem_matching_crop();
		
	}
	
}


module stem_matching_crop() {
	// 	translate([0,0,65])
	translate([0,0,62.25])
	cube(size=[200, 200, 200], center=true);
}


module stem_mounting_plate_round(center_hole=true)
render()
translate([-16,-1.5,0.2975])
// translate([-16,-1.5,0.4])
rotate([0,0,20])
rotate([2,0,0])
translate([0,-2,-1])
translate(v=[0,-42.25,-16.5]) {
	
	rotate([10,0,0])
	difference(){
		
		rotate([0,45,0])
		difference(){
			rotate([90,90,0])
			cylinder(r=3.6,h=mount_plate_thickness,$fn=60);
			// 			cylinder(r=3.6,h=5.4,$fn=60);
			
			// Screw hole for mounting plate
			if (center_hole) {
			rotate([90,90,0])
			translate(v=[0,0,-10])
			cylinder(d=mount_plate_screw_diameter,h=mount_plate_thickness*4,$fn=60);
			}
		}
		
		// Crop a vertical stripe out of the mount plate
		if (slice_mount_plate)
			translate([0,-mount_plate_thickness/2,1])
			cube(size=[10,1,6], center=true);
		
	}
}


module stem_mounting_plate_round2()
render()
translate([-16,-1.5,0.2975])
// translate([-16,-1.5,0.4])
rotate([0,0,20])
rotate([2,0,0])
translate([0,-2,-1])
translate(v=[0,-42.25,-16.5]) {
	
	rotate([10,0,0])
	difference(){
		
		rotate([0,45,0])
		// 		difference(){
		// 			rotate([90,90,0])
		// 			cylinder(r=3.6,h=mount_plate_thickness,$fn=60);
		
		// Screw hole for mounting plate
		rotate([90,90,0])
		translate(v=[0,0,-10])
		cylinder(d=mount_plate_screw_diameter,h=mount_plate_thickness*4,$fn=60);
		// 		}
		
		// 		// Crop a vertical stripe out of the mount plate
		// 		if (slice_mount_plate)
		// 			translate([0,-mount_plate_thickness/2,1])
		// 			cube(size=[10,1,6], center=true);
		
	}
}


module stem_mounting_plate_supports() {
	translate([1.28,-3.5,0])
	translate([-16,-1.5,0.2975])
	rotate([0,0,20])
	rotate([2,0,0])
	translate([0,-2,-1])
	translate(v=[0,-42.25,-16.5]) {
		
		rotate([10,0,0])
		cube([7.19,mount_plate_thickness,10], center=true);
		
	}
}


module angle_crop_behind_mounting_plate()
render()
translate([0,-4.939,0])
translate([0,9,-22.25])
rotate([-10,0,0])
translate([0,5,-1])
translate([-16,-2.5,0])
rotate([0,0,20])
rotate([2,0,0])
translate([0,-2,-1])
translate(v=[0,-42.25,-16.5]) {
	rotate([10,0,0])
	translate([0,-2.75,1])
	cube(size=[10,4,20], center=true);
}


module trim_stem(){
	union(){
		translate([0,44,-35])
		rotate([-17.5,0,0])
		cube(size=[15,10,25], center=true);
		
		translate([0,49,-35])
		cube(size=[10,20,20], center=true);
	}
}
