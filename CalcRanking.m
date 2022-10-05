function CalcRanking(DataName)
%calculate all rankings and buffered-rankings
%inputs:
%DataName: the name of the Data.xls file. 
    %It must include a sheet named 'input', and another sheet named
    %'output'.
    %Both sheets have no title for each column, such as 'labor', 'capital'.

mInput=xlsread(strcat(DataName,"Data.xlsx"),'input');
mOutput=xlsread(strcat(DataName,"Data.xlsx"),'output');

[J,nInput]=size(mInput);
[JOutput,nOutput]=size(mOutput);
if J~=JOutput
    error('The input and output matrix must have the same num of rows');
end

params.IntFeasTol=1e-9;
params.MIPGap=0;
params.MIPGapAbs=0;
params.TimeLimit=3600;
params.MIPFocus=2;

for iDMUo=1:1
    strcat("No.",num2str(iDMUo)," Calculating.....")
    %best buffered-ranking of difference-based efficiency
    [BestBuffRank,RunTime,UpperRankOfBuffRank]=BestDiffBuffRankOpt(mInput,mOutput,iDMUo,params);
    mRunTime(iDMUo,3)=RunTime;
    mRank(iDMUo,2)=UpperRankOfBuffRank;
    mRank(iDMUo,3)=BestBuffRank; 
    
    %worst buffered-ranking of difference-based efficiency
    [WorstBuffRank,RunTime,LowerRankOfBuffRank]=WorstDiffBuffRankOpt(mInput,mOutput,iDMUo,params);
    mRunTime(iDMUo,4)=RunTime;
    mRank(iDMUo,4)=WorstBuffRank;
    mRank(iDMUo,5)=LowerRankOfBuffRank;

    %best ranking of ratio-based efficiency
    [Rank,RunTime]=BestRatioRankOpt(mInput,mOutput,iDMUo,params);
    mRunTime(iDMUo,5)=RunTime;
    mRank(iDMUo,7)=Rank; 
    
    %worst ranking of ratio-based efficiency
    [Rank,RunTime]=WorstRatioRankOpt(mInput,mOutput,iDMUo,params);
    mRunTime(iDMUo,6)=RunTime;
    mRank(iDMUo,8)=Rank;
    
    %best ranking of difference-based efficiency
    [BestRank,RunTime]=BestDiffRankOpt(mInput,mOutput,iDMUo,params);
    mRunTime(iDMUo,1)=RunTime;
    mRank(iDMUo,1)=BestRank; 
    
    %worst ranking of difference-based efficiency
    [WorstRank,RunTime]=WorstDiffRankOpt(mInput,mOutput,iDMUo,params);
    mRunTime(iDMUo,2)=RunTime;
    mRank(iDMUo,6)=WorstRank;  
 end
xlswrite(strcat(DataName,'Result.xlsx','mRunTime'),mRunTime)
xlswrite(strcat(DataName,'Result.xlsx','mRank'),mRank)

DrawRankings(DataName)
