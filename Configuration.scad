
// Puzzlebox Bloom
//
// component: Configuration
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0
//
// source credit: "Blossoming Lamp" by Emmett Lalish [https://www.thingiverse.com/thing:37926]
// creative credit: Patrick Jouin [http://www.mgxbymaterialise.com/limited-editions/mgxmodel/detail/detail/71]
//
// source credit: "Arduino OpenSCAD mounting library (v2.0)" by Kelly Egan [https://github.com/kellyegan/OpenSCAD-Arduino-Mounting-Library]
// source credit: "Pin Connectors V3" by Tony Buser and Emmett Lalish [http://www.thingiverse.com/thing:33790]
// source credit: "Write.scad" by Harlan Martin [http://www.thingiverse.com/thing:16193]


// Design
// Note: All measurements are in mm


print_scale = 0.8; // divide by this number pricely-measured 
                   // facets which cannot be scaled down
                   // for example, screw holes, LEDs, docks, etc.


// Tolerances
tol=0.45 / print_scale; // tolerance for sliding [Printrbot Simple Metal (2014, 2015)]
// tol=0.4 / print_scale; // tolerance for sliding [MakerBot Replicator 2]
// tol=0.3 / print_scale; // tolerance for sliding [Ultimaker 2]
// tol=0.4 / print_scale; // tolerance for sliding [daVinci 1.0]


// Bulb Platform
bulb_platform_position = -51; // flush with top of socket (w/ heigth 6)
bulb_platform_diameter = 34;
bulb_platform_height = 4; // (thickness)
// bulb_platform_height = 7; // (thickness)


// Bulb Pivot
// pivot_outer_diameter = 12.5 + 0.5;
pivot_outer_diameter = 12.5 + 0.5 + 1;
pivot_inner_diameter = 4;

// pivot_thickness = 4 + 0.5;
// pivot_thickness = 4 + 0.5 + 1;
pivot_thickness = 4 + 0.5 + 2;

// pivot_reinforcements_thickness = pivot_thickness-1;
pivot_reinforcements_thickness = 3.5;

pivot_extension = 2.5 + 2 + 5;
// pivot_position_z = bulb_platform_position - bulb_platform_height /2 - pivot_extension - 1.825; // dropped by 2.5mm in order to compensate for the head of the pivot arm
// pivot_position_z = bulb_platform_position - bulb_platform_height /2 - pivot_extension - 2.825 + 0.132;
pivot_position_z = bulb_platform_position - bulb_platform_height /2 - pivot_extension - 2.825 + 0.132 + 0.25;
// pivot_hole_position_z = pivot_position_z-pivot_extension/2 + 2.5 + 2;
pivot_hole_position_z = pivot_position_z-pivot_extension/2 + 2.5;
reinforcement_height = 13;
pivot_round_screw_hole = false;
pivot_square_bolt_hole = true;
// pivot_bolt_screw_hole_diameter = pivot_thickness-1;
pivot_bolt_screw_hole_diameter = 3.5;
// bulb_pivot_offset_x_purple = 10;
bulb_pivot_offset_x_purple = 10+1+0.1;
// bulb_pivot_offset_x_violet = -10;
bulb_pivot_offset_x_violet = -10-1-0.1;


// Branch
slice_mount_plate = false; // Crop a vertical stripe out of the mount plate


// Blossom
height_of_lamp = 76.1;
lamp_error_at_z = height_of_lamp - 31;
height_of_lamp_crop = height_of_lamp - lamp_error_at_z + 10; // crop before z error in model
lamp_crop_pos_z = lamp_error_at_z + (height_of_lamp_crop/2); // "

height_of_lamp_crop = height_of_lamp + 119.75; // crop entire bulb
lamp_crop_pos_z = 50; // "


// Petals
petal_stand_height = 3;


// Cage screw holes
cage_screw_diameter = 4 / print_scale;
// cage_screw_height = 15;
// cage_screw_height = 15 + 100;
// cage_screw_height = 15 + 35; // should be enough to reach through to outer edge of stand but not intersect with support ring in base socket
cage_screw_height = 15 -1 ; // leave a 1-2mm wall between edge of cage()

cage_screw_tilt_degrees = 12;


// Light holes
light_hole_diameter = 24; // easy_mount_cropping
// light_hole_diameter = 15; // small diameter
// light_hole_diameter = 12.5 / print_scale; // if you try to scale this it will create a gap between the purple pivots underneath

// led_diameter = 6 / print_scale; // exact measure is closer to 5.5mm but the heat seems to shring the final size of the hole
led_diameter = (light_hole_diameter * print_scale) / print_scale; // grow large to let more light through


// Bulb Socket
// bulb_socket_crop_position_height = 47; // top of male arm joints
bulb_socket_crop_position_height = 38;
bulb_socket_split_x = 100;
bulb_socket_split_y = 100;
bulb_socket_split_z = 172;
bulb_socket_alternate_joints_position = false; // original lamp alternates

bulb_socket_height = 20; // (calculated)

socket_outer_diameter = 75.75; // (calculated)
socket_rim = socket_outer_diameter - 15.2; // (calculated)


// Base Stand
stand_crop_microusb_slot = true;
stand_crop_dc_adapter_slot = true;

stand_crop_microcontroller_mount = true;
// stand_crop_microcontroller_mount = false;

build_base_socket = true;
// build_base_socket = false;

// build_inner_support_walls = true;
build_inner_support_walls = false;

// linear_tapered_cylinder = true;
linear_tapered_cylinder = false; // original base socket

// slice_socket_center_from_bottom = true;
slice_socket_center_from_bottom = false;

// enable_render_side_petals = true;
// enable_render_side_petals = false;
enable_render_side_petals_left = false;
enable_render_side_petals_right = false;
// enable_render_side_petals_right = true;

// enable_front_wall_hole = true;
enable_front_wall_hole = false;

// front_wall_hole_tapered = false;
front_wall_hole_tapered = true;

// reinforce_front_wall_hole = true;
reinforce_front_wall_hole = false;

stand_extrude_walls = true;

stand_crop_position_x = 87.5;
stand_crop_position_height = 70;
stand_crop_x = 100;
stand_crop_y = 100;
stand_crop_z = 172;

// rotate_screw_holes = [0,0,0]; // 2 holes on forward half, to either side
rotate_screw_holes = [0,0,180]; // 1 hole on forward half, centered

// slice_socket_up_from_bottom = 22.5;
slice_socket_up_from_bottom = 22.5-10;

stand_test_brim_diameter = 135.925;
stand_test_brim_height = 5;

// stand_height = 42.5; // (calculated)
stand_height = 43; // (calculated)
base_extrude_walls_scale_height = 44;

// stand_total_height = stand_height+bulb_socket_height;
stand_total_height = stand_height+bulb_socket_height*2;

stand_cylinder_diameter = 97.5; // (calculated)
stand_cylinder_width = 8.75; // (calculated)
// stand_cylinder_width = 8.5175; // "
// stand_cylinder_width = 8.515; // "
// stand_cylinder_width = 8.5; // "

// base_cylinder_side_hole = 50;
base_cylinder_side_hole = 60;

stand_extrude_walls_scale = (stand_cylinder_diameter - stand_cylinder_width) / stand_cylinder_diameter;

stand_petal_crop_scale_large = 1.2;
stand_petal_crop_scale_medium = 0.8;
stand_petal_crop_scale_small = 0.6;
stand_petal_crop_scale_rear = 1;
// stand_petal_crop_scale_rear = 0.95;
// stand_petal_crop_scale_rear_petal = 0.6;
stand_petal_crop_scale_rear_petal = 0.6;

base_servo_mount_offset_x = -5-5-5;
// base_servo_mount_offset_y = 7.5;
// base_servo_mount_offset_y = -8;
// base_servo_mount_offset_y = 7.5-8;
// base_servo_mount_offset_y = 1.5;
base_servo_mount_offset_y = 1.5-2.5; // controls how far back the servo sits under the piston and connecting rod
base_servo_mount_offset_z = 31.5*2;

// base_servo_mount_crop_from_back = 3.5; // widened for TowerPro MG995
base_servo_mount_crop_from_back = 2.5;

// base_servo_mount_screws_offset_z = -0.75;
base_servo_mount_screws_offset_z = -1;

stand_socket_height = 25; // (calculated)
// stand_socket_crop_top = 3;
stand_socket_crop_top = 4; // (measured)

// actual_stand_height = stand_height+bulb_socket_height+mount_plate_thickness/4+16.7;
// actual_stand_height = 81.325;
actual_stand_height = 83;
stand_extension = 22;
adjusted_stand_height = actual_stand_height + stand_extension;

servo_cylinder_height = 53;

stand_wall_width = 3.5;

servo_cube_x=50;
servo_cube_y=80;
servo_cube_z=servo_cylinder_height;

extrude_base_scale_x = 0.95;
extrude_base_scale_y = 0.95;
extrude_base_scale_z = 0.86359;
extrude_base_t = -5;

stand_servo_x_offset = 0;
stand_servo_y_offset = -34+10;
stand_servo_z_offset = 30;

// microcontroller_height = 15 / print_scale;
// microcontroller_length = 76 / print_scale;
// microcontroller_width = 54 / print_scale;

// microcontroller_height = 15;
microcontroller_height = 13;
microcontroller_length = 76;
// microcontroller_width = 54;
microcontroller_width = 58;

// microcontroller_x_offset = 18;
microcontroller_x_offset = 18-7;
microcontroller_y_offset = 12;
microcontroller_offset_from_bottom = 12;

// microcontroller_bolt_width = 0;
microcontroller_bolt_width = 2.5;

// microcontroller_rotate_position = 0;
// microcontroller_rotate_position = 75;
// microcontroller_rotate_position = 60;
// microcontroller_rotate_position = 67.5;
// microcontroller_rotate_position = 30;
// microcontroller_rotate_position = 15;
// microcontroller_rotate_position = 10;
microcontroller_rotate_position = 7.5;
// microcontroller_rotate_position = 5;
// microcontroller_mount_x_offset = 34.75;
// microcontroller_mount_x_offset = 34.75 - 8.5;
// microcontroller_mount_x_offset = 34.75 - 6;
microcontroller_mount_x_offset = 34.75 - 6 - 4;
// microcontroller_mount_y_offset = -40;
// microcontroller_mount_y_offset = -40 + 7;
// microcontroller_mount_y_offset = -40 + 7 - 5;
microcontroller_mount_y_offset = -40 + 7 - 4;
// microcontroller_mount_z_offset = 15;
microcontroller_mount_z_offset = 20;
// microcontroller_mount_z_offset = 15 + microcontroller_bolt_width + 5;

// microcontroller_mounting_hole_radius_adjustment = 0.25;
microcontroller_mounting_hole_radius_adjustment = 0;

// microcontroller_mount_crop_installation_gutter = true;
microcontroller_mount_crop_installation_gutter = false;

microusb_crop_width = 12;
microusb_crop_height = 80;
microusb_crop_depth = 10;

microusb_x_offset = 0;
microusb_y_offset = 0;
microusb_z_offset = -10;


// Servo
servo_length = 43;
servo_width = 22 + 4; // measure is 22mm, increase by 4 to raise walls above servo itself
servo_depth = 45;
servo_rot_center_offset = 22;
servo_top_piece_height = 10;
rim_size = 10;

mockup_servo_height = 40;
mockup_servo_width = 20;
mockup_servo_depth = 36;
mockup_servo_gear_socket_diameter = 6;
mockup_servo_lip_height = 53;
mockup_servo_lip_width = mockup_servo_width;
mockup_servo_lip_depth = 3.5;

// mockup_servo_gear_diameter = 24 / print_scale;
mockup_servo_gear_diameter = 24;

servo_lip = 22;
servo_mount_plate_height = (servo_length - servo_lip) / 2 ; //10.5
servo_mount_plate_thickness = 6;

wires_crop_width = 4;
wires_crop_length = 10 + 1 + 1;
wires_crop_height = (servo_width) /2 - 2;
wires_crop_x_offset = -10;
wires_crop_y_offset = (servo_length / 2) + (wires_crop_length / 2);

mount_screw_diameter = 2.5;
mount_screw_depth = 8;
mount_screw_upper_position_z = 19;
mount_screw_lower_position_z = mount_screw_upper_position_z - 10; // 1cm gap between mount screws
mount_screw_distance_from_center = (servo_length / 2) + (servo_mount_plate_thickness/2);
mount_screw_upper_position_x = 8.51;

mount_plate_outer_diameter = 3.5;
mount_plate_length = servo_length+2*rim_size;
mount_plate_depth = servo_depth+mount_plate_outer_diameter;


// Microcontroller Mount
// mount_height = 5;
mount_height = 2; // slight rise, most space taken by nut
// mount_height = 4;
//Creates standoffs for different boards
TAPHOLE = 0;
PIN = 1;
PINHOLE = 2;


// Pin

//Radial gap to help pins fit into tight holes
pin_tolerance=0.2;
//Extra gap to make loose hole
loose=0.3;
lip_height=3;
lip_thickness=1;

//Only affects pinhole
hole_twist=0;//[0:free,1:fixed]
//Only affects pinhole
hole_friction=0;//[0:loose,1:tight]
hf=hole_friction==0 ? false : true;
ht=hole_twist==0 ? false : true;


// Lid Mount
mount_screw_tolerance = 0.5;

lid_mount_rotate=[0,0,-65];
lid_mount_length = mount_plate_length;
lid_mount_screw_diameter = 4 + mount_screw_tolerance;

// lid_mount_bolt_spacer = 3.7 / print_scale; // bolt and washer between clip and mount
// lid_mount_bolt_spacer = 3.75 / print_scale; // bolt and washer(s) between clip and mount
lid_mount_bolt_spacer = 3.75; // bolt and washer(s) between clip and mount



// Clip
clip_mount_screw_diameter = 3.85;
// bottom_clip_screw_clearance = 20;
bottom_clip_screw_bolt = 6.85;
bottom_clip_screw_clearance = 3.15; //10mm
bottom_clip_screw_clearance_diameter = bottom_clip_screw_bolt + bottom_clip_screw_clearance;
bottom_clip_screw_clearance_taper = bottom_clip_screw_clearance_diameter - 2;


// Bottom Plate
// bottom_plate_height = 2.4;
// bottom_plate_height = lid_mount_bolt_spacer;
bottom_plate_height = 3.6;
bottom_plate_solid_height = 2.4;
// bottom_plate_inside_height = 2;
bottom_plate_inside_height = 1.5;


// Cover
cover_screw_diameter = 3.8 + 0.2; // (0.2mm tolerance added to exact measurement)
cover_screw_head_diameter = 6.5;
cover_screw_head_width = 2.0;
cover_screw_length = 14;

// cover_width = 6;
cover_width = cover_screw_head_width * 2;
cover_diameter = 12;
cover_sphere_diameter = 12.5 + 0.1;


// Peg
// peg_length = 12;
peg_length = 12 - 2;
peg_diameter = 3.8 + 0.2; // (0.2mm tolerance added to exact measurement)


// Lamp

R=50; // radius of bulb
theta=64; // angle of petal tips
w=5; // width of stems
n=6; // number of petals

nub=1.85;
y=20+nub;
z1=3*nub;
z2=nub;
yU=33;
zU=28;

P=1.3*R*sqrt(2)*3/4;// position of bottom
z=27*(1-cos($t*360))/2;// vertical motion of lamp
phi1=atan2((yU-y),(zU-z1-z))-atan((yU-y)/(zU-z1));
phi2=atan2((yU-y),(zU-z2-z))-atan((yU-y)/(zU-z2));

rotation_correction = 180/(n*2);


// Branch

// Screw hole for mounting plate
// mount_plate_screw_diameter = 3.5 / print_scale;
mount_plate_screw_diameter = 3.65 / print_scale; // drill bit measures 3.6, extra 0.5 for heat expansion of PLA on UM2
// mount_plate_thickness = 50; // (height)
// mount_plate_thickness = 5.4; // (height)
mount_plate_thickness = 6.5; // (height)


// Bloom
// build_bloom_petals_thick = false; // buld petals with original thickness
build_bloom_petals_thick = true; // buld petals twice as thick in Bloom module
// enable_bulb_platform = true; // all models previous to 2014-12-06
enable_bulb_platform = false;
// bulb_pivots_tapered = false; // set to true when bulb_platform enabled
bulb_pivots_tapered = true;


// Lens

enable_platform_lens = true;
// enable_platform_lens = false; // debugging
enable_easy_mount_cropping = true;

lens_radius = 50;
lens_height = 3.275;
crop_cube_size = 100;

lens_sphere_position = -95.85+4.125; // -91.725
lens_crop_position = -48.5-13-(75/2)+1; // -98
lens_position_adjustment = 48;

lens_resolution=30;


// Bulb

// bulb_enable_support_stand = false; // Ultimaker 2
bulb_enable_support_stand = true; // Printrbot Simple Metal
// bulb_support_stand_height = 3;
bulb_support_stand_height = 2;
bulb_support_stand_width = 8;
bulb_support_stand_length = 40;

// bulb_wall_thickness_interior = 3.2 / print_scale; // ~3 walls @ shell thickness 1.2 (0.8 scale)
bulb_wall_thickness_interior = 2.4 / print_scale; // ~2 walls @ shell thickness 1.2 (0.8 scale) [Printrbot Simple Metal (2014, 2015)]
// bulb_wall_thickness_interior = 1.6 / print_scale; // ~1 walls @ shell thickness 1.2 (0.8 scale) [Ultimaker 2]

bulb_wall_thickness = (3.2 * 3) / print_scale;
// bulb_socket_gap = 2; // 1mm all around * print_scale;
bulb_socket_gap = 3;
// bulb_diameter = 80;
bulb_diameter = 78;
// bulb_diameter = 76;
// bulb_diameter = 70;
// bulb_diameter = 60;
// bulb_diameter = 120; // nice large sphere
// bulb_diameter = 160;
// bulb_diameter = 180;
// bulb_diameter = 240;
// bulb_z_offset = (bulb_diameter/2) + 14;
bulb_z_offset = (bulb_diameter/2) + 14 + 1;

bulb_sleeve_diameter = light_hole_diameter-bulb_socket_gap;
// bulb_sleeve_height = bulb_wall_thickness; // 4 (2014-11-09-1)
// bulb_sleeve_height = (3.2 / print_scale);	
bulb_sleeve_height = 5;
// bulb_sleeve_z_offset = 15; // (2014-11-09-1)
bulb_sleeve_z_offset = 15.5;

bulb_trunk_height=13.2;
bulb_trunk_upper_diameter = bulb_sleeve_diameter;
bulb_trunk_lower_diamter = bulb_trunk_upper_diameter - 10;

bulb_trunk_reinforcement_x = 14; // 0.5mm away from pivot mount points
bulb_trunk_reinforcement_y = pivot_outer_diameter;
bulb_trunk_reinforcement_z = 12;

// bulb_mount_screw_plate_height = bulb_wall_thickness - 1; 2014-11-09-1
bulb_mount_screw_plate_height = (3.2 / print_scale) - 1;
bulb_mount_screw_plate_diameter = 10;
// bulb_mount_screw_hole_diameter = pivot_thickness-1; // pivot_thickness = 4 + 0.5;
bulb_mount_screw_hole_diameter = pivot_bolt_screw_hole_diameter;

// bulb_led_wiring_access_hole_height = 30;
bulb_led_wiring_access_hole_height = 30;
// bulb_led_wiring_access_hole_diameter = bulb_sleeve_diameter-bulb_wall_thickness;
bulb_led_wiring_access_hole_diameter = 7.5;
bulb_led_wiring_access_hole_z_offset = 6;


// Piston
// piston_mount_platform_crop = true;
piston_mount_platform_crop = false;

// piston_mount_platform_screw_mount_bolt_crop = true;
piston_mount_platform_screw_mount_bolt_crop = false;

// piston_mount_platform_length = 27;
piston_mount_platform_length = 27 + 2;
piston_mount_platform_width = pivot_outer_diameter;
piston_mount_platform_height = 2.5;

// piston_rod_height = 66;
piston_rod_height = 68.5;
piston_rod_height_extension = 2.5; // height of piston extended because some printers can't handle the top curve cleanly
piston_rod_width = 4;
// piston_rod_diameter = 7.5;
// piston_rod_diameter = 8.5;
// piston_rod_diameter = 8.0 / print_scale;
piston_rod_diameter = 7.75 / print_scale;

piston_cable_run_height = 10 / print_scale;
// piston_cable_run_diamter = 10 / print_scale;
piston_cable_run_diamter = 15 / print_scale;
piston_cable_run_wall_width = 3 / print_scale;



// Rod (Connecting Rod)
connecting_rod_width = 10;
// connecting_rod_height = 3;
connecting_rod_height = 2.4;

connecting_rod_pivot_spacing = 6;

// connecting_rod_pivot_holes = 8;
connecting_rod_pivot_holes = 9;
// connecting_rod_pivot_holes = 10;

connecting_rod_length = (connecting_rod_pivot_holes) * connecting_rod_pivot_spacing;
circle_crop_position = ((connecting_rod_pivot_holes - 1) * connecting_rod_pivot_spacing)/2;

connecting_rod_length_square = (connecting_rod_pivot_holes + 1) * connecting_rod_pivot_spacing;

// connecting_rod_rotation = [0,0,90];
connecting_rod_rotation = [0,0,0];
