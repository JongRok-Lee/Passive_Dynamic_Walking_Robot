clear all; close all;clc
% JongRok Lee

global m m_H m_U l l_U g phi_init 
global E_ref                             

% INITIALIZATION ----------------------------------------------------------
cycle       = 100;       % how many cycle?
d2r = pi/180;
% x_fp = [12.5288  -62.5890  -18.5288  -21.6219]*d2r;
phi_init = 3.0*d2r;      % step: 0.1 degree
load('x_fp.mat')
% initial condition--------------------------------------------------------
x0 =x_fp(find(x_fp(:,1)==phi_init/d2r),2:end);
load('x0.mat');
m_H = 8; m_U = 2;
m  = 3; l  = 1; l_U = 0.4; g = 9.80665;

del_t = 0.001;  % Sampling Time, 1000Hz

t = [];
x = [];
options = odeset('events', @event_fn,'reltol',1e-6);
tspan   = 0:del_t:1;

slope = phi_init/d2r;
fprintf('slope = %g \n',slope);
%Reset parameter
rx=[];xi0=[0 0];
p_H=[]; p_U=[]; p_1=[]; p_2=[];
p_H1=[]; p_11=[]; p_21=[]; p_U1=[];
p_1p=[]; p_2p=[];
v_H=[]; v_U=[]; v_1=[]; v_2=[];xe=[];
%% INITIALIZATION
for n0=1:cycle
    [t,x] = ode45(@state_equation, tspan, x0, options);
    thdot_plus = jump(x);
    x_plus = [x(end,3) thdot_plus(1) x(end,1) thdot_plus(2)];
    x0=x_plus;
    figure(1)
    plot(x(1:end,1),x(1:end,2),'linewidth',2);hold on     % thst
    plot(x(1:end,3),x(1:end,4),'linewidth',2);hold on     % thsw
    axis([-0.5 0.5 -3 3]);grid on
    xlabel('\theta [rad]');
    ylabel('\theta dot [rad/s]');
    title('Limit Cycle of the Compass Gait Biped');
    xe=[xe;x];
    if rem(n0,2) == 1
        rx=[rx;x(1:end-1,1) x(1:end-1,2) x(1:end-1,3) x(1:end-1,4)];
    else
        rx=[rx;x(1:end-1,3) x(1:end-1,4) x(1:end-1,1) x(1:end-1,2)];
    end
    [xi0, p_H,p_1,p_2,p_U,p_1p, p_2p, p_H1,p_11,p_21,p_U1] = position(n0,x,t,xi0,p_H,p_1,p_2,p_U,p_1p, p_2p, p_H1,p_11,p_21,p_U1);
end
save('x0.mat','x0')
rt = 0:del_t:(length(p_H)-1)*del_t;
%% simulation
for i= 1:20:length(p_H)
figure(1)
plot([p_H(i,1)],[p_H(i,2)],'ko','MarkerSize',15,'MarkerFaceColor',[0.5 0.5 0.5]);hold on
plot([p_1(i,1)],[p_1(i,2)],'bo','MarkerSize',5,'MarkerFaceColor','b');hold on
plot([p_2(i,1)],[p_2(i,2)],'ro','MarkerSize',5,'MarkerFaceColor','r');hold on
plot([p_U(i,1)],[p_U(i,2)],'Ko','MarkerSize',20,'MarkerFaceColor','K');hold on

plot([p_1p(i,1) p_H(i,1)],[p_1p(i,2) p_H(i,2)],'b','LineWidth',2);hold on
plot([p_2p(i,1) p_H(i,1)],[p_2p(i,2) p_H(i,2)],'r','LineWidth',2);hold on
plot([p_H(i,1) p_U(i,1)],[p_H(i,2) p_U(i,2)],'k','LineWidth',2);hold on
plot([cosd(180-slope) cycle/2*cosd(slope)],[sind(180-slope) -cycle/2*sind(slope)]);grid on
hold off
axis([-1+p_1p(i,1) 4+p_1p(i,1) -1+p_1p(i,2) 2.2+p_1p(i,2)])
daspect([1 1 1])
end
%%
SA = 0.5*(rx(:,1)+rx(:,3));
figure(1)
plot(rt(1:808),rx(1:808,1),'linewidth',2); hold on
plot(rt(1:808),rx(1:808,3),'linewidth',2); hold on
plot(rt(1:808),SA(1:808),'linewidth',2); hold on; grid on
xlabel('time (s)');ylabel('Angle (rad)');
set(gca,'fontsize',15);legend('Stance leg','Swing leg','Upper body');
