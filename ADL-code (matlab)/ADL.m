function [DAG, time] = ADL(Data, Alpha, data_type)
% by Xianjie Guo, 2023.12.1, Singapore, NTU

ns=max(Data);
[n_samples,p]=size(Data);
maxK=3;

% start
start=tic;

varNValues=ns;
sample=Data;

SepSet=cell(p,p);
PC=cell(1,p);
skeleton=zeros(p,p);

% Step 1: learn the local skeleton of each variable in a dataset
if strcmp(data_type,'dis')
    for i=1:p
        [pc,~,sepset,~]=HITONPC_G2(sample,i,Alpha,ns,p,maxK);
        PC{i}=pc;
        SepSet(i,:)=sepset;
        skeleton(i,pc)=1;
    end
elseif strcmp(data_type,'con')
    for i=1:p
        [pc,~,~,sepset]=HITONPC_Z(sample,i,Alpha,n_samples,p,maxK);
        PC{i}=pc;
        SepSet(i,:)=sepset;
        skeleton(i,pc)=1;
    end
else
    error("Please enter the correct data type!  'dis' or 'con'");
end



% Step 2: construct the global skeleton by adaptively using the AND-rule and the OR-rule
skeleton=new_rule(skeleton,SepSet,PC,p);
cpm = tril(sparse(skeleton));


% Step 3: orient the global skeleton
if strcmp(data_type,'dis')
    % create local scorer
    LocalScorer = bdeulocalscorer(sample, varNValues);

    % create hill climber
    HillClimber = hillclimber(LocalScorer, 'CandidateParentMatrix', cpm);

    % Finally, we learn the structure of the network.

    % learn DAG structure
    DAG = HillClimber.learnstructure();
    DAG = full(DAG);
else
    nEvals = 2500;
    % Use BIC penalty
    penalty = log(n_samples)/2;
    clamped=zeros(n_samples,p); % if there is no intervention data, all are 0
    DAG = DAGsearch(sample,nEvals,0,penalty,0,clamped,skeleton,0);
    DAG = logical(DAG);
end

% end
time=toc(start);
end

