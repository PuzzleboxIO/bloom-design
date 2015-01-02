
// Puzzlebox Bloom
//
// component: Stem
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


module bulb_socket()
render()
difference(){ 
	difference(){
		
		bulb();
		
		// Bulb Socket Crop
		translate(v=[0,0,bulb_socket_crop_position_height]) {
			cube(size=[bulb_socket_split_x, bulb_socket_split_y, bulb_socket_split_z], center=true);
		}
		
	}
	
	translate([0,0,-47])
	cube([100,100,10], center=true);
	
}


module bulb_platform()
difference(){
	translate([0,0,-4])
	difference(){
		union() {
			
			color("blue")
			translate(v=[0,0,bulb_platform_position+1]) {
				// 		cylinder(h=bulb_platform_height, d=bulb_platform_diameter, center=true, $fn=300);
				cylinder(h=bulb_platform_height, d=bulb_platform_diameter, center=true);
			}
			
			// Lens
			// 	color("Lime")
			translate([0,0,-0.1])
			translate([0,0,-48]){
				// 	lens(lens_resolution=$fn);
				// 				lens_crop(lens_resolution=$fn);
				lens_crop(lens_resolution=360);
			}
			
		}
		
		light_holes(diameter=light_hole_diameter, height=cage_screw_height);
		
	}
	
	// Male groove structure for cage
	difference(){
		for(i=[1:n]){
			rotate([0,0,i*180/n])translate([0,0,-50])cube([w+2*tol,2*R,100],center=true);
		}
		difference(){
			base(t=10);
			translate([0,0,-R-P+9])cube(2*R,center=true);
		}
	}
}


module light_holes(diameter, height)
	rotate([0,0,-rotation_correction]){
	
	// how much purple is exposed
	translate(0,0,-150)
	cylinder(d=diameter-2, h=cage_screw_height+150, center=true, $fn=300);
	
	// how much green tapers down to bottom
	translate([0,0,-49.2])
	translate(10,20,-50)
	cylinder(r1=2.5, r2=20, h=3.7, center=true, $fn=300);
	
}


module bulb_pivot()
render()
// rotate([0,0,-1*360/(n*2)+rotation_correction]) // rotate counter-clockwise to align with Y axis
difference(){
	union(){
		
		// Pivot
		translate(v=[0,0,pivot_position_z]) {
			rotate(a=[0,90,0]) {
				cube(size=[pivot_outer_diameter/2+2.5-1.5, pivot_outer_diameter, pivot_thickness], center=true);
			}
		}
		
		// Pivot Reinforcement Wall
		// 		translate(v=[0,0,pivot_position_z + pivot_inner_diameter]) {
		// 			rotate(a=[0,90,0]) {
		// 				cube(size=[pivot_outer_diameter/2+2.5+4, pivot_outer_diameter, pivot_thickness], center=true);
		// 			}
		// 		}
		
		// Pivot Rear Reinforcement Wall
		translate(v=[4,0,pivot_position_z]) {
			rotate(a=[0,90,0]) {
				// 				cube(size=[pivot_outer_diameter/2+2.5-1.5, pivot_outer_diameter-12, pivot_thickness], center=true);
				// 				cube(size=[pivot_outer_diameter/2+2.5-1.5, pivot_outer_diameter-12+1, pivot_thickness], center=true);
				cube(size=[pivot_outer_diameter/2+2.5-1.5, pivot_outer_diameter-12+12, pivot_thickness], center=true);
			}
		}
		
	}
	
	
	// Pivot Rear Reinforcement Wall (Left)
	translate([4.5,-4.15,0])
	rotate([0,0,-15])
	translate(v=[4,0,pivot_position_z]) {
		rotate(a=[0,90,0]) {
			// 				cube(size=[pivot_outer_diameter/2+2.5-1.5, pivot_outer_diameter-12, pivot_thickness], center=true);
			cube(size=[pivot_outer_diameter/2+2.5-1.5+1, pivot_outer_diameter-12+3.75, pivot_thickness+4], center=true);
		}
	}
	
	
	// Pivot Rear Reinforcement Wall (Right)
	translate([4.5,4.1,0])
	rotate([0,0,15])
	translate(v=[4,0,pivot_position_z]) {
		rotate(a=[0,90,0]) {
			// 				cube(size=[pivot_outer_diameter/2+2.5-1.5, pivot_outer_diameter-12, pivot_thickness], center=true);
			cube(size=[pivot_outer_diameter/2+2.5-1.5+1, pivot_outer_diameter-12+4, pivot_thickness+4], center=true);
		}
	}
	
	
	// Pivot Holes (Top)
	if (pivot_round_screw_hole)
		translate(v=[0,0,pivot_hole_position_z+4])
			rotate(a=[0,90,0])
				cylinder(h=pivot_thickness+1, d=pivot_inner_diameter, center=true, $fn=100);
		
	// Pivot Nut Crop
	if (pivot_square_bolt_hole)
// 		translate(v=[0,0,pivot_position_z + pivot_inner_diameter+2])
		translate(v=[0,0,pivot_position_z + pivot_inner_diameter+2+2.75])
			rotate(a=[0,90,0])
				cube(size=[pivot_outer_diameter/2+2.5, pivot_outer_diameter, pivot_thickness+3], center=true);
			
	// Pivot Bolt Screw Hole
	if (pivot_square_bolt_hole)
		translate(v=[0,0,pivot_hole_position_z+10]) 
			cylinder(h=pivot_thickness+1+20, d=pivot_bolt_screw_hole_diameter, center=true, $fn=100);
	
}


module bulb_pivots(){
	color("Purple")
	// 		rotate([0,0,-1*360/(n*2)-rotation_correction])
	// 	translate([10,0,4])
	translate([bulb_pivot_offset_x_purple,0,4])
	bulb_pivot();
	
	color("Violet")
	// 		rotate([0,0,-1*360/(n*2)-rotation_correction])
	// 	translate([-10,0,4])
	translate([bulb_pivot_offset_x_violet,0,4])
	rotate([0,0,180])
	bulb_pivot();
	
	// 	color("DarkOrchid")
	// 	difference(){
	// 		translate([0,0,-52])
	// 		cube(size=[17.5+(pivot_outer_diameter/2), pivot_outer_diameter+15, 3], center=true);
	// 		
	// 		translate([0,0,-20])
	// 		cylinder(h=100, d=led_diameter, center=true);
	// 	}
}


module bulb_pivot_reinforcements(){
	
	// rotate([0,0,-1*360/(n*2)+rotation_correction]){
	// 	rotate([0,0,0])
	
	difference(){
		
		union(){
			// TODO Fix rotation for when n != 6
			// rotate([0,0,-1*360/(n*2)+rotation_correction])
			translate([0,4.2,0])
			rotate([0,0,360/(n*2)])
			translate([-15.5,0,0])
			rotate([0,0,-rotation_correction])
			translate([0,0,reinforcement_height/2])
			cube([7.75, pivot_reinforcements_thickness, reinforcement_height], center=true);
			
			
			translate([31.2,13.825,0])
			rotate([0,0,360/(n*2)])
			translate([-20.5,0,0])
			rotate([0,0,-rotation_correction])
			translate([0,0,reinforcement_height/2])
			cube([7.75, pivot_reinforcements_thickness, reinforcement_height], center=true);
			
			
			// translate([-31.2,13.825,0])
			translate([0.1,0.1,0])
			translate([-3.6,-2.1,0])
			rotate([0,0,-360/(n*2)])
			translate([15.5,0,0])
			rotate([0,0,-rotation_correction])
			translate([0,0,reinforcement_height/2])
			cube([7.75, pivot_reinforcements_thickness, reinforcement_height], center=true);
			
			
			translate([-0.1,-0.1,0])
			translate([-23.25,17.65,0])
			rotate([0,0,-360/(n*2)])
			translate([15.5,0,0])
			rotate([0,0,-rotation_correction])
			translate([0,0,reinforcement_height/2])
			cube([7.75, pivot_reinforcements_thickness, reinforcement_height], center=true);
			
		}
		
		translate([10,-2.685,9])
		rotate([0,0,-rotation_correction])
		// 			cube([pivot_thickness+5, pivot_outer_diameter, reinforcement_height-5], center=true);
		cube([pivot_reinforcements_thickness+5, pivot_outer_diameter, reinforcement_height-5], center=true);
		
		translate([-10,2.685,9])
		rotate([0,0,-rotation_correction])
		// 			cube([pivot_thickness+5, pivot_outer_diameter, reinforcement_height-5], center=true);
		cube([pivot_reinforcements_thickness+5, pivot_outer_diameter, reinforcement_height-5], center=true);
		
		crop_bulb_pivot_reinforcements();
		
	}
	
}


module bulb_pivot_reinforcements_tapered(){
	
	// rotate([0,0,-1*360/(n*2)+rotation_correction]){
	// 	rotate([0,0,0])
	
	difference(){
		
		union(){
			// TODO Fix rotation for when n != 6
			// rotate([0,0,-1*360/(n*2)+rotation_correction])
			translate([0,4.2,0])
			rotate([0,0,360/(n*2)])
			translate([-15.5,0,0])
			rotate([0,0,-rotation_correction])
			translate([0,0,reinforcement_height/2])
			difference(){
				// 				cube([7.75, pivot_thickness-1, reinforcement_height], center=true);
				cube([7.75, pivot_reinforcements_thickness, reinforcement_height], center=true);
				
				translate([2.6, 0, bulb_platform_height+1])
				rotate([0,-42,0])
				// 				cube([pivot_thickness+2, pivot_thickness, reinforcement_height], center=true);
				cube([pivot_thickness+2, pivot_thickness, reinforcement_height], center=true);
			}
			
			
			translate([31.2,13.825,0])
			rotate([0,0,360/(n*2)])
			translate([-20.5,0,0])
			rotate([0,0,-rotation_correction])
			translate([0,0,reinforcement_height/2])
			difference(){
				cube([7.75, pivot_reinforcements_thickness, reinforcement_height], center=true);
				
				translate([-2.6, 0, bulb_platform_height+1])
				rotate([0,42,0])
				cube([pivot_reinforcements_thickness+1+2, pivot_thickness, reinforcement_height], center=true);
			}
			
			// translate([-31.2,13.825,0])
			translate([0.1,0.1,0])
			translate([-3.6,-2.1,0])
			rotate([0,0,-360/(n*2)])
			translate([15.5,0,0])
			rotate([0,0,-rotation_correction])
			translate([0,0,reinforcement_height/2])
			difference(){
				cube([7.75, pivot_reinforcements_thickness, reinforcement_height], center=true);
				
				translate([-2.6, 0, bulb_platform_height+1])
				rotate([0,42,0])
				cube([pivot_reinforcements_thickness+1+2, pivot_thickness, reinforcement_height], center=true);
			}
			
			translate([-0.1,-0.1,0])
			translate([-23.25,17.65,0])
			rotate([0,0,-360/(n*2)])
			translate([15.5,0,0])
			rotate([0,0,-rotation_correction])
			translate([0,0,reinforcement_height/2])
			difference(){
				cube([7.75, pivot_reinforcements_thickness, reinforcement_height], center=true);
				
				translate([2.6, 0, bulb_platform_height+1])
				rotate([0,-42,0])
				cube([pivot_reinforcements_thickness+1+2, pivot_thickness, reinforcement_height], center=true);
			}
			
		}
		
		translate([10,-2.685,9])
		rotate([0,0,-rotation_correction])
		cube([pivot_reinforcements_thickness-1+5, pivot_outer_diameter, reinforcement_height-5], center=true);
		
		translate([-10,2.685,9])
		rotate([0,0,-rotation_correction])
		cube([pivot_reinforcements_thickness-1+5, pivot_outer_diameter, reinforcement_height-5], center=true);
		
		crop_bulb_pivot_reinforcements();
		
	}
	
}


module crop_bulb_pivot_reinforcements(){
	
	translate([0,0,P+6])
	rotate([0,0,-rotation_correction])
	difference(){
		bulb_pivots();
		translate([0,0,10])
		bulb_pivots();
	}
	
	translate([0,0,P+6])
	rotate([0,0,-rotation_correction])
	translate([4,0,0])
	difference(){
		bulb_pivots();
		translate([0,0,10])
		bulb_pivots();
	}
	
	translate([0,0,P+6])
	rotate([0,0,-rotation_correction])
	translate([-4,0,0])
	difference(){
		bulb_pivots();
		translate([0,0,10])
		bulb_pivots();
	}
	
}


// module screw_holes(){
// 	translate([0,0,-8])
// 	translate([0,0,-60])
// 	rotate([rotation_correction,90-cage_screw_tilt_degrees,0])
// 	cylinder(d=cage_screw_diameter, h=cage_screw_height+75, center=true, $fn=300);
// 	
// 	translate([0,0,-8])
// 	translate([0,0,-60])
// 	rotate([0,0,120])
// 	rotate([rotation_correction,90-cage_screw_tilt_degrees,0])
// 	cylinder(d=cage_screw_diameter, h=cage_screw_height+75, center=true, $fn=300);
// 	
// 	translate([0,0,-8])
// 	translate([0,0,-60])
// 	rotate([0,0,240])
// 	rotate([rotation_correction,90-cage_screw_tilt_degrees,0])
// 	cylinder(d=cage_screw_diameter, h=cage_screw_height+75, center=true, $fn=300);
// }


module build_stem() {
	difference(){
		
		// 		translate([0,0,10]) // raise stem (bulb) to fit into socket (when base and stem rendered at same time)
		assemble_bulb();
		
		// build_base(); // for visual comparison only
		
		translate([0,0,-10]) // lower when not rendering base at same time as stem
		screw_holes();
		
	}
	
	if (enable_platform_lens) {
		translate([0,0,17])
		lens_inner(lens_resolution);
	}
	
}

