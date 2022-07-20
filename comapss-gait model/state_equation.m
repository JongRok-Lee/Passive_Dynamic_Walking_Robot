function dxdt = state_equation(t, x)
% JongRok Lee

global l m mh a b l g

% dynamic equation
% thst = x(1), thstdot = x(2), thsw = x(3), thswdot = x(4)

M = [mh*l*l + m*l*l + m*a*a, -m*l*b*cos(x(1)-x(3));
    -m*l*b*cos(x(1)-x(3)), m*b*b];
C = [-m*l*b*sin(x(1)-x(3))*x(4)*x(4);
      m*b*l*sin(x(1)-x(3))*x(2)*x(2)];
G = [-g*(mh*l + m*a + m*l)*sin(x(1));
      g*m*b*sin(x(3))];

ddx  = M\(-C-G);
dxdt = [x(2);ddx(1);x(4);ddx(2)];
