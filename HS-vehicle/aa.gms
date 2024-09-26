Sets
k number of route /1,2,3/
r number of the the vehicle type(1 for minibus and 2 for bus)/1,2/
i index of minbus(1 shows minibus number 1)/1*100/
j index of bus(1 shows bus number 1)/1*60/;
Integer Variables
x(i,k) number of travelers on minibus number i on route k
y(j,k) number of travelers on minibus number i on route k;
Variables Z
S(k) number of passengers left behind on route k ;
Binary Variables
m(i,k) If minibus number i is used on route k
b(j,k) If bus number j is used on route k;
Parameters
c(r) cost of travel per mile by vehicle type
/1 2
2 3/
l(k) length of route k
/1 20
2 30
3 40/
w(r) max capacity of vehicle type
/1 20
2 40/
p(r)
/1 100
2 60/
Table H(r,k) max number of vehicle r in route k
         1       2       3
1        20      40      20
2        25      20      30
scalar T /5/;
scalar D /10000/;

Equations
obj objective function
cons1(k) equation for number of passengers left behind on route k
cons2(k) making sure the number of minibus on route k is not more than max on route k
cons3(k) making sure the number of bus on route k is not more than max on route k
cons4(i,k) making sure we don't have more passengers than the capacity of minibus and allocate only to vehicles we use
cons5(j,k) making sure we don't have more passengers than the capacity of bus and allocate only to vehicles we use
cons6(i)
cons7(j)
cons8
cons9;
obj..Z=E=sum(k,(c('1')*l(k)*sum(i,m(i,k))+c('2')*l(k)*sum(j,b(j,k))+T*S(k)));
cons1(k)..D-sum(i,x(i,k))-sum(j,y(j,k))=E=S(k);
cons2(k)..sum(i,m(i,k))=L=H('1',k);
cons3(k)..sum(j,b(j,k))=L=H('2',k);
cons4(i,k)..x(i,k)=L=w('1')*m(i,k);
cons5(j,k)..y(j,k)=L=w('2')*b(j,k);
cons6(i)..sum(k,m(i,k))=L=1;
cons7(j)..sum(k,b(j,k))=L=1;
cons8.. sum((i,k),m(i,k))=l= p('1') ;
cons9.. sum((j,k),b(j,k))=l= p('2');


Model Travel /all/;
Solve Travel using mip minimizing Z;
Display x.l,
        y.l,
        m.l,
        b.l;




