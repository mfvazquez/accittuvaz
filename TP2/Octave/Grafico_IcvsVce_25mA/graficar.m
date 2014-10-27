close all;
clear all;

Medicion1=dlmread('Medicion1.txt','\t',1,0);
Medicion2=dlmread('Medicion2.txt','\t',1,0);
Medicion3=dlmread('Medicion3.txt','\t',1,0);

Simulacion1=dlmread('tbjphillipsICvsVCE(25mA).txt','\t',1,0);
Simulacion2=dlmread('tbjsiemensICvsVCE(25mA).txt','\t',1,0);

Simulacion1(:,2)=Simulacion1(:,2)*1000;	% Normalización a mA
Simulacion2(:,2)=Simulacion2(:,2)*1000;
Simulacion1(:,1)=Simulacion1(:,1)*1000;	% Normalización a mV
Simulacion2(:,1)=Simulacion2(:,1)*1000;


Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion1(end-5:end,:)');	
ro1=1/Param(1)
Ic_sat1=Param(2)
Va1=ro1*Ic_sat1


Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion2(end-5:end,:)');	
ro2=1/Param(1)
Ic_sat2=Param(2)
Va2=ro2*Ic_sat2

Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion3(end-5:end,:)');	
ro3=1/Param(1)	
Ic_sat3=Param(2)
Va3=ro3*Ic_sat3


Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion1(50:end,:)');	
ro4=1/Param(1)
Ic_sat4=Param(2)
Va4=ro4*Ic_sat4


Param=fmins('A_x_mas_B',[0.1 5],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion2(50:end,:)');	
ro5=1/Param(1)
Ic_sat5=Param(2)
Va5=ro5*Ic_sat5

V=0:1:5000;

figure
hold on

inicio_v = 1500;

plot(Simulacion1(:,1),Simulacion1(:,2),'m-','Linewidth',3)
plot(Simulacion2(:,1),Simulacion2(:,2),'y-','Linewidth',3)

plot(Medicion1(:,1),Medicion1(:,2),'ro','Markersize',6)
plot(Medicion2(:,1),Medicion2(:,2),'go','Markersize',6)
plot(Medicion3(:,1),Medicion3(:,2),'bo','Markersize',6)
plot(V(inicio_v:end),(1/ro1)*V(inicio_v:end)+Ic_sat1,'r-','Linewidth',1)
plot(V(inicio_v:end),(1/ro2)*V(inicio_v:end)+Ic_sat2,'g-','Linewidth',1)
plot(V(inicio_v:end),(1/ro3)*V(inicio_v:end)+Ic_sat3,'b-','Linewidth',1)


legend(	sprintf('philips ro5 = %e mA  Va= %e mV', ro4, Va4),
		sprintf('siemens ro5 = %e mA  Va= %e mV', ro5, Va5),
		sprintf('transistor 1 ro5 = %e mA  Va= %e mV', ro1, Va1),
		sprintf('transistor 2 ro5 = %e mA  Va= %e mV', ro2, Va3),
		sprintf('transistor 3 ro5 = %e mA  Va= %e mV', ro3, Va2),
		'Location','Northoutside')



xlabel('Vce [mV]')
ylabel('Ic [mA]')
axis([0 5000 20 30])
grid minor
print('IcvsVce_5mA.png','-dpng');


