
// Puzzlebox Bloom
//
// component: Bottom
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0
//
// source credit: "Write.scad" by Harlan Martin [http://www.thingiverse.com/thing:16193]


// Libraries
use <../library/WriteScad/Write.scad>


// Modules

module assemble_bottom() {
	
	// 	// Draft - render Stand shell
	// 	// extrude_base();
	// 	
	// 	// Draft - Stand interior
	// 	build_stand_extruded_interior();
	// 	
	// 	// Draft - Mount for clip
	// 	render_lid_mount();
	// 	
	// 	// Draft - Clip
	// 	assemble_clip();
	// 	
	// 	// Draft -- Clip alignment screw
	// 	lid_mount_alignment_screw();
	
	
	translate([0,0,-bottom_plate_height])
	difference(){
		extrude_bottom();
		
		// 	translate([0,0,-bottom_plate_height])
		translate([0,0,-0.1])
		bottom_clip_screw_crop();
		
		// Slice up bottom using upper_inside cutout scaled down
		// 		translate([0,0,-4.5+bottom_plate_height])
		// 		scale([0.8,0.8,0.8])
		// 		difference(){
		// 			bottom_upper_inside();
		// 			build_stand_extruded();
		// 		}
		
		
	}
	
	
	// upper inside
	if (bottom_render_upper_inside)
	difference(){
		translate([0,0,-0.01])
		// 		scale([0.986,0.986,0.986])
		// 		scale([0.975,0.975,0.975])
		// 		scale([0.95,0.95,0.95])
		scale([0.925,0.925,1])
		// 				scale([0.9,0.9,1])
		difference(){
			bottom_upper_inside();
			// 			scale([0.9,0.9,0.9])
			// 			scale([1.05,0.95,1])
			build_stand_extruded_interior();
			// 			scale([0.95,1.05,1])
			// 			build_stand_extruded_interior();
		}
		
		
		// Crop unecessary inner space from upper inside
		// 				translate([0,0,0.75])
		translate([0,0,0.5])
		scale([0.825,0.825,1]){
			difference(){
				
				union(){
					bottom_upper_inside();
					
					// 					translate([24,-29.61,0]) // scale([0.986,0.986,0.986])
					// 					translate([24,-29.3,0]) // scale([0.975,0.975,0.975])
					// 					translate([24,-28.6,0]) // scale([0.95,0.95,0.95])
					translate([30,-25.45,0]) // scale([0.925,0.925,1])
					rotate([0,0,microcontroller_rotate_position])
					cube([30,10,2],center=true);
					
					// 					translate([-20,-40,0]) // scale([0.975,0.975,0.975])
					// 					translate([-17.5,-37.5,0]) // scale([0.95,0.95,0.95])
					translate([-17.5,-37.5,0]) // scale([0.925,0.925,1])
					cylinder(h=2,d=10,center=true);	
				}
				
				mount_screw_reinforcement();
				
				difference(){
					cylinder(h=2,d=78,center=true);
					cylinder(h=2,d=77,center=true);
					
					
					translate([25,-30,0])
					cylinder(h=2,d=10,center=true);
				}
				
			}
			
		}
		
		
		upper_clip_screw_crop();
		
		
		// Crop edges of interior pieces to make room after scaling
		rotate([0,0,microcontroller_rotate_position])
		translate([25,-24.9,0])
		cube([10,10,5],center=true);
		
		translate([-10,-25,0])
		cube([10,10,5],center=true);
		
		if (stand_render_lid_mount) {
			// Area around clip
			// 		translate([-33,-5,0])
			// 		cube([12.5,12.5,5],center=true);
			translate([-32,-7.5,0])
			cube([12.5,20,5],center=true);
		}
		
		rotate([0,0,microcontroller_rotate_position])
		translate([22,23,0])
		cube([10,18,5],center=true);
		
		translate([-5,-30,0])
		cube([10,15,5],center=true);
		
		translate([3.25,-23,0])
		cube([7.5,5,5],center=true);
		
		rotate([0,0,45])
		translate([-11,-27.5,0])
		cube([7,15,5],center=true);
		
		
		// Crop bottom layer
		translate([0,0,0-4/2])
		cube([80,80,4], center=true);
		
		
	} // upper inside
	
	else {
	
		difference(){
	
// 		translate([0,0,0.5])
			scale([0.825,0.825,1])
				mount_screw_reinforcement();
				
			upper_clip_screw_crop();
		}
	
	}
	
	// 	lid_mount_alignment_screw();
	
	
}


module bottom_upper_inside(){
	
	// Upper inside
	translate([0,0,bottom_plate_inside_height/2])
	// 	cylinder(h=bottom_plate_inside_height, d=80, center=true);
	// 	cylinder(h=bottom_plate_inside_height, d1=75, d2=80, center=true);
	cylinder(h=bottom_plate_inside_height, d1=78, d2=77, center=true);
}


module extrude_bottom(){
	
	// Inner solid
	difference(){
		
		// 		translate([0,0,bottom_plate_solid_height/2])
		translate([0,0,bottom_plate_solid_height])
		// 	cylinder(h=bottom_plate_solid_height, d=80, center=true);
		cylinder(h=bottom_plate_solid_height, d1=75, d2=80, center=true);
		// 		cylinder(h=bottom_plate_solid_height*2, d1=75, d2=80, center=true);
		
		// 	rotate([0,0,115])
		// 	translate([0,0,0.4])
		// 		writecylinder(text="Puzzlebox",
		// 						radius=38,
		// 						h=8,
		// 						face="bottom",
		// 						t=1,
		// 						space=1.2,
		// 						font="braille.dxf");
		
		// 		lid_mount_alignment_screw();
		upper_clip_screw_crop();
		
	}
	
	// Upper inside
	bottom_upper_inside();
	
	
	// Outer edge
	difference(){
		
		translate([0,0,bottom_plate_height])
		difference(){
			
			translate([0,0,35])
			
			difference(){
				scale([extrude_base_scale_x,extrude_base_scale_y,extrude_base_scale_z])
				render_base(extrude_base_t);
				
				scale([extrude_base_scale_x-0.075,extrude_base_scale_y-0.075,extrude_base_scale_z+0.01])
				render_base(extrude_base_t);
				
			}
			
			translate([0,0,(125/2)])
			cube([125,125,125],center=true);
			
		}
		
		translate([0,0,(-100/2)])
		cube([100,100,100],center=true);
		
	}
	
	
}


module bottom_clip_screw_crop(){
	
// 	echo("bottom_clip_screw_clearance_diameter", bottom_clip_screw_clearance_diameter);
// 	echo("bottom_clip_screw_clearance_taper", bottom_clip_screw_clearance_taper);
	
	translate(bottom_plate_rear_right_screw_offset)
	translate([-14,-5,bottom_plate_solid_height/2])
	cylinder(h=bottom_plate_solid_height+0.5, d1=bottom_clip_screw_clearance_diameter, d2=bottom_clip_screw_clearance_taper, center=true);
	
	translate(bottom_plate_rear_left_screw_offset)
	translate([-14,-5,bottom_plate_solid_height/2])
	cylinder(h=bottom_plate_solid_height+0.5, d1=bottom_clip_screw_clearance_diameter, d2=bottom_clip_screw_clearance_taper, center=true);
	
	translate(bottom_plate_front_right_screw_offset)
	translate([-14,-5,bottom_plate_solid_height/2])
	cylinder(h=bottom_plate_solid_height+0.5, d1=bottom_clip_screw_clearance_diameter, d2=bottom_clip_screw_clearance_taper, center=true);
	
	translate(bottom_plate_front_left_screw_offset)
	translate([-14,-5,bottom_plate_solid_height/2])
	cylinder(h=bottom_plate_solid_height+0.5, d1=bottom_clip_screw_clearance_diameter, d2=bottom_clip_screw_clearance_taper, center=true);
	
	
}


module upper_clip_screw_crop(){
	
	translate(bottom_plate_rear_right_screw_offset)
	translate([-15,0,-10])
	translate([lid_mount_bolt_spacer,0,lid_mount_bolt_spacer])
	translate([-10,-5,4])
	translate([7.5,0,0])
	// 	cylinder(h=25, d=lid_mount_screw_diameter+0.2, center=true);
		cylinder(h=25, d=lid_mount_screw_diameter+0.25, center=true);
	
	translate(bottom_plate_rear_left_screw_offset)
	translate([-15,0,-10])
	translate([lid_mount_bolt_spacer,0,lid_mount_bolt_spacer])
	translate([-10,-5,4])
	translate([7.5,0,0])
		cylinder(h=25, d=lid_mount_screw_diameter+0.25, center=true);
	
	translate(bottom_plate_front_right_screw_offset)
	translate([-15,0,-10])
	translate([lid_mount_bolt_spacer,0,lid_mount_bolt_spacer])
	translate([-10,-5,4])
	translate([7.5,0,0])
		cylinder(h=25, d=lid_mount_screw_diameter+0.25, center=true);
	
	translate(bottom_plate_front_left_screw_offset)
	translate([-15,0,-10])
	translate([lid_mount_bolt_spacer,0,lid_mount_bolt_spacer])
	translate([-10,-5,4])
	translate([7.5,0,0])
		cylinder(h=25, d=lid_mount_screw_diameter+0.25, center=true);
	
}


module mount_screw_reinforcement(){
	
	// Cylinder reinforcement area around mount screw
	translate(bottom_plate_rear_right_screw_offset)
	translate(bottom_plate_rear_right_screw_reinforcement_cylinder_offset)
	translate([-16.5,-6,1])
	cylinder(h=2,d=15,center=true);
	
	// Cylinder reinforcement area around mount screw
	translate(bottom_plate_rear_left_screw_offset)
	translate(bottom_plate_rear_left_screw_reinforcement_cylinder_offset)
	translate([-16.5,-6,1])
	cylinder(h=2,d=15-1,center=true);
	
	// Cylinder reinforcement area around mount screw
	translate(bottom_plate_front_right_screw_offset)
	translate(bottom_plate_front_right_screw_reinforcement_cylinder_offset)
	translate([-16.5,-6,1])
	cylinder(h=2,d=15,center=true);
	
	// Cylinder reinforcement area around mount screw
	translate(bottom_plate_front_left_screw_offset)
	translate(bottom_plate_front_left_screw_reinforcement_cylinder_offset)
	translate([-16.5,-6,1])
	cylinder(h=2,d=15,center=true);
	
}
