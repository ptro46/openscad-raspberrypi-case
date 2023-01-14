
/*
$fa = 1;
$fs = 0.4;
*/

/* [Pi Lid] */
do_pi_lid = true ;
do_aerations_lid = true ;

/* [Pi Bottom case] */
do_pi_bas = true ; // calculate pi bottom
do_hdmi = true ;
do_jack = true ;
do_supports_pi = true ;

/* [Cluster] */
do_supports_cluster = false ;

/* [Hidden] */
$fn=100;

pi_case_bas_x = 68 ;
pi_case_bas_y = 97 ;
pi_case_bas_z = 15.90 ;
//pi_case_bas_z = 30 ;

pi_case_haut_x = 64 ;
pi_case_haut_y = 93 ;
pi_case_haut_z = 10 ;

pi_case_lid_x = pi_case_bas_x ;
pi_case_lid_y = pi_case_bas_y ;
pi_case_lid_z = 11 ;

carte_sd_x = 16 ;
carte_sd_y = 8.1 ;
carte_sd_z = 8 ;

marge_alimentation_y = 9.5 ;
alimentation_x = 4.2 ;
alimentation_y = 13.20 ;
alimentation_z = 13.9 ;

marge_hdmi_y = 4.81 ;
hdmi_x = 4.2 ;
hdmi_y = 21 ;
hdmi_z = 14.9 ;

marge_jack_y = 6 ;
jack_x = 4.2 ;
jack_y = 10 ;
jack_z = 13.9 ;

bloc_eth_usb_x = 55;
bloc_eth_usb_y = 4.2 ;
bloc_eth_usb_z = 23.49 ;

bloc_eth_usb_lid_x = 55;
bloc_eth_usb_lid_y = 4.2 ;
bloc_eth_usb_lid_z = 10 ;

aeration_hole_lid_x = 50;
aeration_hole_lid_y = 2;
aeration_hole_lid_z = 8;

support_cluster_shift_x = 2 ;
support_cluster_shift_y = 2 ;
support_cluster_x = 10 ;
support_cluster_y = 10 ;
support_cluster_z = 8 ;
support_cylindre_diametre = 7 ;
support_cylindre_z = 6 ;


marge_1_x_bord_support = 2.51 ;
marge_1_y_bord_support = 2.51 ;

marge_2_x_bord_support = 2.51 ;
marge_2_y_bord_support = 22.50 ;

support_x = 6 ;
support_y = 6 ;
support_z = 2 ;

pico_bas_diametre = 2 ;
pico_bas_z = 1.25 ;

pico_haut_diametre = 1.20 ;
pico_haut_z = 1.25 ;

module support_pi() {
    union() {
        cube([support_x,support_y,support_z],center=true);
        translate([0,0,support_z/2+pico_bas_z/2]) {
            cylinder(h=pico_bas_z,d=pico_bas_diametre,center=true);
            translate([0,0,pico_bas_z/2+pico_haut_z/2]) {
                cylinder(h=pico_haut_z,d1=pico_bas_diametre,d2=pico_haut_diametre,center=true);
            }
        }
    }
}

module cote_pi_case_bas() {
    difference() {
        difference() {
            difference() {
                difference() {
                    cube([pi_case_bas_x,pi_case_bas_y,pi_case_bas_z],center=true);
                    translate([0,0,2]) {
                        cube([pi_case_bas_x-8,pi_case_bas_y-8,pi_case_bas_z],center=true);
                    }
                }
                translate([0,pi_case_bas_y/2,-(pi_case_bas_z/2)+carte_sd_z/2-.1]) {
                    cube([carte_sd_x,carte_sd_y,carte_sd_z],center=true);
                }
            }
            translate([-pi_case_bas_x/2,pi_case_bas_y/2,-pi_case_bas_z/2]) {
                translate([-0.1,-(marge_alimentation_y+alimentation_y),-0.1]) {
                    cube([alimentation_x,alimentation_y,alimentation_z]);
                    translate([0,-(marge_hdmi_y+hdmi_y),0]) {
                        if ( do_hdmi ) {
                            cube([hdmi_x,hdmi_y,hdmi_z]);
                        }
                        translate([0,-(marge_jack_y+jack_y),0]) {
                            if ( do_jack ) {
                                cube([jack_x,jack_y,jack_z]);
                            }
                        }
                    }
                }
            }
        }
        translate([-(pi_case_bas_x/2)+(pi_case_bas_x-bloc_eth_usb_x)/2,-(pi_case_bas_y/2+0.1),-(pi_case_bas_z/2+0.1)]) {
            cube([bloc_eth_usb_x,bloc_eth_usb_y,bloc_eth_usb_z]);
        }
    }
}

module cote_pi_case_haut() {
    difference() {
        translate([0,0,pi_case_bas_z/2+pi_case_haut_z/2]) {
            difference() {
                cube([pi_case_haut_x,pi_case_haut_y,pi_case_haut_z],center=true);
                cube([pi_case_haut_x-4,pi_case_haut_y-4,pi_case_haut_z+2],center=true);
            }
        }
        translate([-(pi_case_bas_x/2)+(pi_case_bas_x-bloc_eth_usb_x)/2,-(pi_case_bas_y/2+0.1),-(pi_case_bas_z/2+0.1)]) {
            cube([bloc_eth_usb_x,bloc_eth_usb_y,bloc_eth_usb_z]);
        }
    }
}

module support_cluster() {
    difference() {
        cube([support_cluster_x,support_cluster_y,support_cluster_z],center=true);
        translate([0,0,-(support_cluster_z-support_cylindre_z)/2-0.1]) {
            cylinder(h=support_cylindre_z,d=support_cylindre_diametre,center=true);
        }
    }
}


module add_supports_cluster(translate_x, translate_y, translate_z, do_rotate) {
    translate([ translate_x, translate_y, translate_z]) {
        if ( do_rotate ) {
            rotate([180,0,0]) {
                support_cluster();
            }
        } else {
            support_cluster();
        }
    }

    translate([-translate_x, translate_y, translate_z]) {
        if ( do_rotate ) {
            rotate([180,0,0]) {
                support_cluster();
            }
        } else {
            support_cluster();
        }
    }

    translate([ translate_x,-translate_y, translate_z]) {
        if ( do_rotate ) {
            rotate([180,0,0]) {
                support_cluster();
            }
        } else {
            support_cluster();
        }
    }

    translate([-translate_x,-translate_y, translate_z]) {
        if ( do_rotate ) {
            rotate([180,0,0]) {
                support_cluster();
            }
        } else {
            support_cluster();
        }
    }
}

module pi_bas() {
    union() {
        cote_pi_case_bas();
        cote_pi_case_haut();
        
        if ( do_supports_cluster ) {
            add_supports_cluster(   (pi_case_bas_x/2+support_cluster_x/2-2),
                                    (pi_case_bas_y/2+support_cluster_y/2-2),
                                   -(pi_case_bas_z/2-support_cluster_z/2),
                                    false);
        }

        if ( do_supports_pi ) {
            translate([ (pi_case_bas_x/2-support_x/2-4-marge_1_x_bord_support),
                        (pi_case_bas_y/2-support_y/2-4-marge_1_y_bord_support),
                       -(pi_case_bas_z/2-support_z/2)+support_z]) {
                support_pi();
            }

            translate([-(pi_case_bas_x/2-support_x/2-4-marge_1_x_bord_support),
                        (pi_case_bas_y/2-support_y/2-4-marge_1_y_bord_support),
                       -(pi_case_bas_z/2-support_z/2)+support_z]) {
                support_pi();
            }

            translate([ (pi_case_bas_x/2-support_x/2-4-marge_2_x_bord_support),
                       -(pi_case_bas_y/2-support_y/2-4-marge_2_y_bord_support),
                       -(pi_case_bas_z/2-support_z/2)+support_z]) {
                support_pi();
            }

            translate([-(pi_case_bas_x/2-support_x/2-4-marge_2_x_bord_support),
                       -(pi_case_bas_y/2-support_y/2-4-marge_2_y_bord_support),
                       -(pi_case_bas_z/2-support_z/2)+support_z]) {
                support_pi();
            }
        }
        
    }
}

module pi_lid() {
    translate([0,0,pi_case_bas_z/2+pi_case_haut_z/2+1]) {
        difference() {
            difference() {
                difference() {
                        cube([pi_case_lid_x,pi_case_lid_y,pi_case_lid_z],center=true);
                        translate([0,0,-2]) {
                            cube([pi_case_lid_x-3.6,pi_case_lid_y-3.6,pi_case_lid_z],center=true);
                        }
                }
                translate([0,-pi_case_lid_y/2,-3]) {
                    cube([bloc_eth_usb_lid_x,bloc_eth_usb_lid_y,bloc_eth_usb_lid_z],center=true);
                }
            }

            if ( do_aerations_lid ) {
                for(step_y=[0:8]) {
                    translate([0,step_y*(aeration_hole_lid_y+3),aeration_hole_lid_z/2]) {
                        cube([aeration_hole_lid_x,aeration_hole_lid_y,aeration_hole_lid_z],center=true);
                    }
                }

                for(step_y=[1:8]) {
                    translate([0,-step_y*(aeration_hole_lid_y+3),aeration_hole_lid_z/2]) {
                        cube([aeration_hole_lid_x,aeration_hole_lid_y,aeration_hole_lid_z],center=true);
                    }
                }
            }
        }
        
        if ( do_supports_cluster ) {
            
            add_supports_cluster(   (pi_case_lid_x/2+support_cluster_x/2-2),
                                    (pi_case_lid_y/2+support_cluster_y/2-2),
                                   +(pi_case_lid_z/2-support_cluster_z/2),
                                    true);
        }
    }
}

module main() {
    if ( do_pi_bas ) {
        pi_bas();
    }

    if ( do_pi_lid ) {
        pi_lid();
    }

}

main();
