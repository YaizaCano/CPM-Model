# Implementation of the basic CPM-PERT

# Corresponds to each of the set of milestones,
# nodes of the AOA
set MILESTONES;

# Each task is represented as a task between
# two different milestones
# (origin, dest), that is LINKS == (origin, destination) pair
set TASKS within {MILESTONES, MILESTONES};

# representes instant when tasks (i, j) must finalize
# where durations{j}
var t{MILESTONES} >= 0;

# represents the duration of a task
param durations{TASKS} >= 0;

# reprsents the inactivity of a task
var inactivity{TASKS} >= 0;

# Define inactivity
s.t. define_inactivity{(i, j) in TASKS}: inactivity[i, j] = t[j] - t[i] - durations[i, j];

# NonNegativity
s.t. non_negative{(i, j) in TASKS}: t[i] + durations[i, j] - t[j] <= 0;

# minimize the total project time
minimize time:  sum{i in MILESTONES}t[i];
 
