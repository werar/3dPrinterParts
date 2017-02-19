/*
Solar holder
Used with flat surface to mount chip solar panels (11x6)
*/


/* [Main Settings] */
//Holder thickness (Z)
holder_thicknes=5;

//Holder width
holder_height=3;

//Holder dimention near mounting surface
sufrace_width=20;
sufrace_height=5;
surface_thicknes=7;

//Solar mount part height (from surface)
solar_mount_part_height=10;
// Solar thickness
solar_thickness=3.1;

//Solar top and bottom holder width
solar_bottom_holder_width=6;
solar_top_holder_width=5;

module surface_part()
{
    screw_diameter=3;
    $fn=100;
    
    difference()
    {
        cube([sufrace_width,sufrace_height,surface_thicknes]);
        //screw hole
        translate([sufrace_width*0.8,0,surface_thicknes/2])rotate([-90,0,0])cylinder(holder_thicknes,screw_diameter/2,screw_diameter/2);   
    }
}



module main()
{
    surface_part();
    
    cube([holder_height,get_total_height(),holder_thicknes]);
    
    translate([0,solar_mount_part_height,0])cube([holder_height+solar_bottom_holder_width,holder_height,holder_thicknes]);
    
    translate([0,solar_mount_part_height+solar_thickness+holder_height,0])cube([holder_height+solar_top_holder_width,holder_height,holder_thicknes]);
    
}

main();

function get_total_height()=solar_mount_part_height+holder_thicknes+solar_thickness;  