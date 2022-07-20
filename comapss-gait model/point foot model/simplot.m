function simplot(x)
  % JongRok Lee  
  figure(1)
  plot(x(1:end,1),x(1:end,2),'linewidth',2);hold on     % thst
  plot(x(1:end,3),x(1:end,4),'linewidth',2);hold on     % thsw
  axis([-0.5 0.5 -3 3]);grid on
  xlabel('\theta [rad]');
  ylabel('\theta dot [rad/s]');
  title('Limit Cycle of the Compass Gait Biped');
