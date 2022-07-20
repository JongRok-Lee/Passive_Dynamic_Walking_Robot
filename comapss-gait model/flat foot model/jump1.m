function thdot_plus = jump1(x)
% JongRok Lee
global m m_H l c d
twoa = x(end,1)-x(end,3);

q_plus = [2*d^2*m+d^2*m_H+(5*l^2*m)/4+l^2*m_H-(l^2*m*cos(twoa))/2+(d*l*m*sin(twoa))/2,(l*m*(l-2*l*cos(twoa)+2*d*sin(twoa)))/4;
    -(l*m*(l*cos(twoa)-d*sin(twoa)))/2,(l^2*m)/4];

q_minus = [(5*l^2*m)/4+l^2*m_H-(l^2*m*cos(twoa))/2-2*c*d*m-c*d*m_H-(c*l*m*sin(twoa))/2,(l*m*(l-2*l*cos(twoa)+2*d*sin(twoa)))/4;
-(l*m*(l*cos(twoa)+c*sin(twoa)))/2,(l^2*m)/4];

thdot_plus = q_plus\q_minus*[x(end,2); x(end,4)];
end
