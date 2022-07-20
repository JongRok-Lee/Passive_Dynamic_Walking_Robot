function dxdt = state_equation(t, x)
% Jong Rok
% May 2021

global m m_H m_U l l_U g

% dynamic equation
% thst = x(1), thstdot = x(2), thsw = x(3), thswdot = x(4)
M = [(5*l^2*m)/4 + l^2*m_H + l^2*m_U + (l_U^2*m_U)/4 + l*l_U*m_U*cos(x(1)/2 - x(3)/2), - (m*cos(x(1) - x(3))*l^2)/2 + (m_U*cos(x(1)/2 - x(3)/2)*l*l_U)/2 + (m_U*l_U^2)/4;
    - (m*cos(x(1) - x(3))*l^2)/2 + (m_U*cos(x(1)/2 - x(3)/2)*l*l_U)/2 + (m_U*l_U^2)/4, (m*l^2)/4 + (m_U*l_U^2)/4];
C = [-(l*l_U*m_U*x(2)*sin(x(1)/2 - x(3)/2))/4*x(2) + (l*l_U*m_U*x(4)*sin(x(1)/2 - x(3)/2))/4*x(4) - (l^2*m*x(4)*sin(x(1) - x(3)))/2*x(4);
   (l*x(2)*(l*m*sin(x(1) - x(3))*x(2) - l_U*m_U*sin(x(1)/2 - x(3)/2)))/2*x(2)];
G = [- g*m_U*((l_U*sin(x(1)/2 + x(3)/2))/2 + l*sin(x(1))) - (3*g*l*m*sin(x(1)))/2 - g*l*m_H*sin(x(1));
    (g*l*m*sin(x(3)))/2 - (g*l_U*m_U*sin(x(1)/2 + x(3)/2))/2];

ddx  = M\(-C-G);
dxdt = [x(2);ddx(1);x(4);ddx(2)];
