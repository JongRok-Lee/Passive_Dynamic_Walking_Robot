function [xi0, p_H,p_1,p_2,p_U,p_1p, p_2p, p_H1,p_11,p_21,p_U1] = position(n0,x,t,xi0,p_H,p_1,p_2,p_U,p_1p, p_2p, p_H1,p_11,p_21,p_U1)
% JongRok Lee
global l l_U
SA = -0.5*(x(1:end-1,1) + x(1:end-1,3));
if rem(n0,2) == 1
    p_Hp =xi0 + [-l*sin(x(1:end-1,1)) l*cos(x(1:end-1,1))];
    p_10 = xi0 + 0.5*[-l*sin(x(1:end-1,1)) l*cos(x(1:end-1,1))];
    p_20 = p_Hp + 0.5*[l*sin(x(1:end-1,3)) -l*cos(x(1:end-1,3))];
    p_U0 = p_Hp + [l_U*sin(SA) +l_U*cos(SA)];
    
    p_Hp1 = [-l*sin(x(1:end-1,1)) l*cos(x(1:end-1,1))];
    p_101 =  0.5*[-l*sin(x(1:end-1,1)) l*cos(x(1:end-1,1))];
    p_201 = p_Hp1 + 0.5*[l*sin(x(1:end-1,3)) -l*cos(x(1:end-1,3))];
    p_U01 = p_Hp1 + [l_U*sin(SA) +l_U*cos(SA)];
    
    
    p_H = [p_H; p_Hp];
    p_1 = [p_1; p_10];
    p_2 = [p_2; p_20];
    p_U = [p_U; p_U0];
    
    p_H1 = [p_H1; p_Hp1];
    p_11 = [p_11; p_101];
    p_21 = [p_21; p_201];
    p_U1 = [p_U1; p_U01];
    
    p_1p = [p_1p; ones(length(t)-1,1)*xi0(1) ones(length(t)-1,1)*xi0(2)];
    p_2p = [p_2p ;p_Hp + [l*sin(x(1:end-1,3)) -l*cos(x(1:end-1,3))]];
    % new zero point 
    xi0= xi0 + [-l*sin(x(end,1))+l*sin(x(end,3)) l*cos(x(end,1))-l*cos(x(end,3))];
else
    p_Hp = xi0 + [-l*sin(x(1:end-1,1)) l*cos(x(1:end-1,1))];
    p_20 = xi0 + 0.5*[-l*sin(x(1:end-1,1)) l*cos(x(1:end-1,1))];
    p_10 = p_Hp + 0.5*[l*sin(x(1:end-1,3)) -l*cos(x(1:end-1,3))];
    p_U0 = p_Hp + [l_U*sin(SA) +l_U*cos(SA)];
    
    p_Hp1 = [-l*sin(x(1:end-1,1)) l*cos(x(1:end-1,1))];
    p_201 = 0.5*[-l*sin(x(1:end-1,1)) l*cos(x(1:end-1,1))];
    p_101 = p_Hp1 + 0.5*[l*sin(x(1:end-1,3)) -l*cos(x(1:end-1,3))];
    p_U01 = p_Hp1 + [l_U*sin(SA) +l_U*cos(SA)];
    
    p_H = [p_H; p_Hp];
    p_2 = [p_2; p_20];
    p_1 = [p_1; p_10];
    p_U = [p_U; p_U0];
    
    p_H1 = [p_H1; p_Hp1];
    p_21 = [p_21; p_201];
    p_11 = [p_11; p_101];
    p_U1 = [p_U1; p_U01];
    
    % zero point
    p_2p = [p_2p ;ones(length(t)-1,1)*xi0(1) ones(length(t)-1,1)*xi0(2)];
    p_1p = [p_1p; p_Hp + [l*sin(x(1:end-1,3)) -l*cos(x(1:end-1,3))]];
    xi0= xi0 + [-l*sin(x(end,1))+l*sin(x(end,3)) l*cos(x(end,1))-l*cos(x(end,3))];
end
end
