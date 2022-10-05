function DrawRankings(DataName)

mRank=xlsread(strcat(DataName,'Result.xlsx'),"mRank");

f=figure()
hold on
[J,numRank]=size(mRank);
b1=bar(mRank(1:J,6),'EdgeColor','w','FaceColor','b');
b2=bar(mRank(1:J,5),'EdgeColor','w','FaceColor','y');
b3=bar(mRank(1:J,4),'EdgeColor','w','FaceColor','r');
b4=bar(mRank(1:J,3),'EdgeColor','w','FaceColor','y');
b5=bar(mRank(1:J,2),'EdgeColor','w','FaceColor','b');
b6=bar(mRank(1:J,1),'EdgeColor','w','FaceColor','w');
ylabel('Ranking')
xlabel('DMU No.')
legend({'Ranking Interval','Approximate Ranking Interval','Buffered-ranking Interval'},'location',"northoutside",'Orientation',"horizontal")
set(f,'Position',[100 100 900 400])
saveas(f,strcat(DataName,'Rankings.eps'),'epsc');
end

