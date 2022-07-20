function [xi0, p_H,p_1,p_2,p_01, p_02, p_1t, p_2t] = position(n0,x,t,xi0,p_H,p_1,p_2,p_01, p_02, p_1t, p_2t)
global l r L1 L2 phi_init
phi = phi_init*ones(length(t),1);

if rem(n0,2) == 1
    % leg1의 호 중심
    p_01b =xi0 + [r*sin(phi)-r*cos(phi).*(phi + x(:,1)) r*cos(phi)+r*sin(phi).*(phi + x(:,1))];
    % leg1의 끝
    p_1t0 = p_01b - r*[-sin(x(:,1)) cos(x(:,1))];
    % 골반의 위치
    p_Hpb =p_01b + L1*[-sin(x(:,1)) cos(x(:,1))];  
    % leg1의 위치
    p_10b = p_01b + L2*[-sin(x(:,1)) cos(x(:,1))];
    % leg2의 위치
    p_20b = p_Hpb + 0.5*[l*sin(x(:,3)) -l*cos(x(:,3))];
    % leg2의 끝
    p_2t0 = p_Hpb + [l*sin(x(:,3)) -l*cos(x(:,3))];
    % leg2의 호 중심
    p_02b = p_Hpb + L1*[l*sin(x(:,3)) -l*cos(x(:,3))];% leg2의 호 중심
    
    p_H = [p_H; p_Hpb(1:end-1,:)];%골반위치
    p_1 = [p_1; p_10b(1:end-1,:)];%leg1 위치
    p_2 = [p_2; p_20b(1:end-1,:)];%leg2 위치
    p_1t = [p_1t; p_1t0(1:end-1,:)];%leg1의 끝
    p_2t = [p_2t; p_2t0(1:end-1,:)];%leg2의 끝
    p_01 = [p_01; p_01b(1:end-1,:)];%leg1의 호 중심
    p_02 = [p_02; p_02b(1:end-1,:)];%leg2의 호 중심
    
    % new zero point 
    xi0= p_02b(end,:) + [-r*sin(phi_init)+r*cos(phi_init)*(phi_init + x(end,3)) -r*cos(phi_init)-r*sin(phi_init)*(phi_init + x(end,3))];
else
    % leg2의 호 중심
    p_02b =xi0 + [r*sin(phi)-r*cos(phi).*(phi + x(:,1)) r*cos(phi)+r*sin(phi).*(phi + x(:,1))];
    % leg2의 끝
    p_2t0 = p_02b - r*[-sin(x(:,1)) cos(x(:,1))];
    % 골반의 위치
    p_Hpb =p_02b + L1*[-sin(x(:,1)) cos(x(:,1))];
    % leg2의 위치
    p_20b = p_02b + L2*[-sin(x(:,1)) cos(x(:,1))];
    % leg1의 위치
    p_10b = p_Hpb + 0.5*[l*sin(x(:,3)) -l*cos(x(:,3))];
    % leg1의 끝
    p_1t0 = p_Hpb + [l*sin(x(:,3)) -l*cos(x(:,3))];
    % leg1의 호 중심
    p_01b = p_Hpb + L1*[l*sin(x(:,3)) -l*cos(x(:,3))];% leg2의 호 중심
    
    
    p_H = [p_H; p_Hpb(1:end-1,:)];%골반위치
    p_2 = [p_2; p_20b(1:end-1,:)];%leg2 위치
    p_1 = [p_1; p_10b(1:end-1,:)];%leg1 위치
    p_2t = [p_2t; p_2t0(1:end-1,:)];%leg2의 끝
    p_1t = [p_1t; p_1t0(1:end-1,:)];%leg1의 끝
    p_02 = [p_02; p_02b(1:end-1,:)];%leg2의 호 중심
    p_01 = [p_01; p_01b(1:end-1,:)];%leg1의 호 중심
    
    % zero point
    xi0= p_01b(end,:) + [-r*sin(phi_init)+r*cos(phi_init)*(phi_init + x(end,3)) -r*cos(phi_init)-r*sin(phi_init)*(phi_init + x(end,3))];
end
end
