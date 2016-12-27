//fun holder

points=[[6,16],[6,10],[0,10],[0,0],[30,0],[30,10],[24,10],[24,16],[22,16],[22,8],[28,8],[28,4],[26,2],[4,2],[2,4],[2,8],[8,8],[8,16]];

solid_paths=[[0,1,2,3,4,5,6,7]];

paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]];



difference()
{
 linear_extrude(height = 30, center = false, convexity = 10, twist = 0)
 polygon(points, paths,convexity=10);
 $fn=80;
    //powinno byc 15,17,37 ale grzalka nie jest symetrycznie tutaj
 translate([13,17,37]) rotate([90,0,0])cylinder(34,11,11);
}