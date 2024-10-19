%JongRok Lee, 2024 04 17
function dxdt = state_equation2(t, x)
global control m_s m_t m_H a_s b_s a_t b_t l_s l_t L g

M = [L^2*m_H+L^2*m_s+L^2*m_t+a_s^2*m_s+a_t^2*m_t+l_s^2*m_t+2*a_t*l_s*m_t,-L*cos(x(1)-x(3))*(b_s*m_s+b_t*m_t+l_t*m_s);
    -L*cos(x(1)-x(3))*(b_s*m_s+b_t*m_t+l_t*m_s),m_s*b_s^2+2*m_s*b_s*l_t+m_t*b_t^2+m_s*l_t^2];
C = [0,-L*x(4)*sin(x(1)-x(3))*(b_s*m_s+b_t*m_t+l_t*m_s);
    L*x(2)*sin(x(1)-x(3))*(b_s*m_s+b_t*m_t+l_t*m_s),0]*[x(2);x(4)];
G = [-g*sin(x(1))*(L*m_H+L*m_s+L*m_t+a_s*m_s+a_t*m_t+l_s*m_t);
    g*sin(x(3))*(b_s*m_s+b_t*m_t+l_t*m_s)];

ddx  = M\(-C-G);     % faster, IMPORTANT
dxdt = [x(2);ddx(1);x(4);ddx(2);];

% EOF
