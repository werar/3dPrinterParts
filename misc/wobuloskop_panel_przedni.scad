out_y=54;

 out=[[5,0],[150,0],[150+5-0.9,3.4],[155,out_y/2],[150+5-0.9,out_y-3.4],[150,out_y],[5,out_y],[0.9,out_y-3.4],[0,out_y/2],[0.9,3.4]];
 //b=[[3,0,1,2]];
 ;
 difference(){
 union(){
 linear_extrude(height = 1.9, center = false, convexity = 10, scale = 1.0) polygon(out);
 linear_extrude(height = 3, center = false, convexity = 10, scale = 1.0) translate([2.5,2.4,0]) scale([149/155,49/out_y,1])polygon(out);
 }

 //LCD
 //TODO: must be little higher
 translate([155-131,17,0]) cube([131-55,41-15,3],false);
 
 
 //holes
  translate([155-29.7,21.4,0]) cylinder(3,  d=7,false);
  translate([155-29.7,40.34,0]) cylinder(3,  d=7,false);
 }
 
 