// Puzzlebox Bloom
//
// component: Mount
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0
//
// source credit: "Arduino OpenSCAD mounting library (v2.0)" by Kelly Egan [https://github.com/kellyegan/OpenSCAD-Arduino-Mounting-Library]
// source credit: "Pin Connectors V3" by Tony Buser and Emmett Lalish [http://www.thingiverse.com/thing:33790]


// Libraries
use <../library/Pin_Connectors_V3/pins.scad>
include <../library/OpenSCAD-Arduino-Mounting-Library/arduino.scad>


module assemble_mount(){
	
	// 	mockup_microcontroller();
	
	// 	mount();
	
	// 	mount_pin();
	
	// 		mount_tapped();
	mount_tapped(r = mountingHoleRadius+0.4);
	
	// 	mount_pinhole();
	
}


module mount(){
	union() {
		standoffs(boardType=LEONARDO, height=mount_height, mountType=TAPHOLE);
		boardShape(boardType=LEONARDO, offset = 3);
	}
}


module mount_pin(){
	union() {
		standoffs(boardType=LEONARDO, height=mount_height, mountType=PIN);
		boardShape(boardType=LEONARDO, offset = 3);
	}
}


module mount_tapped(r=mountingHoleRadius+0.2){
	difference(){
		union() {
			// 			standoffs(boardType=LEONARDO, height=mount_height, holeRadius=mountingHoleRadius ,mountType=TAPHOLE);
			standoffs(boardType=LEONARDO, 
				 height=mount_height, 
				 topRadius = mountingHoleRadius + 1+1*1.5, 
				 bottomRadius =  mountingHoleRadius + 2+1*1.5, 
				 holeRadius=mountingHoleRadius ,mountType=TAPHOLE);
			
			boardShape(boardType=LEONARDO, offset = 3, mountType=PIN);
			
		}	
		holePlacement(boardType = LEONARDO)
		translate([0, 0, -0.01])
		// 		cylinder( h=pcbHeight + 3 + 1.02, r = mountingHoleRadius );
		cylinder( h=pcbHeight + 3 + 1.02, r = r );
	}
}


module mount_tapped_extended(r=mountingHoleRadius+0.2){
	difference(){
		union() {
			// 			standoffs(boardType=LEONARDO, height=mount_height, holeRadius=mountingHoleRadius ,mountType=TAPHOLE);
			standoffs(boardType=LEONARDO, 
				 height=mount_height, 
				 topRadius = mountingHoleRadius + 1+1*1.5, 
				 bottomRadius =  mountingHoleRadius + 2+1*1.5, 
				 holeRadius=mountingHoleRadius ,mountType=TAPHOLE);
			
			boardShape(boardType=LEONARDO, offset = 3, mountType=TAPHOLE);
			
			translate([0,40,0])
// 			boardShape(boardType=LEONARDO, offset = 3, mountType=PIN);
// 			cube([55,40,pcbHeight]);
			cube([55,40-1,pcbHeight]);
			
		}	
		holePlacement(boardType = LEONARDO)
		translate([0, 0, -0.01])
		// 		cylinder( h=pcbHeight + 3 + 1.02, r = mountingHoleRadius );
		cylinder( h=pcbHeight + 3 + 1.02, r = r );
	}
}


module mount_tapped_stand(r=mountingHoleRadius+0.2){
	difference(){
		union() {
			standoffs(boardType=LEONARDO, 
				 height=mount_height, 
				 topRadius = mountingHoleRadius + 1+1*1.5, 
				 bottomRadius =  mountingHoleRadius + 2+1*1.5, 
				 holeRadius=mountingHoleRadius ,mountType=TAPHOLE);
			
			boardShape(boardType=LEONARDO, offset = 3, mountType=TAPHOLE);
			
			translate([0,40,0])
			cube([55,39,pcbHeight]);
			
		}
		holePlacement(boardType = LEONARDO)
		translate([0, 0, -0.01])
		cylinder( h=pcbHeight + 3 + 1.02, r = r );
		
		// Installation gutter
		if (microcontroller_mount_crop_installation_gutter) {
			translate([40.75,66.04,pcbHeight/2]){
				cube([10,r*2,pcbHeight * 2], center=true);
				
				translate([-5,0,0])
				cylinder(,h=pcbHeight+0.02, d=r*2, center=true);
			}
		}
	}
	
	
}


module mount_pinhole(){
	difference(){
		
		union() {
			// 			boardShape(boardType=LEONARDO, offset = 3, mountType=PIN);
			boardShape(boardType=LEONARDO, offset=3, height=pcbHeight);
			// 			standoffs(boardType=LEONARDO, height=mount_height, holeRadius=mountingHoleRadius ,mountType=TAPHOLE);
			// 			standoffs(boardType=LEONARDO, height=mount_height, holeRadius=mountingHoleRadius ,mountType=PIN);
			
			holePlacement(boardType=LEONARDO)
			pin_standoff(
				boardType=LEONARDO, 
				height=mount_height, 
				holeRadius=mountingHoleRadius,
				mountType=PINHOLE, 
				pinhole_height=pcbHeight+mount_height);
			
			// 				pinhole_height=pcbHeight+mount_height+3.35);
			// 			// 					  pinhole_height=pcbHeight+mount_height);
		}	
		
		holePlacement(boardType = LEONARDO)
		
		
		// NOTE pinhole()
		// h = shaft height
		// r = shaft radius
		// lh = lip height
		// lt = lip thickness
		// t = extra tolerance for loose fit
		// tight = set to false if you want a joint that spins easily
		// fixed = set to true so pins can't spin
		
		translate([0, 0, -0.01])
		// 		pinhole(h=pcbHeight + 3 + 1.02, 
		// 			pinhole(h=pcbHeight + mount_height,
		// 			pinhole(h=pcbHeight,
		pinhole(h=pcbHeight+mount_height+3.35,
				  r=mountingHoleRadius+0.1, 
			 lh=lip_height, 
			 lt=lip_thickness, 
			 t=loose, 
			 tight=true,
			 fixed=true);
		
	}
}


module pin_standoff( 
boardType = UNO, 
height = 10, 
topRadius = mountingHoleRadius + 1, 
bottomRadius =  mountingHoleRadius + 2, 
holeRadius = mountingHoleRadius,
mountType = TAPHOLE,
pinhole_height = 10 * 4
) {
	
	// 	holePlacement(boardType = boardType)
	union() {
		difference() {
			cylinder(r1 = bottomRadius, r2 = topRadius, h = height, $fn=32);
			if( mountType == TAPHOLE ) {
				cylinder(r =  holeRadius, h = height * 4, center = true, $fn=32);
			}
			if( mountType == PINHOLE ) {
				// 					cylinder(r =  holeRadius, h = pinhole_height, center = true, $fn=32);
				
				// 				pinhole(h=pcbHeight+mount_height+3.35,
				pinhole(h=pcbHeight+mount_height,
						  r=mountingHoleRadius+0.1, 
				lh=lip_height, 
				lt=lip_thickness, 
				t=loose, 
				tight=true,
				fixed=true);
				
			}
		}
		if( mountType == PIN ) {
			translate([0, 0, height - 1])
			pintack( h=pcbHeight + 3, r = holeRadius, lh=3, lt=1, bh=1, br=topRadius );
		}
	}	
}



module mount_with_mockup(){
	mockup_microcontroller();
	mount();
}


module mount_with_pin_mockup(){
	mockup_microcontroller();
	mount_pin();
}


module mockup_microcontroller(){
	translate([0,0,mount_height])
	arduino(LEONARDO);
}


// module boardShape_tappedPin( boardType = UNO, offset = 0, height = pcbHeight, holeRadius=mountingHoleRadius, mountType=TAPHOLE ) {
// 	
// 	topRadius = mountingHoleRadius + 1;
// 	bottomRadius =  mountingHoleRadius + 2; 
// 	
// 	dimensions = boardDimensions(boardType);
// 	
// 	difference(){
// 		boardShape( boardType = boardType, offset = offset, height = height );
// 		
// 		holePlacement(boardType = boardType)
// 		translate([0, 0, -0.01])
// // 			pinhole( h=pcbHeight + 3 + 1.02, r = mountingHoleRadius+1, lh=3, lt=1, bh=1, br=topRadius );
// // 			cylinder( h=pcbHeight + 3 + 1.02, r = mountingHoleRadius);
// 			cylinder( h=pcbHeight + 3 + 1.02, r = mountingHoleRadius +0.2 );
// 	}
// }
