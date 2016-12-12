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
figure
daspect([1,1,1]);
view(2)
[verts,averts] = streamslice(x,y,z,u,v,w,[],[],[5]);
sl = streamline([verts averts]);
axis tight manual off;
ax = gca;
ax.Position = [0,0,1,1];
set(sl,'Visible','off')
iverts = interpstreamspeed(x,y,z,u,v,w,verts,.05);
zlim([4.9,5.1]);
streamparticles(iverts, 200, ...
    'Animate',15,'FrameRate',40, ...
    'MarkerSize',10,'MarkerFaceColor',[0 .5 0])