function [valu, isterm, direc] = event_fn1(t,x)
%JongRok Lee, 2020 11 25
global phi_init L


x_end_thsw = -L*sin(x(1)+phi_init) + L*sin(x(3)+phi_init);
y_end_thsw =  x(3) - x(5);

scuffing = (x_end_thsw <= 0);     % if dy is increasing, direc = 1;

valu   = y_end_thsw;
isterm = 1;
direc  = -1; 
