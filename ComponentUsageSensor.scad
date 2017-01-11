$fn = 100;

// Height between base and wrapper.
smdTapeGap = 2;
// gap for the film to wrap back around
smtTapeTopGap = 1; 
// How far from the edige the hole in the tap is.
tapeHoleOffset = 2; // mm
// How big or small of a hole to make for the light to come through
// This is printed on its side so allow for printer filament to run in.
tapeHoleSize = 2; // mm - hole side to use for the tape hole light.
// How far before the main block the hole for tape sensing should be.
tapeHoleOffsetFromBlock = 3;

// How thick the back (well side) support structure is
// the tape sits against this.
backerWidth = 1.5; // Was 2.
// 8mm tape + backer = 9.5mm, 
// 13mm block -> 3.5mm play on the left.
// 12mm tape + backer = 13.5 >> block width

// How wide the thing is.
blockWidth = 13;

// How much space to allow for the tape.
tapeWidth = 8.5;

// This should match the roll over block height
// in the main dispenser but allow 1.6mm for a PCB to be mounted on top.
bodyHeight = 11;

// How long on the x axis this is.
length = 30;


module addRails() {
    translate([0,0,0]) {
        cube([length, blockWidth - (backerWidth + tapeWidth),smdTapeGap]);

        translate([0,blockWidth -backerWidth ,0]) {
            cube([length, backerWidth,smdTapeGap]);
        }
    }
}
    
    
module mountingHole() {
    translate([-0.1, 4, 10/2 + smdTapeGap ]) {
        rotate([0,90,0]) {
            // Component counter mount hole
            #cylinder(d=3.8, h=length+0.2, $fn=50);
            // Screw head sink in.
            #cylinder(d=7, h=length-15, $fn=50);
        }
    }
}
module lightSensorHole() {
    translate([length - tapeHoleOffsetFromBlock,blockWidth - backerWidth - tapeHoleOffset ,-0.1]) {
        // Small hole all the way up
        cylinder(d=2, h=bodyHeight + smdTapeGap + 0.2);
        // Bigger hole at top for the sensor.
        translate([0,0,6]) {
            cylinder(d=3, h=bodyHeight + smdTapeGap + 0.2);
        }
    }
}

module pcbMountingHome() {
    translate([6,blockWidth - backerWidth - tapeHoleOffset ,-0.1]) {
        translate([0,0,4]) {
            #cylinder(d=4.5, h=bodyHeight + smdTapeGap + 0.2);
        }
    }
}


    
difference() {
    union() {
        // rails for the tape to run through
        addRails();
        
        // Main block body.
        translate([0,0,smdTapeGap]) {
            cube([length,blockWidth,bodyHeight]);
        }
    }
    union() {
        mountingHole();
        lightSensorHole();
        pcbMountingHome();
    }
}