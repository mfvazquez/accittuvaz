close all;
clear all;

Medicion1=dlmread('VRg1.txt','\t',1,0);

%tiempo=Medicion1(:,1)*1000000;	%en micro seg
%Vc=Medicion1(:,2);
%Vrg=16.5-Vc;
%Ic=Vrg/18;
%derivadaVc= diff(Vc) ./diff(tiempo);
%C=Ic(1:end-1)./derivadaVc;


%figure
%hold on
%plot(tiempo(2:end),Vc(2:end),'k-','Linewidth',1)
%plot(tiempo(2:end),Vrg(2:end),'k-','Linewidth',1)
%plot(tiempo(2:end),Ic(2:end)*1000,'r-','Linewidth',1)
%plot(tiempo(2:end),derivadaVc,'b-','Linewidth',1)
%plot(tiempo(2:end),C*1000,'m-','Linewidth',1)
%grid minor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tiempo=0:0.02:1.6; 				%el intervalo de tiempo es const=0.02
tiempo=tiempo';

Vc=Medicion1(:,2);
Vc=Vc(320:400);				% 400-320=80 ptos        80*0.02=1.6
Vrg=16.3-Vc;
Ic=Vrg/18;
derivadaVc= diff(Vc) ./diff(tiempo);
C=Ic(1:end-1)./derivadaVc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tiempo1=0:0.02:1.6;
tiempo1=tiempo1';

Vc1=16.3-16.3*exp(-3*tiempo1);			%ajuste exponencial a ojo
					%no podia hacerlo con el fminsearch
					%me tiraba error
Vrg1=16.3-Vc1;
Ic1=Vrg1/18;
derivadaVc1= diff(Vc1) ./diff(tiempo1);
C1=Ic1(1:end-1)./derivadaVc1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure
hold on
plot(tiempo,Vc,'r-','Linewidth',1)
plot(tiempo,Vrg,'b-','Linewidth',1)
plot(tiempo,Ic,'k-','Linewidth',1)
plot(tiempo(1:end-1),derivadaVc,'g-','Linewidth',1)	% la derivada da cualquier cosa
plot(tiempo(1:end-1),C*1000,'m-','Linewidth',1)		% da mal por culpa de la derivada
axis([0 1.6 0 50])
grid minor

figure
hold on
plot(tiempo1,Vc1,'r-','Linewidth',1)			%curva del ajuste
plot(tiempo,Vc,'r-','Linewidth',1)			%curva medida
plot(tiempo1,Vrg1,'b-','Linewidth',1)
plot(tiempo1,Ic1,'k-','Linewidth',1)
plot(tiempo1(1:end-1),derivadaVc1,'g-','Linewidth',1)
plot(tiempo1(1:end-1),C1*1000,'m-','Linewidth',1)  	% unidad de capacidad nF 
					% C =19.06nF
grid minor