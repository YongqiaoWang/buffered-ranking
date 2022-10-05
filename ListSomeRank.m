clc
clear

mInput=xlsread("PigData.xlsx",'input');
mOutput=xlsread("PigData.xlsx",'output');

vDMUs2nd=[24;55;81;90;113;160;164;189;209;221;228;229;238];

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
TotalResult=[];
for idDMU=1:length(vDMUs2nd)
    %best ranking of difference-based efficiency
    [BestRank,RunTime,vOptNu,vOptMu]=BestDiffRankOpt(mInput,mOutput,vDMUs2nd(idDMU),params);
    vScore=mOutput*vOptMu-mInput*vOptNu;
    %vNormScore=(max(vScore)-vScore)/vecnorm([-vOptNu;vOptMu]);
    %vNormScore=(max(vScore)-vScore)/(max(vScore)-min(vScore));
    vNormScore=round((max(vScore)-vScore)/(max(vScore)-vScore(vDMUs2nd(idDMU))),3);
    mResult=[(1:J)',vNormScore];
    for jDMU=1:J
        mResult(jDMU,3)=sum(vNormScore<vNormScore(jDMU))+1;
        mResult(jDMU,4)=bufferedRank(-vNormScore,-vNormScore(jDMU));   
    end
    mResult=sortrows(mResult,2,'ascend');
    mResult(J+1,4)=vDMUs2nd(idDMU);
    mResult(J+2,4)=BestRank;
    TotalResult=[TotalResult,mResult];
end
xlswrite("PigRank3rd.xlsx",TotalResult,"DiffRank")



function br=bufferedRank(vScore,h)
%aim: calculate the buffered ranking of h in vScores
%input:
%vScore: a vector of scores
%threshold: a score
%output:
%br: bufferedranking
numScore=length(vScore);
cvx_begin
    variable a nonnegative
    variable t(numScore) nonnegative
    minimize(sum(t))
    subject to
        for id=1:numScore
            t(id)>=a*(vScore(id)-h)+1;
        end
cvx_end
br=cvx_optval;
end