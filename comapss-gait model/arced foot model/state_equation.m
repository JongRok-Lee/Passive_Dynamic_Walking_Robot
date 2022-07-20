function dxdt = state_equation(t, x)
% Jong Rok
% May 2021

global m m_H l g r phi_init L1 L2
% dynamic equation
% thst = x(1), thstdot = x(2), thsw = x(3), thswdot = x(4)
M=[m*(L1^2+L2^2+2*r^2)+m_H*(L1^2+r^2)+2*r*cos(phi_init+x(1))*(m*L1+m*L2+m_H*L1),-0.5*(l*m*(r*cos(phi_init+x(3))+L1*cos(x(1)-x(3))));
    -0.5*(l*m*(r*cos(phi_init+x(3))+L1*cos(x(1)-x(3)))),(l^2*m)/4];

C = [-x(2)^2*r*sin(phi_init+x(1))*(L1*m+L2*m+L1*m_H)+(l*m*x(4)^2*(r*sin(phi_init+x(3))-L1*sin(x(1)-x(3))))/2;
    (L1*l*m*x(2)^2*sin(x(1)-x(3)))/2];
G = [-g*m*(L1*sin(x(1))-r*sin(phi_init))-g*m*(L2*sin(x(1))-r*sin(phi_init))-g*m_H*(L1*sin(x(1))-r*sin(phi_init));
    (g*l*m*sin(x(3)))/2];

ddx  = M\(-C-G);     % faster, IMPORTANT
dxdt = [x(2);ddx(1);x(4);ddx(2)];
