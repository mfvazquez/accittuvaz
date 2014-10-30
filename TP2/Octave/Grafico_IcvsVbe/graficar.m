close all;
clear all;

hfe1 = 361;
hfe2 = 326;
hfe3 = 253;
bsimulacion1 = 365;
bsimulacion2 = 366;
bsimulacion3 = 363;


Medicion1=dlmread('Medicion1.txt','\t',1,0);
Medicion2=dlmread('Medicion2.txt','\t',1,0);
Medicion3=dlmread('Medicion3.txt','\t',1,0);
Simulacion1=dlmread('ICvsVBE(VCE=1.25V)phillips.txt','\t',1,0);
Simulacion2=dlmread('ICvsVBE(VCE=1.25)SIE.txt','\t',1,0);
Simulacion3=dlmread('tbjpropio(ICvsVBE).txt','\t',1,0);

Simulacion1(:,2)=Simulacion1(:,2)*1000;	% Normalización a mA
Simulacion2(:,2)=Simulacion2(:,2)*1000;
Simulacion3(:,2)=Simulacion3(:,2)*1000;

Simulacion1(:,1)=Simulacion1(:,1)*1000;	% Normalización a mV
Simulacion2(:,1)=Simulacion2(:,1)*1000;
Simulacion3(:,1)=Simulacion3(:,1)*1000;

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Medicion1(1:end-10,:)');
Vth1=1/Param(2)
Is1=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Medicion2(1:end-10,:)');
Vth2=1/Param(2)
Is2=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Medicion3(1:end-10,:)');
Vth3=1/Param(2)
Is3=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Simulacion1(25:end-30,:)');
Vth4=1/Param(2)
Is4=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Simulacion2(25:end-30,:)');
Vth5=1/Param(2)
Is5=Param(1)

Param=fmins('A_exp_B_x',[1.0634e-10 0],[0,0.00001,0,0,0,0,0,0,0,],[],Simulacion3(25:end-30,:)');
Vth6=1/Param(2)
Is6=Param(1)

Vth1_exp = Vth1
Is1_exp = Is1
Vth2_exp = Vth2
Is2_exp = Is2
Vth3_exp = Vth3
Is3_exp = Is3
Vth4_exp = Vth4
Is4_exp = Is4
Vth5_exp = Vth5
Is5_exp = Is5
Vth6_exp = Vth6
Is6_exp = Is6

V=500:1:800;

figure
hold on

semilogy(Simulacion1(:,1),Simulacion1(:,2),'m-','Linewidth',3)
semilogy(Simulacion2(:,1),Simulacion2(:,2),'y-','Linewidth',3)
semilogy(Simulacion3(:,1),Simulacion3(:,2),'k-','Linewidth',3)

semilogy(Medicion1(:,1),Medicion1(:,2),'ro','Markersize',6)
semilogy(Medicion2(:,1),Medicion2(:,2),'go','Markersize',6)
semilogy(Medicion3(:,1),Medicion3(:,2),'bo','Markersize',6)

semilogy(V(1:230),Is1*exp(V(1:230)/Vth1),'r-','Linewidth',1)
semilogy(V(1:230),Is2*exp(V(1:230)/Vth2),'g-','Linewidth',1)
semilogy(V(1:230),Is3*exp(V(1:230)/Vth3),'b-','Linewidth',1)


legend(	sprintf('philips Is = %e mA  Vth= %e mV', Is4, Vth4),
		sprintf('siemens Is = %e mA  Vth= %e mV', Is5, Vth5),
		sprintf('modelo propio Is = %e mA Vth = %e mV', Is6, Vth6),
		sprintf('transistor 1 Is = %e mA  Vth= %e mV', Is1, Vth1),
		sprintf('transistor 2 Is = %e mA  Vth= %e mV', Is2, Vth2),
		sprintf('transistor 3 Is = %e mA  Vth= %e mV', Is3, Vth3),
	   'Location','Northoutside')

xlabel('Vbe [mV]')
ylabel('Ic [mA]')
axis([510 730 1e-2 4e1])
grid minor
print('IdvsVbe_exp.tex','-depslatexstandalone');

% escala logaritmica


Medicion1_log = Medicion1;
Medicion2_log = Medicion2;
Medicion3_log = Medicion3;
Simulacion1_log = Simulacion1;
Simulacion2_log = Simulacion2;
Simulacion3_log = Simulacion3;

Medicion1_log(:,2) = log(Medicion1(:,2));
Medicion2_log(:,2) = log(Medicion2(:,2));
Medicion3_log(:,2) = log(Medicion3(:,2));
Simulacion1_log(:,2) = log(Simulacion1(:,2));
Simulacion2_log(:,2) = log(Simulacion2(:,2));
Simulacion3_log(:,2) = log(Simulacion3(:,2));


Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion1_log(1:end-10,:)');	
Vth1=1/Param(1)
Is1_log = Param(2)
Is1=exp(Param(2))


Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion2_log(1:end-10,:)');	
Vth2=1/Param(1)
Is2_log = Param(2)
Is2=exp(Param(2))

Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Medicion3_log(1:end-10,:)');	
Vth3=1/Param(1)	
Is3_log = Param(2)
Is3=exp(Param(2))


Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion1_log(25:end-30,:)');	
Vth4=1/Param(1)
Is4_log = Param(2)
Is4=exp(Param(2))

Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion2_log(25:end-30,:)');	
Vth5=1/Param(1)	
Is5_log = Param(2)
Is5=exp(Param(2))


Param=fmins('A_x_mas_B',[0.04 -23],[0,0.0001,0,0,0,0,0,0,0,],[],Simulacion3_log(25:end-30,:)');	
Vth6=1/Param(1)	
Is6_log = Param(2)
Is6=exp(Param(2))


figure
hold on


semilogy(Simulacion1(:,1),Simulacion1(:,2),'m-','Linewidth',3)
semilogy(Simulacion2(:,1),Simulacion2(:,2),'y-','Linewidth',3)
semilogy(Simulacion3(:,1),Simulacion3(:,2),'k-','Linewidth',3)
semilogy(Medicion1(:,1),Medicion1(:,2),'ro','Markersize',6)
semilogy(Medicion2(:,1),Medicion2(:,2),'go','Markersize',6)
semilogy(Medicion3(:,1),Medicion3(:,2),'bo','Markersize',6)


semilogy(V(1:230),Is1*exp(V(1:230)/Vth1),'r-','Linewidth',1)
semilogy(V(1:230),Is2*exp(V(1:230)/Vth2),'g-','Linewidth',1)
semilogy(V(1:230),Is3*exp(V(1:230)/Vth3),'b-','Linewidth',1)


legend(	sprintf('philips Is = %e mA  Vth= %e mV', Is4, Vth4),
		sprintf('siemens Is = %e mA  Vth= %e mV', Is5, Vth5),
		sprintf('modelo modificado Is = %e mA  Vth= %e mV', Is6, Vth6),
		sprintf('transistor 1 Is = %e mA  Vth= %e mV', Is1, Vth1),
		sprintf('transistor 2 Is = %e mA  Vth= %e mV', Is2, Vth2),
		sprintf('transistor 3 Is = %e mA  Vth= %e mV', Is3, Vth3),
	   'Location','Northoutside')

xlabel('Vbe [mV]')
ylabel('Ic [mA]')
axis([510 730 1e-2 4e1])
grid minor
print('IdvsVbe_recta.tex','-depslatexstandalone');


% GRAFICO DE GM

gm_medicion1=diff(Medicion1(:,2))./diff(Medicion1(:,1));
gm_medicion2=diff(Medicion2(:,2))./diff(Medicion2(:,1));
gm_medicion3=diff(Medicion3(:,2))./diff(Medicion3(:,1));
gm_simulacion1=diff(Simulacion1(:,2))./diff(Simulacion1(:,1));
gm_simulacion2=diff(Simulacion2(:,2))./diff(Simulacion2(:,1));
gm_simulacion3=diff(Simulacion3(:,2))./diff(Simulacion3(:,1));

gmt_medicion1 = (Medicion1(:,2) / Vth1);
gmt_medicion2 = (Medicion2(:,2) / Vth2);
gmt_medicion3 = (Medicion3(:,2) / Vth3);
gmt_simulacion1 = (Simulacion1(:,2) / Vth4);
gmt_simulacion2 = (Simulacion2(:,2) / Vth5);
gmt_simulacion3 = (Simulacion3(:,2) / Vth6);

figure
hold on

plot(Simulacion1(2:end,2),gm_simulacion1, 'm-','Linewidth',3);
plot(Simulacion2(2:end,2),gm_simulacion2, 'y-','Linewidth',3);
plot(Simulacion3(2:end,2),gm_simulacion3, 'k-','Linewidth',3);
plot(Medicion1(2:end,2), gm_medicion1, 'ro','Markersize',6);
plot(Medicion2(2:end,2),gm_medicion2, 'go','Markersize',6);
plot(Medicion3(2:end,2),gm_medicion3, 'bo','Markersize',6);


plot(Medicion1(2:end,2), gmt_medicion1(2:end), 'r-','Linewidth',1);
plot(Medicion2(2:end,2), gmt_medicion2(2:end), 'g-','Linewidth',1);
plot(Medicion3(2:end,2), gmt_medicion3(2:end), 'b-','Linewidth',1);



legend(	sprintf('philips Vth= %e mV', Vth4),
		sprintf('siemens Vth= %e mV', Vth5),
		sprintf('modelo modificado Vth= %e mV', Vth6),
		sprintf('transistor 1 Vth= %e mV', Vth1),
		sprintf('transistor 2 Vth= %e mV', Vth2),
		sprintf('transistor 3 Vth= %e mV', Vth3),
	   'Location','Northoutside')


axis([0 30 0 0.8])
xlabel('Ic [mA]')
ylabel('gm [Ohm^-1]')
grid minor
print('gm.tex','-depslatexstandalone');



% graficos de rpi(k)=beta/gm(k)



rpi1=(hfe1./gm_medicion1);
rpi2=(hfe2./gm_medicion2);
rpi3=(hfe3./gm_medicion3);
rpi4=(bsimulacion1./gm_simulacion1);
rpi5=(bsimulacion2./gm_simulacion2);
rpi6=(bsimulacion3./gm_simulacion3);

rpi1_teorico = (hfe1 ./gmt_medicion1);
rpi2_teorico = (hfe2 ./gmt_medicion2);
rpi3_teorico = (hfe3 ./gmt_medicion3);

figure
hold on

plot(Simulacion1(2:end,2),rpi4, 'm-','Linewidth',3);
plot(Simulacion2(2:end,2),rpi5, 'y-','Linewidth',3);
plot(Simulacion3(2:end,2),rpi6, 'k-','Linewidth',3);


plot(Medicion1(2:end,2), rpi1, 'ro','Markersize',6);
plot(Medicion2(2:end,2), rpi2, 'go','Markersize',6);
plot(Medicion3(2:end,2), rpi3, 'bo','Markersize',6);

plot(Medicion1(2:end,2), rpi1_teorico(2:end), 'r-','Linewidth',1);
plot(Medicion2(2:end,2), rpi2_teorico(2:end), 'g-','Linewidth',1);
plot(Medicion3(2:end,2), rpi3_teorico(2:end), 'b-','Linewidth',2);

legend(	sprintf('philips Vth= %e mV hFE = %d', Vth4, bsimulacion1),
		sprintf('siemens Vth= %e mV hFE = %d', Vth5, bsimulacion2),
		sprintf('modelo modificado Vth= %e mV hFE = %d', Vth6, bsimulacion3),
		sprintf('transistor 1 Vth= %e mV hFE = %d', Vth1, hfe1),
		sprintf('transistor 2 Vth= %e mV hFE = %d', Vth2, hfe2),
		sprintf('transistor 3 Vth= %e mV hFE = %d', Vth3, hfe3),
	   'Location','Northoutside')


xlabel('Ic [mA]')
ylabel('rpi [Ohm]')
axis([0 4 0 150000])
grid minor
print('rpi.tex','-depslatexstandalone');


error_Vth4 = ((Vth4_exp - Vth1_exp)/Vth1_exp) * 100
error_Vth5 = ((Vth5_exp - Vth1_exp)/Vth1_exp) * 100
error_Vth6 = ((Vth6_exp - Vth1_exp)/Vth1_exp) * 100
error_Is4 = ((Is4_exp - Is1_exp)/Is1_exp) * 100
error_Is5 = ((Is5_exp - Is1_exp)/Is1_exp) * 100
error_Is6 = ((Is6_exp - Is1_exp)/Is1_exp) * 100

error_Vth4 = ((Vth4  - Vth1 )/Vth1 ) * 100
error_Vth5 = ((Vth5  - Vth1 )/Vth1 ) * 100
error_Vth6 = ((Vth6  - Vth1 )/Vth1 ) * 100
error_Is4 = ((Is4  - Is1 )/Is1 ) * 100
error_Is5 = ((Is5  - Is1 )/Is1 ) * 100
error_Is6 = ((Is6  - Is1 )/Is1 ) * 100
