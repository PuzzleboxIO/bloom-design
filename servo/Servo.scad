
//
// Puzzlebox Bloom
//
// component: Servo Mount
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


// Rendering quality (calculated via angle in degrees)
$fa=3;
$fn=360;

// generic wall thickness used on more or less all parts except the stem
wall_thickness = 4;


// Modules

module mount_plate(){
	// Floor
	translate(v=[mount_plate_outer_diameter/2,0,wall_thickness/2]){
		cube([mount_plate_depth,mount_plate_length,wall_thickness],center=true);
	}
	
	// Right wall
	translate(v=[-servo_top_piece_height/2,servo_length/2+0.5*rim_size,servo_width/2]){
		cube([servo_depth-servo_top_piece_height,rim_size,servo_width],center=true);
	}
	
	// Left wall
	translate(v=[-servo_top_piece_height/2,-servo_length/2-0.5*rim_size,servo_width/2]){
		cube([servo_depth-servo_top_piece_height,rim_size,servo_width],center=true);
	}
	
//	// Servo Mounting Plate (Bottom)
// 	translate(v=[-19.5,0,(servo_mount_plate_height/2)+3]){
// 		cube([servo_mount_plate_thickness,50,servo_mount_plate_height],center=true);
// 	}
// 	translate(v=[-19.5,0,(servo_mount_plate_height/2)+8]){
// 		cube([servo_mount_plate_thickness,50,servo_mount_plate_height],center=true);
// 	}

}


module servo_wall_crop(){
	translate([-(servo_depth)/3, (servo_length/2)+(rim_size/2)+(rim_size/4)+0.01, (servo_width/2)+(servo_mount_plate_thickness/2)+1])
	cube([(servo_depth-servo_top_piece_height)/2+10, rim_size/2, servo_width], center=true);
	
	translate([-(servo_depth)/3, -((servo_length/2)+(rim_size/2)+(rim_size/4)+0.01), (servo_width/2)+(servo_mount_plate_thickness/2)+1])
	cube([(servo_depth-servo_top_piece_height)/2+10, rim_size/2, servo_width], center=true);
	
	// Trim angle at back of mount
	translate([-(servo_depth)/3-9+2, (servo_length/2)+(rim_size/2)+(rim_size/4)+0.01, (servo_width/2)+(servo_mount_plate_thickness/2)+1+10+2])
	rotate([55,0,90])
	cube(25,center=true);
	
	translate([-(servo_depth)/3-9+2, -((servo_length/2)+(rim_size/2)+(rim_size/4)+0.01), (servo_width/2)+(servo_mount_plate_thickness/2)+1+10+2])
	rotate([55,0,90])
	cube(25,center=true);
}


module bottom_plate_screw_holes(){
	// Bottom Left Hole
	translate(v=[servo_depth/2+1-servo_top_piece_height/2,-servo_rot_center_offset,-0.01])
	{
		cylinder(r=mount_plate_outer_diameter/2,h=wall_thickness);
	}
	// Bottom Left Screw Hole
	translate(v=[servo_depth/2+1-servo_top_piece_height/2,-servo_rot_center_offset,3 + 0.01])
	{
		cylinder(r=mount_plate_outer_diameter/1.2,h=wall_thickness/4);
	}
	
	// Bottom Right Hole
	translate(v=[servo_depth/2+1-servo_top_piece_height/2,servo_rot_center_offset,-0.01])
	{
		cylinder(r=mount_plate_outer_diameter/2,h=wall_thickness);
	}
	// Bottom Right Screw Hole
	translate(v=[servo_depth/2+1-servo_top_piece_height/2,servo_rot_center_offset,3 + 0.01])
	{
		cylinder(r=mount_plate_outer_diameter/1.2,h=wall_thickness/4);
	}
	
	// Top Center Hole
	translate(v=[servo_depth/2-servo_top_piece_height-40/2,0,-0.01])
	{
		cylinder(r=mount_plate_outer_diameter/2,h=wall_thickness);
	}
	// Top Center Screw Head
	translate(v=[servo_depth/2-servo_top_piece_height-40/2,0,3 + 0.01])
	{
		cylinder(r=mount_plate_outer_diameter/1.2,h=wall_thickness/4);
	}
}


module control_wires_crop(){
	
	translate([wires_crop_x_offset, wires_crop_y_offset, (wires_crop_height/2) + (servo_mount_plate_thickness) + 0.01])
	cube([wires_crop_width, wires_crop_length, wires_crop_height], center=true);
	
	translate([wires_crop_x_offset, -wires_crop_y_offset, (wires_crop_height/2) + (servo_mount_plate_thickness) + 0.01])
	cube([wires_crop_width, wires_crop_length+1, wires_crop_height], center=true);
	
}


module mount_screws(h=mount_screw_depth, d=mount_screw_diameter)
color("LightGreen"){
	
	// Upper Right
	translate([mount_screw_upper_position_x,mount_screw_distance_from_center,mount_screw_upper_position_z])
	rotate([0,90,0])
	cylinder(d=d, h=h, center=true);
	
	// Bottom Right
	translate([mount_screw_upper_position_x,mount_screw_distance_from_center,mount_screw_lower_position_z])
	rotate([0,90,0])
	cylinder(d=d, h=h, center=true);
	
	// Upper Left
	translate([mount_screw_upper_position_x,-mount_screw_distance_from_center,mount_screw_upper_position_z])
	rotate([0,90,0])
	cylinder(d=d, h=h, center=true);
	
	// Bottom Left
	translate([mount_screw_upper_position_x,-mount_screw_distance_from_center,mount_screw_lower_position_z])
	rotate([0,90,0])
	cylinder(d=d, h=h, center=true);
}


module base_plate(){
	difference(){
		mount_plate();
		mount_screws();
		servo_wall_crop();
		bottom_plate_screw_holes();
		control_wires_crop();
	}
	
}


module mockup_servo(){
	
	color([0.75,0.75,0.75])
// 	cube([servo_length, servo_width, servo_depth], center=true);
// 	cube([20, 36, 40], center=true);
	cube([mockup_servo_width, mockup_servo_depth, mockup_servo_height], center=true);
	
	translate([0,(mockup_servo_depth/2)-10+(mockup_servo_lip_depth/2),0])
		color([0.5,0.5,0.5])
		cube([mockup_servo_lip_width + 0.01,mockup_servo_lip_depth,mockup_servo_lip_height], center=true);
	
	// Gear socket
	translate([0,(mockup_servo_depth/2)+(4/2),-(mockup_servo_height/2)+9])
	rotate([90,0,0])
// 	color([1.5,1.5,1.5])
	color([0.5,0.5,0.5])
	cylinder(h=4,d=mockup_servo_gear_socket_diameter,center=true);
	
	
	// Gear
	translate([0,(mockup_servo_depth/2)+(4/2)+0.51,-(mockup_servo_height/2)+9])
	rotate([90,0,0])
// 	color([1.5,1.5,1.5])
	color([1,1,1])
	cylinder(h=3,d=mockup_servo_gear_diameter,center=true);
	
}
