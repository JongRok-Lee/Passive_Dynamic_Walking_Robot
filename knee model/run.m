clear all; close all;clc
%JongRok Lee, 2020 11 25
global m_s m_t m_H a_s a_t b_s b_t l_s l_t L g phi_init

% INITIALIZATION ----------------------------------------------------------
cycle       = 3;       % how many cycle?
d2r = pi/180;
phi_init = 3.0*d2r;
load('x_fp.mat')
x0 =x_fp(find(x_fp(:,1)==phi_init/d2r),2:end);

% x0 = x0+1e-7*[1 0 0 0 0 0];

% load('x0.mat')

a_s  = 0.2402; b_s  = 0.1834; a_t  = 0.23; b_t  = 0.1756;
m_H = 34.637; m_t = 6.096; m_s  = 2.852;
l_s= a_s + b_s; l_t = a_t + b_t ; L  = l_s + l_t; g = 9.80665;

options1 = odeset('events', @event_fn1,'reltol',1e-6);
options2 = odeset('events', @event_fn2,'reltol',1e-6);
del_t = 0.001;  % Sampling Time, 1000Hz
tspan   = 0:del_t:1;
slope = phi_init/d2r
% Reset Parameter
rx=[]; xi0=[0 0];
p_H=[]; p_1f=[];p_2f=[];
p_1c=[]; p_2c=[];
p_1s=[];p_1t=[];p_2s=[];p_2t=[];t=[];
v_H = [];v_1s = [];v_1t = [];v_2s = [];v_2t = [];
%% INITIALIZATION & 페이즈 포트릿
for n0=1:cycle
    xp=[];t=[];xf(n0,:) = x0;
    [t1,x1] = ode45(@state_equation1, tspan, x0, options1);
    thdot_plus1 = Kneejump(x1);
    x0 = [x1(end,1) thdot_plus1(1) x1(end,3) thdot_plus1(2)];
    xp=[xp;x1(1:end-1,:)]; t=t1(1:end-1);
    [xi0, p_H,p_1f,p_2f,p_1c, p_2c, p_1t, p_2t,p_1s,p_2s] = position1(n0,x1,t1,xi0,p_H,p_1f,p_2f,p_1c, p_2c, p_1t, p_2t,p_1s,p_2s);
    [v_H,v_1s,v_1t,v_2s,v_2t] = velocity1(n0,x1,v_H,v_1s,v_1t,v_2s,v_2t);
    
    [t2,x2] = ode45(@state_equation2, tspan, x0, options2);
    thdot_plus2 = Heeljump(x2);
    x0 = [x2(end,3) thdot_plus2(1) x2(end,1) thdot_plus2(2) x2(end,1) thdot_plus2(2)];
    xp = [xp;x2 x2(:,3) x2(:,4)]; t=[t;t2+t1(end)];
    [xi0, p_H,p_1f,p_2f,p_1c, p_2c, p_1t, p_2t,p_1s,p_2s] = position2(n0,x2,t2,xi0,p_H,p_1f,p_2f,p_1c, p_2c, p_1t, p_2t,p_1s,p_2s);
    [v_H,v_1s,v_1t,v_2s,v_2t] = velocity2(n0,x2,v_H,v_1s,v_1t,v_2s,v_2t);
    figure(1)
    plot(xp(1:end,1),xp(1:end,2),'linewidth',2);hold on     % thst
    plot(xp(1:end,3),xp(1:end,4),'linewidth',2);hold on     % thsw
    axis([-0.6 0.6 -3.5 3.5]);grid on
    
    if rem(n0,2) == 1
        rx=[rx;xp(1:end-1,1) xp(1:end-1,2) xp(1:end-1,3) xp(1:end-1,4) xp(1:end-1,5) xp(1:end-1,6)];
    else
        rx=[rx;xp(1:end-1,3) xp(1:end-1,4) xp(1:end-1,1) xp(1:end-1,2) xp(1:end-1,5) xp(1:end-1,6)];
    end
    speed(n0)=stepspeed(xp,t);
end
save('x0.mat','x0')
rt = 0:del_t:(length(p_H)-1)*del_t;
%% 시뮬레이션 그래프
for i=1:20:length(p_H)/cycle*50
    figure(1)
    plot([p_H(i,1)],[p_H(i,2)],'ko','MarkerSize',20,'MarkerFaceColor',[0.5 0.5 0.5]);hold on
    plot([p_1s(i,1)],[p_1s(i,2)],'bo','MarkerSize',10,'MarkerFaceColor','b');hold on
    plot([p_1t(i,1)],[p_1t(i,2)],'bo','MarkerSize',10,'MarkerFaceColor','b');hold on
    plot([p_2t(i,1)],[p_2t(i,2)],'ro','MarkerSize',10,'MarkerFaceColor','r');hold on
    plot([p_2s(i,1)],[p_2s(i,2)],'ro','MarkerSize',10,'MarkerFaceColor','r');hold on
    plot([p_2c(i,1)],[p_2c(i,2)],'ko','MarkerSize',5,'MarkerFaceColor','k');hold on
    plot([p_1c(i,1)],[p_1c(i,2)],'ko','MarkerSize',5,'MarkerFaceColor','k');hold on
    
    plot([p_1f(i,1) p_1c(i,1)],[p_1f(i,2) p_1c(i,2)],'b','LineWidth',2);hold on
    plot([p_1c(i,1) p_H(i,1)],[p_1c(i,2) p_H(i,2)],'b','LineWidth',2);hold on
    
    plot([p_2c(i,1) p_H(i,1)],[p_2c(i,2) p_H(i,2)],'r','LineWidth',2);hold on
    plot([p_2f(i,1) p_2c(i,1)],[p_2f(i,2) p_2c(i,2)],'r','LineWidth',2);hold on
    plot([cosd(180-slope) cycle/1.5*cosd(slope)],[sind(180-slope) -cycle/1.5*sind(slope)]);hold on;grid on
    hold off
    axis([-1+p_H(i,1) 5+p_H(i,1) -2+p_H(i,2) 1+p_H(i,2)]);
end
%% local stability
figure(3)
subplot(121)
plot(xf(:,1),xf(:,2),'k','linewidth',1.5);hold on
plot(xf(1,1),xf(1,2),'r*'); grid on
xlabel('$\theta_1$ (rad)','interpreter','latex');
ylabel('$\dot{\theta}_1$ (rad/s)','interpreter','latex');
set(gca,'fontsize',20)

subplot(122)
plot(xf(2:end,3),xf(2:end,4),'k','linewidth',1.5);hold on
plot(xf(1,3),xf(1,4),'r*'); grid on
xlabel('$\theta_2$ (rad)','interpreter','latex');
ylabel('$\dot{\theta}_2$ (rad/s)','interpreter','latex');
set(gca,'fontsize',20)
%% local stability
% subplot(133)
plot(xf(2:end,5),xf(2:end,6),'k','linewidth',1.5);hold on
plot(xf(1,5),xf(1,6),'r*');grid on
xlabel('$\theta_3$ (rad)','interpreter','latex');
ylabel('$\dot{\theta}_3$ (rad/s)','interpreter','latex');
set(gca,'fontsize',15)
%% Energy
for k=1:length(v_1s)
    v1s(k) = sqrt(v_1s(k,1)^2+v_1s(k,2)^2);
    v1t(k) = sqrt(v_1t(k,1)^2+v_1t(k,2)^2);
    v2s(k) = sqrt(v_2s(k,1)^2+v_2s(k,2)^2);
    v2t(k) = sqrt(v_2t(k,1)^2+v_2t(k,2)^2);
    vH(k) = sqrt(v_H(k,1)^2+v_H(k,2)^2);
end
T = 0.5*m_s*v1s.^2+0.5*m_t*v1t.^2+0.5*m_s*v2s.^2+0.5*m_t*v2t.^2+0.5*m_H*vH.^2;
T = T';
V = m_s*g*p_1s(:,2)+m_t*g*p_1t(:,2)+m_s*g*p_2s(:,2)+m_t*g*p_2t(:,2)+m_H*g*p_H(:,2);
E = T + V;
dE = gradient(E, del_t);
dT = gradient(T, del_t); dV = gradient(V, del_t);

plot(T,'linewidth',2);hold on;plot(V,'linewidth',2);hold on;plot(E,'linewidth',2);legend('T','V','E');grid on
xlabel('time (t)','interpreter','latex');
ylabel('Energy (J)','interpreter','latex');set(gca,'fontsize',15)
%%
figure(1)
subplot(141); plot(T, V,'k');hold on;grid on
subplot(142); plot(T,dT);hold on;grid on
subplot(143); plot(V,dV);hold on;grid on
subplot(144); plot(E,dE);hold on;grid on
for n = 1:2:length(T)
    figure(1)
    subplot(141); plot(T(n), V(n),"r.");
    subplot(142); plot(T(n), dT(n),"r.");
    subplot(143); plot(V(n), dV(n),"r.");
    subplot(144); plot(E(n), dE(n),"r.");
end
