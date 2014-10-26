close all;
clear all;

Medicion1=dlmread('Medicion1.txt','\t',1,0);
Medicion2=dlmread('Medicion2.txt','\t',1,0);
Medicion3=dlmread('Medicion3.txt','\t',1,0);
Simulacion1=dlmread('ICvsVBE(VCE=1.25V)phillips.txt','\t',1,0);
Simulacion2=dlmread('ICvsVBE(VCE=1.25)SIE.txt','\t',1,0);

Simulacion1(:,2)=Simulacion1(:,2)*1000;	% Normalización a mA
Simulacion2(:,2)=Simulacion2(:,2)*1000;

Simulacion1(:,1)=Simulacion1(:,1)*1000;	% Normalización a mV
Simulacion2(:,1)=Simulacion2(:,1)*1000;

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Medicion1(:,:)');
Vth1=1/Param(2)
Is1=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Medicion2(:,:)');
Vth2=1/Param(2)
Is2=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Medicion3(:,:)');
Vth3=1/Param(2)
Is3=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Simulacion1(50:76,:)');
Vth4=1/Param(2)
Is4=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Simulacion2(50:75,:)');
Vth5=1/Param(2)
Is5=Param(1)

V=500:1:800;

figure
hold on

plot(Simulacion1(:,1),Simulacion1(:,2),'m-','Linewidth',3)
plot(Simulacion2(:,1),Simulacion2(:,2),'y-','Linewidth',3)


plot(Medicion1(:,1),Medicion1(:,2),'ro','Markersize',6)
plot(Medicion2(:,1),Medicion2(:,2),'go','Markersize',6)
plot(Medicion3(:,1),Medicion3(:,2),'bo','Markersize',6)

plot(V,Is1*exp(V/Vth1),'r-','Linewidth',1)
plot(V,Is2*exp(V/Vth2),'g-','Linewidth',1)
plot(V,Is3*exp(V/Vth3),'b-','Linewidth',1)


legend(	sprintf('philips Is = %e mA  Vth= %e mV', Is4, Vth4),
		sprintf('siemens Is = %e mA  Vth= %e mV', Is5, Vth5),
		sprintf('transistor 1 Is = %e mA  Vth= %e mV', Is1, Vth1),
		sprintf('transistor 2 Is = %e mA  Vth= %e mV', Is2, Vth2),
		sprintf('transistor 3 Is = %e mA  Vth= %e mV', Is3, Vth3),
	   'Location','Northoutside')

xlabel('Vbe [mV]')
ylabel('Ic [mA]')
axis([500 750 0 32])
grid minor
print('IdvsVbe_exp.png','-dpng');

% escala logaritmica

Simulacion1(:,2) = log(Simulacion1(:,2));
Simulacion2(:,2) = log(Simulacion2(:,2));

Medicion1(:,2) = log(Medicion1(:,2));
Medicion2(:,2) = log(Medicion2(:,2));
Medicion3(:,2) = log(Medicion3(:,2));

Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion1(5:end,:)');	
Vth1=1/Param(1)
Is1_log = Param(2)
Is1=exp(Param(2))


Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion2(5:end,:)');	
Vth2=1/Param(1)
Is2_log = Param(2)
Is2=exp(Param(2))

Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion3(5:end,:)');	
Vth3=1/Param(1)	
Is3_log = Param(2)
Is3=exp(Param(2))


Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion1(:,:)');	
Vth4=1/Param(1)
Is4_log = Param(2)
Is4=exp(Param(2))

Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion2(:,:)');	
Vth5=1/Param(1)	
Is5_log = Param(2)
Is5=exp(Param(2))


figure
hold on


plot(Simulacion1(:,1),Simulacion1(:,2),'m-','Linewidth',3)
plot(Simulacion2(:,1),Simulacion2(:,2),'y-','Linewidth',3)


plot(Medicion1(:,1),Medicion1(:,2),'ro','Markersize',6)
plot(Medicion2(:,1),Medicion2(:,2),'go','Markersize',6)
plot(Medicion3(:,1),Medicion3(:,2),'bo','Markersize',6)

plot(V(20:end),Is1_log+(V(20:end)/Vth1),'r-','Linewidth',1)
plot(V(20:end),Is2_log+(V(20:end)/Vth2),'g-','Linewidth',1)
plot(V(20:end),Is3_log+(V(20:end)/Vth3),'b-','Linewidth',1)


legend(	sprintf('philips Is = %e mA  Vth= %e mV', Is4, Vth4),
		sprintf('siemens Is = %e mA  Vth= %e mV', Is5, Vth5),
		sprintf('transistor 1 Is = %e mA  Vth= %e mV', Is1, Vth1),
		sprintf('transistor 2 Is = %e mA  Vth= %e mV', Is2, Vth2),
		sprintf('transistor 3 Is = %e mA  Vth= %e mV', Is3, Vth3),
	   'Location','Northoutside')

xlabel('Vbe [mV]')
ylabel('ln(Ic) [ln(mA)]')
axis([500 725 -4 3])
grid minor
print('IdvsVbe_recta.png','-dpng');
