// Height between base and wrapper.
smdTapeGap = 2;

// 1.75mm offset because that's the offset on the tape.
// Was 1.5
tapeHoleOffset = 1.75; // mm

// How thick the back (well side) support structure is
// the tape sits against this.
backerWidth = 1.5; // 1.5;
// 8mm tape + backer = 9.5mm, 
// 13mm block -> 3.5mm play on the left.
// 12mm tape + backer = 13.5 >> block width

// How wide the thing is.
//blockWidth = 13-0.1;
blockWidth = 13;
// How much to remove off the block width to allow
// for printer tollerance so that each block
// fits in the 13mm grid.
// Set to 6.5 to test screw centers.
// Set to 9.75 to test (3mm offset) for LED for component counter and dispenser.
// Set to 1.5 + 1.75 (3.25) to test (3mm offset) for LED for arm
// Set to 4 to test horizontal coupler.
// Set to 0.25 for normal printing.
blockPrinterTollerance = 0.25; //0.25;

// How much space to allow for the tape.
// Actually 8mm but add 0.5 to allow it to move easily
tapeWidth = 8.5;

// How far along the dispenser the top block
// for film removal is.
// 11mm in the original
// 70mm for the 
//blockXOffset = 70;
// PCB is 86mm long.
blockXOffset = 87;