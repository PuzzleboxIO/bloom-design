
// Puzzlebox Bloom
//
// component: Petals
//
// by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


module assemble_petals(){
	
// 	stand_petal1();
	stand_petal2();
	
}

module stand_petal1(){
	
	translate([0,-40,20])
	difference() {
		
		translate([0,65,40])
		assemble_petal1();
		
		translate([0,0,-70])
		cube([200, 200, 100], center=true);
	}
	
	translate([0,0,-petal_stand_height/2])
	cylinder(d=20, h=petal_stand_height, center=true);
	
}

module stand_petal2(){
	
	translate([0,-40,20])
	difference() {
		assemble_petal2();
		
		translate([0,0,-70])
		cube([200, 200, 100], center=true);
	}
	
	translate([0,0,-4/2])
	cylinder(d=20, h=4, center=true);
	
}


module assemble_petal1(){
	for(i=[1:n]){
		color([0,1,0])rotate([0,0,i*360/n])petal1();
		color([1,0,1])rotate([0,0,i*360/n])thick_petal1();
		// 		color([1,0,0])rotate([0,0,i*360/n+180/n])petal1(); // petal1's in all positions
	}
}

module assemble_petal2(){
	for(i=[1:n]){
		color([1,0,0])rotate([0,0,i*360/n+180/n])petal2();
		color([1,1,1])rotate([0,0,i*360/n+180/n])thick_petal2();
	}
}


module thick_petal2(extra_width=1)
render()
intersection(){
	difference(){
		union(){
			intersection(){
				union(){
					difference(){
						rotate([45,0,0])linear_extrude(height=2*R)scale(0.4)petal_shape();
						translate([0,-R*3/4,0])rotate([0,0,-5])translate([0,R*3/4,0])base(t=6);  // inner thickness
					}
// 					translate([0,-45,0])rotate([15,0,0])cube([w,20,150],center=true);  // stem
				}
// 				translate([0,-R*3/4,0])rotate([0,0,-5])translate([0,R*3/4,0])base(t=5);
				translate([0,-R*3/4-extra_width,0])rotate([0,0,-5])translate([0,R*3/4,0])base(t=5);
			}
			translate([0,-25,25-P])cube([w,25,50],center=true);
		}
		base(t=9);
		translate([0,-y,z2-P])joint();
		translate([0,-yU,zU-P])rotate([atan((yU-y)/(zU-z2))-90,0,0])
		slot(L=sqrt((yU-y)*(yU-y)+(zU-z2)*(zU-z2))-(yU-y));
	}
	base(t=0);
}


module thick_petal1(extra_width=1)
render()
difference(){
	intersection(){
		difference(){
			rotate([100,0,0])linear_extrude(height=2*R)scale(0.55)petal_shape();
			translate([0,-R,0])rotate([0,0,4])translate([0,R,0])base(t=1); // inner thickness of petal
		}
		translate([0,-R-extra_width,0])rotate([0,0,4])translate([0,R,0])base(t=0); // outer petal crop
	}
}

