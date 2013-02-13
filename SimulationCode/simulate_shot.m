function [ traj, t, v, w, valid ] = simulate_shot( r0, v0, w0, step )
% simulates a single shot with bounce.
% valid is false if shot is out of bounds/into the net
v = zeros(6,1);
v(1:3) = v0;
v(4:6) = w0;

[r2, traj1, vel, tot_time1, over_net_flag, in_table_flag] = ...
    get_position_on_table(r0, v, step);

t = [];

%did the ball go out of bounds?
if (~over_net_flag || ~in_table_flag)
    v = 0;
    w = 0;
    traj = 0;
    valid = false;
    return;
end

%time for first part of shot
t = tot_time1;

%new spin and velocity before bounce.
v1 = vel(1:3);
w1 = vel(4:6);

%new spin and velocity after bounce.
[v2, w2] = bounce(v1, w1);
v(1:3) = v2;
v(4:6) = w2;

%colour of first path before bounce
c = repmat([1 0 0], size(traj1,1), 1);

[pos, traj2, vel, tot_time2, over_net_flag, in_table_flag] = ...
    get_position_on_table(r2, v, step);

%total time for shot
t = [t ; t(end) + tot_time2];

%colour of second path after bounce
d = repmat([0 0 1], size(traj2,1), 1);

warning('off', 'MATLAB:hg:patch:RGBColorDataNotSupported');
C = [c; d];

v = vel(1:3);
w = vel(4:6);
traj = [traj1; traj2];
valid = 1;

scatter3(traj(:,1), traj(:,2), traj(:,3), 30, C );

xlabel('x');
ylabel('y');
zlabel('z');

table_l = getConstant('table_l');
table_w = getConstant('table_w');
xlim([-0.1 table_w+0.1]);
ylim([-0.1 table_l+0.1]);
zlim([-0.1, 0.7]);

end

