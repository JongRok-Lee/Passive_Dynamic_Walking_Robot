function dxdt = state_equation1(t, x)
% Jong Rok
% May 2021

global m m_H l g c
% dynamic equation
% thst = x(1), thstdot = x(2), thsw = x(3), thswdot = x(4)
M=[2*c^2*m+c^2*m_H+(5*l^2*m)/4+l^2*m_H,-(l*m*(l*cos(x(1)-x(3))+c*sin(x(1)-x(3))))/2;
    -(l*m*(l*cos(x(1)-x(3))+c*sin(x(1)-x(3))))/2,(l^2*m)/4];
C = [(l*m*x(4)^2*(c*cos(x(1)-x(3))-l*sin(x(1)-x(3))))/2;
    -(l*m*x(2)^2*(c*cos(x(1)-x(3))-l*sin(x(1)-x(3))))/2];
G = [(g*(4*c*m*cos(x(1))+2*c*m_H*cos(x(1))-3*l*m*sin(x(1))-2*l*m_H*sin(x(1))))/2;
    (g*l*m*sin(x(3)))/2];



ddx  = M\(-C-G);     % faster, IMPORTANT
dxdt = [x(2);ddx(1);x(4);ddx(2)];
