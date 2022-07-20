clear all; close all;clc

global m m_H l r g phi_init L1 L2 

% INITIALIZATION ----------------------------------------------------------
cycle       = 1;       % how many cycle?
d2r = pi/180;
phi_init = 3.0*d2r;     $ step : 0.1 degree
load('x_fp.mat')
% initial condition--------------------------------------------------------
x0 =x_fp(find(x_fp(:,1)==phi_init/d2r),2:end);
load('x0.mat');
m_H = 10; m  = 5; g = 9.80665;
l  = 1; r = 0.5; L1 = l-r; L2 = 0.5*l-r;
theta0 = -pi/2-30*d2r:0.01:-pi/2+30*d2r;
del_t = 0.001;  % Sampling Time, 1000Hz

t = [];
x = [];
% options = odeset('events', @event_fn,'reltol',1e-6);
tspan   = 0:del_t:5;

slope = phi_init/d2r;
fprintf('slope = %g \n',slope);
%Reset parameter
rx=[];xi0=[0 0];
p_H=[]; p_1=[]; p_2=[];
p_01=[]; p_02=[];
p_1t=[]; p_2t=[];
xe=[];
%% INITIALIZATION
for n0=1:cycle
    [t,x] = ode45(@state_equation, tspan, x0);
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
    [xi0, p_H,p_1,p_2,p_01, p_02, p_1t, p_2t] = position(n0,x,t,xi0,p_H,p_1,p_2,p_01, p_02, p_1t, p_2t);
end
save('x0.mat','x0')
rt = 0:del_t:(length(p_H)-1)*del_t;
%% Arc foot
theta1 = repmat(rx(:,1),1,length(theta0));
theta_0 = repmat(theta0,length(rt),1);
theta2 = repmat(rx(:,3),1,length(theta0));
theta_1 = theta_0 + theta1;theta_2 = theta_0 + theta2;
rx1 = repmat(p_01(:,1),1,length(theta0));ry1 = repmat(p_01(:,2),1,length(theta0));
rx2 = repmat(p_02(:,1),1,length(theta0));ry2 = repmat(p_02(:,2),1,length(theta0));
rx01 =r*cos(theta_1);ry01 =r*sin(theta_1);
rx02 =r*cos(theta_2);ry02 =r*sin(theta_2);
rx_1 = rx01+rx1;ry_1 = ry01+ry1;
rx_2 = rx02+rx2;ry_2 = ry02+ry2;
%% simulation
for i= 1:20:length(p_H)/cycle*10
figure(1)
plot([p_H(i,1)],[p_H(i,2)],'ko','MarkerSize',20,'MarkerFaceColor',[0.5 0.5 0.5]);hold on
plot([p_1(i,1)],[p_1(i,2)],'bo','MarkerSize',15,'MarkerFaceColor','b');hold on
plot([p_2(i,1)],[p_2(i,2)],'ro','MarkerSize',15,'MarkerFaceColor','r');hold on

plot([p_1t(i,1) p_H(i,1)],[p_1t(i,2) p_H(i,2)],'b','LineWidth',2);hold on
plot([p_2t(i,1) p_H(i,1)],[p_2t(i,2) p_H(i,2)],'r','LineWidth',2);hold on
plot([cosd(180-slope) cycle/1.9*cosd(slope)],[sind(180-slope) -cycle/1.9*sind(slope)]);grid on
plot(rx_1(i,:),ry_1(i,:),'k','LineWidth',2); hold on
plot(rx_2(i,:),ry_2(i,:),'k','LineWidth',2)
hold off
axis([-1+p_1t(i,1) 4+p_1t(i,1) -1+p_1t(i,2) 2.2+p_1t(i,2)])
daspect([1 1 1])
end
%%
SA = 0.5*(rx(:,1)+rx(:,3));
figure(1)
plot(rt(:),rx(:,1),'linewidth',2); hold on
plot(rt(:),rx(:,3),'linewidth',2); hold on
plot(rt(:),SA(:),'linewidth',2); hold on; grid on
xlabel('time (s)');ylabel('Angle (rad)');
set(gca,'fontsize',15);legend('Stance leg','Swing leg','Upper body');
