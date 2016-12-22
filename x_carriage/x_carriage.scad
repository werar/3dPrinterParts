

dlugosc_lozyska=30;
srednica_lozyska=19;
wewnetrzna_srednica_lozyska=10;


szerokosc_wsparcia_lozyska=20;
wysokosc_wsparcia_lozyska=10;
margin=2;


odstep_miedzy_lozyskami=80;

dlugosc_sanek=200;
rozstaw_osi=44.67;


wysokosc_glownej_powierzchni=7;
szerokosc_glownej_powierzchni=80;
glebokosc_glownej_powierzchni=100;

//Kolor dodatkowy  
sec_colour        = "OrangeRed";  


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
    difference(){
        rotate([-90,0,0])
        cylinder(dlugosc_lozyska,srednica_lozyska/2,srednica_lozyska/2,false);
        rotate([-90,0,0])
        cylinder(dlugosc_lozyska,wewnetrzna_srednica_lozyska/2,wewnetrzna_srednica_lozyska/2,false);
    }
    
}


module main_surface()
{
    difference()
    {
        translate([-(szerokosc_wsparcia_lozyska/2+margin/2),0,0])
        cube([szerokosc_glownej_powierzchni,glebokosc_glownej_powierzchni,wysokosc_glownej_powierzchni]);
        
        //otwor na grzalke
        translate([rozstaw_osi/2+2,glebokosc_glownej_powierzchni/2,0])grzalka();    
         //otwory na pasek
        x_offset_na_pasek=20;
        y_offset_na_pasek=20;
        translate([szerokosc_glownej_powierzchni-x_offset_na_pasek,y_offset_na_pasek,0]) zestaw_dziurek_na_pasek();    
    }
}


module grzalka()
{
    cylinder(32,16/2,16/2);
    //cylinder(32,24.78/2,24.78/2);
}


module dziurka_na_pasek()
{
    szerokosc_otworu_na_pasek=5;
    glebokosc_otworu_na_pasek=10;
    cube([szerokosc_otworu_na_pasek,szerokosc_otworu_na_pasek,wysokosc_glownej_powierzchni]);
   
}

module zestaw_dziurek_na_pasek()
{
            space_between=10;
            dziurka_na_pasek();
            translate([0,space_between,0]) dziurka_na_pasek();
            translate([0,3*space_between,0]) dziurka_na_pasek();
            translate([0,3*space_between+space_between,0]) dziurka_na_pasek();
}

//łożysko pierwsze z dwoch
translate([rozstaw_osi-szerokosc_wsparcia_lozyska/2-margin/2,0,0]) bearing(szerokosc_wsparcia_lozyska,30,wysokosc_wsparcia_lozyska,19);

//łożysko drugie z dwóch
translate([rozstaw_osi-szerokosc_wsparcia_lozyska/2-margin/2,odstep_miedzy_lozyskami,0]) bearing(szerokosc_wsparcia_lozyska,30,wysokosc_wsparcia_lozyska,19);

//łożysko na drugich sankach
translate([-20/2-margin/2,odstep_miedzy_lozyskami/2,0]) bearing(szerokosc_wsparcia_lozyska,30,wysokosc_wsparcia_lozyska,19);

//główna powierzchnia sanek
translate([0,0,wysokosc_wsparcia_lozyska+margin])main_surface();

translate([rozstaw_osi,0,0]) color(sec_colour)LM10UU();
translate([rozstaw_osi,odstep_miedzy_lozyskami,0]) color(sec_colour) LM10UU();
translate([0,odstep_miedzy_lozyskami/2,0]) color(sec_colour) LM10UU();
color(sec_colour){
translate([0,-20,0])sanki(10);
}
