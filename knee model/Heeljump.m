function thdot_plus = Heeljump(x)
%JongRok Lee, 2020 11 25
global m_s m_t m_H a_s b_s a_t b_t l_s l_t L
alpha = x(end,1)-x(end,3);

Q_plus  = [L^2*(m_H+m_s+m_t) + m_s*a_s^2 + m_t*(a_t+l_s)^2 - (m_s*(b_s+l_t)+m_t*b_t)*L*cos(alpha), m_s*(b_s+l_t)^2 + m_t*b_t^2 - (m_s*(b_s+l_t)+m_t*b_t)*L*cos(alpha);
    -(m_s*(b_s+l_t)+m_t*b_t)*L*cos(alpha),m_s*(b_s+l_t)^2 + m_t*b_t^2];

Q_minus = [(m_H*L+2*m_s*a_s+2*m_t*(a_t+l_s))*L*cos(alpha) - m_s*a_s*(b_s+l_t) - m_t*b_t*(a_t+l_s), - m_s*a_s*(b_s+l_t) - m_t*b_t*(a_t+l_s);
    -m_s*a_s*(b_s+l_t) - m_t*b_t*(a_t+l_s),0];
thdot_plus = Q_plus\Q_minus*[x(end,2); x(end,4)];
end
