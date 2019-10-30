





% load fluctuation simulator for Multi-Period ACOPF solver test.
% It returns active (Pd) and reactive (Qd) load per simulation time. 
% The length of simulation horizon is dependet total number of simulation
% time steps. For example: 
%    T = [t1  t2   t3  .... tN]; So length of T is length(t1)*N. In order
%    to return Pd and Qd, we need to: 
% Inputs:     
%        bus         bus matrix, a standard bus format in MATPOWER
%        simHor      simulation horizon of simulation to generate Pd and Qd
%        hourNo      number of timeSteps per a day in a simulation
%
% Ouputs
%        Pd          matrix of active load [nb * N]
%        Qd          matrix of reactive load [nb * N]

%% input variables


pd = bus (:,3);
qd = bus (:,4);
kl = [1    2    3      4     5   6     7    8     9     10   11   12   13  14    15    16   17   18    19   20   21  22   23 24;
     0.45 0.4  0.35    0.3  0.4  0.45  0.5  0.6   0.7   0.6  0.55  0.5  0.4 0.45 0.55  0.6  0.65  0.8  0.9 1.0   0.9 0.8 0.6 0.5; 
     1     1    1       1    1   1     1     1    1      1    1    1    1   1     1    1     1    1     1   1     1    1   1  1 ];

repTimes = simHor/hourNo; 
KL_p  = zeros(1, simHor);
KL_Q  = zeros(1, simHor);
 for i = 1:  repTimes
     
     l = 1+(i-1)*hourNo : i*hourNo;
     KL_p(1, l) = kl(2,:);
     KL_Q(1, l) = kl(3,:);
     
     
 end
 
 Pd = pd.*KL_p;
 Qd = qd.*KL_Q;