
// Puzzlebox Bloom
//
// component: Peg (Replacement Screw and Mounting Pin)
//
// designed by Puzzlebox Productions, LLC
// http://puzzlebox.io/bloom
//
// Copyright Puzzlebox Productions, LLC (2014-2015)
//
// License: Creative Commons - Attribution - Share Alike
//          https://creativecommons.org/licenses/by-sa/3.0


module assemble_peg(){
	
	build_peg();
	
}


module build_peg(){
	
	color([0.4,0.4,0.4])
	translate([0,0,peg_length/2])
	rotate([0,180,0])
// 		cylinder(h=peg_length, d2=peg_diameter-tol, d1=peg_diameter-(tol*2), center=true);
		cylinder(h=peg_length, d2=peg_diameter, d1=peg_diameter - tol, center=true);
	
	
}
