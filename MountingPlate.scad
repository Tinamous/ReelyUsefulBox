$fn=80;

// 25 for full width.
// 23 for A4 Max + 2 supports either wide.
blockCount = 23;
blockWidth = 13;

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
    mountingHole(xPosition, height-10);
    mountingHole(xPosition, height-60);
    mountingHole(xPosition, height-110);
    mountingHole(xPosition, height-160);
}

module tapeEnterance(blockNumber) {
    blockOffset = blockWidth * blockNumber;
    echo ("blockOffset",blockOffset);
    yPosition = height - 35;
    
    translate([1 + blockOffset, yPosition,0]) {
        #square(blockWidth -2, 20);
    }
}

difference() {
    union() {
        square([width, height]);
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
    }
}




