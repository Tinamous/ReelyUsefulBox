// See: http://www.thingiverse.com/thing:1080195
// Also http://www.thingiverse.com/thing:386738
// Also http://www.thingiverse.com/thing:1686327

// 1206 Tape = 8mm Wide
// 4mm spacing between components.
// 0805 Tape = 8mm Wide
// 0603 Tape = 8mm Wide.
// NeoPixel LED tape = 12mm Wide. (unusual).
// Reel (1206) = 10mm Wide, 180mm Diameter.

// Max width = 325 for really useful box lid.
// 325 / 13 = 25
// 325 / 14 = 23.2 (Gives 3 mm waste).
// 325 / 15 = 21.6 (10mm waste)

// Should be mounted on 5mm Acrtlic base (on top of the box)
// to allow the tape to come over the edge and out the side of the box.

$fn = 100;

include <Common.scad>;

// gap for the film to wrap back around
smtTapeTopGap = 1; 

// How big or small of a hole to make for the light to come through
// This is printed on its side so allow for printer filament to run in.
tapeHoleSize = 2; // mm - hole side to use for the tape hole light.

// How far before the main block the hole for tape sensing should be.
tapeHoleOffsetFromBlock = 3;

// The position of the LED. This is fixed.
//ledHoleX = blockXOffset - tapeHoleOffsetFromBlock;
ledHoleX = 70 - tapeHoleOffsetFromBlock;

// 70mm in the original
// Added 60 for the back extension
// 40 extra to bring the tape neear the front of the box. then
// add a hump to make it easy to pick the tape.
// and then add a bit to overlap with the front mount
// box filler thingy
baseLength = 70 + 60 +20 + 40 + 9;
echo ("baseLength", baseLength);

baseHeight = 5;
echo ("baseHeight", baseHeight);


// The actual width of the block to be printed.
// blockWidth with a small tollerance.
echo("blockWidth",blockWidth);

actualWidth = blockWidth * numberOfBlocksWide;
echo("actualWidth",actualWidth);

// Nice long length so the Dymo label tape
// fits on reasonably well.
tapeTopBlockLength = 40;

// Add a marker (or cover around the enterance hole to meet
// the reel holder
module enteranceMarker() {
// How thick the plastic lid is on the box.
lidPlasticThickness = 3;
// was 20, but with curve it's now 25
tapeEntrySquareLength = 25; // from reel holder
    // Reel holder hole is 14.5mm in.
    translate([15 - 2, 0,-lidPlasticThickness]) {
        // Make a 1.5mm border
        difference() {
            union() {
                cube([tapeEntrySquareLength+2+2,actualWidth ,lidPlasticThickness]);
            }
            union() {
                translate([2, 0, 0]) {
                    cube([tapeEntrySquareLength, actualWidth  - backerWidth,lidPlasticThickness]);
                }
            }
        }
    }
   
}

module enteranceCurve() {
    // Add on the cylinder for the tape to roll over.
    // Use a 1/4 pie shape.
    difference() {
        union() {
            // 15mm start + 25mm hole l
            translate([40 + 5, 0, 0]) {
                rotate([-90,0,0]) {
                    cylinder(r=baseHeight, h=actualWidth);
                }
            }
        }
        union() {
            // Slice off the bottom half of the cylinder
            translate([40 + 5 - baseHeight, 0, -baseHeight]) {
               cube([baseHeight*2, actualWidth  , baseHeight]);
            }
        }
    }
}

module enteranceCutout() {
    translate([37, -0.01, 0]) {
        cube([8,actualWidth  - backerWidth,baseHeight+0.01]);
    }
    
    
    translate([19,-0.01,-6]) {
        rotate([0,-14,0]) {
            translate([0,0,0]) {
                translate([0,0 , 0]) {
                    cube([25,actualWidth  - backerWidth,6]);
                }
            }
        }
    }
}

module exitRamp() {
    // 116 offset from the front of the block
    // is about 10 1206 components.
    // TODO: Compute it better!
    translate([163+9,0,-5]) {
        rotate([0,-7,0]) {
            translate([0,0,5]) {
                cube([28,actualWidth,5]);
            }
        }
    }
}

module screwHole(xPosition, yPosition) {
    // Screws at 13mm spacing (6.5mm from edge.
    translate([xPosition, yPosition, -0.1]) {
        cylinder(d=3.4, h=baseHeight + 0.2);
        
        // And countersink it...
        translate([0,0, baseHeight  + 0.1 - 3]) {
            cylinder(d1=3.4, d2=6, h=3.2);
        }
    }   
}


module screwHeadHole(xPosition, yPosition) {
    // Screws at 13mm spacing (6.5mm from edge.
    // 15mm -> 7.5
    translate([xPosition,yPosition, -0.1]) {
        cylinder(d=7, h=2.5);
    }   
}


module screwHoles() {
    yPosition = blockWidth/2;
    echo("Screw hole Y Offset = ", yPosition);
    
    // 50mm gaps between holes with a 10mm offset to start.
    screwHole(10, yPosition);
    // Hollow this out for the screw to be underneath - this holds the LEDs
    // and the nuts are not captive.
    screwHeadHole(60, yPosition);
    // Hollow this out for the screw to be underneath.
    screwHeadHole(110, yPosition);
    screwHole(160, yPosition);
}


module ledCounterHole() {
    
    for(rep =  [1 : numberOfBlocksWide]) {
        // Move to the far edge
        // Then move in by xmm for the tape hole position
        echo("blockWidth", blockWidth);
        echo("tapeHoleOffset ", tapeHoleOffset );
        echo("backerWidth", backerWidth);
        echo("Led Hole X", ledHoleX);
        ledHoleY = (blockWidth * rep) - (tapeHoleOffset + backerWidth);
        echo("Led Hole Y (from Left)", ledHoleY);
        
        
        ledHoleYRight = tapeHoleOffset + backerWidth;
        echo("Led Hole Y (from Right - reference))", ledHoleYRight);
        
        translate([ledHoleX,ledHoleY, -0.1]) {
            cylinder(d=1.5, h=baseHeight+0.2);
                        
            // Hollow out xmm (3) for a 3mm LED to be inserted
            // Expect this will be glued or on a PCB
            // so allow a tollerance.
            cylinder(d=3, h=baseHeight-1.5);
            
        }
    }
}


// Hole for a pin to be placed through the tape
// to pin it in place.
module tapePinHole() {
    
    for(rep =  [1 : numberOfBlocksWide]) {
        // Move to the far edge
        // Then move in by xmm for the tape hole position
        ledHoleY = (blockWidth * rep) - (tapeHoleOffset + backerWidth);
        
        translate([156,ledHoleY, -0.1]) {
            #cylinder(d=1.5, h=baseHeight+0.2);           
        }
    }
}

// Add a side wall to help heep the tapes separeted
// and if components escape to keep them with in the correct lane.
// create little markers down one edge to indicate 10 components.
module addMiniSideWall() {
    translate([blockXOffset + 28 ,actualWidth-backerWidth, 0]) {
        cube([83, backerWidth, baseHeight + 3.5 ]);
    }
}

module filmRemovalBlock() {
echo ("blockXOffset", blockXOffset);
    
    // Small cube to provide an alignment/locking mechanism
    // for the back blocks that go over the back tapes
    translate([blockXOffset-8, actualWidth - backerWidth , 5 ]) {
        // No more than 10mm height due to display pins.
        rotate([0,45,0]) {
        cube([6, backerWidth, 16]);
        }
    }
    
    translate([0, actualWidth - backerWidth , 5 ]) {
        cube([blockXOffset, backerWidth, smdTapeGap]);
    }
    

    // Block for film to curve over.
    translate([blockXOffset,0, 5 + smdTapeGap ]) {
            
        difference() {
            union() {
                // Block right on top of the tape.
                cube([tapeTopBlockLength, actualWidth, 10]);
                
                translate([tapeTopBlockLength,actualWidth, 10/2 ]) {
                    rotate([90,0,0]) {
                        cylinder(d=10, h=actualWidth);
                        translate([0, 0, actualWidth]) {
                            // Pin
                            // // Drop this as it makes 
                            // changing these blocks difficult and 
                            // doesn't print well.
                            //cylinder(d=3.0, h=2);
                        }
                    }
                }
                
                // Raised back to push the film upwards. 
                cube([5.5, actualWidth, 12.50]);
                cube([3, actualWidth, 17.5]);
                
                // Curved top
                translate([1.5, 0, 17.5]) {
                    rotate([-90,0,0]) {
                            // Pin hole.
                        cylinder(d=3, h=actualWidth, $fn=100);
                    }
                }
            }
            union() {
                translate([tapeTopBlockLength,(actualWidth) +0.1, 10/2 ]) {
                    rotate([90,0,0]) {
                        // Pin hole.
                        //cylinder(d=4.5, h=actualWidth + 0.2, $fn=100);
                    }
                }
                
                /*
                // Replaced by the small rectangle key sticking out from the back
                // to provide alignment for the read block to drop onto
                // this makes the second part easier to print.
                
                // Create a hole in the back to allow the tape counter to be screwed on
                // M3 insert 
                // Insert should be 9mm from fixed edge.
                // this is referenced from the other edge.
                // repeated for each of the blocks so that
                // a multi-pin counter can be used.
                for(rep =  [1 : numberOfBlocksWide]) {
                    insertPosition = (blockWidth * rep) - 9;
                    // Z is relative to the tape gap
                    // however hole needs to be at fixed point.
                    // 7mm up from the top of the dispenser
                    translate([-0.1, insertPosition, 7 - smdTapeGap]) {
                        rotate([0,90,0]) {
                            // Component counter mount hole
                            cylinder(d=4.2, h=10, $fn=50);
                        }
                    }
                }
                */
                
                // Make a nice rounded transition for the film to follow.
                rotate([-90,0,0]) {
                    translate([3 + 2.5,-12.50,- backerWidth]) {
                        cylinder(d=5, h=actualWidth);
                    }
                }
            }
        }
    }
}

// Small block once the film has been removed to stop the components
// flying out of the tape immediat.y
module stopComponentsFlyingBlock() {
    
    translate([blockXOffset + tapeTopBlockLength+3, actualWidth-backerWidth, 5 + smdTapeGap ]) {
         cube([20, backerWidth, 2 ]);
    }
    
    // Block for film to curve over.
    translate([blockXOffset + tapeTopBlockLength + 6,2, 5 + smdTapeGap ]) {
         // Block right on top of the tape.
            cube([20, actualWidth-2, 2]);
    }
}

module topBlock() {

    // very top block
    translate([blockXOffset + 3 + smtTapeTopGap + 2.5,0, 5 + smdTapeGap + 10 + smtTapeTopGap]) {
        rotate([-90,0,0]) {
            translate([0,-2.50,0]) {
                cylinder(d=5, h=actualWidth);
            }
        }
        cube([tapeTopBlockLength - (3 + smtTapeTopGap +2.5), actualWidth, 5]);
    }
}

module blockBacker() {

    // backer to hold it all in place.
    translate([blockXOffset,(actualWidth)-backerWidth, 0]) {
        cube([tapeTopBlockLength-5, backerWidth, baseHeight + smdTapeGap + 10 + smtTapeTopGap + 5]);
    }
}

// main body
difference() {
    union() {
        cube([baseLength, actualWidth, baseHeight]);
        
        addMiniSideWall();
        
        stopComponentsFlyingBlock();
        
        // NOW - ramp up to get the tape past the box edge.
        exitRamp();
        
        filmRemovalBlock();
        
        topBlock();
        
        blockBacker();
    }
    union() {
        // cut out for tape to come up through.
        // 2mm offset to align with the backing block
        enteranceCutout();
        
        // Add a hole for light to shine through to allow counting.
        ledCounterHole();
        
        // Hole for a pin to hold the tape in place.
        tapePinHole();
        
        for(repYOffset =  [0 : blockWidth : actualWidth-1]) {
            //repYOffset = i * 15;
            translate([0,repYOffset,0]) {
                // Screw holes
                #screwHoles();
            }
        }
        
        // Shave off the blockPrinterTollerance from the furthest
        // side from the reel tape holes.
        cube([baseLength,blockPrinterTollerance,5 + smdTapeGap + 10 + smtTapeTopGap + 10]);
    }
}

enteranceCurve();
//enteranceMarker();