$fn=100;

include <Common.scad>;

supportLength = 190; // baseLength = 70 + 60 +20 + 40;
supportWidth = blockWidth * numberOfBlocksWide; // To match block width used in the dispenser.
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

module screwHoles() {
    for (rep = [1 : numberOfBlocksWide]) {
        //repYOffset = i * 13;
        translate([0,blockWidth * (rep -1),0]) {
            
            // Holes to mount it - try and match that of the dispenser
            screwHole(10, supportHeight -3);
            screwHole(60, 2.5);
            screwHole(110, 2.5);
            screwHole(160, 2.5);
        }
    }
}

module ledHole() {
    
    for (rep = [0 : numberOfBlocksWide -1]) {
        ledHoleY = tapeWallWidth + tapeHoleOffset + (rep * blockWidth);
        echo ("ledHoldY", ledHoleY);
        echo ("ledHoldX", ledHoleX);
        
        translate([ledHoleX, ledHoleY, -1]) {
            cylinder(d=5, h=12);
        }
    }
}

module tapeEnterance(blockNumber) {
tapeCutoutLength = 25;    
tapeCutoutDepth = supportHeight;
tapeCutoutWidth = supportWidth - 3;
    
    translate([14.5, backerWidth, 0]) {
        difference() {
            union() {
                cube([tapeCutoutLength,tapeCutoutWidth, tapeCutoutDepth + 0.1]);
            }
            union() {
                translate([tapeCutoutLength, 0, tapeCutoutDepth/2]) {
                    rotate([-90,0,0]) {
                        cylinder(d=tapeCutoutDepth, h=tapeCutoutWidth);
                    }
                }
            
            }
        }
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
            screwHoles();
            
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



difference() {
    union() {
        base();
    }
    union() {
        // Shave off the blockPrinterTollerance from the furthest
        // side from the reel tape holes.
        // + 20 for the cylinder holding the arms
        translate([0,supportWidth - blockPrinterTollerance,0]) {
            #cube([supportLength,blockPrinterTollerance,supportHeight + 20]);
        }
    }
}
