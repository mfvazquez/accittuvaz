close all;
clear all;

Medicion1=dlmread('Medicion1.txt','\t',1,0);
Medicion2=dlmread('Medicion2.txt','\t',1,0);
Medicion3=dlmread('Medicion3.txt','\t',1,0);
Simulacion1=dlmread('tbjphillipsICvsVCE(25mA).txt','\t',1,0);
Simulacion2=dlmread('tbjsiemensICvsVCE(25mA).txt','\t',1,0);
Simulacion3=dlmread('tbjpropio(ICvsVCE)25mA.txt','\t',1,0);

Simulacion1(:,2)=Simulacion1(:,2)*1000;	% Normalización a mA
Simulacion2(:,2)=Simulacion2(:,2)*1000;
Simulacion3(:,2)=Simulacion3(:,2)*1000;


Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion1(16:end,:)');	
ro1=1/Param(1);	
Ic_sat1=Param(2);

Va1=ro1*Ic_sat1;


Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion2(18:end,:)');	
ro2=1/Param(1);	
Ic_sat2=Param(2);

Va2=ro2*Ic_sat2;

Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion3(29:end,:)');	
ro3=1/Param(1);	
Ic_sat3=Param(2);
Va3=ro3*Ic_sat3;


Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion1(5:end,:)');	
ro4=1/Param(1);	
Ic_sat4=Param(2);
Va4=ro4*Ic_sat4;


Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion2(5:end,:)');	
ro5=1/Param(1);	
Ic_sat5=Param(2);
Va5=ro5*Ic_sat5;

Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion3(5:end,:)');	
ro6=1/Param(1)
Ic_sat6=Param(2)
Va6=ro6*Ic_sat6


sprintf('\n Primer transistor & %f & %f & %f ',ro1, Ic_sat1, Va1)
sprintf('\n Segundo transistor & %f & %f & %f ',ro2, Ic_sat2, Va2)
sprintf('\n Tercer transistor & %f & %f & %f  ',ro3, Ic_sat3, Va3)
sprintf('\n Simulacion Phillips & %f & %f & %f ',ro4, Ic_sat4, Va4)
sprintf('\n Simulacion Siemens & %f & %f & %f ',ro5, Ic_sat5, Va5)
sprintf('\n Modelo propio & %f & %e & %f ',ro6, Ic_sat6, Va6)


V=0.3:0.01:5;
V1=1.5:0.01:5;
V2=1.5:0.01:5;
V3=1:0.01:5;

figure
hold on
plot(Medicion1(:,1),Medicion1(:,2),'ro','Markersize',6)
plot(V1(1:end),1/ro1*V1(1:end)+Ic_sat1,'r-','Linewidth',1)


plot(Medicion2(:,1),Medicion2(:,2),'go','Markersize',6)
plot(V2(1:end),1/ro2*V2(1:end)+Ic_sat2,'g-','Linewidth',1)

plot(Medicion3(:,1),Medicion3(:,2),'bo','Markersize',6)
plot(V3(1:end),1/ro3*V3(1:end)+Ic_sat3,'b-','Linewidth',1)

plot(Simulacion1(:,1),Simulacion1(:,2),'mo','Markersize',6)
plot(V(1:end),1/ro4*V(1:end)+Ic_sat4,'m-','Linewidth',1)

plot(Simulacion2(:,1),Simulacion2(:,2),'co','Markersize',6)
plot(V(1:end),1/ro5*V(1:end)+Ic_sat5,'c-','Linewidth',1)

plot(Simulacion3(:,1),Simulacion3(:,2),'ko','Markersize',6)
plot(V(1:end),1/ro6*V(1:end)+Ic_sat6,'k-','Linewidth',1)


legend('1er transistor', 'ajuste', 
	   '2do transistor', 'ajuste',
	   '3er transistor', 'ajuste',
	   'simulacion phillips', 'ajuste',
	   'simulacion siemens', 'ajuste',
	   'simulacion modelo propio', 'ajuste',
	   'Location','Southeast')

xlabel('Tension Vce [V]')
ylabel('Corriente Ic [mA]')
axis([0 5 0 35])
grid minor
print('fig_IdvsVce_25mA.png','-dpng');

