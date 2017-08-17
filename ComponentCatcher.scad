$fn=80;

include <Common.scad>;

// The actual width of the block to be printed.
// blockWidth with a small tollerance.
echo("blockWidth",blockWidth);

actualWidth = (blockWidth * numberOfBlocksWide) - blockPrinterTollerance;
echo("actualWidth",actualWidth);


module pots() {
    cube([21,24, 26]);
}

module backer(thickness) {
    
    hull() {
        cylinder(d=30, h=thickness);

        translate([25,0,0]) {
            cylinder(d=15, h=thickness);
        }
        
        translate([5,-24,0]) {
            cylinder(d=14, h=thickness);
        }
        
        translate([22,-24,0]) {
            rotate([0, 5, 45]) {
                cube([2,15,thickness]);
            }
        }
        
        translate([-2,-54,0]) {
            cube([25,3,thickness]);
        }
    }
}

module componentReleaser () {
    difference() {
        union() {
            // main large curve
            cylinder(d=30, h=actualWidth);

            // Flat exctending back.
            translate([-45,11,0]) {
                cube([45,4,actualWidth]);
            }

            // front cylinder
            translate([25,0,0]) {
                cylinder(d=15, h=actualWidth);
            }
            
            // lower cylinder
            translate([5,-24,0]) {
                cylinder(d=14, h=actualWidth);
            }
            
            // Component collector
            translate([22,-24,0]) {
                rotate([0, 0, 45]) {
                    cube([2,15,actualWidth]);
                }
            }
            
            translate([-(32.5 + 8),3,0]) {
                cube([8,8,actualWidth]);
            }
        }
        union() {
            
            // Hollow out a bit in the main cylinder
            // to allow a rod to pass through
                        
            rotate([90,0,0]) {
                translate([-(16 + 7),actualWidth/2,-15.1]) {
                    cylinder(d=3.5, h=30);
                    
                    cylinder(d1=8, d2=3.5, h=3.5);
                }
            }
        }
    }
}


module bottomShelf() {
    // tray to hold the pot for the components
    translate([0,-54,0]) {
        translate([10,0,0]) {
            cube([30,3,actualWidth]);
        }
        translate([40,1.5,0]) {
            cylinder(d=3, h=actualWidth);
        }

        // stopper for component bottle
        translate([15,0,0]) {
            cube([3,8,actualWidth]);
        }

        // lowest cylinder to bring the tape around
        translate([5,0,0]) {
            difference() {
                cylinder(d=14, h=actualWidth);
                cylinder(d=4.2, h=actualWidth+0.1);
            }
        }
    }
}

translate([18,-51,0]) {
    //%pots();
}


difference() {
    union() {
        componentReleaser();
        backer(backerWidth);
        bottomShelf();
    }
    union() {
        translate([0,0,-0.2]) {
            cylinder(d=4.2, h=actualWidth+0.3);
            
            // Cutout for the pot
            translate([18,-51,0]) {
                cube([21,24, 26]);
            }
            
            translate([5,-54,0]) {                
                cylinder(d=4.2, h=actualWidth+0.1);
            }
        }
        
            
    }
}


