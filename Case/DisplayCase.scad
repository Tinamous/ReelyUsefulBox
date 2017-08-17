$fn=80;

module display() {
    cube([86, 50.5, 1.5]);
    
    // Pins
    translate([0,8,-7]) {
        cube([4, 50-16, 11.5]);
    }
    
    // Holes
    translate([7.25,0,-5]) {
        translate([0,3,0]) {
            cylinder(d=3.5, h=15);
        }
        translate([0,47,0]) {
            cylinder(d=3.5, h=15);
        }
    }
    
    // Main display body
    // 10.4 in
    translate([10,0,0]) {
        // 69.2  + 2*0.5mm for tollerance.
        cube([70.2, 50, 5.3]);
    }
    
    // touch area
    translate([15,2,0]) {
        cube([64, 46, 8]);
    }
    
    // Holes
    // 83mm
    translate([83.5,0,-5]) {
        translate([0,3,0]) {
            cylinder(d=3.5, h=15);
        }
        translate([0,47,0]) {
            cylinder(d=3.5, h=15);
        }
    }
    
    // Pins
    translate([82,19.5,-7]) {
        #cube([3.5, 10, 11.5]);
    }
}

pcbXOffset = 3.5;
pcbYOffset = 1.5;
boxWidth = 51.5;

module body() {
    difference() {
        union() {
            cube([110, boxWidth, 28]);
            
        }
        union() {
            // Wall width 1.5mm
            translate([1.5,1.25,0]) {
                cube([106, boxWidth-1, 25]);
            }
            
            translate([pcbXOffset,pcbYOffset,0]) {
                translate([0,0,22]) {
                    display();
                }
            }
            
            // Trim the front and side
            translate([0,0,0]) {
                // 2 for the first box
                #cube([95, boxWidth, 19]);
            }
            
            // countersink PCB supports
            pcbSupportsCountersinks();
        }
    }
    
    // Re-add Supports as they will have been lost
    pcbSupports();

        
}

module pcbSupportsCountersinks() {
    translate([pcbXOffset,pcbYOffset,22]) {            
        pcbSupportsCountersink(7.25, 3);
        pcbSupportsCountersink(7.25, 47);
        
        pcbSupportsCountersink(83.5, 3);
        pcbSupportsCountersink(83.5, 47);
    }
}

module pcbSupportsCountersink(x,y) {
    translate([x,y,1.5]) {
        translate([0,0,1.6]) {
            #cylinder(d1=3.5, d2=6.5, h=3);
        }
    }
     
}

module pcbSupports() {
    translate([pcbXOffset,pcbYOffset,22]) {            
        pcbSupport(7.25, 3);
        pcbSupport(7.25, 47);
        
        pcbSupport(83.5, 3);
        pcbSupport(83.5, 47);
    }
}


module pcbSupport(x,y) {
    translate([x,y,1.5]) {
        difference() {
            union() {
                cylinder(d=5.5, h=3);
            }
            union() {
                cylinder(d=3.5, h=4);
                translate([0,0,1.6]) {
                    #cylinder(d1=3.5, d2=6.5, h=3);
                }
            }
        }
    }
}


body();

//rotate([180,0,0]) {
//    translate([0,-50,0]) {
        // 1mm in to allow for a thin wall.
        translate([3.5,1.5,22]) {
            %display();
        }
  //  }
