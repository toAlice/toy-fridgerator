use <heatsink.scad>;
use <tec.scad>;
use <psu.scad>

module top() {
    module tecs() {
        translate([-0.01, -0.01, -0.01]) {
            translate([0, 0, 0]) tec([30, 30, 5]);
            translate([66, 0, 0]) tec([30, 30, 5]);
            translate([0, 60, 0]) tec([30, 30, 5]);
            translate([66, 60, 0]) tec([30, 30, 5]);
            translate([0, 120, 0]) tec([30, 30, 5]);
            translate([66, 120, 0]) tec([30, 30, 5]);
        }
    }

    module foam() {
        color("#1F1F1F") difference() {
            cube([96, 150, 5]);
            translate([-0.01, -0.01, -0.01]) {
                translate([0, 0, 0]) tec([30, 30, 5.02]);
                translate([66.2, 0, 0]) tec([30, 30, 5.02]);
                translate([0, 60, 0]) tec([30, 30, 5.02]);
                translate([66.2, 60, 0]) tec([30, 30, 5.02]);
                translate([0, 120.2, 0]) tec([30, 30, 5.02]);
                translate([66.2, 120.2, 0]) tec([30, 30, 5.02]);
            }
        }
    }

    module vapor_chambers() {
        color("#EFEFEF") union() {
            translate([0, 0, -3]) {
                cube([96, 150, 3]);
            }
            translate([0, 0, 5]) {
                cube([96, 150, 3]);
            }
        }    
    }

    module heatsinks() {
        translate([-12, -25, 8]) {
            heatsink(l = 120, w = 200, h=20, t = 2, f = 16, ft = 1.4);
            translate([0, -25, -11]) {
                scale([1, 1, -1]) {
                    heatsink(l = 120, w = 250, h=40, t = 4.8, f = 16, ft = 2.4);
                }
            }
        }
    }

    module mounting() {
        translate([-27, -50, 0]) {
            difference() {
                union() {
                    cube([150, 250, 5]);
                    translate([5, 5, 4.99]) color("#000000") cube([140, 240, 3]);
                    translate([0, 0, -3.01]) color("#000000") cube([150, 250, 3]);
                }
                translate([21, 45, -4]) cube([108, 160, 13]);
            }
        }
    }

    scale([1, 1, -1]) {
        tecs();
        foam();
        vapor_chambers();
        heatsinks();
        mounting();
    }
}


module side_walls() {
    // inner right
    translate([5, 5, 0]) cube([5, 250 + 35, 5 + 35]);
    translate([5, 5, 5 + 35 + 5]) difference() {
        cube([5, 250, 250]);
        // magnet
        translate([0.01, 5, 200]) cube([5, 10, 40]);
    }
    // outer right
    translate([0, 0, 0]) cube([5, 5 + 250 + 35 + 5, 5 + 35 + 5 + 250 + 5 + 3 + 40 + 5]);

    // inner left
    translate([150, 5, 0]) cube([5, 250 + 35, 5 + 35]);
    translate([150, 5, 5 + 35 + 5]) difference() { 
        cube([5, 250, 250]);
        // magnet
        translate([-0.01, 5, 200]) cube([5, 10, 40]);
    }
    // outer left
    translate([150 + 5, 0, 0]) cube([5, 5 + 250 + 35 + 5, 5 + 35 + 5 + 250 + 5 + 3 + 40 + 5]);
}

module tops() {
    // inner top
    translate([27 + 5, 50 + 5, 5 + 35 + 5 + 250 + 5]) top();
    // outer top
    translate([5, 5 + 35, 5 + 35 + 5 + 250 + 5 + 3 + 40]) cube([150,  -5 - 35 + 5 + 250 + 35 + 5, 5]);

}

module bottoms() {
    // inner bottom
    translate([5, 5, 5 + 35]) cube([150, 250, 5]);
    // outer bottom
    %translate([5 + 5, 5, 0]) cube([140, 250 + 35, 5]);
}

module fronts() {
    // outer front upper
    translate([5, 0, 5 + 35 + 5 + 250]) cube([150, 5, 5 + 3 + 40 + 5]);

    // outer front lower
    translate([5 + 5, 5, 5]) difference() {
        cube([140, 5, 35]);
        // 30mm fan holes
        translate([0, 6, 15]) {
            translate([20, 0, 0]) rotate([90, 0, 0]) cylinder(d = 30, h = 7);
            translate([70, 0, 0]) rotate([90, 0, 0]) cylinder(d = 30, h = 7);
            translate([120, 0, 0]) rotate([90, 0, 0]) cylinder(d = 30, h = 7);
        }
    }
}

module backs() {
    // inner back
    translate([5 + 5, 5 + 250 - 5, 5 + 35 + 5]) cube([140, 5, 250]);
    // outer back
    %translate([5, 5 + 250 + 35, 0]) difference() {
        cube([150, 5, 5 + 35 + 5 + 250 + 5 + 3 + 40]);
        // cable hole
        translate([-10 + 150 - 5 - 15 , -1, 5 + 10]) cube([10, 7, 10]);
    }
}

module door() {
    // inner door
    translate([5 + 5, 5, 5 + 35 + 5]) cube([140, 5, 250]);
    // outer door
    translate([5, 0, 5 + 35 + 5]) difference() {
        union() {
            cube([150, 5, 250]);
            translate([75 - 5, -4.99, 230]) cube([10, 5, 10]);
        }
        // magnet
        translate([5 + 5, -0.01, 200]) cube([10, 5.02, 40]);
        translate([-10 + 150 - 5 - 5, -0.01, 200]) cube([10, 5.02, 40]);
    }
}

%side_walls();
%tops();
bottoms();
fronts();
backs();
% door();

translate([5 + 34, 5 + 250 - 110 - 80, 5]) psu();
