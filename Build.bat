@echo off

@echo Deleting old STL files.
del *.stl

@echo Building STLs
"C:\Program Files\OpenSCAD\openscad.com" -o ComponentUsageSensor.stl -D "usePinMount=false" ComponentUsageSensor.scad
"C:\Program Files\OpenSCAD\openscad.com" -o ComponentUsageSensor-Pin.stl -D "usePinMount=true" ComponentUsageSensor.scad
"C:\Program Files\OpenSCAD\openscad.com" -o ReelHolderArm.stl ReelHolderArm.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Dispenser.stl Dispenser.scad
"C:\Program Files\OpenSCAD\openscad.com" -o ReelHolder.stl ReelHolder.scad

# MountingPlate needs svg and editing so ignore