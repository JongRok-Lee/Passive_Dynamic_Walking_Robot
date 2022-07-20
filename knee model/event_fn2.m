function [valu, isterm, direc] = event_fn2(t,x)
%JongRok Lee, 2020 11 25
global phi_init L


x_end_thsw = -L*sin(x(1)+phi_init) + L*sin(x(3)+phi_init);
y_end_thsw =  L*cos(x(1)+phi_init) - L*cos(x(3)+phi_init);

scuffing = (x_end_thsw <= 0); 

valu   = y_end_thsw;
isterm = ~scuffing;
direc  = -1;       
