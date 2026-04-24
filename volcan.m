function [volcan_X,volcan_Y,volcan_Z] = volcan()


% Forma de volcan random

r = linspace(-5000,5000,15);

[x,y] = meshgrid(r,r);

w = randi([0,500],15);

z = 3020 + w - sqrt(x.^2 + y.^2);

% algunas ideas de cómo modelar la montaña a pasos

R = linspace(-5000,5000,300);

[volcan_X,volcan_Y] = meshgrid(R,R);

volcan_Z = interp2(x,y,z,volcan_X,volcan_Y, "cubic");

mountain = (volcan_X.^2 + volcan_Y.^2)<(3020^2);

volcan_Z = volcan_Z.*mountain;

% mapa de color para el volcán

% colors = ( (0:255)/255 ).';
% cada canal de color así puede empezarse

% map = [exp(colors)/exp(1) colors colors];

% colormap(map)

% surf(volcan_X,volcan_Y,volcan_Z, "EdgeColor","none");

% xlabel('Eje X');
% ylabel('Eje Y');
% zlabel('Eje Z');
% title('Volcán');

end
