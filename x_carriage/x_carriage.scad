
show_not_related_components=0;

dlugosc_lozyska=30;
srednica_lozyska=19;
wewnetrzna_srednica_lozyska=10;


szerokosc_wsparcia_lozyska=20;
wysokosc_wsparcia_lozyska=10;
margin=4;


odstep_miedzy_lozyskami=dlugosc_lozyska+32;

dlugosc_sanek=200;
rozstaw_osi=44.67;


wysokosc_glownej_powierzchni=7;
szerokosc_glownej_powierzchni=80;
glebokosc_glownej_powierzchni=2*dlugosc_lozyska+32;

//Kolor dodatkowy  
sec_colour        = "OrangeRed";  


module bearing(x,y,z,r)
{
    $fn=80;
    difference()
    {
        cube([x+margin,y,z+margin]); 
        rotate([-90,0,0])translate([x/2+margin/2,0,0])cylinder(y,r/2,r/2,false);
        //otwory na drucik do przymocowania lozysk
        translate([0,5,z+margin/3])rotate([0,90,0])cylinder(x,1.5,1.5,false);
        translate([0,y-5,z+margin/3])rotate([0,90,0])cylinder(x,1.5,1.5,false);
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
    difference(){
        rotate([-90,0,0])
        cylinder(dlugosc_lozyska,srednica_lozyska/2,srednica_lozyska/2,false);
        rotate([-90,0,0])
        cylinder(dlugosc_lozyska,wewnetrzna_srednica_lozyska/2,wewnetrzna_srednica_lozyska/2,false);
    }
    
}


module main_surface()
{
    origin_glownej_powierzchni=-(szerokosc_wsparcia_lozyska/2+margin/2);
    difference()
    {
        translate([origin_glownej_powierzchni,0,0])
        union()
        {
            cube([szerokosc_glownej_powierzchni,glebokosc_glownej_powierzchni,wysokosc_glownej_powierzchni]);
            szerokosc_additional_part=20;
            glebokosc_additional_part=25;
            translate([-szerokosc_additional_part,glebokosc_glownej_powierzchni/2-glebokosc_additional_part/2,0])  
            main_surface_additional_part(szerokosc_additional_part,glebokosc_additional_part,wysokosc_glownej_powierzchni);
            
            //mocowanie lozysk
            //pierwsze z dwoch
            translate([rozstaw_osi,0,-wysokosc_wsparcia_lozyska-margin]) 
            bearing(szerokosc_wsparcia_lozyska,dlugosc_lozyska,wysokosc_wsparcia_lozyska,srednica_lozyska);
            //drugie z dwóch
            translate([rozstaw_osi,odstep_miedzy_lozyskami,-wysokosc_wsparcia_lozyska-margin]) bearing(szerokosc_wsparcia_lozyska,dlugosc_lozyska,wysokosc_wsparcia_lozyska,srednica_lozyska);
            //pojednycze
            translate([0,odstep_miedzy_lozyskami/2,-wysokosc_wsparcia_lozyska-margin]) bearing(szerokosc_wsparcia_lozyska,dlugosc_lozyska,wysokosc_wsparcia_lozyska,srednica_lozyska);
            
        }
  
        //otwor na grzalke 
        x_offet_grzalka=2;
        os_grzalki=[rozstaw_osi/2+x_offet_grzalka,glebokosc_glownej_powierzchni/2,0];
        translate(os_grzalki)
        {
            grzalka();
            //otwory montazowe extrudera
            translate([14.5,0,0])cylinder(wysokosc_glownej_powierzchni,3/2,3/2);
            translate([-45,0,0])cylinder(wysokosc_glownej_powierzchni,3/2,3/2);
        }    
        //otwory na pasek
        x_offset_na_pasek=20;
        y_offset_na_pasek=20;
        translate([szerokosc_glownej_powierzchni-x_offset_na_pasek,glebokosc_glownej_powierzchni/2,0]) zestaw_dziurek_na_pasek();    
    }

}
module main_surface_additional_part(x,y,z)
{
   cube([x,y,z]);
}

module grzalka()
{
    $fn=50;
    cylinder(32,16/2,16/2);
    //cylinder(32,24.78/2,24.78/2);
}


module dziurka_na_pasek(szerokosc_otworu_na_pasek,glebokosc_otworu_na_pasek)
{
    cube([szerokosc_otworu_na_pasek,glebokosc_otworu_na_pasek,wysokosc_glownej_powierzchni]);
   
}

module zestaw_dziurek_na_pasek()
{
    szerokosc_otworu_na_pasek=5;
    glebokosc_otworu_na_pasek=8;
    space_between=10;
    
    translate([0,space_between/2])
    dziurka_na_pasek(szerokosc_otworu_na_pasek,glebokosc_otworu_na_pasek);
    translate([0,1.8*space_between,0]) dziurka_na_pasek(szerokosc_otworu_na_pasek,glebokosc_otworu_na_pasek);
    translate([0,-space_between/2-glebokosc_otworu_na_pasek/2,0]) dziurka_na_pasek(szerokosc_otworu_na_pasek,glebokosc_otworu_na_pasek);
    translate([0,-1.8*space_between-glebokosc_otworu_na_pasek/2,0]) dziurka_na_pasek(szerokosc_otworu_na_pasek,glebokosc_otworu_na_pasek);
}

//calosc


//główna powierzchnia sanek
translate([0,0,wysokosc_wsparcia_lozyska+margin])main_surface();



if(show_not_related_components)
{

//dodatkowe elementy ktore nie sa czesia detalu
translate([rozstaw_osi,0,0]) color(sec_colour)LM10UU();
translate([rozstaw_osi,odstep_miedzy_lozyskami,0]) color(sec_colour) LM10UU();
translate([0,odstep_miedzy_lozyskami/2,0]) color(sec_colour) LM10UU();
color(sec_colour){
translate([0,-20,0])sanki(10);
}
}


