$fn=100;

include <Common.scad>;

supportLength = 190; // baseLength = 70 + 60 +20 + 40;
supportWidth = blockWidth; // To match block width used in the dispenser.
supportHeight = 10;


// X Axis length
armLength = 20;
armSupportLength = 2;
armHeight = 150;
armWidth = 2;

reelTubeDiameter = 12.6;

ledHoleX = 67; 
// 2mm offset because of support wall.
tapeWallWidth = backerWidth;


module screwHole(xPosition, nutDepth) {
echo ("nutDepth", nutDepth);
    // Screws at 13mm spacing (6.5mm from edge.
    translate([xPosition,6.5, -0.1]) {
        // 4.2mm for M3 heat inserts.
        #cylinder(d=4.2, h=supportHeight +0.2);
        
        //netDepth = 2.5;
        translate([0,0, supportHeight - nutDepth]) {
            #cylinder(d=6.5, h=nutDepth +0.2, $fn=6);
        }
    }
}

module ledHole() {
    
    ledHoleY = tapeWallWidth + tapeHoleOffset;
    echo ("ledHoldY", ledHoleY);
    
    translate([ledHoleX, ledHoleY, 0]) {
        #cylinder(d=5, h=11);
    }
}

module tapeEnterance(blockNumber) {
    
    translate([1.5 + supportWidth, 1.5, 0]) {
        #cube([20,supportWidth - 3, 11]);
    }
}


module base() {
    difference() {
        union() {
            cube([supportLength, supportWidth, supportHeight]);
            
            translate([(supportLength - armLength)/2, 0, 12]) {
                translate([armLength/2, 0, 0]) {
                    rotate([-90,0,0]) {                
                        cylinder(d=20, h=supportWidth);
                    }
                }
            }
        
        } 
        union() {
            // Holes to mount it - try and match that of the dispenser
            screwHole(10, supportHeight -3);
            screwHole(60, 2.5);
            screwHole(110, 2.5);
            screwHole(160, 2.5);
            
            // Hole for the arm thingy.
            translate([(supportLength - armLength)/2, 0, 12]) {
                translate([armLength/2, 0, 0]) {
                    rotate([-90,0,0]) {                
                        cylinder(d=reelTubeDiameter+0.5, h=supportWidth +0.2);
                    }
                }
            }
            
            // Put the arm on the left where we typically 
            // have the excess space on the reel
            // 8mm tape + 2mm offset on right
            // -> 5mm exces.
            // Remove material to allow the arm to slot in.
            translate([(supportLength)/2 , supportWidth +0.1, 12]) {
                rotate([90,0,0]) {
                    cylinder(d=40, h=armWidth + 0.1);
                }
            }
            
            translate([(supportLength)/2 , armWidth, 12]) {
                //cube([40, 2, 25]);
                rotate([90,0,0]) {
                    cylinder(d=40, h=armWidth +0.1);
                }
            }
            
            ledHole();
            tapeEnterance();
        }
    }
}

smallerMatingDiameter = 8;
// How mech space to leave between the inner and outer cylinder.
// 0.2 on UM2+ left a very tight fit.
cyinderMatingTollerance = 0.4;

/*
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
*/

/*
module showReel() {
       
    translate([armLength/2, 0, armHeight]) {
        rotate([-90,0,0]) {                
            color("green") {
                difference() {
                    cylinder(d=180, h=10);
                    cylinder(d=13, h=10.1);
                }
            }
        }
    }
}
*/


difference() {
    union() {
        // Print these seperatly
        base();
    }
    union() {
        // Shave off the blockPrinterTollerance from the furthest
        // side from the reel tape holes.
        // + 20 for the cylinder holding the arms
        translate([0,blockWidth - blockPrinterTollerance,0]) {
            #cube([supportLength,blockPrinterTollerance,supportHeight + 20]);
        }
    }
}
