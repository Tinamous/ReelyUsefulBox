// Height between base and wrapper.
smdTapeGap = 2;

// How thick the back (well side) support structure is
// the tape sits against this.
backerWidth = 1.5; // Was 2.
// 8mm tape + backer = 9.5mm, 
// 13mm block -> 3.5mm play on the left.
// 12mm tape + backer = 13.5 >> block width

// How wide the thing is.
//blockWidth = 13-0.1;
blockWidth = 13;
// How much to remove off the block width to allow
// for printer tollerance so that each block
// fits in the 13mm grid.
blockPrinterTollerance = 0.1;

// How much space to allow for the tape.
tapeWidth = 8.5;

// How far along the dispenser the top block
// for film removal is.
// 11mm in the original
// 70mm for the 
//blockXOffset = 70;
// PCB is 86mm long.
blockXOffset = 87;