function [avg_path, avg_vel, avg_time, stdev_path, stdev_vel, stdev_t, num_valid] = monte_carlo(r0, v0_norm, w0_norm, step_size)
% Monte carlo simulation of various shots made
% Shot input is anywhere going forward with norm >= v_min, <= v_max

table_l = getConstant('table_l');
table_w = getConstant('table_w');
R = getConstant('R');

count = 0;
table_bounce_count = 0;

paths = zeros(step_size,1);
vels = zeros(step_size,1);
times = zeros(step_size,1);

for i = 1:step_size
    v_theta = rand * pi;
    v_phi = rand * 100/180 * pi;
    w_theta = rand * 2*pi;
    w_phi = rand * pi;
    
    [ traj, t, ~, ~, valid ] = ...
        simulate_shot( r0, ...
        v0_norm*[sin(v_phi)*cos(v_theta), sin(v_phi)*sin(v_theta), cos(v_phi)], ...
        w0_norm*[sin(w_phi)*cos(w_theta), sin(w_phi)*sin(w_theta), cos(w_phi)], 0.05 );
    
    if (~valid)
        continue;
    end
    
    % Determine when the shot goes out of bounds
    for j = 1:min(size(t,1),size(traj,1)) 
        if (traj(j,3) < R)
            table_bounce_count = table_bounce_count + 1;
        end
        
        if ((~(0 <= traj(j,1) && traj(j,1) <= table_w &&...
              0 <= traj(j,2) && traj(j,2) <= table_l)) || ...
              (j == min(size(t,1),size(traj, 1))) || ...
              table_bounce_count == 2)
            tot_time = t(j);
            break;
        end
    end
    count = count+1;
    
    traj_diff = diff(traj);
    traj_diff = traj_diff .* traj_diff;
    traj_diff = sum(traj_diff,2);
    traj_diff = sqrt(traj_diff);
    path_length = sum(traj_diff);
    
    paths(count) = path_length;
    vels(count) = path_length/tot_time;
    times(count) = tot_time;
    
    table_bounce_count = 0;
    
end
%count is the number of valid tests

avg_path = mean(paths(1:count));
avg_vel = mean(vels(1:count));
avg_time = mean(times(1:count));

stdev_path = std(paths(1:count));
stdev_vel = std(vels(1:count));
stdev_t = std(times(1:count));

num_valid = count;
end