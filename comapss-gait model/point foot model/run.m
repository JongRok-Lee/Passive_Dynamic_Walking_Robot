clear all; close all; clc

global m mh a b l g phi_init 
global E_ref                             

% INITIALIZATION ----------------------------------------------------------
cycle       = 100;       % how many cycle?
d2r = pi/180;
phi_init = 3.0*d2r;      % step: 0.1 degree

load('x_fp.mat')
x0 =x_fp(find(x_fp(:,1)==phi_init/d2r),2:end);
mh = 10; m  = 5; a  = 0.5; b  = 0.5; l  = 1; g = 9.80665;

del_t = 0.001;  % Sampling Time, 1000Hz

joint = [];
joint_all = [];
t = [];
x = [];
options = odeset('events', @event_fn,'reltol',1e-6);
tspan   = 0:del_t:1;

slope = phi_init/d2r;
fprintf('slope = %g \n',slope);
%% INITIALIZATION

for n=1:cycle
    [t,x] = ode45(@state_equation, tspan, x0, options);
    thdot_plus = jump(x);
    x_plus = [x(end,3) thdot_plus(1) x(end,1) thdot_plus(2)];
    x0=x_plus;
    simplot(x);
    joint=[joint; x];
end
x_plus=x0
