function [pos, traj, vel , tot_time, over_net_flag, in_table_flag] = get_position_on_table(r0, v0, stepSize)
% Returns (x,y) position of ball after it hits the table for a given
% initial position (r0) and initial velocity (v0).
% Requires r0(3)>R (z coordinate of bottom of ball must be above the
% table)
% table height is assumed to be 0

table_l = getConstant('table_l');
table_w = getConstant('table_w');
net_h = getConstant('net_h');
R = getConstant('R');

if (r0(1,3) <= R)
    return
end

%% Solve for trajectory
options = odeset('MaxStep', stepSize);
[t_vel, v] = ode23(@ball_flight_vel, [0 5], v0, options);

[t_pos, r] = ball_flight_pos(r0, t_vel, v(:,1:3));

%% Binary search to check if the ball went over the net

left = 1;
right = size(r,1);
mid = floor((left+right)/2);
R = getConstant('R');

while (not(r(mid,2) < (table_l/2) && r(mid+1,2) >= (table_l/2)))
    if (r(mid,2) > (table_l/2))
        right = mid;
    else
        left = mid;
    end
    mid = floor((left+right)/2);
    if (mid == 1 || mid == size(r,1)-1)
        break;
    end
end

if (r(mid,3) > net_h + R)
    over_net_flag = 1;
else
    over_net_flag = 0;
end

%% Binary search to find point where ball hits table
left = 1;
right = size(r,1);
mid = floor((left+right)/2);

while (not(r(mid,3) > R && r(mid+1,3) <= R))
    if (r(mid+1,3) > R)
        left = mid;
    else
        right = mid;
    end
    
    mid = floor((left+right)/2);
    if (mid == 1 || mid == size(r,1)-1)
        break;
    end
end

pos = r(mid, :);
traj = r(1:mid, :);
vel = v(mid, :);
tot_time = t_pos;

%% Check if the ball landed in the table
if (table_l/2 <= pos(2) && pos(2) <= table_l && 0 <= pos(1) && pos(1) <= table_w)
    in_table_flag = 1;
else
    in_table_flag = 0;
end

end

