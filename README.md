# Buffered-ranking intervals for virtual profit efficiency analysis
Best buffered ranking: The best buffered-ranking for a DMU is the highest upper buffered-ranking over all feasible settings of input/output multipliers. Here, the upper buffered-ranking for a DMU is the maximum *k* that the average of the top *k* efficient scores is higher than or equal to this DMU.

## Requirements:
- [Gurobi](http://www.gurobi.com "Gurobi"): for all Mixed-integer linear programming
- [CVX](http://cvxr.com/cvx/ "CVX"): for all continuous linear programming

## Usage
- function BestDiffBuffRankFun
- function WorstDiffBuffRankFun
- function BestDiffRankOpt
- function WorstDiffRankOpt
- function BestRatioRankOpt
- function WorstRatioRankOpt
### %Aim 
- %Estimate the best buffered-ranking of the viral profit efficiency of iDMUo among DMUs (mInput,mOutput)

## Files
-  BestDiffRankFun.m: Estimate the bestibuffered ranking in difference form 
-  WorstDifffRankFun.m: Estimate the worst buffered ranking  in difference form
-  BestDiffkOpt.m: Estimate the best ranking  in difference form
-  WorstDiffkOpt.m: Estimate the worst ranking  in difference form
-  BestRatioOpt.m: Estimate the best ranking  in ratio form
-  WorstRatioOpt.m: Estimate the worst ranking in ration form
-  CalcRanking.m: Calculate all kinds of rankings for a dataset 
-  DrawExample.m: Calculate all figures and tables for example 1
-  ListSomeRank: list computational results of some DMUs with same best rankings 
-  ListSomeBuffRank: list computational results of some DMUs with closed best buffered-rankings 
-  PFT1981Data.xlsx: The PFT1981 Data file
-  PigData.xlsx: The Pig Data file
-  HospitalsData.xlsx: The Hospitals Data file


## Citation
Yongqiao Wang, He Ni, Stan Uryasev, Buffered-Ranking Intervals for Virtual Profit Efficiency Analysis, Working paper, Zhejiang Gongshang University.
