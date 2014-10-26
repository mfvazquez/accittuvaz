close all;
clear all;

Vth1 =  0.027900;
Is1 =  1.0623e-10;
Vth2 =  0.027756;
Is2 =  1.1211e-10;
Vth3 =  0.028065;
Is3 =  1.0112e-10;
Vth4 =  0.027096;
Is4 =  7.9122e-11;
Vth5 =  0.025723;
Is5 =  1.9832e-11;
Vth6 =  0.025914;
Is6 =  1.1065e-10;


Medicion1=dlmread('Medicion1.txt','\t',1,0);
Medicion2=dlmread('Medicion2.txt','\t',1,0);
Medicion3=dlmread('Medicion3.txt','\t',1,0);
Simulacion1=dlmread('ICvsVBE(VCE=1.25V)phillips.txt','\t',1,0);
Simulacion2=dlmread('ICvsVBE(VCE=1.25)SIE.txt','\t',1,0);
Simulacion3=dlmread('tbjpropio(ICvsVBE).txt','\t',1,0);

Simulacion1(:,2)=Simulacion1(:,2)*1000;	% Normalización a mA
Simulacion2(:,2)=Simulacion2(:,2)*1000;
Simulacion3(:,2)=Simulacion3(:,2)*1000;


gm_medicion1=diff(Medicion1(:,2))./diff(Medicion1(:,1));
gm_medicion2=diff(Medicion2(:,2))./diff(Medicion2(:,1));
gm_medicion3=diff(Medicion3(:,2))./diff(Medicion3(:,1));
gm_simulacion1=diff(Simulacion1(10:end-10,2))./diff(Simulacion1(10:end-10,1));
gm_simulacion2=diff(Simulacion2(10:end-10,2))./diff(Simulacion2(10:end-10,1));
gm_simulacion3=diff(Simulacion3(10:end-10,2))./diff(Simulacion3(10:end-10,1));

gmt_medicion1 = (Medicion1(:,2) / Vth1);
gmt_medicion2 = (Medicion2(:,2) / Vth2);
gmt_medicion3 = (Medicion3(:,2) / Vth3);
gmt_simulacion1 = (Simulacion1(:,2) / Vth4);
gmt_simulacion2 = (Simulacion2(:,2) / Vth5);
gmt_simulacion3 = (Simulacion3(:,2) / Vth6);


figure
hold on
plot(Medicion1(2:end,2), gm_medicion1, 'ro','Markersize',6);
plot(Medicion1(2:end,2), gmt_medicion1(2:end), 'r-','Markersize',6);

plot(Medicion2(2:end,2),gm_medicion2, 'go','Markersize',6);
plot(Medicion2(2:end,2), gmt_medicion2(2:end), 'g-','Markersize',6);

plot(Medicion3(2:end,2),gm_medicion3, 'bo','Markersize',6);
plot(Medicion3(2:end,2), gmt_medicion3(2:end), 'b-','Markersize',6);

plot(Simulacion1(11:end-10,2),gm_simulacion1, 'mo','Markersize',6);
plot(Simulacion1(2:end,2), gmt_simulacion1(2:end), 'm-','Markersize',6);

plot(Simulacion2(11:end-10,2),gm_simulacion2, 'co','Markersize',6);
plot(Simulacion2(2:end,2), gmt_simulacion2(2:end), 'c-','Markersize',6);

plot(Simulacion3(11:end-10,2),gm_simulacion3, 'ko','Markersize',6);
plot(Simulacion3(2:end,2), gmt_simulacion3(2:end), 'k-','Markersize',6);


legend('1er transistor', 'calculo teorico',
		'2do transistor', 'calculo teorico',
		'3er transistor', 'calculo teorico',
		'simulacion phillips', 'calculo teorico',
		'simulacion siemens', 'calculo teorico',
		'simulacion modelo propio', 'calculo teorico',
	   'Location','Northwest')


axis([0 10 0 400])
xlabel('Ic [mA]')
ylabel('gm [Ohm^-1]')
grid minor
print('fig_gm.png','-dpng');



% graficos de rpi(k)=beta/gm(k)
hfe1=300;
hfe2=309;
hfe3=260;
bsimulacion1 = 458.7;
bsimulacion2 = 466;
bsimulacion3 = 260;

rpi1=(hfe1./gm_medicion1);
rpi2=(hfe2./gm_medicion2);
rpi3=(hfe3./gm_medicion3);
rpi4=(bsimulacion1./gm_simulacion1);
rpi5=(bsimulacion2./gm_simulacion2);
rpi6=(bsimulacion3./gm_simulacion3);


rpi1_teorico = (hfe1 ./gmt_medicion1);
rpi2_teorico = (hfe2 ./gmt_medicion2);
rpi3_teorico = (hfe3 ./gmt_medicion3);
rpi4_teorico = (bsimulacion1./gmt_simulacion1);
rpi5_teorico = (bsimulacion2./gmt_simulacion2);
rpi6_teorico = (bsimulacion3./gmt_simulacion3);

figure
hold on
plot(Medicion1(2:end,2), rpi1, 'ro','Markersize',6);
plot(Medicion1(2:end,2), rpi1_teorico(2:end), 'r-','Markersize',6);

plot(Medicion2(2:end,2), rpi2, 'go','Markersize',6);
plot(Medicion2(2:end,2), rpi2_teorico(2:end), 'g-','Markersize',6);

plot(Medicion3(2:end,2), rpi3, 'bo','Markersize',6);
plot(Medicion3(2:end,2), rpi3_teorico(2:end), 'b-','Markersize',6);

plot(Simulacion1(11:end-10,2),rpi4, 'mo','Markersize',6);
plot(Simulacion1(2:end,2), rpi4_teorico(2:end), 'm-','Markersize',6);

plot(Simulacion2(11:end-10,2),rpi5, 'co','Markersize',6);
plot(Simulacion2(2:end,2), rpi5_teorico(2:end), 'c-','Markersize',6);

plot(Simulacion3(11:end-10,2),rpi6, 'ko','Markersize',6);
plot(Simulacion3(2:end,2), rpi6_teorico(2:end), 'k-','Markersize',6);

legend('1er transistor', 'calculo teorico',
		'2do transistor', 'calculo teorico',
		'3er transistor', 'calculo teorico',
		'simulacion phillips', 'calculo teorico',
		'simulacion siemens', 'calculo teorico',
		'simulacion modelo propio', 'calculo teorico',
	   'Location','Northeast')


xlabel('Ic [mA]')
ylabel('rpi [Ohm]')
axis([-0.001 0.1 -1000 100000])
grid minor
print('fig_rpi.png','-dpng');

