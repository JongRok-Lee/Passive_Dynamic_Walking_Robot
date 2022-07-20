function [valu, isterm, direc] = event_fn2(t,x)
% JongRok Lee

global phi_init l c d

x_end_thsw = -l*sin(x(1)+phi_init) + l*sin(x(3)+phi_init);
y_end_thsw =  ( l*cos(x(1)+phi_init) - d*sin(x(1)+phi_init) ) - ( l*cos(x(3)+phi_init) + c*sin(x(3)+phi_init) );

scuffing = (x_end_thsw <= 0.2);

valu   = y_end_thsw;
isterm = ~scuffing; 
direc  = -1;  
