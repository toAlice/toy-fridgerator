module heatsink(w = 150, l = 100, h = 45, t = 10, f = 29, ft = 1) {
    module lineup(n = 1, space = 1) {
        for (i = [0 : n - 1]) {
            translate([space * i, 0, 0]) {
                children(0);
            }
        }
    };

    color("#CCCCCC") union() {
        cube([l, w, t]);
        lineup(f, (l - ft) / (f - 1)) {
            cube([ft, w, h]);
        }
    } 
}