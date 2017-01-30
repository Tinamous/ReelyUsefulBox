// Height between base and wrapper.
// for fat components (e.g. LEDs) increase this.
// NB: Tape enterance is not adjusted for this.
smdTapeGap = 2;
// smdTapeGap = 3; // for LEDs

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

// How many block units (e.g. 13mm's) wide
// Mounting holes will be duplicated but 
// LED hole not.
// Be sure to set tapeWidth correctly for the wide tape.
numberOfBlocksWide = 4;

// How much to remove off the block width to allow
// for printer tollerance so that each block
// fits in the 13mm grid.
// Set to 6.5 to test screw centers.
// Set to 9.75 to test (3mm offset) for LED for component counter and dispenser.
// Set to 1.5 + 1.75 (3.25) to test (3mm offset) for LED for arm
// Set to 4 to test horizontal coupler.
// Set to 0.25 for normal printing.
blockPrinterTollerance = 0.15; //0.25;

// Tape Width MUST be set appropriatly
// for numberOfBlocksWide>1 it is assumed this is for
// wide tape and not just to make n blocks in one go.
// Hence tapeWidth must be set for the tap to ensure
// the tape is guided properly.

// How much space to allow for the tape.
// Actually 8mm but add 0.5 to allow it to move easily
// LED tape is 12.5mm wide so use 13mm
tapeWidth = 8.5;

// If the tape is to be repeated for each block wide
// typically if making n component sensor blocks in one go 
// e.g. 4 unit block.
// if just wide tape, set to false and set tape width.
repeatTape = true;

// How far along the dispenser the top block
// for film removal is.
// 11mm in the original
// 70mm for the 
//blockXOffset = 70;
// PCB is 86mm long.
blockXOffset = 87;