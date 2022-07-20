function [xi0, p_H,p_1,p_2,p_1h, p_2h, p_1t, p_2t,p_1c,p_2c] = position(n0,x,t,xi0,p_H,p_1,p_2,p_1h, p_2h, p_1t, p_2t,p_1c,p_2c)
global l c d
if rem(n0,2) == 1
    % leg1의 뒤꿈치
    p_01hb = repmat(xi0,length(t),1);
    % leg1의 다리 중심
    p_01b =p_01hb + c*[cos(x(:,1)) sin(x(:,1))];
    % leg1의 발 끝
    p_1t0 = p_01hb + (c+d)*[cos(x(:,1)) sin(x(:,1))];
    % 골반의 위치
    p_Hpb =p_01b + l*[-sin(x(:,1)) cos(x(:,1))];  
    % leg1의 위치
    p_10b = p_01b + 0.5*l*[-sin(x(:,1)) cos(x(:,1))];
    % leg2의 위치
    p_20b = p_Hpb + 0.5*[l*sin(x(:,3)) -l*cos(x(:,3))];
    % leg2의 다리 중심
    p_02b = p_Hpb + l*[sin(x(:,3)) -cos(x(:,3))];
    % leg2의 발 끝
    p_2t0 = p_02b + d*[cos(x(:,3)) sin(x(:,3))];
    % leg2의 뒤꿈치
    p_02hb = p_02b + c*[-cos(x(:,3)) -sin(x(:,3))];% leg2의 호 중심
    
    p_H = [p_H; p_Hpb(1:end-1,:)];%골반위치
    p_1 = [p_1; p_10b(1:end-1,:)];%leg1 위치
    p_2 = [p_2; p_20b(1:end-1,:)];%leg2 위치
    p_1t = [p_1t; p_1t0(1:end-1,:)];%leg1의 발 끝
    p_2t = [p_2t; p_2t0(1:end-1,:)];%leg2의 발 끝
    p_1h = [p_1h; p_01hb(1:end-1,:)];%leg1의 뒤꿈치
    p_2h = [p_2h; p_02hb(1:end-1,:)];%leg2의 뒤꿈치
    p_1c = [p_1c; p_01b(1:end-1,:)];%leg1의 다리 중심
    p_2c = [p_2c; p_02b(1:end-1,:)];%leg2의 다리 중심
    
    % new zero point 
    xi0= p_1t0(end,:);
else
    % leg2의 뒤꿈치
    p_02hb = repmat(xi0,length(t),1);
    % leg2의 다리 중심
    p_02b =p_02hb + c*[cos(x(:,1)) sin(x(:,1))];
    % leg2의 발 끝
    p_2t0 = p_02hb + (c+d)*[cos(x(:,1)) sin(x(:,1))];
    % 골반의 위치
    p_Hpb =p_02b + l*[-sin(x(:,1)) cos(x(:,1))];
    % leg2의 위치
    p_20b = p_02b + 0.5*l*[-sin(x(:,1)) cos(x(:,1))];
    % leg1의 위치
    p_10b = p_Hpb + 0.5*l*[sin(x(:,3)) -cos(x(:,3))];
    % leg1의 다리 중심
    p_01b = p_Hpb + l*[sin(x(:,3)) -cos(x(:,3))];
    % leg1의 발 끝
    p_1t0 = p_01b + d*[cos(x(:,3)) sin(x(:,3))];
    % leg1의 뒤꿈치
    p_01hb = p_01b + c*[-cos(x(:,3)) -sin(x(:,3))];
    
    
    p_H = [p_H; p_Hpb(1:end-1,:)];%골반위치
    p_2 = [p_2; p_20b(1:end-1,:)];%leg2 위치
    p_1 = [p_1; p_10b(1:end-1,:)];%leg1 위치
    p_2t = [p_2t; p_2t0(1:end-1,:)];%leg2의 발 끝
    p_1t = [p_1t; p_1t0(1:end-1,:)];%leg1의 발 끝
    p_2h = [p_2h; p_02hb(1:end-1,:)];%leg2의 뒤꿈치
    p_1h = [p_1h; p_01hb(1:end-1,:)];%leg1의 뒤꿈치
    p_2c = [p_2c; p_02b(1:end-1,:)];%leg2의 다리 중심
    p_1c = [p_1c; p_01b(1:end-1,:)];%leg1의 다리 중심
    
    % zero point
    xi0= p_2t0(end,:);
end
end
