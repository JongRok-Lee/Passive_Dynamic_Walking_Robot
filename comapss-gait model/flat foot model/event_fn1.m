function [valu, isterm, direc] = event_fn1(t,x)
%JongRok Lee, 2020 11 25
global phi_init

y_end_thsw =  x(1) + phi_init;

valu   = y_end_thsw;
isterm = 1;  
direc  = -1;
