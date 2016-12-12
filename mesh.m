X1 = -2:.25:2;
Y1 = X1;
[x,y] = meshgrid(X1);
u = -y;
v = .5*x;
% subplot(2,1,2);
for i = 1:100
    pause(.5);
    quiver(x,y,u,v)
end

load wind
[sx sy sz] = meshgrid(100,20:2:50,5);
verts = stream3(x,y,z,u,v,w,sx,sy,sz);
sl = streamline(verts);
view(-10.5,18)
daspect([2 2 0.125])
axis tight;
set(gca,'BoxStyle','full','Box','on')
iverts = interpstreamspeed(x,y,z,u,v,w,verts,0.01);
set(gca,'SortMethod','childorder');
streamparticles(iverts,15,...
	'Animate',10,...
	'ParticleAlignment','on',...
	'MarkerEdgeColor','none',...
	'MarkerFaceColor','red',...
	'Marker','o');