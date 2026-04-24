% Función que hace un círculo!
% -------------------------------

function [x,y] = getCircle(r,center)

  % know that center is a length 2 vector containing
  % coordinates x and y for the center.

  tic;

  h = center(1); k = center(2);

  t = 0:0.01:2*pi;

  % here we use the circle equations for x and y

  x = r*cos(t) + h; y = r*sin(t) + k;

  x = sparse(x).'; y = sparse(y).'; % it is recommended for performance!

  % disp(['It took ' num2str(toc) ' [s] to make this circle.'])


endfunction
