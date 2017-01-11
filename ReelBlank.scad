// Use where rod needs blanks to make the full length

rodDiameter = 11; // Reel hole size 13-ish mm. SuppotHole = 12mm.
blankDiameter = 25; // Reel hole size 13-ish mm. SuppotHole = 12mm.

// How many reels this should support.
numberOfReelBlanks = 1;

// How wide the dispensing blocks are
blockWidth = 13;

// How deep the inset in the support is.
supportInset = 5;

height =  (blockWidth * numberOfReelBlanks);

echo ("height", height);




difference() {
    union() {
        cylinder(d=blankDiameter, h=height, $fn=80);
    }
    
    union() {
        cylinder(d=rodDiameter + 1, h=height, $fn=80);
    }
}