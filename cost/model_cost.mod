# Implementation of CPM-PERT with cost restrictions

# Corresponds to each of the set of milestones,
# nodes of the AOA
set MILESTONES;

# Each task is represented as a task between
# two different milestones
# (origin, dest), that is LINKS == (origin, destination) pair
set TASKS within {MILESTONES, MILESTONES};
set REAL_TASKS within {MILESTONES, MILESTONES};

param crash_costs{TASKS} >= 0;
param normal_costs{TASKS} >= 0;

# represents the cost of exectuing the task
param normal_duration{TASKS} >= 0;
param crash_duration{TASKS} >= 0;


# alpha represents the relationship between the two objective functions
param alpha >= 0, <= 1;

# represents the money we currently have, it is the threshold for interest
param b0 >= 0;

# interest rate r
param r >= 0;

# represents the duration of a task
var durations{TASKS} >= 0;

var costs{TASKS} >= 0;


# represents the quantity to pay after money reaching the threshold b0
var interest_pay >= 0;

# represents the total quantity to pay without interest
var total_cost >= 0;

# represents the total duration
var total_duration >= 0;

# representes instant when tasks (i, j) must finalize
# where durations{j}
var t{MILESTONES} >= 0;

# reprsents the inactivity of a task
var inactivity{TASKS} >= 0;

# upper and lower bounds
s.t. calculate_duration{(i, j) in TASKS}: normal_duration[i, j] >= durations[i, j] >= crash_duration[i, j];
s.t. calculate_cost{(i, j) in TASKS}: normal_costs[i, j] <= costs[i, j] <= crash_costs[i, j];

# defines the relationship that exists betwen paying more and working faster
# it is a linear relationship so we need to calculate the bias and weight
s.t. relationship_cost_duration{(i, j) in REAL_TASKS}: costs[i, j] = ((durations[i, j] - crash_duration[i, j]) / (normal_duration[i, j] - crash_duration[i, j])) * (normal_costs[i, j] -crash_costs[i, j]) + crash_costs[i, j];


# defines the total cost
s.t. calculate_total_cost: total_cost = sum{(i, j) in TASKS} costs[i, j];

# defines total duration
s.t. calculate_total_duration: total_duration = sum{i in MILESTONES} t[i];

# defines the quantity to pay as interest as the extra money that is
# needed.
s.t. calculate_interest: interest_pay = max(total_cost - b0, 0) * r;

# Define inactivity
s.t. define_inactivity{(i, j) in TASKS}: inactivity[i, j] = t[j] - t[i] - durations[i, j];

# NonNegativity
s.t. non_negative{(i, j) in TASKS}: t[i] + durations[i, j] - t[j] <= 0;

# minimize the total project time and cost
minimize funct: alpha * (interest_pay + total_cost)  + (1 - alpha) * (total_duration);
