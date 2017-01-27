//extruder do mk8


//parametry drukarki i standardowe wymiary
dlugosc_sanek=200;
rozstaw_osi=44.67;

show_not_related_components=0;

dlugosc_lozyska=30;
srednica_lozyska=19; //powinno byc 19
wewnetrzna_srednica_lozyska=10;

szerokosc_wsparcia_lozyska=20;
wysokosc_wsparcia_lozyska=10;
margin=4;

odstep_miedzy_lozyskami=dlugosc_lozyska+17;

wysokosc_glownej_powierzchni=7; //z
szerokosc_glownej_powierzchni=82; //x
glebokosc_glownej_powierzchni=2*dlugosc_lozyska+17; //y

//Kolor dodatkowy  
sec_colour = "OrangeRed";  

module bearing(x,y,z,r)
{
    $fn=80;
    difference()
    {
        cube([x+margin,y,z+margin]); 
        rotate([-90,0,0])translate([x/2+margin/2,0,0])cylinder(y,r/2,r/2,false);
        //otwory na drucik do przymocowania lozysk
        translate([-1,5,z+margin/3])rotate([0,90,0])cylinder(x+margin+2,1.5,1.5,false);
        translate([-1,y-5,z+margin/3])rotate([0,90,0])cylinder(x+margin+2,1.5,1.5,false);
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
    
    szerokosc_additional_part=18;
    glebokosc_additional_part=40;
    
    difference()
    {
        translate([origin_glownej_powierzchni,0,0])
        union()
        {
            difference()
            {
            cube([szerokosc_glownej_powierzchni,glebokosc_glownej_powierzchni,wysokosc_glownej_powierzchni]);
            //odchudzimy glowna powierzchnie
            translate([30,0,0]) cube([szerokosc_glownej_powierzchni,glebokosc_glownej_powierzchni/5,wysokosc_glownej_powierzchni]);
            translate([30,glebokosc_glownej_powierzchni-glebokosc_glownej_powierzchni/5,0]) cube([szerokosc_glownej_powierzchni,glebokosc_glownej_powierzchni/5,wysokosc_glownej_powierzchni]);
                
            }
            
            translate([-szerokosc_additional_part,glebokosc_glownej_powierzchni/2-glebokosc_additional_part/2,0])  
            main_surface_additional_part(szerokosc_additional_part,glebokosc_additional_part,wysokosc_glownej_powierzchni);
            
            //mocowanie lozysk
            //pierwsze z dwoch
             translate([0,0,-wysokosc_wsparcia_lozyska-margin]) bearing(szerokosc_wsparcia_lozyska,dlugosc_lozyska,wysokosc_wsparcia_lozyska,srednica_lozyska);
            //drugie z dwóch
            translate([0,odstep_miedzy_lozyskami,-wysokosc_wsparcia_lozyska-margin]) bearing(szerokosc_wsparcia_lozyska,dlugosc_lozyska,wysokosc_wsparcia_lozyska,srednica_lozyska);
            
            
            //pojednycze
            translate([rozstaw_osi,odstep_miedzy_lozyskami/2,-wysokosc_wsparcia_lozyska-margin]) 
            bearing(szerokosc_wsparcia_lozyska,dlugosc_lozyska,wysokosc_wsparcia_lozyska,srednica_lozyska);  
        }
  
        //otwor na grzalke 
        przesuniecie_grzalki_poza_os=-24;
        os_grzalki=[przesuniecie_grzalki_poza_os,glebokosc_glownej_powierzchni/2+4,0];
        translate(os_grzalki)
        {
            grzalka();
            $fn=80;
            //otwory montazowe extrudera //ok 17 od osi grzalki
            translate([0,-16.8,0])cylinder(wysokosc_glownej_powierzchni,2,2);
           
       }    
       $fn=80;
       //pomocnicze otwory na solidniejsze przymocowanie mk8
       //wspolrzedne na oko
       translate([16,20,0])cylinder(wysokosc_glownej_powierzchni,1.5,1.5);
       translate([16,57,0])cylinder(wysokosc_glownej_powierzchni,1.5,1.5);
       
        //otwory na pasek
        x_offset_na_pasek=22;
        y_offset_na_pasek=5;
        translate([szerokosc_glownej_powierzchni-x_offset_na_pasek,glebokosc_glownej_powierzchni/2,0]) zestaw_dziurek_na_pasek();    
    }

}
module main_surface_additional_part(x,y,z) //where hotend is inserted
{
   cube([x,y,z]);
}

module grzalka()
{
    $fn=50;
    promien_wejscia_do_extrudera=15/2;
    translate([0,0,0]) cylinder(17,promien_wejscia_do_extrudera,promien_wejscia_do_extrudera); 
    //wyciecie aby nie wykrecac grzalki
    translate([-20,-promien_wejscia_do_extrudera,0])cube([20,promien_wejscia_do_extrudera*2,50]);
}


module dziurka_na_pasek(szerokosc_otworu_na_pasek,glebokosc_otworu_na_pasek)
{
    cube([szerokosc_otworu_na_pasek,glebokosc_otworu_na_pasek,wysokosc_glownej_powierzchni]);
   
}

module zestaw_dziurek_na_pasek()
{
    szerokosc_otworu_na_pasek=8;
    glebokosc_otworu_na_pasek=5;
    space_between=6;
    
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
translate([rozstaw_osi,odstep_miedzy_lozyskami/2,0]) color(sec_colour)LM10UU();
translate([0,odstep_miedzy_lozyskami,0]) color(sec_colour) LM10UU();
translate([0,0,0]) color(sec_colour) LM10UU();
color(sec_colour){
translate([0,-20,0])sanki(10);
}
}

//grzalka();
