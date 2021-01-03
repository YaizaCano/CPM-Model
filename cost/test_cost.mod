set MILESTONES:= 10 20 30 40 50;

set TASKS :=
10 30
10 20
20 50
30 40
30 50
40 50
;

param b0 = 200;
param alpha = 0.7;
param r = 15;

param normal_costs :=
10 30 1
10 20 3
20 50 7
30 40 100
30 50 1
40 50 100
;

param crash_costs :=
10 30 5
10 20 5
20 50 10
30 40 200
30 50 5
40 50 220
;

param crash_duration :=
10 30 3 # months
10 20 4
20 50 3
30 40 1
30 50 3
40 50 3

;

param normal_duration :=
10 30 30 # months
10 20 20
20 50 5
30 40 6
30 50 8
40 50 15

;
