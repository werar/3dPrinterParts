out_y=54;

 out=[[5,0],[150,0],[150+5-0.9,3.4],[155,out_y/2],[150+5-0.9,out_y-3.4],[150,out_y],[5,out_y],[0.9,out_y-3.4],[0,out_y/2],[0.9,3.4]];
 //b=[[3,0,1,2]];
 polygon(out);
 
 translate([2.3,2.4,5]) scale([149/155,49/out_y,1])  polygon(out);
 

 
 //polygon(a,b);
 //polygon(a,[[2,3,0,1,2]]);