/* Objective function */
max: -z;

/* Variable bounds */
 z >= m + b - 3;
 z >= -m - b +3;
 
 z >= 2m + b - 5;
 z >= -2m - b + 5;
 
 z >= 3m + b - 7;
 z >= -3m - b +7;
 
 z >= 5m + b - 11;
 z >= -5m - b +11;

 z >= 7m + b - 14;
 z >= -7m - b + 14;

 z >= 8m + b - 15;
 z >= -8m - b +15;
 
 z >= 10m + b - 19;
 z >= -10m - b +19;
 
 z >= 0;
 b >= 0;
 m >= 0;