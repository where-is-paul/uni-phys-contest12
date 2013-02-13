function [v2, w2] = bounce( v1, w1 )
% obtains the new velocity (v2) and new spin (w2) of the ball after one
% bounce on the table with initial velocity (v1) and spin (w2)
mu = getConstant('mu');
cor = getConstant('cor');
r = getConstant('R');

%u = v_xy + (w x r);
u = v1(1:2) + [ -r * w1(2), r * w1(1) ]; 

%alpha = mu * (1+coeff of restitution) * |v_z|/||u||
a = mu * (1+cor) * abs(v1(3))/norm(u, 2);
a = min(a, 2/5);

Av = [1-a  0    0;
     0     1-a  0;
     0     0    -cor];
Bv = [0    a*r 0;
      -a*r 0   0;
      0    0   0];
  
Aw = [0             -3*a/(2*r)    0;
      3*a/(2*r)     0             0;
      0             0             0];
Bw = [1-3*a/2    0         0;
      0          1-3*a/2   0;
      0          0         0];
  
v2 = Av*v1' + Bv*w1';
w2 = Aw*v1' + Bw*w1';

end

