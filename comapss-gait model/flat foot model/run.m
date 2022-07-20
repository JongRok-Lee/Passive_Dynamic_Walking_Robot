clear all; close all;clc

global beta control m m_H l c d g phi_init
global E_ref                             

% INITIALIZATION ----------------------------------------------------------
cycle       =100;       % how many cycle?
beta    = 0*pi/180;     % radian, change slope,  0 means the reference slope.
control = 0;            % 0 off, 1 on
d2r = pi/180;
phi_init = 3.0*d2r;
load('x_fp.mat')
% initial condition--------------------------------------------------------
x0 =x_fp(find(x_fp(:,1)==phi_init/d2r),2:end);
load('x0.mat');
% x0=[18.2426, -77.7252, -26.7156, -17.4164]*d2r;
m_H = 10; m  = 5; g = 9.80665;
l  = 1; c =  0.05; d = 0.1;
del_t = 0.001;  % Sampling Time, 1000Hz

t = [];
x = [];
options1 = odeset('events', @event_fn1,'reltol',1e-6);
options2 = odeset('events', @event_fn2,'reltol',1e-6);
tspan   = 0:del_t:1;
slope = phi_init/d2r;
fprintf('slope = %g \n',slope);
%Reset parameter
rx=[];xi0=[0 0];
p_H=[]; p_1=[]; p_2=[];
p_1h=[]; p_2h=[];
p_1t=[]; p_2t=[];
p_1c=[]; p_2c=[];
%% INITIALIZATION
for n0=1:cycle
    xp=[];
    [t,x] = ode45(@state_equation1, tspan, x0, options1);
    thdot_plus = jump1(x);
    x0 = [x(end,1) thdot_plus(1) x(end,3) thdot_plus(2)];
    [xi0, p_H,p_1,p_2,p_1h, p_2h, p_1t, p_2t,p_1c,p_2c] = position1(n0,x,t,xi0,p_H,p_1,p_2,p_1h, p_2h, p_1t, p_2t,p_1c,p_2c);
    xp=[xp;x];
    
    [t,x] = ode45(@state_equation2, tspan, x0, options2);
    thdot_plus = jump2(x);
    x0 = [x(end,3) thdot_plus(1) x(end,1) thdot_plus(2)];
    [xi0, p_H,p_1,p_2,p_1h, p_2h, p_1t, p_2t,p_1c,p_2c] = position2(n0,x,t,xi0,p_H,p_1,p_2,p_1h, p_2h, p_1t, p_2t,p_1c,p_2c);
    xp=[xp;x];
    
    figure(1)
    plot(xp(:,1),xp(:,2),'linewidth',2);hold on     % thst
    plot(xp(:,3),xp(:,4),'linewidth',2);hold on     % thsw
    axis([-0.5 0.5 -3 3]);grid on
    xlabel('\theta [rad]');
    ylabel('\theta dot [rad/s]');
    title('Limit Cycle of the Compass Gait Biped');
    if rem(n0,2) == 1
        rx=[rx;xp(1:end-1,1) xp(1:end-1,2) xp(1:end-1,3) xp(1:end-1,4)];
    else
        rx=[rx;xp(1:end-1,3) xp(1:end-1,4) xp(1:end-1,1) xp(1:end-1,2)];
    end
end
save('x0.mat','x0')
rt = 0:del_t:(length(p_H)-1)*del_t;
%% simulation
for i= 1:15:length(p_H)/cycle*15
figure(1)
plot([p_H(i,1)],[p_H(i,2)],'ko','MarkerSize',20,'MarkerFaceColor',[0.5 0.5 0.5]);hold on
plot([p_1(i,1)],[p_1(i,2)],'bo','MarkerSize',15,'MarkerFaceColor','b');hold on
plot([p_2(i,1)],[p_2(i,2)],'ro','MarkerSize',15,'MarkerFaceColor','r');hold on

plot([p_1t(i,1) p_1h(i,1)],[p_1t(i,2) p_1h(i,2)],'b','LineWidth',1);hold on
plot([p_1c(i,1) p_H(i,1)],[p_1c(i,2) p_H(i,2)],'b','LineWidth',2);hold on
plot([p_2t(i,1) p_2h(i,1)],[p_2t(i,2) p_2h(i,2)],'r','LineWidth',1);hold on
plot([p_2c(i,1) p_H(i,1)],[p_2c(i,2) p_H(i,2)],'r','LineWidth',2);hold on

plot([cos(pi-phi_init) cycle/1.2*cos(phi_init)],[sin(pi-phi_init) -cycle/1.2*sin(phi_init)],'k');grid on
hold off
axis([-1+p_1t(i,1) 4+p_1t(i,1) -1+p_1t(i,2) 2.2+p_1t(i,2)])
daspect([1 1 1])
end
%%
figure(1)
plot(xp(:,2),'linewidth',2); hold on
plot(xp(:,4),'linewidth',2); hold on
xlabel('time (s)');ylabel('Angle_vel (rad/s)');
set(gca,'fontsize',15);legend('Stance leg','Swing leg');
