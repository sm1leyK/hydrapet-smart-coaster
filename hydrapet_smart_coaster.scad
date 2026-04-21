/*
HydraPet smart coaster / intelligent cup dock

Design goals:
- 100 mm round footprint
- 35 mm overall shell height
- Upper shell + lower shell assembly
- Floating cup insert that sends force to a 75 mm bar load cell
- Continuous side light window with 5 mm diffuser gap
- Front OLED window, rear Type-C cutout, ESP32 tray, button hole, buzzer pocket

Notes:
- The cup insert is intentionally modeled as a loose floating puck so the load path
  goes into the load cell instead of bypassing through the outer shell.
- The load cell footprint is generic. Adjust the support spacing and screw holes for
  your exact sensor before final production.
*/

$fn = 96;

// ---------------------------------------------------------------------------
// View controls
// ---------------------------------------------------------------------------
view_mode = "section";   // assembled, exploded, top_shell, bottom_shell, cup_insert, section
show_reference_parts = false; // set true to preview generic ESP32 and load cell envelopes
show_colors = true;
explode_gap = 18;

// ---------------------------------------------------------------------------
// Core envelope
// ---------------------------------------------------------------------------
outer_d = 100;
outer_r = outer_d / 2;
total_h = 35;
shell_wall = 2.5;
body_corner_r = 3.0;
floor_t = 2.4;

split_z = 12;             // seam between lower and upper shell
seam_overlap = 3.0;
seam_clearance = 0.30;

// ---------------------------------------------------------------------------
// Top cup area
// ---------------------------------------------------------------------------
cup_recess_d = 72;
cup_recess_depth = 4;

cup_insert_d = 76.0;      // floating load-transfer puck
cup_insert_plate_h = 7.0;
cup_insert_pad_h = 3.0;
cup_insert_stem_d = 14.0;
cup_insert_pad_size = [18, 12];

top_opening_d = 76.8;     // slightly larger than insert for free motion
top_opening_r = top_opening_d / 2;

// ---------------------------------------------------------------------------
// Light band
// ---------------------------------------------------------------------------
light_window_h = 8;
light_window_bottom_z = 13.5;
light_window_top_z = light_window_bottom_z + light_window_h;
light_diffuser_t = 1.5;
light_gap = 5.0;          // diffuser to LED distance
led_strip_width = 3.0;    // flexible strip width when wrapped around the ring

light_chamber_outer_r = outer_r - light_diffuser_t;
light_chamber_inner_r = light_chamber_outer_r - light_gap;
led_guide_t = 0.9;
led_slot_bottom_z = light_window_bottom_z + (light_window_h - led_strip_width) / 2;
led_slot_top_z = led_slot_bottom_z + led_strip_width;

// ---------------------------------------------------------------------------
// Front OLED window
// ---------------------------------------------------------------------------
oled_window_w = 35;
oled_window_h = 22;
oled_window_z = 23;
oled_corner_r = 2.5;
oled_cut_depth = 16;
oled_tab_t = 1.4;
oled_tab_depth = 2.2;

// ---------------------------------------------------------------------------
// Rear Type-C
// ---------------------------------------------------------------------------
typec_w = 12;
typec_h = 8;
typec_z = 8.5;
typec_corner_r = 1.8;
typec_cut_depth = 14;
typec_relief_size = [18, 12, 10];

// ---------------------------------------------------------------------------
// Internal electronics
// ---------------------------------------------------------------------------
esp32_space = [52, 22];
esp32_tray_size = [54, 24, 2.2];
esp32_tray_center = [0, -20.0];
esp32_tray_z = floor_t + 0.8;
esp32_rail_h = 5.0;
esp32_rail_t = 1.6;

button_d = 12;
button_z = 7.8;

buzzer_d = 15;
buzzer_pocket_depth = 4.2;
buzzer_center = [-22, 18];

// ---------------------------------------------------------------------------
// Load cell geometry (generic 75 mm straight bar)
// ---------------------------------------------------------------------------
load_cell_size = [75, 13, 6.5];
load_cell_support_size = [14, 18, 3.1];
load_cell_support_offset = 28;
load_cell_mount_hole_d = 3.2;
load_cell_screw_head_d = 6.4;
load_cell_screw_head_h = 2.0;

load_cell_top_z = floor_t + load_cell_support_size[2] + load_cell_size[2];
cup_insert_stem_h = total_h - load_cell_top_z - cup_insert_plate_h - cup_insert_pad_h;
cup_insert_total_h = cup_insert_pad_h + cup_insert_stem_h + cup_insert_plate_h;

// ---------------------------------------------------------------------------
// Assembly bosses
// ---------------------------------------------------------------------------
boss_radius = 34;
boss_d = 8.0;
boss_lower_h = split_z - floor_t;
boss_upper_h = 9.0;
boss_angles = [45, 135, 225, 315];

bottom_screw_clearance_d = 3.2;
bottom_counterbore_d = 6.4;
bottom_counterbore_h = 2.2;
upper_pilot_d = 2.7;

// ---------------------------------------------------------------------------
// Seam lip
// ---------------------------------------------------------------------------
lower_cavity_r = 44.0;
seam_lip_inner_r = 41.2;
seam_lip_outer_r = 45.4;
seam_socket_inner_r = seam_lip_inner_r - seam_clearance;
seam_socket_outer_r = lower_cavity_r + seam_clearance;

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
function polar_x(radius, angle_deg) = radius * cos(angle_deg);
function polar_y(radius, angle_deg) = radius * sin(angle_deg);

module preview_color(color_value) {
    if (show_colors) {
        color(color_value) children();
    } else {
        children();
    }
}

module ring(r_outer, r_inner, h) {
    difference() {
        cylinder(r = r_outer, h = h);
        translate([0, 0, -0.1]) cylinder(r = r_inner, h = h + 0.2);
    }
}

module rounded_square_2d(size = [10, 10], r = 1.5) {
    offset(r = r) offset(delta = -r) square(size, center = true);
}

module rounded_slot_y(size = [10, 10], depth = 10, r = 1.5) {
    rotate([90, 0, 0])
        linear_extrude(height = depth, center = true)
            rounded_square_2d(size, r);
}

module rounded_body() {
    translate([0, 0, body_corner_r])
        minkowski() {
            cylinder(r = outer_r - body_corner_r, h = total_h - 2 * body_corner_r);
            sphere(r = body_corner_r);
        }
}

module z_crop(z0, z1) {
    intersection() {
        children();
        translate([-outer_d, -outer_d, z0])
            cube([outer_d * 2, outer_d * 2, z1 - z0]);
    }
}

module body_slice(z0, z1) {
    z_crop(z0, z1) rounded_body();
}

// ---------------------------------------------------------------------------
// Subtractive features
// ---------------------------------------------------------------------------
module top_center_opening() {
    translate([0, 0, split_z - 0.2])
        cylinder(r = top_opening_r, h = total_h - split_z + 0.4);
}

module top_socket_cut() {
    translate([0, 0, split_z - 0.05])
        ring(seam_socket_outer_r, seam_socket_inner_r, seam_overlap + 0.2);
}

module light_band_chamber() {
    translate([0, 0, light_window_bottom_z])
        ring(light_chamber_outer_r, light_chamber_inner_r, light_window_h);
}

module oled_window_cut() {
    translate([0, outer_r - light_diffuser_t - 0.4, oled_window_z])
        rounded_slot_y([oled_window_w, oled_window_h], oled_cut_depth, oled_corner_r);
}

module typec_cut() {
    translate([0, -outer_r + 1.0, typec_z])
        rounded_slot_y([typec_w, typec_h], typec_cut_depth, typec_corner_r);

    translate([
        -typec_relief_size[0] / 2,
        -outer_r + 4.0,
        typec_z - typec_relief_size[2] / 2
    ])
        cube([typec_relief_size[0], typec_relief_size[1], typec_relief_size[2]]);
}

module lower_main_cavity() {
    translate([0, 0, floor_t])
        cylinder(r = lower_cavity_r, h = split_z - floor_t + 0.6);
}

module button_cut() {
    translate([outer_r - 4.0, 0, button_z])
        rotate([0, 90, 0]) cylinder(d = button_d, h = 16, center = true);
}

module buzzer_pocket_cut() {
    translate([buzzer_center[0], buzzer_center[1], floor_t - 0.05])
        cylinder(d = buzzer_d + 1.0, h = buzzer_pocket_depth);
}

module wire_relief_cuts() {
    // Load cell to ESP32
    translate([-3, -22, floor_t])
        cube([6, 22, 4.0]);

    // ESP32 tray to rear connector
    translate([-6, -42, floor_t])
        cube([12, 14, 6.0]);
}

module lower_fastener_holes() {
    for (angle = boss_angles) {
        translate([polar_x(boss_radius, angle), polar_y(boss_radius, angle), -0.05])
            cylinder(d = bottom_screw_clearance_d, h = split_z + 2);

        translate([polar_x(boss_radius, angle), polar_y(boss_radius, angle), -0.05])
            cylinder(d = bottom_counterbore_d, h = bottom_counterbore_h + 0.05);
    }
}

module upper_pilot_holes() {
    for (angle = boss_angles) {
        translate([polar_x(boss_radius, angle), polar_y(boss_radius, angle), split_z - 0.05])
            cylinder(d = upper_pilot_d, h = boss_upper_h + 0.1);
    }
}

module load_cell_mount_holes() {
    for (x_sign = [-1, 1]) {
        translate([x_sign * load_cell_support_offset, 0, floor_t - 0.05])
            cylinder(d = load_cell_mount_hole_d, h = load_cell_support_size[2] + 0.2);

        // Bottom access so the sensor can be screwed in from the underside.
        translate([x_sign * load_cell_support_offset, 0, -0.05])
            cylinder(d = load_cell_mount_hole_d, h = floor_t + 0.1);

        // Simple counterbore for low-profile screw heads.
        translate([x_sign * load_cell_support_offset, 0, -0.05])
            cylinder(d = load_cell_screw_head_d, h = load_cell_screw_head_h + 0.05);
    }
}

// ---------------------------------------------------------------------------
// Additive features
// ---------------------------------------------------------------------------
module lower_seam_lip() {
    translate([0, 0, split_z - 0.05])
        ring(seam_lip_outer_r, seam_lip_inner_r, seam_overlap);
}

module lower_bosses() {
    for (angle = boss_angles) {
        translate([polar_x(boss_radius, angle), polar_y(boss_radius, angle), floor_t])
            cylinder(d = boss_d, h = boss_lower_h);
    }
}

module upper_receivers() {
    for (angle = boss_angles) {
        translate([polar_x(boss_radius, angle), polar_y(boss_radius, angle), split_z])
            difference() {
                cylinder(d = boss_d, h = boss_upper_h);
                translate([0, 0, -0.05])
                    cylinder(d = upper_pilot_d, h = boss_upper_h + 0.1);
            }
    }
}

module led_strip_guides() {
    // Two thin locating ribs keep a 3 mm wide wrapped strip centered in the light window.
    for (z_pos = [led_slot_bottom_z - led_guide_t, led_slot_top_z]) {
        translate([0, 0, z_pos])
            ring(light_chamber_inner_r + 1.7, light_chamber_inner_r, led_guide_t);
    }
}

module oled_mount_tabs() {
    tab_y = top_opening_r + 0.8;
    frame_w = oled_window_w + 6;
    frame_h = oled_window_h + 6;

    translate([-frame_w / 2, tab_y, oled_window_z + frame_h / 2 - oled_tab_t / 2])
        cube([frame_w, oled_tab_depth, oled_tab_t]);
    translate([-frame_w / 2, tab_y, oled_window_z - frame_h / 2 - oled_tab_t / 2])
        cube([frame_w, oled_tab_depth, oled_tab_t]);

    translate([-frame_w / 2 - oled_tab_t / 2, tab_y, oled_window_z - frame_h / 2])
        cube([oled_tab_t, oled_tab_depth, frame_h]);
    translate([frame_w / 2 - oled_tab_t / 2, tab_y, oled_window_z - frame_h / 2])
        cube([oled_tab_t, oled_tab_depth, frame_h]);
}

module esp32_tray() {
    translate([
        esp32_tray_center[0] - esp32_tray_size[0] / 2,
        esp32_tray_center[1] - esp32_tray_size[1] / 2,
        esp32_tray_z
    ])
        cube(esp32_tray_size);

    // Simple side rails for glue-free placement if needed.
    translate([
        esp32_tray_center[0] - esp32_tray_size[0] / 2,
        esp32_tray_center[1] - esp32_tray_size[1] / 2,
        esp32_tray_z
    ])
        cube([esp32_tray_size[0], esp32_rail_t, esp32_rail_h]);

    translate([
        esp32_tray_center[0] - esp32_tray_size[0] / 2,
        esp32_tray_center[1] + esp32_tray_size[1] / 2 - esp32_rail_t,
        esp32_tray_z
    ])
        cube([esp32_tray_size[0], esp32_rail_t, esp32_rail_h]);
}

module load_cell_supports() {
    for (x_sign = [-1, 1]) {
        translate([x_sign * load_cell_support_offset, 0, floor_t + load_cell_support_size[2] / 2])
            difference() {
                cube(load_cell_support_size, center = true);
                translate([0, 0, -load_cell_support_size[2] / 2 - 0.1])
                    cylinder(d = load_cell_mount_hole_d, h = load_cell_support_size[2] + 0.2);
            }
    }

    // Low lateral guides help keep the bar sensor aligned during assembly.
    for (y_sign = [-1, 1]) {
        translate([
            0,
            y_sign * (load_cell_size[1] / 2 + 1.4),
            floor_t + 0.5
        ])
            cube([load_cell_size[0] - 8, 1.2, 2.2], center = true);
    }
}

// ---------------------------------------------------------------------------
// Main shell modules
// ---------------------------------------------------------------------------
module bottom_shell() {
    difference() {
        union() {
            difference() {
                body_slice(0, split_z);
                lower_main_cavity();
            }

            lower_seam_lip();
            lower_bosses();
            esp32_tray();
            load_cell_supports();
        }

        lower_fastener_holes();
        button_cut();
        typec_cut();
        buzzer_pocket_cut();
        wire_relief_cuts();
        load_cell_mount_holes();
    }
}

module top_shell() {
    difference() {
        union() {
            difference() {
                body_slice(split_z, total_h);
                top_center_opening();
                top_socket_cut();
                light_band_chamber();
                oled_window_cut();
            }

            led_strip_guides();
            oled_mount_tabs();
            upper_receivers();
        }
    }
}

// ---------------------------------------------------------------------------
// Floating cup insert
// ---------------------------------------------------------------------------
module cup_recess_cut() {
    union() {
        translate([0, 0, cup_insert_total_h - cup_recess_depth - 0.05])
            cylinder(d = cup_recess_d, h = cup_recess_depth + 0.1);

        // Soft lead-in around the cup edge. It is closer to a printable chamfer than a
        // true fillet, but keeps the appearance gentle and prints reliably.
        hull() {
            translate([0, 0, cup_insert_total_h - 0.02])
                cylinder(d = cup_recess_d + 5.0, h = 0.02);
            translate([0, 0, cup_insert_total_h - 1.8])
                cylinder(d = cup_recess_d, h = 0.02);
        }
    }
}

module cup_insert() {
    difference() {
        union() {
            // Force pad that lands on the load cell center.
            translate([
                -cup_insert_pad_size[0] / 2,
                -cup_insert_pad_size[1] / 2,
                0
            ])
                cube([cup_insert_pad_size[0], cup_insert_pad_size[1], cup_insert_pad_h]);

            // Central stem transfers force down without tying into the outer shell.
            translate([0, 0, cup_insert_pad_h])
                cylinder(d = cup_insert_stem_d, h = cup_insert_stem_h);

            // Top puck that the cup actually sits on.
            translate([0, 0, cup_insert_pad_h + cup_insert_stem_h])
                cylinder(d = cup_insert_d, h = cup_insert_plate_h);
        }

        cup_recess_cut();
    }
}

// ---------------------------------------------------------------------------
// Reference parts for tuning
// ---------------------------------------------------------------------------
module load_cell_reference() {
    preview_color([0.85, 0.25, 0.25, 0.45])
        translate([
            -load_cell_size[0] / 2,
            -load_cell_size[1] / 2,
            floor_t + load_cell_support_size[2]
        ])
            cube(load_cell_size);
}

module esp32_reference() {
    preview_color([0.15, 0.55, 0.20, 0.35])
        translate([
            -esp32_space[0] / 2,
            esp32_tray_center[1] - esp32_space[1] / 2,
            esp32_tray_z + esp32_tray_size[2]
        ])
            cube([esp32_space[0], esp32_space[1], 5.0]);
}

module reference_parts() {
    if (show_reference_parts) {
        load_cell_reference();
        esp32_reference();
    }
}

// ---------------------------------------------------------------------------
// Assembly views
// ---------------------------------------------------------------------------
module assembled_model(gap = 0) {
    preview_color([0.94, 0.94, 0.96])
        bottom_shell();

    translate([0, 0, gap])
        preview_color([0.98, 0.98, 1.0])
            top_shell();

    translate([0, 0, load_cell_top_z + gap / 2])
        preview_color([0.96, 0.96, 0.96])
            cup_insert();

    reference_parts();
}

module section_model() {
    intersection() {
        assembled_model(0);
        translate([-outer_d, 0, -1]) cube([outer_d * 2, outer_d, total_h + 2]);
    }
}

// ---------------------------------------------------------------------------
// Output selector
// ---------------------------------------------------------------------------
if (view_mode == "assembled") {
    assembled_model(0);
} else if (view_mode == "exploded") {
    assembled_model(explode_gap);
} else if (view_mode == "top_shell") {
    preview_color([0.98, 0.98, 1.0]) top_shell();
} else if (view_mode == "bottom_shell") {
    preview_color([0.94, 0.94, 0.96]) bottom_shell();
} else if (view_mode == "cup_insert") {
    preview_color([0.96, 0.96, 0.96]) cup_insert();
} else if (view_mode == "section") {
    section_model();
} else {
    assembled_model(0);
}
