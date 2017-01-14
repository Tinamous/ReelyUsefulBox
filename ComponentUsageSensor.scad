$fn = 100;

include <Common.scad>;


// gap for the film to wrap back around
smtTapeTopGap = 1; 

// How far from the edige the hole in the tap is.
tapeHoleOffset = 2; // mm

// How big or small of a hole to make for the light to come through
// This is printed on its side so allow for printer filament to run in.
tapeHoleSize = 2; // mm - hole side to use for the tape hole light.

// How far before the main block the hole for tape sensing should be.
tapeHoleOffsetFromBlock = 3;

// This should match the roll over block height
// excludes the tape gap.
bodyHeight = 18 - smdTapeGap;

// How long on the x axis this is.
// From Dispenser.
// blockXOffset = 70;
//length = 102; block offset is 87mm
length = blockXOffset -1; //86; // Or 85?

// This is 0.5mm less than the main dispenser so that
// the tape doesn't hit as it enters the dispenser.
tapeGap = smdTapeGap +1; // - 0.5;

module cutoutTapePath() {
    // Fattest part is on the right y=0)
    translate([-0.1,blockWidth - (backerWidth + tapeWidth),-0.1]) {
        //#cube([length+1.2, tapeWidth, tapeGap+0.2]);
    }
    
    // Put a very slight angle on the block so that the tape comes out
    // at a lower height than would be expected for the smdTapeGap
    // in the dispenser block - so it shouldn't get stuck when feeding through.
    translate([-0.1,blockWidth - (backerWidth + tapeWidth),0]) {
        rotate([0,1,0]) {
            cube([length+0.1, tapeWidth, tapeGap]);
        }
        //translate([0,blockWidth - backerWidth ,0]) {
    }
}

// Not used now.
module addRails() {
    translate([0,0,0]) {
        
        cube([length, blockWidth - (backerWidth + tapeWidth), tapeGap]);

        translate([0,blockWidth - backerWidth ,0]) {
            
            
            cube([length, backerWidth, tapeGap]);
        }
    }
}
    

// Holes for the module to be mounted onto the dispenser.    
module mountingHole() {
// Horizontal hole.
// 20mm screw. 5mm into nut leaves 15mm in the body.
screwHeadDepth = length - 4;
    
    translate([-0.1, 4, 10/2 + tapeGap]) {
        rotate([0,90,0]) {
            // Component counter mount hole
            cylinder(d=3.8, h=length+0.2);
            // Screw head sink in.
            cylinder(d=7, h=screwHeadDepth);
        }
    }
    
    // All vertical holes are on a 13mm pitch
    // so 6.5 from edge.
    // Dispenser first hole is 10mm in.
    translate([10, 6.5, 0]) {
       #cylinder(d=4.2, h=bodyHeight);
    }
    
    // Add a cutout for the screw head.
    // Sink it right in otherwise we need a long screw.
    // as it has to go through the 5mm of the dispenser
    // and the 10mm of the rool holder top.
    translate([10, 6.5, tapeGap + 1.5]) {
        //   
       #cylinder(d=7, h= bodyHeight);
    }
}

module lightSensorHole() {
    translate([70 - tapeHoleOffsetFromBlock,blockWidth - backerWidth - tapeHoleOffset ,-0.1]) {
        // Small hole all the way up
        cylinder(d=2, h=bodyHeight + tapeGap + 0.2);
        
        // Bigger hole at top for the sensor to be pushed into
        translate([0,0,6]) {
            cylinder(d=3, h=bodyHeight + tapeGap + 0.2);
        }
        
        // And an even bigger hole for the wide part of the sensor.
        // so that the PCB can sit flush onto the block.
        translate([0,0,bodyHeight-2]) {
            #cylinder(d=6, h=2 + 0.2);
        }
    }
}

module pcbMountingHoles() {
    
screwHoleDepth = 6;
    translate([20,6.5,0]) {
        #cylinder(d=8, h= bodyHeight - screwHoleDepth);
        #cylinder(d=4.5, h= bodyHeight + 0.1);
    }
    
    translate([50,6.5,0]) {
        #cylinder(d=8, h= bodyHeight - screwHoleDepth);
        #cylinder(d=4.5, h=bodyHeight + 0.1);
    }
}

// 
module pcbPinsCutouts() {
    
    // Remove space for the display pins to protrude through
    // blocks.
    
    translate([0, 0, bodyHeight-3]) {
        #cube([6,blockWidth,3]);
    }
    
    // Remove space for the OSH LED. This is only needed on the middle 2 
    // blocks.
    oshLedXPosition=73; //mm
    translate([oshLedXPosition-2, 0, bodyHeight-2]) {
        #cube([4,blockWidth,2]);
    }
}


    
difference() {
    union() {
        // rails for the tape to run through
        //addRails();
        
        // Main block body.
        translate([0,0,0]) {
            cube([length, blockWidth, bodyHeight]);
        }
    }
    union() {
        cutoutTapePath();
        
        mountingHole();
        lightSensorHole();
        
        pcbMountingHoles();
        
        pcbPinsCutouts();
    }
}