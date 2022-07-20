function [v_H,v_1,v_2,v_U] = velocity(n0,x,v_H,v_1,v_2,v_U)
% JongRok Lee
global l l_U
SA = -0.5*(x(1:end-1,1) + x(1:end-1,3));
if rem(n0,2) == 1
    v_Hp = [-l*cos(x(1:end-1,1)).*x(1:end-1,2) -l*sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_10 = 0.5*[-l*cos(x(1:end-1,1)).*x(1:end-1,2) -l*sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_20 = v_Hp + 0.5*[l*cos(x(1:end-1,3)).*x(1:end-1,4) l*sin(x(1:end-1,3)).*x(1:end-1,4)];
    v_U0 = v_Hp + [-0.5*l_U*cos(SA).*(x(1:end-1,2)+x(1:end-1,4)) -0.5*l_U*sin(SA).*(x(1:end-1,2)+x(1:end-1,4))];
    
    v_H = [v_H; v_Hp];
    v_1 = [v_1; v_10];
    v_2 = [v_2; v_20];
    v_U = [v_U; v_U0];
    
else
    v_Hp = [-l*cos(x(1:end-1,1)).*x(1:end-1,2) -l*sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_20 = 0.5*[-l*cos(x(1:end-1,1)).*x(1:end-1,2) -l*sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_10 = v_Hp + 0.5*[l*cos(x(1:end-1,3)).*x(1:end-1,4) l*sin(x(1:end-1,3)).*x(1:end-1,4)];
    v_U0 = v_Hp + [-0.5*l_U*cos(SA).*(x(1:end-1,2)+x(1:end-1,4)) -0.5*l_U*sin(SA).*(x(1:end-1,2)+x(1:end-1,4))];
    
    v_H = [v_H; v_Hp];
    v_2 = [v_2; v_20];
    v_1 = [v_1; v_10];
    v_U = [v_U; v_10];
end
end
