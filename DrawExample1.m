clear
clc

EffMeasure=[0.95,0.95,0.95,0.93,0.91,0.87,0.87,0.83,0.81,0.78,0.78,0.78]';
EffMeasure=2*(EffMeasure-max(EffMeasure))/(max(EffMeasure)-min(EffMeasure));
id=[3,8,11,10,2,5,7,6,1,4,9,12];
J=length(EffMeasure);

%calculating upper buffered ranking
vDesSEM=sort(EffMeasure,'descend');
for j=1:J
    vUOrder(j,1)=j;
    vUA(j,1)=FunUAver(vDesSEM,vUOrder(j,1));
end
vURank=Funrank(vDesSEM,vDesSEM);
vUBRank=Funbrank(vDesSEM,vDesSEM);

%calculating lower buffered ranking
vIncrSEM=sort(EffMeasure);
for j=1:J
    vLOrder(j,1)=j;
    vLA(j,1)=FunUAver(vIncrSEM,vLOrder(j,1));
end
vLRank=flipud(J+1-Funrank(-vIncrSEM,-vIncrSEM));
vLBRank=flipud(J+1-Funbrank(-vIncrSEM,-vIncrSEM));
allRanks=[vUOrder,vDesSEM,vURank,vLRank,vUBRank,vLBRank]
allRanks=[id',allRanks];
sortrows(allRanks,1)
% ymin=vDesSEM(J)-0.1*(vDesSEM(1)-vDesSEM(J));
% ymax=vDesSEM(1)+0.1*(vDesSEM(1)-vDesSEM(J));
% xmin=vDesSEM(J)-0.1*(vDesSEM(1)-vDesSEM(J));
% xmax=vDesSEM(1)+0.1*(vDesSEM(1)-vDesSEM(J));
ymin=vDesSEM(J);
ymax=vDesSEM(1);
xmin=vDesSEM(J);
xmax=vDesSEM(1);


%draw lower average figure
figure
hold on
plot(vUOrder,vLA,'-xb','LineWidth',1.5);

%plot(vLOrder,vLA,'-*b','LineWidth',2);
%hh=legend('$k$-upper average','$k$-lower average','Location','west','Interpreter','latex')
%hh=legend('$k$-upper average','$k$-lower average');
%set(hh,'Location','west');
%set(hh,'Interpreter','latex');
plot([0,J+1-vLBRank(8)],[vDesSEM(8),vDesSEM(8)],'-.b')
plot([J+1-vLBRank(8),J+1-vLBRank(8)],[ymin,vDesSEM(8)],'-.b')
text(0,vDesSEM(8),'DE$_{6}$','HorizontalAlignment','right','Interpreter','Latex');
hh=text(J+1-vLBRank(8),ymin+0.01,'$J$+1-brDE$_6^L$','HorizontalAlignment','left','Interpreter','Latex');
%set(hh,'Rotation',45);
xlabel('$k$','Interpreter','Latex')
ylabel('LA$_k$','Interpreter','Latex')
ylim([xmin,xmax]);
yticks([-2,-1,0])
xlim([0,J]);
xticks(0:3:12);
set(gcf,'unit','centimeters','position',[10 5 10 8]);
print('LA','-depsc')
close

%draw lower bRank figure
figure
hold on
brank=vLOrder;
numWorst=sum(vIncrSEM==vIncrSEM(1));
brank(1:numWorst)=numWorst;
plot(vLA,brank,'-b','LineWidth',2);
plot([vIncrSEM(J),vLA(J)],[J,J],'-b','LineWidth',2);
plot(vDesSEM,J+1-vLBRank,'go','MarkerSize',5,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
hh=text(vDesSEM(10),J+1-vLBRank(10),'~~DE$_4$, DE$_9$, DE$_{12}$','Interpreter','Latex');
hh=text(vDesSEM(9),J+1-vLBRank(9),'~~DE$_{1}$','Interpreter','Latex');
hh=text(vDesSEM(8),J+1-vLBRank(8),'~~DE$_{6}$','Interpreter','Latex');
hh=text(vDesSEM(7),J+1-vLBRank(7),'~~DE$_{5}$,DE$_{7}$ ','Interpreter','Latex');
set(hh,'Rotation',270);
hh=text(vDesSEM(5),J+1-vLBRank(5),'~~DE$_{2}$ ','Interpreter','Latex');
set(hh,'Rotation',270);
hh=text(vDesSEM(4),J+1-vLBRank(4),'~~DE$_{10}$','Interpreter','Latex');
set(hh,'Rotation',270);
hh=text(vDesSEM(3),J+1-vLBRank(3),'~~DE$_{3}$,DE$_{8}$,DE$_{11}$','Interpreter','Latex');
set(hh,'Rotation',270);
ylabel('$J$+1-brDE$_j^L$','Interpreter','Latex');
xlabel('LA$_k$','Interpreter','Latex');
hh=text(vDesSEM(8),0,'DE$_{6}$','HorizontalAlignment','right','Interpreter','Latex');
set(hh,'Rotation',90);
text(xmin,J+1-vLBRank(8)+0.5,'$J$+1-brDE$_6^L$','HorizontalAlignment','left','Interpreter','Latex');
plot([xmin,vDesSEM(8)],[J+1-vLBRank(8),J+1-vLBRank(8)],'-.b')
plot([vDesSEM(8),vDesSEM(8)],[0,J+1-vLBRank(8)],'-.b')
xlim([xmin,xmax]);
xticks([-2,-1,0])
ylim([0,J]);
yticks(0:3:12);
set(gcf,'unit','centimeters','position',[10 5 10 8]);
print('lowerbrank','-depsc');
close



%draw upper brank figure
figure
hold on
ylabel('brDE$^U~~~~~~~~$','Interpreter','Latex');
xlabel('UA$_k$','Interpreter','Latex');
set(gcf,'unit','centimeters','position',[10 5 10 7]);
numBest=sum(vDesSEM==vDesSEM(1));
brank=vUOrder;
brank(1:numBest)=numBest;
plot(vUA,brank,'-b','LineWidth',2);
plot([vDesSEM(J),vUA(J)],[J,J],'-b','LineWidth',2);
plot(vDesSEM,vUBRank,'go','MarkerSize',5,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
text(vDesSEM(3),vUBRank(3),'~DE$_3$,DE$_8$,DE$_{11}$ ','HorizontalAlignment','right','Interpreter','Latex');
text(vDesSEM(4),vUBRank(4),'~DE$_{10}~$  ','Interpreter','Latex');
text(vDesSEM(5),vUBRank(5),'~DE$_2~$ ','Interpreter','Latex'); 
text(vDesSEM(6),vUBRank(6),'~DE$_5$,DE$_7$ ','Interpreter','Latex');
hh=text(vDesSEM(8),vUBRank(8),'~DE$_6~$ ','Interpreter','Latex');
set(hh,'Rotation',315);
hh=text(vDesSEM(9),vUBRank(9),'~DE$_1~$ ','Interpreter','Latex');
set(hh,'Rotation',315);
hh=text(vDesSEM(10),vUBRank(10),'~DE$_4$,DE$_9$,DE$_{12}~$ ','Interpreter','Latex');
set(hh,'Rotation',315);
plot([xmin,vDesSEM(5)],[vUBRank(5),vUBRank(5)],'-.b')
plot([vDesSEM(5),vDesSEM(5)],[0,vUBRank(5)],'-.b')
yticks([2,6,10])
hh=text(vDesSEM(5),0,'DE$_{2}$','HorizontalAlignment','right','Interpreter','Latex');
set(hh,'Rotation',90);
text(xmin,vUBRank(5),'brDE$_2^U$','HorizontalAlignment','right','Interpreter','Latex');
xlim([xmin,xmax]);
xticks([-2,-1,0])
ylim([0,J]);
yticks(0:3:12);
set(gcf,'unit','centimeters','position',[10 5 10 8]);
print('upperbrank','-depsc');
close

%draw upper average figure
figure
hold on
plot(vUOrder,vUA,'-xb','LineWidth',1.5);
plot([0,vUBRank(5)],[vDesSEM(5),vDesSEM(5)],'-.b')
plot([vUBRank(5),vUBRank(5)],[ymin,vDesSEM(5)],'-.b')
text(0,vDesSEM(5),'DE$_{2}$','HorizontalAlignment','right','Interpreter','Latex');
hh=text(vUBRank(5)+0.3,ymin,'brDE$_2^U$','HorizontalAlignment','left','Interpreter','Latex');
set(hh,'Rotation',90);
xlabel('$k$','Interpreter','Latex')
ylabel('UA$_k$','Interpreter','Latex')
ylim([xmin,xmax]);
yticks([-2,-1,0])
xlim([0,J]);
xticks(0:3:12);
%set(gca,'xaxisLocation','top')
set(gcf,'unit','centimeters','position',[10 5 10 8]);
print('UA','-depsc')
close






















% %draw lower brank
% figure
% hold on
% %plot(vrank,vbrank,'^b');
% plot(vURank,vUBRank,'g^','MarkerSize',5,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);
% xlim([0,J]);
% ylim([0,J]);
% xlabel('Upper rank');
% ylabel('buffered upper rank');
% plot([0,J],[0,J],':k')
% text(vURank(3),vUBRank(3),' {[1]}, {[2]}, {[3]}','HorizontalAlignment','left');
% text(vURank(4),vUBRank(4),'{[4]} ','HorizontalAlignment','right');
% text(vURank(5),vUBRank(5),'{[5]} ','HorizontalAlignment','right');
% text(vURank(6),vUBRank(6),'{[6]}, {[7]} ','HorizontalAlignment','right');
% hh=text(vURank(8),vUBRank(8),' {[8]}');
% set(hh,'Rotation',270);
% hh=text(vURank(9),vUBRank(9),' {[9]}');
% set(hh,'Rotation',270);
% hh=text(vURank(10),vUBRank(10),' {[10]}, {[11]}, {[12]}');
% set(hh,'Rotation',270);
% set(gcf,'unit','centimeters','position',[10 5 10 7]);
% print('rankvsbrank','-depsc');
% %close








% vUSEM=sort(unique(EffMeasure),'descend');
% numUSEM=length(vUSEM);
% numDraw=J*10;
% for iDraw=1:numDraw
%     vk(iDraw,1)=iDraw*J/numDraw;
%     vUA(iDraw,1)=FunUAver(vSEM,vk(iDraw,1));
% end
% plot(vk,vUA,'-');

function vrank=Funrank(vSEM,vx)
vSEM=sort(vSEM,'descend');
numvx=length(vx);
for ivx=1:numvx
    tt=sum(vSEM>vx(ivx));
    vrank(ivx,1)=tt+1;        
end
end

function vbrank=Funbrank(vSEM,vx)
vSEM=sort(vSEM,'descend');
numvx=length(vx);
for j=1:length(vSEM)
    vOrder(j,1)=j;
    vUA(j,1)=FunUAver(vSEM,vOrder(j,1));
end 
for ivx=1:numvx
%     if vx(ivx)==max(vSEM)
%         vbrank(ivx,1)=sum(vSEM==max(vSEM));
%     end
    if vx(ivx)<=mean(vSEM)
        vbrank(ivx,1)=length(vSEM);
    else
        tt=sum(vUA>=vx(ivx));
        vbrank(ivx,1)=tt+(vUA(tt)-vx(ivx))/(vUA(tt)-vUA(tt+1));        
    end
end
end

function UA=FunUAver(vSEM,k)
if k>length(vSEM)
    error('k cannot be larger than the size of EffMeasure');
end
UA=sum(vSEM(1:floor(k)))+vSEM(ceil(k))*(k-floor(k));
UA=round(UA/k*10^10)/10^10;
end