$fn=80;

// 25 for full width.
// 23 for A4 Max + 2 supports either wide.

// top 312-320mm usable area.
// 315mm @ 15mm -> 21 -> 5 4wide blocks + 1 end block (or double block).
blockCount = 21; //25; 

//blockWidth = 13;
blockWidth = 15;

width = blockWidth * blockCount;
// Max width = 325.
height = 192;

ledHoleY = 67; 

// 2mm offset because of support wall.
tapeWallWidth = 2;
// 1.5mm offset because that's the offset on the tape.
tapeHoleOffset = 1.5; // mm

initialHoleOffset = blockWidth / 2;

module ledHole(blockNumber) {
    blockOffset = blockWidth * (blockNumber+1);
    
    ledHoleX = blockOffset - tapeWallWidth - tapeHoleOffset;
    echo ("ledHoldX", ledHoleX);
    
    translate([ledHoleX, height - ledHoleY,0]) {
        #circle(d=5);
    }
}

module blockOutline(blockNumber) {
    blockOffset = blockWidth * blockNumber;
    color("blue") {
        translate([blockOffset, 0,0]) {
            square([blockWidth, height]);
        }
    }
}

module mountingHole(xPosition, yPosition) {
    translate([xPosition, yPosition,0]) {
        circle(d=3.2);
    }
}

module mountingHoles(xPosition) {
    // Bach
    mountingHole(xPosition, height-10);
    mountingHole(xPosition, height-60);
    mountingHole(xPosition, height-110);
    // Front
    mountingHole(xPosition, height-160);
}

module tapeEnterance(blockNumber) {
    blockOffset = blockWidth * blockNumber;
    echo ("blockOffset",blockOffset);
    // 14.5 start position of the enterance.
    // then it's 25 mm long. + 2mm fudge
    yPosition = height - (14.5 + 25 + 2);
    
    // 2mm wall thickness, so first block enterance
    // starts 2mm from left hand edge.
    
    translate([blockOffset+2, yPosition, 0]) {
        
        // Making hole only 25mm long, even though it's 2mm forward.
        // as this is difficult to cut with the read holes close by.
        // this edge is by the top of the tape which is typically flat
        // so should run smoothly.
        if (blockCount-1 == blockNumber) {
            // reduce the size of the last block 
            // to allow for the +2 at the start
            // and then the 2mm wall width as well
            square([blockWidth-4, 25]);
        } else {
            square([blockWidth, 25]);
        }
    }
}

difference() {
    union() {
        // Main Body
        square([width, height]);
        
        // If using laser cut template, pad the outside to sit nicely
        // with the front right edges.
        
        // remove this if printing paper to stick on as template.
        
        // Left edge should alignt around the raised area of the lid
        // right and front edge should 
        // With alignment aids for  right hand side (and to seal off the routing area)
        translate([-9,-15,0])  {
            //square([width+9+15, height+15]); // 315x 192mm -> 339x 207mm
        }
        
        for (i= [0 : blockCount -1]) {
        //    blockOutline(i);
        }
    }
    union() {
        for (i= [0 : blockCount -1]) {
            mountingHoles(initialHoleOffset + blockWidth * i);
            
            tapeEnterance(i);
            
            ledHole(i);
        }
        
        // Allow for the corner
        translate([width+10, -40,0]) {
            rotate(45) {
              //  #square([40,30]);
            }
        }
    }
}




