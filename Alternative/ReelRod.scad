rodDiameter = 12; // Reel hole size 13-ish mm. SuppotHole = 12mm.

// How many reels this should support.
numberOfReels = 7;

// How wide the dispensing blocks are
blockWidth = 13;

// How deep the inset in the support is.
supportInset = 5;

rodHeight =  (blockWidth * numberOfReels) + (2 * (supportInset -1) );

echo ("rodHeight", rodHeight);

cylinder(d=rodDiameter, h=rodHeight, $fn=80);
