$fn=80;

supportLength = 190; // baseLength = 70 + 60 +20 + 40;
supportWidth = 13; // To match block width used in the dispenser.


// X Axis length
riserLength = 20;
riserSupportLength = 2;
riserHeight = 150;
riserWidth = 2;

reelTubeDiameter = 12.6;

ledHoleX = 67; 
// 2mm offset because of support wall.
tapeWallWidth = 2;
// 1.5mm offset because that's the offset on the tape.
tapeHoleOffset = 1.5; // mm


module screwHole(xPosition) {
    translate([xPosition,supportWidth/2, -0.1]) {
        // 4.2mm for M3 heat inserts.
        #cylinder(d=4.2, h=20);
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
            cube([supportLength, supportWidth, 10]);
            
            translate([(supportLength - riserLength)/2, 0, 12]) {
                translate([riserLength/2, 0, 0]) {
                    rotate([-90,0,0]) {                
                        cylinder(d=20, h=supportWidth);
                    }
                }
            }
        
        } 
        union() {
            // Holes to mount it - try and match that of the dispenser
            screwHole(10);
            screwHole(60);
            screwHole(110);
            screwHole(160);
            
            // Hole for the riser thingy.
            translate([(supportLength - riserLength)/2, 0, 12]) {
                translate([riserLength/2, 0, 0]) {
                    rotate([-90,0,0]) {                
                        #cylinder(d=reelTubeDiameter+0.5, h=supportWidth);
                    }
                }
            }
            
            // Put the arm on the left where we typically 
            // have the excess space on the reel
            // 8mm tape + 2mm offset on right
            // -> 5mm exces.
            // Remove material to allow the riser to slot in.
            translate([(supportLength)/2 , supportWidth , 12]) {
                //cube([40, 2, 25]);
                rotate([90,0,0]) {
                    cylinder(d=40, h=2);
                }
            }
            
            ledHole();
            tapeEnterance();
        }
    }
}

smallerMatingDiameter = 8;

module riser() {
    difference() {
        union() {
        // Fat outer cylinger.
        translate([riserLength/2, 0, 0]) {
            rotate([-90,0,0]) {
                translate([0, 0, supportWidth-2]) {
                    // Create the large outside curved edge.
                    // cut hole in for contersinking M3 screw
                        cylinder(d=riserLength, h=riserWidth);
                }
                
                // Create a large pin then subtract a small pin
                // + tollerance to allow two ends to mate
                // to hold in place.
                difference() {
                    union() {
                        translate([0,0,riserWidth]) {
                            cylinder(d=reelTubeDiameter, h=supportWidth-riserWidth);
                        }
                    }
                    union() {
                        cylinder(d=smallerMatingDiameter + 0.2, h=supportWidth-riserWidth);
                    }
                }
            }
        }
        
        translate([0,supportWidth-2,0]) {
            cube([riserLength, riserWidth, riserHeight]) ;
        }
        
        translate([riserLength/2, 0, riserHeight]) {
            rotate([-90,0,0]) {
                translate([0, 0, supportWidth-2]) {
                    cylinder(d=riserLength, h=riserWidth);
                }
                
                // Smaller inner mating pin
                // with hole for M3 brass inser
                difference() {
                    translate([0,0,riserWidth]) { 
                        cylinder(d=smallerMatingDiameter + 0.2, h=supportWidth-riserWidth);
                    }
                    cylinder(d=4.3, h=supportWidth);
                    
                }
            }
        }
    }
    union() {
        translate([riserLength/2, supportWidth+0.5,0]) {
            rotate([90,0,0]) 
                // Countersink hole at top
                #cylinder(d1=6, d2=3.4, h=riserWidth+1);
            }
        }
}
}

module showReel() {
    
    
        translate([riserLength/2, 0, riserHeight]) {
            rotate([-90,0,0]) {                
                color("green") {
                    cylinder(d=180, h=10);
                }
            }
        }
}

// Main riser and roll cut out support.
difference() {
    union() {
        // Print these seperatly
        //base();
        
        translate([(supportLength - riserLength)/2, 0, 12]) {
            rotate([0,00]) {
                riser();
            
                //showReel();
            }
            
            /*
            translate([0,-15,0]) {
                showReel();
            }
            
            translate([0,15,0]) {
                showReel();
            }
            */
        }
    }
    union() {

    }
}