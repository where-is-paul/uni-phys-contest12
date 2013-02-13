function vp = ball_flight_vel(t,v)
% Velocity of ping pong ball during flight influenced by gravity, drag and
% magnus force
% v(1:3) is translational velocity
% v(4:6) is rotational velocity

    R = getConstant('R');
    rho = getConstant('rho');
    kin_vis = getConstant('kin_vis');
    m = getConstant('m');
    mag_const = 16/3*pi*pi*R^3;
    drag_const = 0.5*pi*R^2*getConstant('C_d')*rho;
    v_norm = norm(v(1:3),2);
    vp(1:3,1) = 1/m * ...
              [-drag_const*v_norm,    -mag_const*v(6),        mag_const*v(5);
    
                mag_const*v(6),       -drag_const*v_norm,    -mag_const*v(4);
           
               -mag_const*v(5),        mag_const*v(4),       -drag_const*v_norm] * v(1:3);
    
    vp = vp - [0,0,getConstant('g')]';
    
    %Update angular rotation
    I = 2/3 * m * R^2;
    w_norm = norm(v(4:6),2);
    Re = w_norm*R*2*R/kin_vis;
    
    rot_drag_cost = 0.5 * R^5 * rho * Re/I;
    vp(4:6) = -rot_drag_cost * diag([w_norm,w_norm,w_norm]) * v(4:6);
end
