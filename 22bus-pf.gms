sets i Number of Buses in System /1*22/
     slackbus(i) Number of SlackBus in System /1/

*PV(i) Number of PV_Buses in System  / if exist/
     PQ(i) Number of PQ_Buses in System  /2*22/
  LLoad(i)/2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22/
 s index for season of year /B-P,T,Z/
         ti index for time of day /1*24/
r         /1-3,1-4,2-3,2-4/
scalar sbase/50/;

alias(i,j);



set Gen Number of Generation Units in System /g1/;

Table GenD(Gen,*) 'generating units characteristics'
         Pg      Qg      Pmax     Pmin    Qmax    Qmin
g1       0        0      1000        0     100     -100 ;


Set GBconect(i,Gen) 'connectivity index of each generating unit to each bus'

/1.g1/;

parameters
pd
qd;
parameter
pdo(i) active power for nomrmal load pu /1 0,2 0.098,3 0.0982,4 0.0984,5 0.0988,6 0.09,7 0.09,8 0.09,9 0.085,10 0.09,11 0.091,12 0.09,13 0.09,14 0.085
                                       ,15 0.088,16 0.09,
                                      17 0.088,18 0.0905,19 0.0913,20 0.092,21 0.001,22 0.09/
qdo(i) active power for nomrmal load pu /1 0,2 0.025,3 0.025,4 0.025,5 0.025,6 0.025,7 0.025,8 0.0249,9 0.0248,10 0.0247,11 0.0246,12 0.0245,13 0.0245
                                       ,14 0.0245,15 0.0245,16 0.025,17 0.028
                                      ,18 0.03,19 0.035,20 0.04,21 0.01,22 0.025/

Table BD(i,*) 'demands of each bus in MW and MVar'
         Pd          Qd

1        0            0
2        0.334        0.102
3        0.639        0.193
4        0.344        0.112
5        0.631        0.181
6        0.539        0.194
7        0.618        0.201
8        0.663        0.099
9        0.384        0.121
10       0.639        0.109
11       0.387        0.113
12       0.512        0.102
13       0.611        0.188
14       0.284        0.107
15       0.631        0.195
16       0.383        0.102
17       0.594        0.189
18       0.324        0.213
19       0.631        0.194
20       0.334        0.114
21       0.295        0.122
22       0.353        0.101;


table co_p(s,ti) coeffiecent for active power
       1         2       3       4       5      6       7        8        9        10       11      12      13      14     15       16      17      18        19      20      21      22      23      24
T      0.6      0.6     0.6     0.6     0.6    0.7     0.65     0.65     0.65     0.65     0.65    0.65    0.65    0.65   0.7      0.65    0.65    0.75      0.8     0.75    0.75    0.75    0.6     0.6
;

*table co_price(s,ti) coeffiecent for price of electricity
*        1
*2       3       4       5        6       7       8       9        10     11      12      13      14      15      16      17      18       19      20      21      22      23      24
*T      60
*  60      60      60      60       90      90      90      90       90     120     120     120     120     120     80      80      80       80      80      70      70      70      70
  ;



Table   branch(i,j,*)   in pu

                 r            x            b       rateA    rateB   rateC     tap      an        st        min         max       km

1.2            0.246         0.072375      0        0        0        0        0        0        1        -360        360        0.75
2.3            0.2624        0.0772        0        0        0        0        0        0        1        -360        360        0.8
3.4            0.1968        0.0579        0        0        0        0        0        0        1        -360        360        0.6
3.12           0.1312        0.0386        0        0        0        0        0        0        1        -360        360        0.4
4.5            0.2132        0.062725      0        0        0        0        0        0        1        -360        360        0.65
5.6            0.3116        0.091675      0        0        0        0        0        0        1        -360        360        0.95
5.13           0.2296        0.06755       0        0        0        0        0        0        1        -360        360        0.7
6.7            0.2132        0.062725      0        0        0        0        0        0        1        -360        360        0.65
6.14           0.4592        0.1351        0        0        0        0        0        0        1        -360        360        1.4
14.15          0.1968        0.0579        0        0        0        0        0        0        1        -360        360        0.6
7.8            0.2624        0.0772        0        0        0        0        0        0        1        -360        360        0.8
7.16           0.2132        0.062725      0        0        0        0        0        0        1        -360        360        0.65
16.17          0.1968        0.0579        0        0        0        0        0        0        1        -360        360        0.6
17.18          0.1804        0.053075      0        0        0        0        0        0        1        -360        360        0.55
8.9            0.2132        0.062725      0        0        0        0        0        0        1        -360        360        0.65
9.10           0.1312        0.0386        0        0        0        0        0        0        1        -360        360        0.4
9.19           0.2624        0.0772        0        0        0        0        0        0        1        -360        360        0.8
19.20          0.1476        0.043425      0        0        0        0        0        0        1        -360        360        0.45
20.21          0.1312        0.0386        0        0        0        0        0        0        1        -360        360        0.4
21.22          0.1312        0.0386        0        0        0        0        0        0        1        -360        360        0.4
10.11          0.1476        0.043425      0        0        0        0        0        0        1        -360        360        0.45
;

Set line(i,j)
/1.2,2.3,3.4,3.12,4.5,5.6,5.13,6.7,6.14,14.15,7.8,7.16,16.17,17.18,8.9,9.10,9.19,19.20,20.21,21.22,10.11/



parameter
b
g
;


variable
V
theta
Pg
Qg
Pfrom
Qfrom
Ploss
edummy
;



equations
eq1
eq2
eq3
eq4
eq5
eq6
eq7
eq8

;



b(i,j)$(line(i,j)and branch(i,j,'st'))= -branch(i,j,'x')/(sqr(branch(i,j,'r'))+sqr(branch(i,j,'x')));
g(i,j)$(line(i,j)and branch(i,j,'st'))= branch(i,j,'r')/(sqr(branch(i,j,'r'))+sqr(branch(i,j,'x')));
pd(i,ti)=BD(i,'pd') *co_p('t',ti);
qd(i,ti)=BD(i,'qd') *co_p('t',ti);

*************************************PowerFlowEquations*************************************************

eq1(i,ti)..         sum(Gen$GBconect(i,Gen), Pg(Gen,ti))-pd(i,ti)/sbase-sum(line(i,j),Pfrom(i,j,ti))-sum(line(j,i),Pfrom(i,j,ti))=e=0;

eq2(i,ti)..         sum(Gen$GBconect(i,Gen), Qg(Gen,ti))-qd(i,ti)/sbase-sum(line(i,j),Qfrom(i,j,ti))-sum(line(j,i),Qfrom(i,j,ti))=e=0;

**************************************LineFlowConstraints***********************************************

eq3(i,j,ti)$(line(i,j))..               Pfrom(i,j,ti)=e=(power(V(i,ti),2)*g(i,j)-V(i,ti)*V(j,ti)*[g(i,j)*cos(theta(i,ti)-theta(j,ti))+b(i,j)*sin(theta(i,ti)-theta(j,ti))]);


eq4(i,j,ti)$(line(i,j))..               Pfrom(j,i,ti)=e=(power(V(j,ti),2)*g(i,j)-V(i,ti)*V(j,ti)*[g(i,j)*cos(theta(i,ti)-theta(j,ti))-b(i,j)*sin(theta(i,ti)-theta(j,ti))]);


eq5(i,j,ti)$(line(i,j))..               Qfrom(i,j,ti)=e=(-power(V(i,ti),2)*(branch(i,j,'b')/2+b(i,j))-V(i,ti)*V(j,ti)*[g(i,j)*sin(theta(i,ti)-theta(j,ti))-b(i,j)*cos(theta(i,ti)-theta(j,ti))]);


eq6(i,j,ti)$(line(i,j))..               Qfrom(j,i,ti)=e=(-power(V(j,ti),2)*(branch(i,j,'b')/2+b(i,j))+V(i,ti)*V(j,ti)*[g(i,j)*sin(theta(i,ti)-theta(j,ti))+b(i,j)*cos(theta(i,ti)-theta(j,ti))]);

V.lo(i,ti)=0.7;

V.up(i,ti)=1.05;


V.fx('1',ti)=1.08;

Pg.lo(Gen,ti) = GenD(Gen,'Pmin')/sbase;
Pg.up(Gen,ti) = GenD(Gen,'Pmax')/sbase;

Qg.lo(Gen,ti) = GenD(Gen,'Qmin')/sbase;
Qg.up(Gen,ti) = GenD(Gen,'Qmax')/sbase;

*******************************************************************************************************************************************

eq7(ti)..                Ploss(ti)=e=0.5*(sum(line(i,j),g(i,j)*[sqr(V(i,ti))+sqr(V(j,ti))-2*V(i,ti)*V(j,ti)*cos(theta(i,ti)-theta(j,ti))]));

eq8..                edummy=e=0;
model Rec/all/
*eq2,eq8,eq3,eq4/
*,eq3,eq4,eq5,eq6,eq7,eq8/;


option reslim=1000800;

option minlp=dicopt;
*optca=0,optcr=0,nlp=conopt4;


solve Rec using minlp minimizing edummy;
display v.l,pg.l,qg.l,ploss.l;

execute_unload "results_22bus-pf.gdx" pg
execute 'gdxxrw.exe results_22bus-pf.gdx var=pg rng=classic1!'
execute_unload "results_22bus-pf.gdx" qg
execute 'gdxxrw.exe results_22bus-pf.gdx Var=qg rng=classic2!'
execute_unload "results_22bus-pf.gdx" v
execute 'gdxxrw.exe results_22bus-pf.gdx Var=v rng=classic3!'
execute_unload "results_22bus-pf.gdx" ploss
execute 'gdxxrw.exe results_22bus-pf.gdx var=ploss rng=classic4!'
execute_unload "results_22bus-pf.gdx" theta
execute 'gdxxrw.exe results_22bus-pf.gdx var=theta rng=classic5!'
