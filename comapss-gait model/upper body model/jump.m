function thdot_plus = jump(x)
% JongRok Lee
global m m_H m_U l l_U
twoa = x(end,3)-x(end,1);
q_plus = [(5*l^2*m)/4+l^2*m_H+l^2*m_U+(l_U^2*m_U)/2-(l^2*m*cos(twoa))/2+(3*l*l_U*m_U*cos(twoa/2))/2,(l^2*m)/4+(l_U^2*m_U)/2-(l^2*m*cos(twoa))/2+(l*l_U*m_U*cos(twoa/2))/2;
    -(m*cos(twoa)*l^2)/2+m_U*cos(twoa/2)*l*l_U+(m_U*l_U^2)/2,(m*l^2)/4+(m_U*l_U^2)/2];
q_minus = [(l_U^2*m_U)/2-(l^2*m)/4+l^2*m*cos(twoa)+l^2*m_H*cos(twoa)+l^2*m_U*cos(twoa)+(3*l*l_U*m_U*cos(twoa/2))/2,-(m*l^2)/4+(m_U*cos(twoa/2)*l*l_U)/2+(m_U*l_U^2)/2;
    -(m*l^2)/4+m_U*cos(twoa/2)*l*l_U+(m_U*l_U^2)/2,(l_U^2*m_U)/2];
thdot_plus = q_plus\q_minus*[x(end,2); x(end,4)];
end
