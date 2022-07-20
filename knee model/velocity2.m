function [v_H,v_1s,v_1t,v_2s,v_2t] = velocity2(n0,x,v_H,v_1s,v_1t,v_2s,v_2t)
global a_s a_t b_s b_t L l_s l_t
if rem(n0,2) == 1
    v_Hp = L* [-cos(x(1:end-1,1)).*x(1:end-1,2) -sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_1s0 = a_s* [-cos(x(1:end-1,1)).*x(1:end-1,2) -sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_1t0 = (l_s+a_t)*[-cos(x(1:end-1,1)).*x(1:end-1,2) -sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_2t0 = v_Hp + b_t*[cos(x(1:end-1,3)).*x(1:end-1,4) sin(x(1:end-1,3)).*x(1:end-1,4)];
    v_2s0 = v_Hp + (l_t+b_s)*[cos(x(1:end-1,3)).*x(1:end-1,4) sin(x(1:end-1,3)).*x(1:end-1,4)];
    
    v_H = [v_H; v_Hp];
    v_1s = [v_1s; v_1s0];
    v_1t = [v_1t; v_1t0];
    v_2s = [v_2s; v_2s0];
    v_2t = [v_2t; v_2t0];
    
else
    v_Hp = L*[-cos(x(1:end-1,1)).*x(1:end-1,2) -sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_2s0 = a_s*[-cos(x(1:end-1,1)).*x(1:end-1,2) -sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_2t0 = (l_s+a_t)*[-cos(x(1:end-1,1)).*x(1:end-1,2) -sin(x(1:end-1,1)).*x(1:end-1,2)];
    v_1t0 = v_Hp + b_t*[cos(x(1:end-1,3)).*x(1:end-1,4) sin(x(1:end-1,3)).*x(1:end-1,4)];
    v_1s0 = v_Hp + (l_t+b_s)*[cos(x(1:end-1,3)).*x(1:end-1,4) sin(x(1:end-1,3)).*x(1:end-1,4)];
    
    v_H = [v_H; v_Hp];
    v_1s = [v_1s; v_1s0];
    v_1t = [v_1t; v_1t0];
    v_2s = [v_2s; v_2s0];
    v_2t = [v_2t; v_2t0];
end
end
