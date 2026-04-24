function [X,Y,Z,m, v_0] = proyectil(o)

% lanzamientos del volcán

% condiciones iniciales

  rho_b = 2500; % kg/m3 ...densidad del proyectil

  g = 9.81;

  rho = 0.77; % kg/m^3, investigar esta densidad del aire...

  f = 0:359;

  % step!!!

  h = 0.1;

  T_stop = 60;

  X = []; Y = []; Z =[]; T = [];

  done = 0;

  for t=0:h:T_stop

    if t == 0
      % o = randi([0,89]);

      v_0 = randi([150,290]); % m/s

      v = v_0;

      % m = 35.34 + randi([-10,10]); % supongamos un intervalo de +-10

      D = (40 + randi([-25,25]))/100;

      C = randi([47,55])/100;

      A = (pi*D^2)/4; K = rho*C*A/2;

      m = (2*A*D*rho_b)/3;

      u = [ v*cosd(o)*cosd(f) ; v*cosd(o)*sind(f); v*sind(o)*ones(1,360) ];

      a = [zeros(1,360); zeros(1,360); -g*ones(1,360)] - (K/m)*v.*u;

      r = [zeros(1,360); zeros(1,360); 3020*ones(1,360)];

    end

  T = [T; t];

  u = u + h*a;

  r = r + h*u;

  X = [X; r(1,:)]; Y = [Y; r(2,:)]; Z = [Z; r(3,:)];

  X = sparse(X); Y = sparse(Y); Z = sparse(Z);

  v = sqrt(sum(u.*u));

  a = [zeros(1,360); zeros(1,360); -g*ones(1,360)] - (K/m)*v.*u;

  l = r(3,:);

  limit = 3000 - sqrt(r(1)^2 + r(2)^2);

  if (limit <= 0)
    limit = 0;
  end

  for k = 1:length(l)
    if done == 1
      break
    end

    if (l(k) <= limit )
      done = 1;
    end

  end

  if done == 1
    break
  end

  end

save "proyectil.txt" X Y Z m


end

