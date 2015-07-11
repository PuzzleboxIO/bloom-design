
// Puzzlebox Bloom
//
// component: Stand
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0
//
// source credit: "Blossoming Lamp" by Emmett Lalish [https://www.thingiverse.com/thing:37926]


// Modules

module assemble_stand() {
	
	build_stand_extruded();
	
}


module build_stand_extruded(){
	
	// Draft - display socket for alignment
	// 	translate([0,0,stand_extension])
	// 		import_socket();
	
	// Draft - display piston for alignment
	// 	translate([0,0,stand_extension])
	// 	translate([0,0,70])
	// 	rotate([0,0,90])
	// 	scale([0.8,0.8,0.8])
	// 		piston();
	
	// Draft - display mockup servo for alignment
	// 	translate([stand_servo_x_offset,stand_servo_y_offset,stand_servo_z_offset])
	// 		mockup_servo();
	
	// Draft - display mockup arduino for alignment
	// 	translate([0,0,80])
	// 	rotate(microcontroller_rotate_position)
	// 	rotate([180,0,0])
	// 	translate([microcontroller_mount_x_offset,microcontroller_mount_y_offset,microcontroller_mount_z_offset])
	// 	rotate([0,-90,0])
	// 	translate([0,0,microcontroller_bolt_width])
	// 		mockup_microcontroller();
	
	
	// Exterior
	build_stand_extruded_exterior();
	
	// Interior
	build_stand_extruded_interior();
	
	
	
} // build_stand_extruded()


module build_stand_extruded_exterior(){
	
	difference(){
		
		extrude_base();
		
		render_screw_holes();
		
		if (enable_render_side_petals_left || enable_render_side_petals_right)
			translate([0,0,40])
			render_side_petals();
		
		// Front wall hole
		if (enable_front_wall_hole) {
			translate([0,50,40])
			rotate([90,90,0])
			cylinder(h=100, d=base_cylinder_side_hole-10, center=true);
			
			// Front wall hole (tapered)
			if (front_wall_hole_tapered)
				translate([0,40,44])
				rotate([90,90,0])
				cylinder(h=30, d1=base_cylinder_side_hole*1.5, d2=base_cylinder_side_hole/8, center=true);
		}
		
		// Carve a small edge away from the interior wall of stand to leave extra room for corner of microcontroller
		rotate(microcontroller_rotate_position)
		rotate([180,0,0])
		translate([microcontroller_mount_x_offset+1,microcontroller_mount_y_offset,microcontroller_mount_z_offset])
		rotate([0,-90,0])
		mockup_microcontroller();
		
		
		// Crop slots for MicroUSB and power cables
		translate([0,0,-5])
		rotate(microcontroller_rotate_position) {
			
			// MicroUSB
			if (stand_crop_microusb_slot) {
				rotate([0,0,-4]) // slightly left
				translate([-0.75,0,20])
				rotate([0,0,150])
				microcontroller_microusb_petal_crop(petal_scale=0.116); // slight decrease to fit tighters to cables
			}
			
			// DC Adapter
			if (stand_crop_dc_adapter_slot) {
				rotate([0,0,-1.5])
				// 			translate([-4.5,0,-11])
				translate([-4.5,0,-11+1])
				rotate([0,0,150])
				microcontroller_microusb_petal_crop(petal_scale=0.100); // increased for 9V battery pack
				// 			microcontroller_microusb_petal_crop(petal_scale=0.09);
				// 			microcontroller_microusb_petal_crop(petal_scale=0.08);
			}
			
		}
		
	}
	
	
}


module build_stand_extruded_interior() {
	difference(){
		union(){
			
			// Servo mount
			render_servo_mount();
			
			// Microcontroller mount
			if (stand_render_microcontroller_mount)
				render_microcontroller_mount();
			
			
			// Lid mount (bottom of object)
			if (stand_render_lid_mount)
				render_lid_mount();
			
			
		}
		
		
		// crop external surface
		extrude_base_crop();
		
		base_floor_crop();
		
		
	}
	
}


module render_microcontroller_mount() {

	difference(){
		union() {
			// Microcontroller mount
			rotate(microcontroller_rotate_position)
			translate([-microcontroller_mount_x_offset,-microcontroller_mount_y_offset,-microcontroller_mount_z_offset])
			rotate([0,-90,0])
			translate([80+0.4,0,-50])
			rotate([0,0,180])
			// 			mount_tapped();
			// 			mount_tapped_extended(r = mountingHoleRadius+0.25);
// 			mount_tapped_stand(r = mountingHoleRadius+0.25);
			mount_tapped_stand(r = mountingHoleRadius + microcontroller_mounting_hole_radius_adjustment);
			
			
			rotate(microcontroller_rotate_position)
			scale([1.05,1.05,1.05])
			translate([0,0,12])
			rotate([180,0,0])
			
			translate([-3.2,0,0])
			translate([0,3,0])
			scale([1,0.85,1])
			microcontroller_mount();

			
			// Connect Mount plate to back wall of Stand
			color([1,1,1])
			rotate([0,0,-90+microcontroller_rotate_position])
			translate([3.5-40,22.5+1.9,(microcontroller_width/2)-5.1])
			cube([(microcontroller_height/2)+32.5, pcbHeight, microcontroller_width+21], center=true);
			
			color([0.5,1,0.5])
			translate([12.5,-95,-3])
			rotate([0,0,-90+microcontroller_rotate_position])
			translate([3.5-40,22.5+1.9,(microcontroller_width/2)-5.1])
			cube([(microcontroller_height/2)+32.5, pcbHeight, microcontroller_width+21], center=true);
		}
		
		// Crop mounting holes
		rotate(microcontroller_rotate_position)
		translate([-microcontroller_mount_x_offset,-microcontroller_mount_y_offset,-microcontroller_mount_z_offset])
		rotate([0,-90,0])
		translate([80+0.4,0,-50])
		rotate([0,0,180])
		holePlacement(boardType = LEONARDO)
		translate([0, 0, -0.01])
// 		cylinder( h=pcbHeight + 3 + 1.02, r = mountingHoleRadius+0.25 );
		cylinder( h=pcbHeight + 3 + 1.02, r = mountingHoleRadius+microcontroller_mounting_hole_radius_adjustment );
		
		
		// Slice microcontroller mounting board down the middle to save material
		if (stand_crop_microcontroller_mount) {
			rotate([0,0,-90+microcontroller_rotate_position])
			translate([25-10-10-1.5,7.5+15,(microcontroller_width/2)])
			cube([(microcontroller_height/2)+5+5+5+10+7.5, 10, microcontroller_width+20+1], center=true);
		}
	}

}


module render_microcontroller_mount_rear(){
	
	difference(){
		
		render_microcontroller_mount();
		
		rotate([0,0,-90+microcontroller_rotate_position])
		translate([3.5-40,20+2.5,(microcontroller_width/2)-5])
		cube([(microcontroller_height/2)+32.5+15, 10, microcontroller_width+25], center=true);
		
		extrude_base_crop();
	
	}

}


module extrude_base(){
	
	difference(){
		
		translate([0,0,35])
		
		difference(){
			scale([extrude_base_scale_x,extrude_base_scale_y,extrude_base_scale_z])
			render_base(extrude_base_t);
			
			scale([extrude_base_scale_x-0.075,extrude_base_scale_y-0.075,extrude_base_scale_z+0.01])
			render_base(extrude_base_t);
			
		}
		
		// Crop bottom of stand
		// 		translate([0,0,(-100/2)])
		// 		cube([100,100,100],center=true);
		base_floor_crop();
		
	}
	
	
	// Reinforce front wall hole
	if (reinforce_front_wall_hole)
		difference(){
			
			translate([0,5,0])
			translate([0,35,60])
			rotate([45,0,0])
			cube([80,17.5,22.5],center=true);
			
			// Crop outside edige of reinforcement
			difference(){
				
				cube([200,200,200],center=true);
				
				translate([0,0,35])
				scale([extrude_base_scale_x,extrude_base_scale_y,extrude_base_scale_z])
				render_base(extrude_base_t);
				
			}
			
		}
		
}


module extrude_base_crop(){
	
	translate([0,0,35])
	
	difference(){
		cube([200,200,200],center=true);
		
		scale([extrude_base_scale_x,extrude_base_scale_y,extrude_base_scale_z])
		render_base(extrude_base_t);
		
	}
	
}


module base_floor_crop(){
	
	translate([0,0,(-100/2)])
	cube([100,100,100],center=true);
	
}


module microcontroller_mount(){
	
	difference(){
		translate([microcontroller_x_offset+(microcontroller_height/2)+6.5,-3,microcontroller_offset_from_bottom/2+2.5])
		cube([microcontroller_height/2, microcontroller_length+3, microcontroller_offset_from_bottom-5],center=true);
		
		
		translate([-3.1,0,-4.4+4])
		translate([microcontroller_x_offset+(microcontroller_height/2)+6.5,-3,microcontroller_offset_from_bottom/2])
		// 		rotate([0,-33,0])
		// 		rotate([0,-25,0])
		rotate([0,-45,0])
		cube([microcontroller_height/2, microcontroller_length+3, microcontroller_offset_from_bottom+20],center=true);
	}
	
}


module microcontroller_crop(){
	
	translate([microcontroller_x_offset+(microcontroller_height/2),-microcontroller_y_offset,(microcontroller_width/2)+microcontroller_offset_from_bottom])
	cube([microcontroller_height, microcontroller_length+5, microcontroller_width],center=true);
	
}


module microcontroller_microusb_crop(){
	
	translate([microcontroller_x_offset+(microcontroller_height/2),-microcontroller_y_offset,(microcontroller_width/2)+microcontroller_offset_from_bottom])
	translate([microusb_x_offset,microusb_y_offset,microusb_z_offset])
	rotate([0,90,-5])
	cube([microusb_crop_width, microusb_crop_height+5, microusb_crop_depth],center=true);
	
}


module microcontroller_microusb_petal_crop(petal_scale=0.15){
	
	rotate([0,0,106.5])
	translate([-60,0,30])
	rotate([90,0,0]) // rotate petals to be vertical
	rotate([0,90,0])
	rotate([0,15,0])
	linear_extrude(height=60)scale(petal_scale)petal_shape();
}


module render_screw_holes(){
	
	translate([0,0,stand_extension])
	rotate(rotate_screw_holes)
	translate([0,0,stand_height+bulb_socket_height])
	scale([print_scale, print_scale, print_scale])
	rotate([0,0,-30])
	screw_holes();
	
}


module render_side_petals(){
	
	if (enable_render_side_petals_right)
		extrude_petal_hole();
	
	if (enable_render_side_petals_left)
		rotate([0,180,0])
		extrude_petal_hole();
}


module render_base(t=0)
rotate_extrude()scale([1,1.3])translate([-t,0])difference(){
	union(){
		circle(r=R);
		translate([0,-R*sqrt(2)*3/4])square([R/sqrt(2),150/1.3]);
	}
	translate((R+R/2)/sqrt(2)*[1,1])circle(r=R/2);
	translate((R+R/2)/sqrt(2)*[1,-1])circle(r=R/2);
	translate([t-2*R,-2*R])square([2*R,4*R]);
}


module import_socket(){
	
	
	// Normal
	// 	rotate([0,0,2*360/n+180/n])
	// 	translate([0,0,-22])
	// 	translate([0,0,stand_total_height])
	// 	build_socket();
	
	// Scale 0.8
	rotate([0,0,2*360/n+180/n])
	translate([0,0,-20])
	translate([0,0,stand_total_height])
	scale([print_scale, print_scale, print_scale])
	build_socket();
	
	// use screw holes to confirm correct positioning of socket
	// 	rotate(rotate_screw_holes)
	// 	translate([0,0,stand_height+bulb_socket_height])
	// 	scale([print_scale, print_scale, print_scale])
	// 	rotate([0,0,-30])
	// 	screw_holes();
	
}


module import_base(){
	difference() {
		
		union() {
			rotate([0,0,90]) // spin the screw holes to align versus servo
			build_base();
		}
		
		if (piston_mount_platform_crop){
			// Piston Mount Platform Crop
			translate([0,0,10-piston_mount_platform_height/2])
			cube([piston_mount_platform_length+1, piston_mount_platform_width+1.5, piston_mount_platform_height + 0.5], center=true);
			
			// Pivot Bolt Screw Head Crop (Violet)
			translate(v=[10+0.5,0,10-piston_mount_platform_height-piston_mount_platform_height/2])
			cube([7,5,2.5], center=true);
		}
	}
	
}


module base_cylinder_wall(){
	
	translate([0,0,-mount_plate_length/2])
	difference(){
		cylinder(h=mount_plate_length, d2=stand_cylinder_diameter*print_scale, d1=stand_cylinder_diameter, center=true);
		
		cylinder(h=mount_plate_length+0.1, d2=(stand_cylinder_diameter-stand_cylinder_width)*print_scale, d1=stand_cylinder_diameter-stand_cylinder_width, center=true);
		
		base_cylinder_wall_holes();
		
	}
}


module base_cylinder_wall_crop(){
	
	translate([0,0,(-mount_plate_length/2)-0.1])
	difference(){
		
		cylinder(h=mount_plate_length, d=stand_cylinder_diameter + 50, center=true);
		
		cylinder(h=mount_plate_length+0.1, d2=stand_cylinder_diameter*print_scale, d1=stand_cylinder_diameter, center=true);
		
		
	}
}


module linear_tapered_cylinder(){
	translate([0,0,(-mount_plate_length/2)+(bulb_socket_height/2)])
	difference(){
		
		cylinder(h=mount_plate_length+bulb_socket_height, d2=socket_outer_diameter*print_scale, d1=stand_cylinder_diameter, center=true);
		cylinder(h=mount_plate_length+bulb_socket_height+0.1, d2=(socket_outer_diameter-stand_cylinder_width+0.5)*print_scale, d1=stand_cylinder_diameter-stand_cylinder_width, center=true);
		
		base_cylinder_wall_holes();
		
	}
}


module linear_tapered_cylinder_crop(){
	translate([0,0,(-mount_plate_length/2)+(bulb_socket_height/2)-0.1])
	difference(){
		cylinder(h=mount_plate_length+bulb_socket_height, d=stand_cylinder_diameter + 50, center=true);
		cylinder(h=mount_plate_length+bulb_socket_height+0.1, d2=socket_outer_diameter*print_scale, d1=stand_cylinder_diameter, center=true);
	}
}


module extrude_base_cylinder_walls(){
	
	translate([0,0,(-mount_plate_length/2)+(bulb_socket_height/2)])
	difference(){
		
		cylinder(h=mount_plate_length+bulb_socket_height, d2=socket_outer_diameter*print_scale, d1=stand_cylinder_diameter, center=true);
		
		cylinder(h=mount_plate_length+bulb_socket_height+0.1, d2=(socket_outer_diameter-stand_cylinder_width+0.5)*print_scale, d1=stand_cylinder_diameter-stand_cylinder_width, center=true);
		
		base_cylinder_wall_holes();
		
	}
}


module extruded_base_cylinder_walls_crop(){
	
	translate([0,0,(-mount_plate_length/2)+(bulb_socket_height/2)-0.1])
	difference(){
		
		cylinder(h=mount_plate_length+bulb_socket_height, d=stand_cylinder_diameter + 50, center=true);
		
		cylinder(h=mount_plate_length+bulb_socket_height+0.1, d2=socket_outer_diameter*print_scale, d1=stand_cylinder_diameter, center=true);
		
		
	}
}


module extrude_petal_hole(){
	
	translate([-100,0,0])
	rotate([90,0,0])
	rotate([0,90,0])
	linear_extrude(height=60)scale(0.30)petal_shape();
	
}


module base_cylinder_wall_holes(){
	
	// Front wall hole
	translate([0,50,0])
	rotate([90,90,0])
	cylinder(h=100, d=base_cylinder_side_hole, center=true);
	
	// Rear wall hole
	// 	translate([0,-50,0])
	// 	rotate([90,90,0])
	// 	cylinder(h=100, d=base_cylinder_side_hole, center=true);
	
	
	// Small side petal holes
	side_petal_holes();
	
	rotate([0,180,0])
	side_petal_holes();
	
}


module side_petal_holes(){
	
	
	// Rear
	rotate([0,0,180]){
		rotate([0,0,-90])
		scale([stand_petal_crop_scale_large,stand_petal_crop_scale_large,stand_petal_crop_scale_large])
		extrude_petal_hole();
		
		// Rows
		scale([stand_petal_crop_scale_rear,stand_petal_crop_scale_rear,stand_petal_crop_scale_rear])
		translate([5,-11,0])
		rotate([0,0,90]) {
			
			translate([100,0,30])
			scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
			rotate([0,0,25])
			extrude_petal_hole();
			
			translate([100,0,-30])
			scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
			scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
			rotate([0,0,25])
			extrude_petal_hole();
			
			translate([100,0,-30])
			scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
			rotate([0,0,25])
			extrude_petal_hole();
			
		}
		
		// Rear middle petals
		rotate([0,0,-90]) {
			scale([stand_petal_crop_scale_rear_petal,stand_petal_crop_scale_rear_petal,stand_petal_crop_scale_rear_petal])
			// 	rotate([0,0,332.5])
			rotate([0,0,330])
			extrude_petal_hole();
		}
	}
	
	
	// Bottom row
	rotate([0,0,-90]){
		translate([0,0,-30])
		scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
		scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
		rotate([0,0,25])
		extrude_petal_hole();
		
		translate([100,0,-30])
		scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
		rotate([0,0,-25])
		extrude_petal_hole();
		
		
	}
	
	
	// Sides
	scale([stand_petal_crop_scale_large,stand_petal_crop_scale_large,stand_petal_crop_scale_large])
	extrude_petal_hole();
	
	// 	for(i=[1:6])
	// 		rotate([0,0,i*360/n+180/n])
	// 		scale([0.6,0.6,0.6])
	// 		extrude_petal_hole();
	
	// 	for(i=[1:6])
	// // 		rotate([0,0,i*360/n+180/n])
	// 		rotate([0,0,i*360/n+120/n])
	// 		scale([0.6,0.6,0.6])
	// 		extrude_petal_hole();
	
	
	scale([stand_petal_crop_scale_medium,stand_petal_crop_scale_medium,stand_petal_crop_scale_medium])
	rotate([0,0,320])
	extrude_petal_hole();
	
	
	scale([stand_petal_crop_scale_medium,stand_petal_crop_scale_medium,stand_petal_crop_scale_medium])
	rotate([0,0,36])
	extrude_petal_hole();
	
	
	// Top row
	translate([0,0,30])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	rotate([0,0,25])
	extrude_petal_hole();
	
	translate([100,0,30])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	rotate([0,0,-25])
	extrude_petal_hole();
	
	
	translate([100,0,30])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	rotate([0,0,25])
	extrude_petal_hole();
	
	translate([100,0,30])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	rotate([0,0,25])
	extrude_petal_hole();
	
	
	// Bottom row
	translate([0,0,-30])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	rotate([0,0,25])
	extrude_petal_hole();
	
	translate([100,0,-30])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	rotate([0,0,-25])
	extrude_petal_hole();
	
	
	translate([100,0,-30])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	rotate([0,0,25])
	extrude_petal_hole();
	
	translate([100,0,-30])
	scale([stand_petal_crop_scale_small,stand_petal_crop_scale_small,stand_petal_crop_scale_small])
	rotate([0,0,25])
	extrude_petal_hole();
	
}


module import_servo(){
	translate([0,-27.5,-31.5])
	rotate([0,90,0])
	rotate([0,0,90])
	base_plate();
}


module bottom_servo_mount(){
	
	translate([0,-27.5,-31.5])
	rotate([0,90,0])
	rotate([0,0,90])
	
	difference(){
		
		translate(v=[-servo_top_piece_height/2,-servo_length/2-0.5*rim_size,servo_width/2])
		difference(){
			translate([-2.5,0,0])
			cube([servo_depth-servo_top_piece_height+5,rim_size,servo_width],center=true);
			
			translate([-5,0,((servo_depth-servo_top_piece_height)/2+10)/2])
			cube([((servo_depth-servo_top_piece_height)/2)+10, (rim_size/2)+10, servo_width], center=true);
			
// 			translate([-20,5,0])
// 			cube([servo_depth-servo_top_piece_height,rim_size,servo_width+0.2],center=true);
			
		}
		
		translate([0,base_servo_mount_screws_offset_z,0])
		mount_screws(h=mount_screw_depth+2, d=cage_screw_diameter * print_scale);
		
		
// 		color([0,1,0])
// 		translate([base_servo_mount_crop_from_back,0,0])
// 		translate([-12.5,-21.5,8])
// 		cube([10,10,20], center=true);
		
	}
	
}


module bottom_servo_mount_reinforcement(){
	
	translate([-10.6,-32.68,-mount_plate_length+(5/2)])
	rotate([0,0,45])
	cube([40,10,5],center=true);
	
	translate([-10.6,-32.68,-mount_plate_length+(5/2)])
	rotate([0,0,45])
	translate([-20-2,-10-5,0])
	cube([40,20,5],center=true);
	
	
	// 	translate([36.5,-32.68,-mount_plate_length+(5/2)])
	translate([36.5,-32.68,-mount_plate_length+(5/2)-0.375])
	rotate([0,0,-45])
	// 	cube([40,10,5],center=true);
	cube([40,10,4.25],center=true);
	
	translate([36.5,-32.68,-mount_plate_length+(5/2)])
	rotate([0,0,-45])
	translate([25,0,0])
	cube([40,30,5],center=true);
	
}


module servo_mount_crop(){
	
	// Tapered section below servo
	// 	translate([10,-32.68,-mount_plate_length+(10/2)+5+2.5])
	// 	rotate([15,0,0])
	// 	cube([40,40,10],center=true);
	
	translate([10,-32.68,-mount_plate_length+(10/2)+5+2.5+3.4375])
	rotate([15,0,0])
	cube([40,40,10],center=true);
	
	translate([0,-27.5,-31.5])
	rotate([0,90,0])
	rotate([0,0,90])
	translate([wires_crop_x_offset-5, -wires_crop_y_offset, (wires_crop_height/2) + (servo_mount_plate_thickness) + 0.01])
	cube([wires_crop_width+10, wires_crop_length+1, wires_crop_height], center=true);
	
}


module socket_rim(){
	
	difference(){
		
		translate([0,0,stand_height+bulb_socket_height+mount_plate_thickness/4+16.7])
		color([1,0,0])
		difference(){
			cylinder(h=mount_plate_thickness/2, d=socket_rim+10, center=true);
			cylinder(h=mount_plate_thickness/2+0.1, d=socket_rim-mount_plate_thickness+1, center=true);
		}
		
		// Add screw holes
		rotate(rotate_screw_holes)
		translate([0,0,stand_height+bulb_socket_height])
		scale([print_scale, print_scale, print_scale])
		rotate([0,0,-30])
		screw_holes();
		
	}
}


module socket_rim_flush(){
	
	difference(){
		
		socket_rim();
		import_socket();
		
	}
}


module extrude_walls(){
	
	translate([0,0,(stand_height-base_extrude_walls_scale_height)*2])
	
	// 	scale([30,30,base_extrude_walls_scale_height]) // close but too wide
	scale([25,25,base_extrude_walls_scale_height])
	rotate_extrude(convexity = 10, $fn = 100)
	// 	translate([1.9, 0, 0])
	translate([1.4, 0, 0])
	circle(r = 1, $fn = 100);
}


module extruded_walls_crop(){
	
	translate([0,0,stand_height/2+bulb_socket_height])
	
	difference(){
		cylinder(h=stand_height+bulb_socket_height*2, d=200, center=true);
		
		extrude_walls();
		
		cylinder(h=200, d=socket_rim, center=true);
		
	}
}


module socket_rim_reinforcement(){
	
	difference(){
		
		translate([0,0,-16.5])
		
		translate([0,0,stand_total_height])
		
		rotate_extrude($fn=200)
		scale([10,10,10])
		rotate([90,0,0]) 
		render()
		polygon( points=[[0.1,3],[5,0],[5,3]]);
		
		cylinder(h=400, d=socket_rim-mount_plate_thickness, center=true);
		
		extruded_walls_crop();
		
		translate([0,0,stand_total_height+40/2-0.01])
		cylinder(h=40, d=200, center=true);
		
	}
	
}


module build_stand_cylinder() {
	
	translate([0,0,stand_height+bulb_socket_height])
	difference(){
		
		union(){
			
			if (! linear_tapered_cylinder){
				scale([print_scale, print_scale, print_scale])
				color([1,0,1])
				import_base();
			}
			
			
			difference(){
				translate([base_servo_mount_offset_x,base_servo_mount_offset_y,0])
				union(){
					bottom_servo_mount();
					bottom_servo_mount_reinforcement();
				}
				
				servo_mount_crop();
				
			}
			
			
			if (linear_tapered_cylinder) {
				linear_tapered_cylinder();
			} else {
				base_cylinder_wall();
			}
			
		} // union()
		
		// Crop everything extending beyond base cylinder wall
		if (linear_tapered_cylinder) {
			linear_tapered_cylinder_crop();
			
			// Add screw holes
			rotate(rotate_screw_holes)
			scale([print_scale, print_scale, print_scale])
			rotate([0,0,-30])
			screw_holes();
			
		} else {
			base_cylinder_wall_crop();
		}
		
		
	} // difference()
	
}


module render_servo_mount() {
	translate([base_servo_mount_offset_x,base_servo_mount_offset_y,base_servo_mount_offset_z])
	union(){
		bottom_servo_mount();
		bottom_servo_mount_reinforcement();
	}
	
}


module servo_cube(){

	translate([0,-10,servo_cube_z/2])
	difference(){
		cube([servo_cube_x,servo_cube_y,servo_cube_z], center=true);
		cube([servo_cube_x-(stand_wall_width*2),servo_cube_y+0.02,servo_cube_z+0.02], center=true);
	}
}


module servo_cube_crop(){
	// 	translate([0,-10,servo_cube_z/2]){
	cube([servo_cube_x*2,servo_cube_y,servo_cube_z*2], center=true);
	
	cube([servo_cube_x,servo_cube_y,servo_cube_z], center=true);
	// 	}
}


module servo_cylinder(){
	
	servo_cylinder_height = mockup_servo_lip_height;
	translate([0,0,servo_cylinder_height/2])
	difference(){
		cylinder(h=servo_cylinder_height, d=100, center=true);
		cylinder(h=servo_cylinder_height+0.02, d=100-stand_wall_width, center=true);
	}
	
}


module servo_cylinder_crop(){
	translate([0,0,servo_cylinder_height/2])
	difference(){
		cylinder(h=servo_cylinder_height+10, d=200, center=true);
		cylinder(h=servo_cylinder_height+10.02, d=100, center=true);
	}
}


module servo_cylinder_slim(){
	
	diameter=75;
	
	servo_cylinder_height = mockup_servo_lip_height;
	translate([0,-(diameter/2)+25,servo_cylinder_height/2])
	difference(){
		cylinder(h=servo_cylinder_height, d=diameter, center=true);
		cylinder(h=servo_cylinder_height+0.02, d=diameter-stand_wall_width, center=true);
	}
	
}


module servo_cylinder_slim_crop(){
	
	diameter=75;
	
	servo_cylinder_height = mockup_servo_lip_height;
	translate([0,-(diameter/2)+25,servo_cylinder_height/2-1])
	difference(){
		cylinder(h=servo_cylinder_height+10, d=diameter*2, center=true);
		cylinder(h=servo_cylinder_height+10.02, d=diameter, center=true);
	}
	
}


module render_lid_mount() {
	
	translate([base_servo_mount_offset_x,base_servo_mount_offset_y,base_servo_mount_offset_z])
	lid_mount();
	
}


module lid_mount(){
	
	rotate(lid_mount_rotate)
	translate([-10.6,-32.68,-lid_mount_length+(5/2)])
	rotate(-lid_mount_rotate){
		
		difference(){
			
			union(){
				translate([13,0,0])
				cube([14,10,5],center=true);
				
				translate([18.5,0,10])
				cube([3,10,15],center=true);
				
				translate([16,0,3.5])
				rotate([0,45,0])
				cube([3,10,7.5],center=true);
				
				translate([11.575,-7.5,1.5])
				rotate([0,45,0])
				cube([17.5,5,50],center=true);
				
			}
			
			translate([18.5,0,12.5])
			rotate([0,90,0])
			cylinder(h=10, d=lid_mount_screw_diameter, center=true);
			
			translate([28.751,-5,10])
			cube([17.5,12.5,50],center=true);
			
			translate([22.5,-7.5,22.5])
			cube([15,5.02,10],center=true);
			
		}
	}
	
	
}
