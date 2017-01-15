$fn=100;

supportWidth = 13 - 0.25; // To match block width used in the dispenser.

// X Axis length
armLength = 20;
armSupportLength = 2;
armHeight = 120;
armWidth = 2;

reelTubeDiameter = 12.6;

smallerMatingDiameter = 8;

// How mech space to leave between the inner and outer cylinder.
// 0.2 on UM2+ left a very tight fit.
cyinderMatingTollerance = 0.3;

module arm() {
    difference() {
        union() {
        // Fat outer cylinger.
        translate([armLength/2, 0, 0]) {
            rotate([-90,0,0]) {
                translate([0, 0, supportWidth-2]) {
                    // Create the large outside curved edge.
                    // cut hole in for contersinking M3 screw
                        cylinder(d=armLength, h=armWidth);
                }
                
                // Create a large pin then subtract a small pin
                // + tollerance to allow two ends to mate
                // to hold in place.
                difference() {
                    union() {
                        translate([0,0,armWidth]) {
                            cylinder(d=reelTubeDiameter, h=supportWidth-armWidth);
                        }
                    }
                    union() {
                        cylinder(d=smallerMatingDiameter + cyinderMatingTollerance, h=supportWidth-armWidth);
                    }
                }
            }
        }
        
        translate([0,supportWidth-2,0]) {
            cube([armLength, armWidth, armHeight]) ;
        }
        
        translate([armLength/2, 0, armHeight]) {
            rotate([-90,0,0]) {
                translate([0, 0, supportWidth-2]) {
                    cylinder(d=armLength, h=armWidth);
                }
                
                // Smaller inner mating pin
                // with hole for M3 brass inser
                difference() {
                    translate([0,0,armWidth]) { 
                        cylinder(d=smallerMatingDiameter + 0.2, h=supportWidth-armWidth);
                    }
                    cylinder(d=4.3, h=supportWidth);
                    
                }
            }
        }
    }
    union() {
        translate([armLength/2, supportWidth+0.5,0]) {
            rotate([90,0,0]) 
                // Countersink hole at top
                #cylinder(d1=6, d2=3.4, h=armWidth+1);
            }
        }
    }
}


rotate([-90,0,0]) {
    arm();
}
