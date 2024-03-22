sets
 i Number of Buses in System /1*22/
r /z1*z4/
z/1*5/

     slackbus(i) Number of SlackBus in System /1/

*PV(i) Number of PV_Buses in System  / if exist/
     PQ(i) Number of PQ_Buses in System  /2*22/
  LLoad(i)/2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22/
 s index for season of year /B-P,T,Z/
         ti index for time of day /1*24/
          w index for level of operation/1*4/


alias(i,j);



set Gen Number of Generation Units in System /g1/;

parameter
c_fix fix costof location cs ($) / 163000/
cs_p cost for one charge point /20907.44/

scalar sbase/50/;

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
       1     2       3       4       5    6       7        8        9        10       11      12      13      14     15       16      17      18        19      20      21      22      23      24
T      0.6  0.6     0.6     0.6     0.6   0.7     0.65     0.65     0.65     0.65     0.65    0.65    0.65    0.65   0.7      0.65    0.65    0.75      0.8     0.75    0.75    0.75    0.6     0.6
;

table co_price(s,ti) coeffiecent for price of electricity
        1         2       3       4       5    6       7       8       9        10     11      12      13      14      15      16      17      18       19      20      21      22      23      24
T      60        60      60      60      60    90      90      90      90       90     120     120     120     120     120     80      80      80       80      80      70      70      70      70
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
table c_wait(i,w)  cost of waiting because of state of level of opreation charging station  ($.h)
         1       2       3       4
1        1       1.5     3       6
2        1       1.5     3       6
3        1       1.5     3       6
4        1       1.5     3       6
5        1       1.5     3       6
6        1       1.5     3       6
7        1       1.5     3       6
8        1       1.5     3       6
9        1       1.5     3       6
10       1       1.5     3       6
11       1       1.5     3       6
12       1       1.5     3       6
13       1       1.5     3       6
14       1       1.5     3       6
15       1       1.5     3       6
16       1       1.5     3       6
17       1       1.5     3       6
18       1       1.5     3       6
19       1       1.5     3       6
20       1       1.5     3       6
21       1       1.5     3       6
22       1       1.5     3       6;
Set line(i,j)
/1.2,2.3,3.4,3.12,4.5,5.6,5.13,6.7,6.14,14.15,7.8,7.16,16.17,17.18,8.9,9.10,9.19,19.20,20.21,21.22,10.11/



parameter
b
g
d_
d(r) /z1 210,z2 185,z3 150,z4 130/
c_d(ti)/1 0.01,2 0.01,3 0.01,4 0.01,5 0.01,6 0.06,7 0.06,8 0.06,9 0.06,10 0.06,11 0.07,12 0.07,13 0.07,14 0.07,15 0.07,16 0.09,17 0.09,18 0.09,19 0.03,20 0.03,21 0.03,22 0.03,23 0.03,24 0.03/  ;

table TR(r,i)
        1       2       3     4       5          6       7       8       9       10      11      12      13      14      15      16      17      18      19      20      21      22
z1      5       5       5     5      20          20      20      20      27      27      27      5       20      20      20      20      20      20      27      27      27      27
z2     12      12      12    12      15          5       5       5       10      10      10      12      15      5       5       15      15      15      10      20      10      10
z3     20      20      20    20      15          15      15      15      5        5       5      20      15      15      15      15      15      15      5       5       5       5
z4     20      20      20    20      5           10      10      10     15       15      15      20      5       10      10      5       5        5      15      15      15      15 ;
D_(r,ti)=d(r)*c_d(ti);
****************&&&&&&&&&&&&&&&&&&&
set
dg/pv,wt/
;
parameters
cww/10000/
vc_i  cut_in/3/
vc_o cut_out /25/
v_r rated velovity/15/
p_wind
h_c

wt_max maximum power w-t 0.5mw/0.01/
pv_mx maximum power kw 450kw /0.009/

v_wind(ti)/1 107.95,2 8.8,3 9.65,4 10.55,5 9.45
,6 8.45,7 7.15,8 6.4,9 6.45,10 5.1,11 4.35,12 4.7,13 5.1
,14 6.2,15 7.2,16 8,17 9.35,18 10,19 9,20 8.5,21 7.4
,22 7,23 6.75,24 7.15/
TA(ti)/1 0
,2 0,3 0,4 0,5 0.8
,6 0.5,7 0.6,8 0.8,9 0.9,10 0.95,11 0.98,12 1,13 1,14 1,15 1,16 0.98
,17 0.95,18 0.8
,19 0.4,20 0,21 0,22 0,23 0,24 0/
;
*table h_c(dg,k) harmonic current factor
*         1     2        3       4        5       6        7       8       9       10      11
*pv       1     0.011    0.032   0.0026   0.034   0.0012   0.011   0.008   0.0004   0.008   0.006
*wt       1     0.011    0.032   0.0026   0.034   0.0012   0.011   0.008   0.0004   0.008   0.006
;
*i_wt(k,i,ti)$lload(i)= p_wind(ti)* h_c('wt',k);
*i_pv(k,i,ti)$lload(i)= TA(ti)*pv_mx* h_c('pv',k);

p_wind(ti)$(v_wind(ti)<vc_i)=0 ;

p_wind(ti)$(vc_i<v_wind(ti) and v_wind(ti)<v_r)=wt_max* (v_wind(ti)-vc_i)/(v_r-vc_i);
p_wind(ti)$(v_r<v_wind(ti) and v_wind(ti)<vc_o)=wt_max;

p_wind(ti)$(v_wind(ti)>vc_o)=0 ;
*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

positive variable pwind,pv,sst
positive variable fr
positive variable landa
binary variable xs
integer variable y
binary variable bw,bp

variable
V
theta
Pg
Qg
Pfrom
Qfrom
Ploss
edummy
pst
qst
pstt
;



equations
eq1
eq2
eq3
eq4
eq5
eq6
*eq7
eq8
e1
e2
e3
e4
co1
co2
co3
co4
co5
co6
co7
co8
co9;

parameter
c_instal
c_travel
c_waitt
c_equip

co_pp
plosss
;

b(i,j)$(line(i,j)and branch(i,j,'st'))= -branch(i,j,'x')/(sqr(branch(i,j,'r'))+sqr(branch(i,j,'x')));
g(i,j)$(line(i,j)and branch(i,j,'st'))= branch(i,j,'r')/(sqr(branch(i,j,'r'))+sqr(branch(i,j,'x')));
pd(i,ti)=BD(i,'pd') *co_p('t',ti);
qd(i,ti)=BD(i,'qd') *co_p('t',ti);
co_pp(ti) =co_price('t',ti);
***********************************objective function
eq8.. edummy=e=sum(i,c_fix*xs(i)+cs_p*y(i))+sum((w,i,ti),c_wait(i,w)*landa(i,w,ti))+10*(sum((i,r,ti),D_(r,ti)*fr(i,r,ti)*TR(r,i)))
+sum((i )$lload(i),6322*Sbase*pstt(i)*xs(i))+sum((i,gen,ti),co_pp(ti)*pg(gen,ti)+(co_pp(ti)*0.15)*(pv(i,ti)+pwind(i,ti)));

*****************************************TN_constraints*********************************************
co1(i,ti)$ LLoad(i)                          ..sum(r,D_(r,ti)*fr(i,r,ti))=e=sum(w,landa(i,w,ti));
co2(i,w,ti)$ LLoad(i)                      ..landa(i,w,ti)=l=y(i);
co3(r,ti)                        ..sum(i $LLoad(i),fr(i,r,ti))=e=1;
co4                           ..sum(i,xs(i))=l=5 ;
co5(i) $ LLoad(i)                       ..y(i)=l=5*xs(i);
co6(i) $ LLoad(i)                       ..y(i)=g=xs(i);
co7(i,i,ti) $LLoad(i)      ..sum(r,D_(r,ti)*fr(i,r,ti))=l=4*y(i);
co8(i ,ti)$ (lload(i))       ..pst(i ,ti)=e=((sum(w,landa(i,w,ti))*0.15*(0.001)*100)/(1*0.9*sbase));

*************************************PowerFlowEquations*************************************************

eq1(i,ti)..         sum(Gen$GBconect(i,Gen), Pg(Gen,ti))+pv(i,ti)$lload(i)+pwind(i,ti)$lload(i)-pst(i,ti)$lload(i)-pd(i,ti)/sbase-sum(line(i,j),Pfrom(i,j,ti))-sum(line(j,i),Pfrom(i,j,ti))=e=0;
*+pv(i,ti)+pwind(i,ti)
eq2(i,ti)..         sum(Gen$GBconect(i,Gen), Qg(Gen,ti))-qd(i,ti)/sbase-sum(line(i,j),Qfrom(i,j,ti))-sum(line(j,i),Qfrom(i,j,ti))=e=0;

*co9(i,ti)$LLoad(i)                                ..sqrt(sqr(pst(i,ti))+sqr(qst(i,ti)))=l=(sst(i));
co9(i,ti) ..    pst(i,ti)=l=pstt(i)*xs(i)  ;
**************************************LineFlowConstraints***********************************************

eq3(i,j,ti)$(line(i,j))..               Pfrom(i,j,ti)=e=(power(V(i,ti),2)*g(i,j)-V(i,ti)*V(j,ti)*[g(i,j)*cos(theta(i,ti)-theta(j,ti))+b(i,j)*sin(theta(i,ti)-theta(j,ti))]);


eq4(i,j,ti)$(line(i,j))..               Pfrom(j,i,ti)=e=(power(V(j,ti),2)*g(i,j)-V(i,ti)*V(j,ti)*[g(i,j)*cos(theta(i,ti)-theta(j,ti))-b(i,j)*sin(theta(i,ti)-theta(j,ti))]);


eq5(i,j,ti)$(line(i,j))..               Qfrom(i,j,ti)=e=(-power(V(i,ti),2)*(branch(i,j,'b')/2+b(i,j))-V(i,ti)*V(j,ti)*[g(i,j)*sin(theta(i,ti)-theta(j,ti))-b(i,j)*cos(theta(i,ti)-theta(j,ti))]);


eq6(i,j,ti)$(line(i,j))..               Qfrom(j,i,ti)=e=(-power(V(j,ti),2)*(branch(i,j,'b')/2+b(i,j))+V(i,ti)*V(j,ti)*[g(i,j)*sin(theta(i,ti)-theta(j,ti))+b(i,j)*cos(theta(i,ti)-theta(j,ti))]);

**************************************************************************************************************
e1(i,ti)$lload(i)                                     ..pwind(i,ti)=l=p_wind(ti)*bw(i);

e2..                                        sum(i,bw(i))=e=1;


e3(i,ti) $lload(i)                                     ..pv(i,ti)=l=pv_mx*TA(ti)*bp(i);

e4..                                        sum(i,bp(i))=e=1;

*eq7(ti)..                Ploss(ti)=e=0.5*(sum(line(i,j),g(i,j)*[sqr(V(i,ti))+sqr(V(j,ti))-2*V(i,ti)*V(j,ti)*cos(theta(i,ti)-theta(j,ti))]));
*****************************************************
V.lo(i,ti)=0.7;

V.up(i,ti)=1.05;

*qst.up(i,ti)=0;
pstt.lo(i)=0;
pstt.up(i)=0.02;
V.fx('1',ti)=1.08;

Pg.lo(Gen,ti) = GenD(Gen,'Pmin')/sbase;
Pg.up(Gen,ti) = GenD(Gen,'Pmax')/sbase;

Qg.lo(Gen,ti) = GenD(Gen,'Qmin')/sbase;
Qg.up(Gen,ti) = GenD(Gen,'Qmax')/sbase;

model Rec/all/


option reslim=1000800;

option lp=cplex,nlp=lindo,minlp=dicopt;
*option optca=1,optcr=1;

solve Rec using minlp minimizing edummy;

*********************************
c_instal= sum(i,c_fix*xs.l(i)+cs_p*y.l(i));
c_travel=10*(sum((i,r,ti),D_(r,ti)*fr.l(i,r,ti)*TR(r,i))) ;
c_waitt=sum((w,i,ti),c_wait(i,w)*landa.l(i,w,ti));
c_equip=sum((i )$lload(i),6322*Sbase*pstt.l(i)*xs.l(i));
plosss(ti)=0.5*(sum(line(i,j),g(i,j)*[sqr(V.l(i,ti))+sqr(V.l(j,ti))-2*V.l(i,ti)*V.l(j,ti)*cos(theta.l(i,ti)-theta.l(j,ti))]));

****************888

display xs.l,y.l,fr.l,landa.l,edummy.l,c_instal,c_travel,c_waitt,c_equip,pst.l,pstt.l,v.l,pg.l,qg.l,pwind.l,pv.l,bp.l,bw.l,plosss;

* v.l,pg.l,qg.l,ploss.l,bw.l,bp.l,pwind.l,pv.l;
execute_unload "results_22-DG-cs.gdx" pg
execute 'gdxxrw.exe results_22-DG-cs.gdx var=pg rng=classic1!'
execute_unload "results_22-DG-cs.gdx" qg
execute 'gdxxrw.exe results_22-DG-cs.gdx Var=qg rng=classic2!'
execute_unload "results_22-DG-cs.gdx" v
execute 'gdxxrw.exe results_22-DG-cs.gdx Var=v rng=classic3!'
execute_unload "results_22-DG-cs.gdx" plosss
execute 'gdxxrw.exe results_22-DG-cs.gdx par=plosss rng=classic4!'
execute_unload "results_22-DG-cs.gdx" pst
execute 'gdxxrw.exe results_22-DG-cs.gdx var=pst rng=classic5!'
execute_unload "results_22-DG-cs.gdx" pwind
execute 'gdxxrw.exe results_22-DG-cs.gdx var=pwind rng=classic6!'
execute_unload "results_22-DG-cs.gdx" pv
execute 'gdxxrw.exe results_22-DG-cs.gdx var=pv rng=classic7!'

execute_unload "results_22-DG-cs.gdx" fr
execute 'gdxxrw.exe results_22-DG-cs.gdx var=fr rng=classic8!'
execute_unload "results_22-DG-cs.gdx" landa
execute 'gdxxrw.exe results_22-DG-cs.gdx var=landa rng=classic9!'