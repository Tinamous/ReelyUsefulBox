@echo off

@echo Deleting old STL files.
del *.stl

@echo Building Component Usage Sensor with screw STLs
"C:\Program Files\OpenSCAD\openscad.com" -o ComponentUsageSensor.stl -D "usePinMount=false" ComponentUsageSensor.scad

@echo Building Component Usage Sensor with Pin STLs
"C:\Program Files\OpenSCAD\openscad.com" -o ComponentUsageSensor-Pin.stl -D "usePinMount=true;numberOfBlocksWide=1" ComponentUsageSensor.scad
# For LED tape
"C:\Program Files\OpenSCAD\openscad.com" -o ComponentUsageSensor-Pin-LED.stl -D "usePinMount=true;numberOfBlocksWide=2;tapeWidth=13" ComponentUsageSensor.scad
# Covers 4 individual 8mm tape (resistor/caps) as opposed to a double wide tape.
"C:\Program Files\OpenSCAD\openscad.com" -o ComponentUsageSensor-Pin-4Wide-MultiTape.stl -D "usePinMount=true;numberOfBlocksWide=4;repeatTape=true" ComponentUsageSensor.scad

@echo Building Reel Holder Arm STLs
"C:\Program Files\OpenSCAD\openscad.com" -o ReelHolderArm.stl -D  "numberOfBlocksWide=1" ReelHolderArm.scad
"C:\Program Files\OpenSCAD\openscad.com" -o ReelHolderArm-2Wide.stl -D  "numberOfBlocksWide=2" ReelHolderArm.scad

@echo Building Dispenser STLs
"C:\Program Files\OpenSCAD\openscad.com" -o Dispenser.stl -D  "numberOfBlocksWide=1"  Dispenser.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Dispenser-2Wide.stl -D  "numberOfBlocksWide=2;smdTapeGap=3" Dispenser.scad

@echo Building Reel Holder STLs
"C:\Program Files\OpenSCAD\openscad.com" -o ReelHolder.stl -D  "numberOfBlocksWide=1"  ReelHolder.scad
"C:\Program Files\OpenSCAD\openscad.com" -o ReelHolder-2Wide.stl -D  "numberOfBlocksWide=2" ReelHolder.scad

# MountingPlate needs svg and editing so ignore