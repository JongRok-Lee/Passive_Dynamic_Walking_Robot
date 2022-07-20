function thdot_plus = jump2(x)
% JongRok Lee
global m m_H l c d
twoa = x(end,1)-x(end,3);

q_plus=[2*c^2*m+c^2*m_H+(5*l^2*m)/4+l^2*m_H-(l^2*m*cos(twoa))/2+(c*l*m*sin(twoa))/2,(l*m*(l-2*l*cos(twoa)+2*c*sin(twoa)))/4;
    -(l*m*(l*cos(twoa)-c*sin(twoa)))/2,(l^2*m)/4];
q_minus=[l^2*m*cos(twoa)+(-(l^2*m)/4)+l^2*m_H*cos(twoa)-2*c*d*m*cos(twoa)-c*d*m_H*cos(twoa)-(3*c*l*m*sin(twoa))/2-c*l*m_H*sin(twoa)-(3*d*l*m*sin(twoa))/2-d*l*m_H*sin(twoa),-(l^2*m)/4;
    -(l^2*m)/4,0];
thdot_plus = q_plus\q_minus*[x(end,2); x(end,4)];
end
