function plotva(v,a,dn)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

scatter(v,a);
dx = 0.2; dy = 0.2;
text(v+dx,a+dx,dn);
xlabel('Valence');
ylabel('Arousal');

xmax = max(abs(v));
xmax = 1.2*xmax;
ymax = max(abs(a));
ymax = 1.2*ymax;
axis([-xmax xmax -ymax ymax]);

x = -xmax:xmax;
y = -ymax:ymax;
hold on;
plot(0*y,y,'black');
hold on;
plot(x,0*x,'black');
end

