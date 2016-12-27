// <Sopak's Common Hotend Library> (c) by <Kamil Sopko>
// 
// <Sopak's Common Hotend Library> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

//default precision
$fn = 50;


Gallery();


// gallery preview
module Gallery(transparency=1){

    rotate([0,180,0]){

        distance=30;
        
        translate([-30,0,63]) DiamondHotendAssembly();

        translate([1*distance,0,0]) E3D175V6Assembly(transparency=transparency);
        
        translate([2*distance,0,0]) E3D175V6Assembly(liteVersion=true, transparency=transparency);
        
        translate([3*distance,0,0]) E3D300V6Assembly(transparency=transparency);
        
        translate([4*distance,0,0]) E3D175V5Assembly(transparency=transparency);

        translate([5*distance,0,0]) E3D175V5Assembly(simplifiedVersion=true, transparency=transparency);

        translate([6*distance,0,0]) E3D300V5Assembly(transparency=transparency);

        translate([7*distance,0,0]) E3D300V5Assembly(simplifiedVersion=true, transparency=transparency);
        
    }
        
}

//V6 assembly 1.75mm
module E3D175V6Assembly(liteVersion=false, transparency=1){
    color("GhostWhite",transparency){
        E3D175V6Heatsink(liteVersion);            
    }

    if(!liteVersion){
        color("LightSteelBlue",transparency){
            translate([0,0,42.7-14.8])E3D175V6Break();    
        }
    }
    
    color("Ivory",transparency){
        translate([0,0,42.7+2.1+1])E3D175V6Block();            
    }
    
    color("DarkGoldenrod"){
        translate([0,0,42.7+2.1+11.5-6.4])E3D175V6Nozzle();
    }
    
}

//V6 assembly 3mm
module E3D300V6Assembly(transparency=1){
    color("GhostWhite",transparency){
        E3D300V6Heatsink();            
    }

    color("LightSteelBlue",transparency){
        translate([0,0,46-18])E3D300V6Break();    
    }
    color("Ivory",transparency){
        translate([0,0,46+2.1+1])E3D300V6Block();            
    }
    
    color("DarkGoldenrod"){
        translate([0,0,46+2.1+11.5-6.4])E3D300V6Nozzle();
    }
    
}




//E3D V6 NOZZLE 1.75 0.4
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-175-NOZZLE.png
module E3D175V6Nozzle(cr2=0.75,cr3=0.2) {
     E3DV6Nozzle(cr1=1,cr2=cr2,cr3=cr3);
}

//E3D V6 NOZZLE 3mm 0.4
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-300-NOZZLE.png
module E3D300V6Nozzle(cr2=0.75,cr3=0.2) {
     E3DV6Nozzle(cr1=1.6,cr2=cr2,cr3=cr3);
}


//E3D V6 NOZZLE 0.4
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-175-NOZZLE.png
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-300-NOZZLE.png
module E3DV6Nozzle(cr1=1,cr2=0.75,cr3=0.2) {
    difference(){  
        union(){
            cylinder(r1=2.5,r2=3,h=0.5);
            translate([0,0,0.5])cylinder(r=3,h=5.5);
            translate([0,0,6])cylinder(r=2.5,h=1.5);
            translate([0,0,7.5])cylinder(r=4,h=3,$fn=6);
            translate([0,0,10.5])cylinder(r1=2,r2=0.5,h=2);
        }
        union(){    
            cylinder(r1=cr1+0.2,r2=cr1,h=0.5);            
            translate([0,0,0.5])cylinder(r=cr1,h=10);            
            lnTriangle=tan(30)*(cr1-cr2);
            lnTriangle2=tan(30)*(cr2-cr3);
            translate([0,0,10.5]){  
                cylinder(r1=cr1,r2=cr2,h=lnTriangle);              
                translate([0,0,lnTriangle])cylinder(r=cr2,h=12.5-10.5-0.8-lnTriangle-lnTriangle2); 
                translate([0,0,12.5-10.5-0.8-lnTriangle2])cylinder(r1=cr2,r2=cr3,h=lnTriangle2);
                translate([0,0,12.5-10.5-0.8])cylinder(r=cr3,h=0.8);
            }       
        }
    }
}

//E3D V6 BLOCK 1.75
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-BLOCK.png
module E3D175V6Block() {
    E3DV6Block();
}

//E3D V6 BLOCK 3mm
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-BLOCK.png
module E3D300V6Block() {
    E3DV6Block();
}

//E3D V6 BLOCK
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-BLOCK.png
module E3DV6Block() {
    translate([-20+4.5,-8,0]){
        difference(){  
            union(){
                cube([20,16,11.5]);
            }
            union(){
                translate([20-17.5,8,0]) cylinder(r=1.5,h=11.5);
                translate([20-4.5,8,0]) cylinder(r=3,h=11.5);
                rotate([90,90,0]) {
                    translate([-11.5+4,20-11.5,-16]) cylinder(r=3,h=16.01);
                    translate([-11.5+4.8,20-3.5,-16]) cylinder(r=1.5,h=3.5);
                    translate([-11.5+2,20-2,-16]) cylinder(r=0.75,h=4.5);
                    translate([-11.5+2,20-2,-16]) cylinder(r=1,h=2);
                }
                translate([0,0,11.5-5])cube([20-11.5,16.01,2]);
            }
        }
    }
}

//E3D V6 BREAK 1.75
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-175-BREAK.png
module E3D175V6Break(cr1=2.1,cr2=1.0) {

    difference(){  
        union(){
            cylinder(r1=2.5,r2=3,h=0.5);
            translate([0,0,0.5])cylinder(r=3,h=6);
            translate([0,0,6])cylinder(r=3.5,h=14.8-6);
            translate([0,0,14.8])cylinder(r=2.4,h=2.1);
            translate([0,0,14.8+2.1])cylinder(r=3,h=7.1-2.1-0.5);
            translate([0,0,14.8+7.1-0.5])cylinder(r1=3,r2=2.5,h=0.5);
        }
        union(){    
            cylinder(r=cr1,h=6);            
            lnTriangle=tan(30)*(cr1-cr2);
            translate([0,0,6]){  
                cylinder(r1=cr1,r2=cr2,h=lnTriangle);              
                translate([0,0,lnTriangle])cylinder(r=cr2,h=7.1+14.8-6-lnTriangle);        
            }       
        }
    }
}

//E3D V6 BREAK 3
//same as version 5
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-300-BREAK.png
module E3D300V6Break() {
    E3D300V5Break();
}



//E3D V6 heatsink 1.75 version
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-175-SINK.png
//http://wiki.e3d-online.com/wiki/File:DRAWING-LITE6-175-SINK.png
module E3D175V6Heatsink(liteVersion=false) {
    difference(){
        union(){
            //head section
            translate([0,0,0])cylinder(r=8, h=3.7);
            translate([0,0,3.7])cylinder(r=6, h=6);
            translate([0,0,9.7])cylinder(r=8, h=3);
            translate([0,0,12.7])cylinder(r=4.5, h=1.5);
            translate([0,0,14.2])cylinder(r=8, h=1);
            
            //radiators 
            if(liteVersion){
                translate([0,0,15.2]){
                    cylinder(r=4.5, h=1.5);
                    translate([0,0,1.5]){
                        cylinder(r=11.15, h=1);
                        translate([0,0,1]){
                            cylinder(r=3.5, h=2);
                            translate([0,0,2]){
                                cylinder(r=11, h=1);
                                translate([0,0,1]){
                                    cylinder(r=3.05, h=3);
                                    translate([0,0,3]){
                                        cylinder(r=11, h=1);
                                        translate([0,0,1]){
                                            cylinder(r=3.5, h=2);
                                            translate([0,0,2]){
                                                cylinder(r=11.15, h=1);
                                                translate([0,0,1]){
                                                    cylinder(r=7, h=1.5);    
                                                    translate([0,0,1.5]){
                                                        cylinder(r=11.15, h=1);
                                                        translate([0,0,1]){
                                                            cylinder(r=3.5, h=2);    
                                                            translate([0,0,2]){
                                                                cylinder(r=11, h=1);
                                                                translate([0,0,1]){
                                                                    cylinder(r=3.05, h=2.25);
                                                                    translate([0,0,2.25]){
                                                                        cylinder(r=11, h=1);
                                                                        translate([0,0,1]){
                                                                            cylinder(r=3.05, h=2.25);
                                                                            translate([0,0,2.25]){
                                                                                cylinder(r=11, h=1);
                                                                                translate([0,0,1]){
                                                                                    cylinder(r=3.5, h=2);
                                                                                    translate([0,0,2]){
                                                                                        cylinder(r=11.15, h=1);
                                                                                        translate([0,0,1]){
                                                                                            cylinder(r=2.75, h=2.1);
                                                                                            translate([0,0,2.1]){
                                                                                                cylinder(r=3.05, h=4.5);
                                                                                                translate([0,0,4.5]){
                                                                                                    cylinder(r1=3,r2=2.5, h=0.5);
                                                                                                }                                                                                                
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }else{
            
                for(i=[0:10]){            
                    translate([0,0,15.2+(i*2.5)]){
                        
                        cylinder(r=4.5+i*(7-4.5)/11, h=1.5);
                        translate([0,0,1.5]) cylinder(r=11.15, h=1);
                    }
                }
            }
        }
        union(){            
            cr1=2.1;
            translate([0,0,0])cylinder(r=4.5,h=6.7);            
            lnTriangle=tan(30)*(4.5-cr1);
            translate([0,0,6.7]){        
                cylinder(r1=4.5,r2=cr1,h=lnTriangle);        
            }       
            
            if(liteVersion){
                translate([0,0,6.7+lnTriangle])cylinder(r=cr1,h=42.7-6.7-lnTriangle+7.1);    
            }else{            
                lnTriangle3=tan(30)*(3.5-cr1);
                translate([0,0,42.7-14.8-lnTriangle3])cylinder(r1=cr1,r2=3.5,h=lnTriangle3);    
                translate([0,0,42.7-14.8])cylinder(r=3.5,h=14.8);
                
                translate([0,0,6.7+lnTriangle])cylinder(r=cr1,h=42.7-14.8-6.7-lnTriangle-lnTriangle3);    
            }
        }
    }
}


//E3D V6 heatsink 3mm version
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-300-SINK-B.png
module E3D300V6Heatsink() {
    difference(){
        union(){
            //head section
            translate([0,0,0])cylinder(r=8, h=7);
            translate([0,0,7])cylinder(r=6, h=6);
            translate([0,0,13])cylinder(r=8, h=3);
            translate([0,0,16])cylinder(r=4.5, h=1.5);
            translate([0,0,17.5])cylinder(r=8, h=1);
            
            //radiators 
            for(i=[0:10]){            
                translate([0,0,46-27.5+(i*2.5)]){
                    
                    cylinder(r=4.5+i*(7-4.5)/11, h=1.5);
                    translate([0,0,1.5]) cylinder(r=11.15, h=1);
                }
            }
            
        }
        union(){            
            cr1=1.6;
                        
            lnTriangle=tan(30)*(6.5-4.5);
            lnTriangle2=tan(30)*(4.5-3.5);
            lnTriangle3=tan(30)*(3.5-cr1);
            lnTriangle4=tan(30)*(3-cr1);
            
            cylinder(r=6.5,h=5);            
            translate([0,0,5]){
                cylinder(r1=6.5,r2=4.5,h=lnTriangle);        
                               
                translate([0,0,lnTriangle-.01]){
                    cylinder(r=4.5,h=3);            
                    translate([0,0,3]){
                        cylinder(r1=4.5,r2=3.5,h=lnTriangle2);        
                        translate([0,0,lnTriangle2-.01]){
                            cylinder(r=3.5,h=5);  
                            translate([0,0,5]){
                                cylinder(r1=3.5,r2=cr1,h=lnTriangle3+0.01);        
                                translate([0,0,lnTriangle3]){
                                    cylinder(r=cr1,h=46-18-lnTriangle4-5-3-5-lnTriangle-lnTriangle2-lnTriangle3+0.02);            
                                }
                            }                        
                        }
                    }
                }
            }                                              
            
            translate([0,0,46-18-lnTriangle4])cylinder(r1=cr1,r2=3,h=lnTriangle4);    
            translate([0,0,46-18])cylinder(r=3,h=18);
            
        }
    }
}



//V5 assembly 1.75mm
module E3D175V5Assembly(simplifiedVersion=false,transparency=1){
    color("GhostWhite",transparency){
        E3D175V5Heatsink(simplifiedVersion);            
    }

    color("LightSteelBlue",transparency){
        translate([0,0,50.1-25.1+7.1])E3D175V5Break();    
    }
    color("Ivory",transparency){
        translate([0,0,50.1+2.1+1])E3D175V5Block();            
    }
    
    color("DarkGoldenrod"){
        translate([0,0,50.1+2.1+11.5-6.4])E3D175V5Nozzle();
    }
    
}

//V5 assembly 3mm
module E3D300V5Assembly(simplifiedVersion=false,transparency=1){
    color("GhostWhite",transparency){
        E3D300V5Heatsink(simplifiedVersion);            
    }

    color("LightSteelBlue",transparency){
        translate([0,0,50.1-25.1+7.1])E3D300V5Break();    
    }
    color("Ivory",transparency){
        translate([0,0,50.1+2.1+1])E3D300V5Block();            
    }
    
    color("DarkGoldenrod"){
        translate([0,0,50.1+2.1+11.5-6.4])E3D300V5Nozzle();
    }
    
}

//E3D V5 NOZZLE 1.75  same  like V6
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-175-NOZZLE.png
module E3D175V5Nozzle(cr1=1,cr2=0.75,cr3=0.2) {
    E3D175V6Nozzle(cr1,cr2,cr3);
}


//E3D V5 NOZZLE 3mm same  like V6
//http://wiki.e3d-online.com/wiki/File:DRAWING-V6-300-NOZZLE.png
module E3D300V5Nozzle(cr1=1,cr2=0.75,cr3=0.2) {
    E3D300V6Nozzle(cr1,cr2,cr3);
}




//E3D V5 BLOCK 1.75
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-BLOCK_rev5.jpg
module E3D175V5Block() {
    E3DV5Block();
}

//E3D V5 BLOCK 3mm
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-BLOCK_rev5.jpg
module E3D300V5Block() {
    E3DV5Block();
}

//E3D V5 BLOCK
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-BLOCK_rev5.jpg
//slighly modified as I have  this  at home ;)
module E3DV5Block() {
    translate([-16+6,-8,0]){
        difference(){  
            union(){
                cube([16,16,12]);
            }
            union(){
                translate([16-13.5,8,0]) cylinder(r=1.5,h=12);
                translate([16-6,8,0]) cylinder(r=3,h=12);
                rotate([90,90,0]) {
                    translate([-7,16-12.25,-16]) cylinder(r=3.05,h=16.01);
                    //translate([-11.5+4.8,20-3.5,-16]) cylinder(r=1.5,h=3.5);
                    //translate([-11.5+2,20-2,-16]) cylinder(r=0.75,h=4.5);
                    translate([-2,16-14,-16]) cylinder(r=1,h=16.01);
                    translate([-8.5,16-6,-16]) cylinder(r=1.25,h=8);
                    translate([-2.5,16-6,-16]) cylinder(r=1.25,h=8);
                }
                
            }
        }
    }
}


//E3D V5 BREAK 1.75mm
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-BREAK.jpg
module E3D175V5Break() {
    E3DV5Break(1);
}


//E3D V5 BREAK 3mm
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-BREAK.jpg
module E3D300V5Break() {
    E3DV5Break(1.6);
}

//E3D V5 BREAK
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-BREAK.jpg
module E3DV5Break(cr) {
    difference(){  
        union(){
            cylinder(r1=2,r2=2.4,h=0.5);
            translate([0,0,0.5])cylinder(r=2.4,h=4);
            translate([0,0,4.5])cylinder(r1=2.5,r2=3,h=0.5);
            translate([0,0,5])cylinder(r=3,h=20.6-2.1-5-0.5);
            translate([0,0,25.1-7.1])cylinder(r=cr+0.4,h=2.1);
            translate([0,0,25.1-5])cylinder(r=3,h=4.5);
            translate([0,0,25.1-.5])cylinder(r1=3,r2=2.5,h=0.5);
        }
        union(){    
            lnTriangle=tan(30)*(0.4);
            cylinder(r1=cr+0.4,r2=cr,h=lnTriangle);                        
            translate([0,0,lnTriangle]) cylinder(r=cr,h=25.1-lnTriangle);              
        }        
    }
}


//E3D V5 heatsink 1.75mm version
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-SINK.jpg
module E3D175V5Heatsink(simplifiedVersion=true)  {
    E3DV5Heatsink(simplifiedVersion,filamentDiameter=1.75);
}

//E3D V5 heatsink 3mm version
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-SINK.jpg
module E3D300V5Heatsink(simplifiedVersion=true)  {
    E3DV5Heatsink(simplifiedVersion,filamentDiameter=3);
}

//E3D V5 heatsink
//http://wiki.e3d-online.com/wiki/File:DRAWING-V5-SINK.jpg
module E3DV5Heatsink(simplifiedVersion=true,filamentDiameter=1.75)  {
    difference(){
        union(){
            //head section
            translate([0,0,0])cylinder(r=8, h=3.7);
            translate([0,0,3.7])cylinder(r=6, h=5.6);
            translate([0,0,9.3])cylinder(r=8, h=3);
            translate([0,0,12.3])cylinder(r=6, h=2.3);
            translate([0,0,14.6])cylinder(r=8, h=1.2);

            //center section
            
            if(simplifiedVersion){
                translate([0,0,18.3])cylinder(r=7.5, h=31.8);
                cylinder(r=6, h=50.1);
            }else{            
                cylinder(r=4.5, h=50.1);
                translate([0,0,33.1])cylinder(r=7.5, h=17);            
                translate([0,0,29.7])cylinder(r=6.5, h=17);
            }
            //radiators 
            for(i=[0:9]){            
                translate([0,0,50.1-3.4*i-1.2])cylinder(r=12.5, h=1.2);
            }
        }
        union(){            
            if(filamentDiameter==1.75){
                E3DV5HeatsinkCut(cr1=1,cr2=2,lD=4);                            
            }else{
                E3DV5HeatsinkCut(cr1=1.6,cr2=3.2,lD=6);
            }   
        }
    }   
}


// internal Cut module
module E3DV5HeatsinkCut(cr1,cr2,lD){
    translate([0,0,0])cylinder(r=cr1,h=51);
    
    translate([0,0,0])cylinder(r=4.5,h=10);            
    translate([0,0,10]){
        lnTriangle=tan(60)*(4.5-cr2);
        cylinder(r1=4.5,r2=cr2,h=lnTriangle);
        translate([0,0,lnTriangle]){
            cylinder(r=cr2,h=lD);
            lnTriangle2=tan(30)*(cr2-cr1);
            translate([0,0,lD])cylinder(r1=cr2,r2=cr1,h=lnTriangle2);
        }
    }
    
    lnTriangle3=tan(30)*(3-cr1);
    translate([0,0,51-18-lnTriangle3])cylinder(r1=1,r2=3,h=lnTriangle3);
    
    translate([0,0,51-18])cylinder(r=3,h=18);
}


//http://reprap.org/wiki/Diamond_Hotend
//Diamond Hotend V6 assembly 1.75mm
module DiamondHotendAssembly(transparency=1){
   rotate([0,180,0]){
        color("DarkGoldenrod",transparency){
            DiamondHotend();
        }
        
        for(i=[0:2]){            
            translate([0, 0, 1.5]){
                rotate([0,28,i*360/3]){
                    translate([0, 0, 42.7+27]){
                        rotate([0,180,0]){
                            color("GhostWhite",transparency){
                                E3D175V6Heatsink();            
                            }
                            color("LightSteelBlue",transparency){
                                translate([0,0,42.7-14.8])E3D175V6Break();    
                            }
                        }
                    }
                }
            }
        }
    }   
}



// Diamond Hotend
//http://reprap.org/mediawiki/images/7/73/Diamond_Nozzle.pdf
module DiamondHotend() {
	difference() {		
		union() {
			cylinder(r1=0.75, r2=27/2, h=18);
			
			translate([0, 0, 18])cylinder(r=27/2, h=3);
			
			translate([0, 0, 21])cylinder(r1=27/2, r2=3, h=5);
            
		}
        union(){
            cylinder(r=0.2, h=2); 
            translate([0, 0, 26-15])cylinder(r=3.05, h=15);
               
            //teplomer
            rotate([0,28,1*360/6]){
                translate([0, 0, 14.9])cylinder(r=1, h=10);
            }

            
        
            for(i=[0:2]){            
                translate([0, 0, 1.5]){
                    rotate([0,28,i*360/3]){
                        cylinder(r=0.2, h=2.5);    
                        translate([0, 0, 2.5])cylinder(r1=0.2,r2=1, h=0.5);    
                        translate([0, 0, -30])cylinder(r=0.05, h=100);    
                        
                        translate([0, 0, 3]){
                            cylinder(r=1, h=21);
                            translate([0, 0, 21-6]){
                                cylinder(r=3, h=6);
                            }
                        }
                    }
                }
            }
        }
	}     
}