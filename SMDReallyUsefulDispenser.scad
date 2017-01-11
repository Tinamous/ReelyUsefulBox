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

// Height between base and wrapper.
smdTapeGap = 2;
// gap for the film to wrap back around
smtTapeTopGap = 1; 
// How far from the edige the hole in the tap is.
tapeHoleOffset = 1.5; // mm
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

// 11mm in the original
// 70mm for the 
blockXOffset = 70;

// 70mm in the original
// Added 60 for the back extension
// 40 extra to bring the tape neear the front of the box. then
// add a hump to make it easy to pick the tape.
baseLength = 70 + 60 +20 + 40;
baseHeight = 5;
echo ("baseLength", baseLength);

module enteranceCutout() {
    translate([0,0,0]) {
        rotate([0,-14,0]) {
            translate([-10,0,-8]) {
                translate([10,0 , 0]) {
                    cube([65,blockWidth  - backerWidth,2]);
                }
            }
        }
    }
}

module exitCutout() {
    // 116 offset from the front of the block
    // is about 10 1206 components.
    // TODO: Compute it better!
    translate([163,0,0]) {
        rotate([0,8,0]) {
            translate([0,0,5]) {
                #cube([40,blockWidth - backerWidth,2]);
            }
        }
    }
}

module screwHole(xPosition) {
    translate([xPosition,blockWidth/2, -0.1]) {
        cylinder(d=3.4, h=baseHeight + 0.2);
        
        // And countersink it...
        translate([0,0, baseHeight  + 0.1 - 3]) {
            cylinder(d1=3.4, d2=6, h=3.2);
        }
    }   
}

module screwHoles() {
    // 50mm gaps between holes with a 10mm offset to start.
    screwHole(10);
    screwHole(60);
    screwHole(110);
    // Not needed but keep to show how if fits in with the reel support.
    screwHole(160);
}

module ledCounterHole() {
    // Move to the far edge
    // Then move in by xmm for the tape hole position
ledHoleX = blockXOffset - tapeHoleOffsetFromBlock;
echo("Led Hole X", ledHoleX);
    
    translate([blockXOffset - tapeHoleOffsetFromBlock,
                (blockWidth-backerWidth) - tapeHoleOffset, 
                -0.1]) {
        cylinder(d=1.5, h=baseHeight+0.2);
                    
        // Hollow out xmm (3) for a 3mm LED to be inserted
        // Expect this will be glued or on a PCB
        // so allow a tollerance.
        cylinder(d=3.1, h=baseHeight-2);
        
    }
}

// create little markers down one edge to indicate 10 components.
module addMarker() {
    translate([blockXOffset + 28 ,blockWidth-backerWidth, 0]) {
        cube([40, backerWidth, baseHeight + 2 ]);
    }
}

// main body
difference() {
    union() {
        cube([baseLength, blockWidth, baseHeight]);
        addMarker();
    }
    union() {
        // cut out for tape to come up through.
        // 2mm offset to align with the backing block
        enteranceCutout();
        
        // cut out for tape to EXIT through.
        // 2mm offset to align with the backing block
        exitCutout();
        
        // Screw holes
        screwHoles();
        
        // Add a hole for light to shine through to allow counting.
        ledCounterHole();
    }
}

// Block for film to curve over.
translate([blockXOffset,0, 5 + smdTapeGap ]) {
    
    difference() {
        union() {
           
            cube([20, blockWidth, 10]);
            translate([20,blockWidth, 10/2 ]) {
                rotate([90,0,0]) {
                    cylinder(d=10, h=blockWidth);
                    translate([0, 0, blockWidth]) {
                        // Pin
                        // // Drop this as it makes 
                        // changing these blocks difficult and 
                        // doesn't print well.
                        //cylinder(d=3.0, h=2);
                    }
                }
            }
            
            // Raised back to push the film upwards. 
            cube([5.5, blockWidth, 12.50]);
            cube([3, blockWidth, 17.5]);
            // Curved top
            translate([1.5, 0, 17.5]) {
                rotate([-90,0,0]) {
                        // Pin hole.
                    cylinder(d=3, h=blockWidth, $fn=100);
                }
            }
        }
        union() {
            translate([20,blockWidth +0.1, 10/2 ]) {
                rotate([90,0,0]) {
                    // Pin hole.
                    cylinder(d=4.5, h=blockWidth + 0.2, $fn=100);
                }
            }
            
            // Create a hole in the back to allow the tape counter to be screwed on
            // M3 insert 
            translate([-0.1, 4, 10/2 ]) {
                rotate([0,90,0]) {
                    // Component counter mount hole
                    cylinder(d=4.2, h=10, $fn=50);
                }
            }
            
            // Make a nice rounded transition for the film to follow.
            rotate([-90,0,0]) {
                translate([3 + 2.5,-12.50,-backerWidth]) {
                    cylinder(d=5, h=blockWidth);
                }
            }
        }
    }

}



// very top block
translate([blockXOffset + 3 + smtTapeTopGap + 2.5,0, 5 + smdTapeGap + 10 + smtTapeTopGap]) {
    rotate([-90,0,0]) {
        translate([0,-2.50,0]) {
            cylinder(d=5, h=blockWidth);
        }
    }
    cube([20 - (3 + smtTapeTopGap + 2.5), blockWidth, 5]);

}

// backer to hold it all in place.
translate([blockXOffset,blockWidth-backerWidth, 0]) {
    cube([15, backerWidth, baseHeight + smdTapeGap + 10 + smtTapeTopGap + 5]);

}