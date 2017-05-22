$fn=100;


include <Common.scad>;

supportWidth = (blockWidth * numberOfBlocksWide) - 0.25; // To match block width used in the dispenser.

// X Axis length
armLength = 20;
armSupportLength = 2;
armHeight = 120;
armWidth = 1;

reelTubeDiameter = 12.6;

smallerMatingDiameter = 8;

// How mech space to leave between the inner and outer cylinder.
// 0.2 on UM2+ left a very tight fit.
cylinderMatingTollerance = 0.4;

// How much to redice the height of the end cylinders to ensure one fits fully in the other
cylinderHeightTollerence = 2;

module arm() {
    difference() {
        union() {
            // Fat outer cylinger.
            translate([armLength/2, 0, 0]) {
                translate([0, 0, 0]) {
                    // Create the large outside curved edge.
                    // cut hole in for contersinking M3 screw
                        cylinder(d=armLength, h=armWidth);
                }
                
                // Create a large pin then subtract a small pin
                // + tollerance to allow two ends to mate
                // to hold in place.
                
                translate([0,0,0])  {
                    difference() {
                        union() {
                          cylinder(d=reelTubeDiameter, h=supportWidth -cylinderHeightTollerence);
                        }
                    
                        union() {
                            translate([0,0,armWidth]) {
                                cylinder(d=smallerMatingDiameter + cylinderMatingTollerance, h=supportWidth - cylinderHeightTollerence +1);
                            }
                        }
                    }
                }
            }

            
            // Main body
            translate([0,0, supportWidth-armWidth,0]) {
                cube([armLength, armHeight, armWidth]) ;
            }
            
            // Small cylinder end
            translate([armLength/2, armHeight,0]) {
                    translate([0, 0, 0]) {
                       cylinder(d=armLength, h=armWidth);
                    }
                    
                    // Smaller inner mating pin
                    // with hole for M3 brass inser
                    // Keep this short to reduce the maiting surface
                    // area when connected to the fatter cylidner
                    // otherwise it's difficult to seperate
                    smallCylinderHeight = (blockWidth);
                    translate([0,0,0]) { 
                        difference() {
                            union() {
                                translate([0,0,0]) { 
                                cylinder(d=smallerMatingDiameter + 0.2, h=smallCylinderHeight-cylinderMatingTollerance);
                                }
                            }
                            union() {
                                translate([0,0,armWidth]) { 
                                    #cylinder(d=4.3, h=smallCylinderHeight );
                                }
                            }
                        }
                        
                    }
            }
        }
        union() {
            translate([armLength/2, 0, -0.5]) {
                    // Countersink hole at top
                    cylinder(d1=6, d2=3.4, h=armWidth+1);
                    // Ensure the hole runs all the way through
                    cylinder(d=3.4, h=supportWidth+1);
            }
        }
    }
}


//rotate([-90,0,0]) {
    arm();
//}
