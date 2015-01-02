
// Puzzlebox Bloom
//
// component: Pin (Replacement Screw and Mounting Pin)
//
// designed by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014-2015)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0
//
// source credit: "Pin Connectors V3" by Tony Buser and Emmett Lalish [http://www.thingiverse.com/thing:33790]


// Libraries
use <../library/Pin_Connectors_V3/pins.scad>


module assemble_pin(){
	
	assemble_mounting_pin();
	
}


module assemble_mounting_pin(){
	
	// 	pin(h=pcbHeight+mount_height,r=mountingHoleRadius/2,lh=lip_height,lt=lip_thickness,t=pin_tolerance);
	// 	pin(h=length,r=diameter/2,lh=lip_height,lt=lip_thickness,t=pin_tolerance);
	// 	pinpeg(h=length+pcbHeight+mount_height,r=diameter/2,lh=lip_height,lt=lip_thickness,t=pin_tolerance);
	// 	pinpeg(h=pcbHeight+mount_height,r=mountingHoleRadius,lh=lip_height,lt=lip_thickness,t=pin_tolerance);
	
	
	
	echo ("pcbHeight", pcbHeight);
	echo ("mount_height", mount_height);
	echo ("mountingHoleRadius", mountingHoleRadius);
	
	
	
	// V2
	// 	pinpeg(h=pcbHeight+mount_height,r=mountingHoleRadius);
	
	// 	translate([10,0,0])
	// 	pinpeg(h=5+pcbHeight+mount_height,r=mountingHoleRadius);
	
	// 	translate([20,0,0])
	// 	pinpeg(h=length,r=mountingHoleRadius);
	
	// 	translate([0,0,0])
	// 	pinpeg(h=pcbHeight *2 + 3 + mount_height, r = mountingHoleRadius, lh=3, lt=1, bh=1, br=mountingHoleRadius + 1);
	// 
	// 	
	// 	translate([-10,0,0])
	// 	pinpeg(h=pcbHeight*2 + 3 + mount_height + 1, r = mountingHoleRadius, lh=3, lt=1, bh=1, br=mountingHoleRadius + 1);
	// 
	// 	translate([-20,0,0])
	// 	pinpeg(h=pcbHeight*2 + 3 + mount_height + 2, r = mountingHoleRadius, lh=3, lt=1, bh=1, br=mountingHoleRadius + 1);
	// 
	// 	translate([-30,0,0])
	// 	pinpeg(h=pcbHeight*2 + 3 + mount_height + 4, r = mountingHoleRadius, lh=3, lt=1, bh=1, br=mountingHoleRadius + 1);
	
	
	
	
	
	// Defaults V3 demo
	translate([-20,0,0])
	pin_connectors_v3_examples();
	
	translate([80,-30,0]){
		// Test standoff
		translate([-100,0,0])
		mount_plate_standoff();
		
		// Test mount plate
		translate([-120,0,0])
		mount_plate_standoff_test();
	}
	
	
	// V3
	length = pcbHeight*2 + mount_height;
	
	
	build_pin(length=length, radius=mountingHoleRadius);
	
	translate([10,0,0])
	build_pin(length=length+3, radius=mountingHoleRadius);
	
	translate([20,0,0])
	build_pin(length=length+3*2, radius=mountingHoleRadius);
	
	translate([30,0,0])
	build_pin(length=length+3*3, radius=mountingHoleRadius);
	
	translate([40,0,0])
	build_pin(length=length+3*4, radius=mountingHoleRadius);
	
	translate([50,0,0])
	build_pin(length=length+3*5, radius=mountingHoleRadius);
	
	
	
	
	translate([0,-30,0]){
		
		translate([50,0,0])
		build_pin(length=length, radius=mountingHoleRadius);
		
		translate([40,0,0])
		build_pin(length=length+3, radius=mountingHoleRadius);
		
		translate([30,0,0])
		build_pin(length=length+3*2, radius=mountingHoleRadius);
		
		translate([20,0,0])
		build_pin(length=length+3*3, radius=mountingHoleRadius);
		
		translate([10,0,0])
		build_pin(length=length+3*4, radius=mountingHoleRadius);
		
		translate([0,0,0])
		build_pin(length=length+3*5, radius=mountingHoleRadius);
	}
	
	
	
	
	
	// 	translate([0,length/2,0])
	// 	pin(h=4,r=mountingHoleRadius,lh=lip_height,lt=lip_thickness,t=pin_tolerance, side=true);
	
	// 	pinshaft(h=length,r=mountingHoleRadius,t=pin_tolerance, side=true);
	
	// 	rotate([0,0,180])
	// 	translate([0,length/2,0])
	// 	pin(h=4,r=mountingHoleRadius,lh=lip_height,lt=lip_thickness,t=pin_tolerance, side=true);
	
}

// module pinpeg(h=20, r=4, lh=3, lt=1) {
//   union() {
//     translate([0, -h/4+0.05, 0]) pin(h/2+0.1, r, lh, lt, side=true);
//     translate([0, h/4-0.05, 0]) rotate([0, 0, 180]) pin(h/2+0.1, r, lh, lt, side=true);
//   }
// }


module pin_connectors_v3_examples(){
	
	// 	object=0;//[0:pin,1:pinpeg,2:pinhole]
	length=20;
	diameter=8;
	//Only affects pinhole
	hole_twist=0;//[0:free,1:fixed]
	//Only affects pinhole
	hole_friction=0;//[0:loose,1:tight]
	//Radial gap to help pins fit into tight holes
	pin_tolerance=0.2;
	//Extra gap to make loose hole
	loose=0.3;
	lip_height=3;
	lip_thickness=1;
	hf=hole_friction==0 ? false : true;
	ht=hole_twist==0 ? false : true;
	
	pin(h=length,r=diameter/2,lh=lip_height,lt=lip_thickness,t=pin_tolerance);
	
	translate([-20,0,0])
	pinpeg(h=length,r=diameter/2,lh=lip_height,lt=lip_thickness,t=pin_tolerance);
	
	
	translate([-40,0,0])
	pinhole(h=length,r=diameter/2,lh=lip_height,lt=lip_thickness,t=loose,tight=hf,fixed=ht);
	
	translate([-45,-25,0])
	difference(){
		translate([0,0,length/2])
		cube([diameter*2,diameter*2,length],center=true);
		pinhole(h=length,r=diameter/2,lh=lip_height,lt=lip_thickness,t=loose,tight=hf,fixed=ht);
	}
	
	
}


module mount_plate_standoff(){
	
	// 	holePlacement(boardType=LEONARDO)
	pin_standoff(
		boardType=LEONARDO, 
		height=mount_height, 
		holeRadius=mountingHoleRadius,
		mountType=PINHOLE, 
		pinhole_height=pcbHeight+mount_height);
	
	
}


module mount_plate_standoff_test(){
	
	
	difference(){
		
		union() {
			
			// 			boardShape(boardType=LEONARDO, offset=3, height=pcbHeight);
			
			translate([0,0,pcbHeight/2])
			cube([15,20,pcbHeight],center=true);
			
			
			// 			holePlacement(boardType=LEONARDO)
			// 			translate([0,0,pcbHeight])
			pin_standoff(
				boardType=LEONARDO, 
				height=mount_height, 
				holeRadius=mountingHoleRadius,
				mountType=PINHOLE, 
				pinhole_height=pcbHeight+mount_height);
			
		}	
		
		// 		holePlacement(boardType = LEONARDO)
		
		translate([0, 0, -0.01])
		pinhole(h=pcbHeight+mount_height+3.35,
				  r=mountingHoleRadius+0.1, 
			 lh=lip_height, 
			 lt=lip_thickness, 
			 t=loose, 
			 tight=true,
			 fixed=true);
		
	}
	
	
}


module build_pin(length=0, radius=mountingHoleRadius) {
	
	echo ("length", length);
	
	translate([0,length/2,0])
	pin(h=3,r=mountingHoleRadius,lh=lip_height,lt=lip_thickness,t=pin_tolerance, side=true);
	
	pinshaft(h=length,r=mountingHoleRadius,t=pin_tolerance, side=true);
	
	rotate([0,0,180])
	translate([0,length/2,0])
	pin(h=3.75,r=mountingHoleRadius-0.1,lh=lip_height,lt=lip_thickness,t=pin_tolerance, side=true);
	
}
