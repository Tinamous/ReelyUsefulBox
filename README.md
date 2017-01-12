Reely Useful Box - SMD Reel storage and dispenser.
==================================================

SMD reel storage and dispenser based on a 19XL Really Useful Storage Box.

![Part build dispenser](/Images/DispenserX4.jpg)

Each reel is held and dispenced individually.
The box will hold 25 individual reels (assuming standard 8mm tape for resistors/capacitors).
Each reel holder is 13mm wide. For wider tape/reels this could be doubled to keep to the same hole grid.
Each reel holder is made of 3 different printed parts (1x Top dispenser, 1x reel holder top, 2x reel arms).
Component counter option with LED and photodiode counting of the tape holes.

You can have as few as you want, or as many (well 25 per box and as many boxes as you need).

All design files are Openscad and .stl for direct printing. I found it best to print with a brim as these are long parts and have a tendency to warp at the ends.

##MountingPlate

This is the drilling guide. You can either print it out and drill, or laser cut some acrylic with it.

* Open the .svg file in Inkscape and print this out. 
* It's bigger than A4/Letter, do not scale it! (The box is bigger than A4 length ways so you will need a couple of these for the full 25 way box).
* Stick the sheet to the box lid, allow a margin of about 4mm around the edges where the lid inner curves up (remember the reel holder top has to fit inside).
* Ensure the holes line up with the SMDReelyUsefulDispenser.
* Drill the holes. 
** 4MM for the M3 screw holes (4x).
** 5mm for the LED insert.
** 9-10mm for the square tape hole. This is likely to crack the lid in the process, maybe drill 4 M3.5 holes at each corner and cut, or cut out the entire length of all the sections with a dremmel of something  (Be VERY careful if you use a knife, the lid is very tough!).

##Dispenser

This sits on the top of the lid. 

Print in any color you like, you can color code the dispensers to match your components. I'm using:

* 1206 Resistors: Red
* 0805 Resistors: Green
* 1206 Capacitors: White
* 0805 Capacitors: Grey
* 1206 LEDs (Blue): Blue
* Other: Bronze

Original inspiration taken from http://www.thingiverse.com/thing:1080195 with modifications.

* Print this on it's side without supports but with a brim.
* 4 mounting holes for M3 countersunk machine screws.
* A small hole that aligns with the holes in the tape and accepts a 3mm LED underneath.
* The tape film wraps around the block on the top and exits vertically, so pulling the tape film up advances the tape and removes the film.
* Of you can just leave the film on if you want to cut of a section of tape.
* The top block has a hold in the back. Use a M3 heatfit   insert in here if you want to use the component usage sensor block.

## ReelHolder-Top

This sits inside the box to hold the reel arms and is screwed to the lid with the dispenser on the top.

* Print without supports but with a brim as this tends to warp at the edges.
* Fit 3x or 4x M3 HeatFit inserts (Do not fit the one by the square cut out if you wish to use the ComponentUsageSensor block.
* The M5 hole allows a 3mm LED to be pushed through into the dispenser 


## ReelHolder-Arm

These hold the reel and is mounted in the ReelHolder-Top.

* Print 2x of these for each arm.
* These push together either side of the reel and the ReelHolder-Top
* For the end ones you may wish to use a M3 HeatFit insert and small machine screw to hold the tops together if you don't have a tight fit.
* If the arms are not a good fit together change the value of cyinderMatingTollerance in the OpenScad file. I found 0.4 worked well, 0.2 was very tight.
* You may also like to shorten these arms. The variable armHeight sets the length of these. 150mm should allow the reel to be pulled to one side to be replaced.


## Parts Required:

* M3 Heatfit insert Part 1010655 http://www.insertsdirect.com/cgi-bin/sh000001.cgi?WD=1010655&PN=unheaded-heatfit-insert%2ehtml#a1010655
* M3 x 20mm countersunk machine screw (x5 per reel)
* M3 x 6mm countersunk machine screw (x1 for end reels only, or x2 per reel if you need to keep the reeel arms together).
* 19XL Really Useful Box http://www.ryman.co.uk/really-useful-storage-box-19xl-litre
* PLA.
* Drills: 4mm, 5mm, 9 or 10mm.
* SMD devices on reels!

## Printer Settings

* Printer: Ultimaker 2 Extended+
* Print Sequence: One at a Time
* Profile: Fast print
** Layer Height: 0.15
** Infil: 20%
** Speed: 60 mm/s
** Wall Thickness: 0.7mm
** Top/Bottom Thickness: 0.75mm
* Build Plate Adhesion: Brim
* Support: None