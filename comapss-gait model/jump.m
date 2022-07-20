function thdot_plus = jump(x)
global m mh a b l
twoa = x(end,3)-x(end,1);
q_plus  = [m*a*a+mh*l*l+m*l*l-m*b*l*cos(twoa), m*b*b-m*b*l*cos(twoa);
    -m*b*l*cos(twoa), m*b*b];
q_minus = [(mh*l*l+2*m*a*l)*cos(twoa)-m*a*b, -m*a*b;
    -m*a*b, 0];
thdot_plus = q_plus\q_minus*[x(end,2); x(end,4)];
end
