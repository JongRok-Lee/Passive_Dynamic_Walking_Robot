function thdot_plus = Kneejump(x)
%JongRok Lee, 2020 11 25
global m_s m_t m_H a_s b_s a_t b_t l_s l_t L
alpha = x(end,1)-x(end,3);
beta = x(end,1)-x(end,5);
gamma = x(end,3)-x(end,5);

Q_plus = [(m_H+m_s+m_t)*L^2+m_s*a_s^2+m_t*(a_t+l_s)^2-(m_s*(b_s+l_t)+m_t*b_t)*L*cos(alpha), m_s*(b_s+l_t)^2+m_t*b_t^2-(m_s*(b_s+l_t)+m_t*b_t)*L*cos(alpha);
    -(m_s*(b_s+l_t)+m_t*b_t)*L*cos(alpha), m_s*(b_s+l_t)^2+m_t*b_t^2];

Q_minus = [(m_H+m_s+m_t)*L^2+m_s*a_s^2+m_t*(a_t+l_s)^2-(m_t*b_t+m_s*l_t)*L*cos(alpha)-L*b_s*m_s*cos(beta), m_t*b_t^2+m_s*l_t^2-(m_t*b_t+m_s*l_t)*L*cos(alpha)+m_s*b_s*l_t*cos(gamma), m_s*b_s*(b_s-L*cos(beta)+l_t*cos(gamma));
    -(m_s*l_t+m_t*b_t)*L*cos(alpha)-m_s*L*b_s*cos(beta), m_t*b_t^2+m_s*l_t^2+m_s*b_s*l_t*cos(gamma), m_s*b_s*(b_s+l_t*cos(gamma))];

thdot_plus = Q_plus\Q_minus*[x(end,2); x(end,4); x(end,6)];
end
