function speed=stepspeed(x,t)
global L l_t l_s

foot=[-L*sin(x(end,1)) L*cos(x(end,1))]+[l_t*sin(x(end,3)) -l_t*cos(x(end,3))]+[l_s*sin(x(end,5)) -l_s*cos(x(end,5))];
speed = sqrt(dot(foot,foot))/t(end);
end
