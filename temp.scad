

dlugosc_lozyska=30;
srednica_lozyska=19;
wewnetrzna_srednica_lozyska=10;

margin=2;

odstep_miedzy_lozyskami=80;

dlugosc_sanek=200;
rozstaw_osi=44.67;


module bearing(x,y,z,r)
{
    difference()
    {
        cube([x+margin,y,z+margin]);
        rotate([-90,0,0]) 
        translate([x/2+margin/2,0,0])
        cylinder(y,r/2,r/2,false);
    }
}


module sanki(r)
{
    rotate([-90,0,0])
    cylinder(dlugosc_sanek,r/2,r/2,false);
    
    rotate([-90,0,0])
    translate([rozstaw_osi,0,0])
    cylinder(dlugosc_sanek,r/2,r/2,false);
}

module LM10UU()
{
    //LM10UU
    difference(){
        rotate([-90,0,0])
        cylinder(dlugosc_lozyska,srednica_lozyska/2,srednica_lozyska/2,false);
        rotate([-90,0,0])
        cylinder(dlugosc_lozyska,wewnetrzna_srednica_lozyska/2,wewnetrzna_srednica_lozyska/2,false);
    }
    
}

translate([-20/2-margin/2,0,0]) bearing(20,30,10,19);

translate([rozstaw_osi-20/2-margin/2,0,0]) bearing(20,30,10,19);
translate([rozstaw_osi,0,0]) LM10UU();

translate([rozstaw_osi-20/2-margin/2,odstep_miedzy_lozyskami,0]) bearing(20,30,10,19);
translate([rozstaw_osi,odstep_miedzy_lozyskami,0]) LM10UU();

translate([0,odstep_miedzy_lozyskami/2,0]) LM10UU();
translate([0,odstep_miedzy_lozyskami/2,0]) bearing(20,30,10,19);


sanki(10);
