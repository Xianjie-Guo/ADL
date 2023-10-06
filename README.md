[Adaptive Skeleton Construction for Accurate DAG Learning](https://ieeexplore.ieee.org/abstract/document/10098143) <br>

# Usage
"ADL.m" is main function. <br>
Note that this code currently supports only discrete datasets.<br>
----------------------------------------------
function [DAG, time] = ADL(Data, Alpha) <br>
* INPUT: <br>
```Matlab
Data is the data matrix, and rows represent the number of samples and columns represent the number of nodes. If Data is a discrete dataset, the value in Data should start from 1.
Alpha is the significance level, e.g., 0.01 or 0.05.
```
* OUTPUT: <br>
```Matlab
DAG is a directed acyclic graph learned on a given dataset。
time is the runtime of the algorithm.
```
# Example
```Matlab
clear;
clc;
addpath(genpath('common_func/'));
alpha=0.01;
data=load('./dataset/Alarm_network/Alarm_s500_v1.txt');
data=data+1;
[DAG, time] = ADL(data, alpha);
```

# Reference
* Guo, Xianjie, et al. "Adaptive Skeleton Construction for Accurate DAG Learning." *IEEE Transactions on Knowledge and Data Engineering* (2023).
