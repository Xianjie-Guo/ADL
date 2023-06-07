function [DAG, time] = ADL(Data, Alpha)
% by Xianjie Guo, 2021.3.2

ns=max(Data);
[~,p]=size(Data);
maxK=3;

% start
start=tic;

varNValues=ns;
sample=Data;

SepSet=cell(p,p);
PC=cell(1,p);
skeleton=zeros(p,p);

% learn the local skeleton of each variable in a dataset
for i=1:p
    [pc,~,sepset,~]=HITONPC_G2(sample,i,Alpha,ns,p,maxK);
    PC{i}=pc;
    SepSet(i,:)=sepset;
    skeleton(i,pc)=1;
end

% construct the global skeleton by adaptively using the AND-rule and the OR-rule
skeleton=new_rule(skeleton,SepSet,PC,p);
cpm = tril(sparse(skeleton));

% create local scorer
LocalScorer = bdeulocalscorer(sample, varNValues);

% create hill climber
HillClimber = hillclimber(LocalScorer, 'CandidateParentMatrix', cpm);

% Finally, we learn the structure of the network.

% learn DAG structure
DAG = HillClimber.learnstructure();

% end
time=toc(start);
end

