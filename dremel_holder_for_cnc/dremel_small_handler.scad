//Mocowanie małego dremelka

m=1; //szerzej o 1mm
w=5; //grubosc scianek lejka

difference()
{
    difference()
    {
        translate([10,-30,0])cube([15,60,35],center=false); //podstawa mocowania
        //otwory
        translate([5,-22,27]) rotate([0,90,0]) cylinder(h=25, r=3/2,$fn=30); 
        translate([5,-22,8]) rotate([0,90,0]) cylinder(h=25, r=3/2,$fn=30);
        translate([5,22,27]) rotate([0,90,0]) cylinder(h=25, r=3/2,$fn=30); 
        translate([5,22,8]) rotate([0,90,0]) cylinder(h=25, r=3/2,$fn=30);
    }
    rotate_extrude($fn=200) polygon( points=[[15.7/2+m,0],[17.8/2+m,3],[19/2+m,7.5],[20.1/2+m,12],[21.0/2+m,16.3],[21.95/2+m,20.7],[23.46/2+m,28.8],[24.77/2+m,35],[0,35],[0,0]]);
}
    
difference()
{
    union()
    {
        rotate_extrude($fn=200) polygon( points=[[15.7/2+m,0],[17.8/2+m,3],[19/2+m,7.5],[20.1/2+m,12],[21.0/2+m,16.3],[21.95/2+m,20.7],[23.46/2+m,28.8],[24.77/2+m,35],[24.77/2+m+w,35],[15.7/2+m+w,0]] );
        difference()
        {
            translate([-28,-10,0]) cube([15,20,35],center=false); //do spięcia lejka z przodu
            //otwory
            translate([-19,15,8]) rotate([90,90,0]) cylinder(h=30, r=3/2,$fn=30);
            translate([-19,15,27]) rotate([90,90,0]) cylinder(h=30, r=3/2,$fn=30);
        }
    }
    translate([-30,-2.5,0]) cube([30,5,35],center=false); //wyciecie
}

 
