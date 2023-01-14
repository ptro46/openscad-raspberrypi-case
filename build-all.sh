#!/bin/bash

#
#
# /* [Pi Lid] */
# do_pi_lid = true ;
# do_aerations_lid = true ;

# /* [Pi Bottom case] */
# do_pi_bas = true ; // calculate pi bottom
# do_hdmi = true ;
# do_jack = true ;
# do_supports_pi = true ;

# /* [Cluster] */
# do_supports_cluster = true ;
#
#



for target in rpi-case-bottom-cluster-1 rpi-case-bottom-cluster-2 rpi-case-bottom-cluster-3 rpi-case-bottom-cluster-4 rpi-case-bottom-no-cluster-1 rpi-case-bottom-no-cluster-2 rpi-case-bottom-no-cluster-3 rpi-case-bottom-no-cluster-4 rpi-case-top-cluster-with-aeration rpi-case-top-cluster-without-aeration rpi-case-top-no-cluster-with-aeration rpi-case-top-no-cluster-without-aeration
do
	echo ${target}
	openscad -q -o ${target}.stl -p parameters.json -P ${target} boitier-pi-bas.scad
done


