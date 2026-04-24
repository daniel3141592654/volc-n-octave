% paso 1: crear el volcan!
clear;
clc;

[volcan_X, volcan_Y, volcan_Z]=volcan();


colors = ( (0:255)/255 ).'; % cada canal de color así puede empezarse

map = [exp(colors)/exp(1) colors colors];

figure (1,"Name", "Simulación")

hold on

colormap(map)

surf(volcan_X, volcan_Y, volcan_Z)

title('Superficie del volcan')
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)')

R = [];

% [a,b,c] = sphere();

% la lista de colores del mapa!!

color_list = [[1,0,0];[1,0.5,0];[1,1,0]];


for theta = 0:15:89

  figure (1,"Name", "Simulación")

  [X,Y,Z,mass,vel] = proyectil(theta);

  r = mean(sqrt(X(end,:).^2 + Y(end,:).^2));

  R = [R; r];

  % fprintf("Radio del lanzamiento = %.3f m\n",r)

  phi = randi([1,360],3,1);

  x = X(:,phi); y = Y(:,phi); z = Z(:,phi);

  for t=1:10:length(x)

    plot3(x(t,:), y(t,:), z(t,:), '.',...
          'color', [1,(length(x)-t)/length(x),0])
    pause(0.05)

  end

  figure(2,"Name", "Mapa de riesgo")

  hold on

  collision_x = x(end,:); collision_y = y(end,:);

  label = sprintf("Proyectil con theta = %.1f °, m = %.2f kg v = %.1f m/s",theta,mass,vel);

  plot(collision_x(:), collision_y(:), '*',...
  'color', [ 0, 0.5, theta/89], 'DisplayName', label)

  legend()


end

rmin = min(R); rmean = mean(R); rmax = max(R);

rlist = [rmin rmean rmax];

figure(2,"Name", "Mapa de riesgo")

hold on

[c,h] = contour(volcan_X, volcan_Y, volcan_Z, '-k');

clabel(c,h) % pone indicaciones de altura del terreno

axis('equal')


for k = 1:length(rlist)

  [circle_x,circle_y] = getCircle(rlist(k), [0,0]);

  msg = sprintf("Alcance: %.2f m\n", rlist(k));

  plot(circle_x, circle_y, "Color", color_list(k,:), "DisplayName", msg)
  title('Mapa del alcance del proyectil')
  xlabel('X (m)'); ylabel('Y (m)')
  legend()
end

fprintf("Alcance mínimo: %.3f\nMedio: %.3f\nMáximo: %.3f\n",rmin,rmean,rmax)

xlim([-5000,5000])
ylim([-5000,5000])

clear
