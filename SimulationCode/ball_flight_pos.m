function [t_new, r] = ball_flight_pos(init, t, v)
% Given the velocity at given times (via ode**), returns the position of
% the ball

    del_t = diff(t);
    del_t = repmat(del_t,1,3);
    v_times_del_t = del_t .* v(1:end-1,:);

    r = cumsum(v_times_del_t,1);
    init = repmat(init,size(r,1),1);
    r = r + init;
    t_new = t(1:end-1,:);

end