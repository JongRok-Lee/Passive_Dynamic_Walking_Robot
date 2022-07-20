function [xi0, p_H,p_1f,p_2f,p_1c, p_2c, p_1t, p_2t,p_1s,p_2s] = position1(n0,x,t,xi0,p_H,p_1f,p_2f,p_1c, p_2c, p_1t, p_2t,p_1s,p_2s)
global L l_s l_t a_s a_t b_s b_t
if rem(n0,2) == 1
    % leg1의 발
    p_01f = repmat(xi0,length(t),1);
    % leg1의 무릎
    p_01c =p_01f + l_s*[-sin(x(:,1)) cos(x(:,1))];
    % 골반의 위치
    p_Hpb =p_01f + L*[-sin(x(:,1)) cos(x(:,1))];
    % leg2의 무릎
    p_02c = p_Hpb + l_t*[sin(x(:,3)) -cos(x(:,3))];
    % leg2의 발
    p_02f = p_02c + l_s*[sin(x(:,5)) -cos(x(:,5))];
    
    % leg_1s의 위치
    p_1sb = p_01f + a_s*[-sin(x(:,1)) cos(x(:,1))];
    % leg_1t의 위치
    p_1tb = p_01c + a_t*[-sin(x(:,1)) cos(x(:,1))];
    % leg_2t의 위치
    p_2tb = p_Hpb + b_t*[sin(x(:,3)) -cos(x(:,3))];
    % leg_2s의 위치
    p_2sb = p_02c + b_s*[sin(x(:,5)) -cos(x(:,5))];
    
    p_H = [p_H; p_Hpb(1:end-1,:)];%골반위치
    p_1f = [p_1f; p_01f(1:end-1,:)];%leg1 발 위치
    p_2f = [p_2f; p_02f(1:end-1,:)];%leg2 발 위치
    p_1c = [p_1c; p_01c(1:end-1,:)];%leg1 무릎 위치
    p_2c = [p_2c; p_02c(1:end-1,:)];%leg2 무릎 위치
    p_1s = [p_1s; p_1sb(1:end-1,:)];%leg_1s 위치
    p_1t = [p_1t; p_1tb(1:end-1,:)];%leg_1t 위치
    p_2t = [p_2t; p_2tb(1:end-1,:)];%leg_2t 위치
    p_2s = [p_2s; p_2sb(1:end-1,:)];%leg_2s 위치
    
    % new zero point 
    xi0= p_01f(end,:);
else
    % leg2의 발
    p_02f = repmat(xi0,length(t),1);
    % leg2의 무릎
    p_02c =p_02f + l_s*[-sin(x(:,1)) cos(x(:,1))];
    % 골반의 위치
    p_Hpb =p_02f + L*[-sin(x(:,1)) cos(x(:,1))];
    % leg1의 무릎
    p_01c = p_Hpb + l_t*[sin(x(:,3)) -cos(x(:,3))];
    % leg1의 발
    p_01f = p_01c + l_s*[sin(x(:,5)) -cos(x(:,5))];
    
    % leg_2s의 위치
    p_2sb = p_02f + a_s*[-sin(x(:,1)) cos(x(:,1))];
    % leg_2t의 위치
    p_2tb = p_02c + a_t*[-sin(x(:,1)) cos(x(:,1))];
    % leg_1t의 위치
    p_1tb = p_Hpb + b_t*[sin(x(:,3)) -cos(x(:,3))];
    % leg_1s의 위치
    p_1sb = p_01c + b_s*[sin(x(:,5)) -cos(x(:,5))];
    
    
    p_H = [p_H; p_Hpb(1:end-1,:)];%골반위치
    p_1f = [p_1f; p_01f(1:end-1,:)];%leg1 발 위치
    p_2f = [p_2f; p_02f(1:end-1,:)];%leg2 발 위치
    p_1c = [p_1c; p_01c(1:end-1,:)];%leg1 무릎 위치
    p_2c = [p_2c; p_02c(1:end-1,:)];%leg2 무릎 위치
    p_1s = [p_1s; p_1sb(1:end-1,:)];%leg_1s 위치
    p_1t = [p_1t; p_1tb(1:end-1,:)];%leg_1t 위치
    p_2t = [p_2t; p_2tb(1:end-1,:)];%leg_2t 위치
    p_2s = [p_2s; p_2sb(1:end-1,:)];%leg_2s 위치
    
    % zero point
    xi0= p_02f(end,:);
end
end
