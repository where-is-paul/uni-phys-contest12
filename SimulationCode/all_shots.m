function [l, v, t, sl, sv, st, n] = all_shots( r )
% average path length and velocity over all shots
% for a particular radius r
    
    changeR(r);
    
    pause(1);
    clear all;
    
    E = getConstant('energy');
    m = getConstant('m');
    r = getConstant('R');
    
    I = (2/3) * m * r^2;
    v0 = sqrt(2*(1/2)*E/m);
    w0 = sqrt(2*(1/2)*E/I);
    r0 = [1.525/2, 0, 0.4];
    disp(v0);
    disp(w0);
    disp(m);
    disp(r);
    [l, v, t, sl, sv, st, n] = ...
        monte_carlo(r0, v0, w0, 2000);
    
end

