$fn=80;

supportLength = 190; // baseLength = 70 + 60 +20 + 40;
supportWidth = 13; // To match block width used in the dispenser.


// X Axis length
riserLength = 18;
riserSupportLength = 10;
riserHeight = 90;

reelTubeDiameter = 12.6;

module screwHole(xPosition) {
    translate([xPosition,supportWidth/2, -0.1]) {
        // 4.2mm for M3 heat inserts.
        #cylinder(d=4.2, h=20);
    }
}

difference() {
    union() {
        cube([supportLength, supportWidth, 10]);
    } 
    union() {
        // Holes to mount it - try and match that of the dispenser
            screwHole(10);
            screwHole(60);
            screwHole(110);
            screwHole(160);
    }
}

// Main riser and roll cut out support.
difference() {
    union() {
        translate([(supportLength - riserLength)/2, 0, 10]) {
            cube([riserLength, supportWidth, riserHeight]) ;
        }
        
        translate([(supportLength )/2, 0, riserHeight + 10]) {
            rotate([270,0,0]) {
                cylinder(h=supportWidth, d=riserLength);
            }
        }
        
        translate([(supportLength )/2 - 29, 0, 10]) {
                cube([60, supportWidth, 20]);
        }
    }
    union() {
        
        // Cut out sections to give a nice curved transition
        // between the top and the rod support.
        translate([(supportLength )/2 - 29, -1, 30]) {
            rotate([270, 0, 0]) {
                cylinder(d=40, h=supportWidth+2);
            }
        }
        
        translate([(supportLength )/2 + 29, -1, 30]) {
            rotate([270, 0, 0]) {
                cylinder(d=40, h=supportWidth+2);
            }
        }
        
        
        // Opening to drop tube into
        translate([(supportLength )/2 - (reelTubeDiameter/2), 0, riserHeight-20]) {
            cube([22,5.1,20]);
        }
        
        translate([(supportLength )/2 - (reelTubeDiameter/2), supportWidth - 5.1, riserHeight-20]) {
            cube([22,5.1,20]);
        }
        
        // Path for tube to drop down to end.
        translate([(supportLength )/2 - (reelTubeDiameter/2), 0, riserHeight-20]) {
            cube([reelTubeDiameter,5,30]);
        }
        
        
        translate([(supportLength )/2 - (reelTubeDiameter/2), supportWidth - 5, riserHeight-20]) {
            cube([reelTubeDiameter,5,30]);
        }
            
        
        // Circles to hold the rod in place
        translate([(supportLength )/2, 0, riserHeight + 10]) {
            rotate([270,0,0]) {
                cylinder(h=5, d=reelTubeDiameter);
            }
            
        }
        
        translate([(supportLength )/2, supportWidth - 5, riserHeight + 10]) {
            rotate([270,0,0]) {
                cylinder(h=5, d=reelTubeDiameter);
            }
            
        }
    }
}

// Support for opening to allow it to be printed.
translate([(supportLength )/2 + 6, supportWidth/2, riserHeight-6.5]) {
    rotate([45, 0,0]) {
        cube([3, 9, 9]);
    }
}


// Support arms for main riser 

translate([35, 0, 10]) {
    rotate([0,30,0]) {
       // cube([riserSupportLength, supportWidth, 105]) ;
    }
}

rotate([0,0,180]) {
    translate([-150, -12, 10]) {
        rotate([0,30,0]) {
            //cube([riserSupportLength, supportWidth, 105]) ;
        }
    }
}