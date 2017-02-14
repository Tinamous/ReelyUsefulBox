$fn = 100;

include <Common.scad>;

// How big or small of a hole to make for the light to come through
// This is printed on its side so allow for printer filament to run in.
tapeHoleSize = 2; // mm - hole side to use for the tape hole light.

// How far before the main block the hole for tape sensing should be.
tapeHoleOffsetFromBlock = 3;

// This should match the roll over block height
// excludes the tape gap.
bodyHeight = 14;
echo("bodyHeight",bodyHeight);

// How long on the x axis this is.
// From Dispenser.
// blockXOffset = 70;
//length = 102; block offset is 87mm
length = blockXOffset - 1; //86; // Or 85?

echo("blockWidth",blockWidth);
actualWidth = blockWidth * numberOfBlocksWide;

// This is 0.5mm less than the main dispenser so that
// the tape doesn't hit as it enters the dispenser.
tapeGap = smdTapeGap +1; // - 0.5;

usePinMount = true;


// Tape Width MUST be set appropriatly
// for numberOfBlocksWide>1 it is assumed this is for
// wide tape and not just to make n blocks in one go.
// Hence tapeWidth must be set for the tap to ensure
// the tape is guided properly.
module cutoutTapePath() {
    // Fattest part is on the right y=0)
    translate([-0.1,blockWidth - (backerWidth + tapeWidth),-0.1]) {
        //#cube([length+1.2, tapeWidth, tapeGap+0.2]);
    }
    
echo ("blockWidth=",blockWidth);
echo ("backerWidth=",backerWidth);
echo ("tapeWidth=",tapeWidth);
echo ("Left offset=",blockWidth - (backerWidth + tapeWidth));
    
    // Put a very slight angle on the block so that the tape comes out
    // at a lower height than would be expected for the smdTapeGap
    // in the dispenser block - so it shouldn't get stuck when feeding through.
    translate([-0.1,actualWidth - (backerWidth + tapeWidth),0]) {
        rotate([0,1,0]) {
            #cube([length+0.1, tapeWidth, tapeGap]);
        }
        //translate([0,blockWidth - backerWidth ,0]) {
    }
}

module cutoutMultiTapePath() {
    // Put a very slight angle on the block so that the tape comes out
    // at a lower height than would be expected for the smdTapeGap
    // in the dispenser block - so it shouldn't get stuck when feeding through.
    
    for (rep = [1 : numberOfBlocksWide]) {
        width = blockWidth * rep;
        translate([-0.1,width - (backerWidth + tapeWidth),0]) {
            rotate([0,1,0]) {
                #cube([length+0.1, tapeWidth, tapeGap]);
            }
            //translate([0,blockWidth - backerWidth ,0]) {
        }
    }
}
   
// Make a sticky out pointy thing for mounting to the 
// dispenser block.
module mountingPoint() {
    
        // No repetition for multiblocks.
        // Fixed at 7mm up
        translate([length - 0.1, 4, 7]) {
            rotate([0,90,0]) {
                // Component counter mount hole
                // Hole is 4.2mm
                cylinder(d1=4, d2=3.4,  h=4);
            }
    }
}

// Use either this or the mounting point
module horizontalMountingHole() {
// Horizontal hole.
// 20mm screw. 5mm into nut leaves 15mm in the body.
// Don't make shorter as this 
screwHeadDepth = length - 15;
    
    translate([-0.1, 4, 10/2 + smdTapeGap]) {
        rotate([0,90,0]) {
            // Component counter mount hole
            cylinder(d=3.8, h=length+0.2);
            // Screw head sink in.
            cylinder(d=7, h=screwHeadDepth);
        }
    }
}

// Holes for the module to be mounted onto the dispenser.    
module mountingHole() {

    // Needs to be addeed.
    //mountingPoint();
    
    // If used, needs to be subtracted.
    if (!usePinMount) {
        horizontalMountingHole();
    }
    
    // All vertical holes are on a 13mm pitch
    // so 6.5 from edge.
    // Dispenser first hole is 10mm in.
    translate([10, 6.5, 0]) {
       cylinder(d=4.2, h=bodyHeight);
    }

    // Add a cutout for the screw head.
    // Sink it right in otherwise we need a long screw.
    // as it has to go through the 5mm of the dispenser
    // and the 10mm of the rool holder top.
    translate([10, 6.5, tapeGap + 1.5]) {
        //   
       cylinder(d=7, h= bodyHeight);
    }
}

module lightSensorHole() {
    translate([0,0,0]) {
        translate([70 - tapeHoleOffsetFromBlock, blockWidth - backerWidth - tapeHoleOffset,-0.1]) {
            // Small hole all the way up
            // Tape hole is about 1.75 with 4mm spacing
            cylinder(d=1.25, h=bodyHeight - tapeGap + 0.2);
            
            // Bigger hole at top for the sensor to be pushed into
            // Add 0.3mm on to allow for Form2 tight fit.
            // 3mm worked well for UM PLA.
            translate([0,0, tapeGap + 2]) {
                cylinder(d=3 + 0.3, h=bodyHeight - tapeGap);
            }
            
            // And an even bigger hole for the wide part of the sensor.
            // so that the PCB can sit flush onto the block.
            // LED body length is about 5-6 mm.
            // Allow 1mm only for the top part.
            translate([0,0,bodyHeight - 1]) {
                cylinder(d=6, h= 2);
            }
        }
    }
}

module pcbMountingHoles() {
    
    // Just do the one mounting hole as the LED/diode is already a mounting point.
    // 
screwHoleDepth = 4;
// PCB has LED at 3mm offset
// however it's actually 3.25 (1.5mm backerWidth wall))
// or 3.75 if we use a 2mm backerWidth wall
// So move the mounting hole so that the distance between the LED hole
// and the mouting hole are the same.
pcbLedOffsetFudge = 0.25;
        
    translate([20,6.5 - pcbLedOffsetFudge,0]) {
        //#cylinder(d=8, h= bodyHeight - screwHoleDepth);
        // 6.5 is a little tight for the nut.
        cylinder(d=6.6, h= bodyHeight - screwHoleDepth, $fn=6);
        cylinder(d=4.5, h= bodyHeight + 0.1);
    }
    
    /*
    translate([50,6.5 - pcbLedOffsetFudge,0]) {
        //#cylinder(d=8, h= bodyHeight - screwHoleDepth);
        cylinder(d=6.6, h= bodyHeight - screwHoleDepth, $fn=6);
        cylinder(d=4.5, h=bodyHeight + 0.1);
    }
    */
}

// 
module pcbPinsCutouts() {
    
    // Remove space for the display pins to protrude through
    // blocks.
    
    // 3mm In.
    translate([0, 0, bodyHeight-2]) {
        cube([6,blockWidth,2.1]);
    }
    
    // 84mm In.
    translate([81, 0, bodyHeight-3]) {
        cube([6,blockWidth,3.1]);
    }
    
    // Remove space for the OSH LED. This is only needed on the middle 2 
    // blocks.
    oshLedXPosition=73; //mm
    translate([oshLedXPosition-2, 0, bodyHeight-2]) {
        cube([4,blockWidth,2.1]);
    }
}

difference() {
    union() {
        // Main block body.
        cube([length, actualWidth, bodyHeight]);
        
        if (usePinMount) {
            
            if (repeatTape) {
                // repeat pins might cause problems for tollerance.
                for (rep = [0 : numberOfBlocksWide -1]) {    
                    repYOffset = rep * 13;
                    translate([0,repYOffset,0]) {
                        mountingPoint();
                    }
                }
            } else {
                mountingPoint();
            }
        }
    }
    union() {
        if (repeatTape) {
            cutoutMultiTapePath();
        } else {
            cutoutTapePath();
        }
        

        // Repeat the cutouts for as many 
        // repeats of the block width we are making
        // For tape wider than 10mm we need a double
        // or bigger block width whilst keeping the same
        // holes.
        for (rep = [0 : numberOfBlocksWide -1]) {    
            repYOffset = rep * 13;
            translate([0,repYOffset,0]) {
                mountingHole();
                
                // Always repeat light sensor as the 
                // PCB may have the sensor fitted and would 
                // need the hold.
                lightSensorHole();
                
                pcbMountingHoles();
                
                pcbPinsCutouts();
            }
        }
        
        // Shave off the blockPrinterTollerance from the furthest
        // side from the reel tape holes.
        #cube([length,blockPrinterTollerance,bodyHeight]);
    }
}