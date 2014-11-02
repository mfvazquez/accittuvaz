close all;
clear all;

Medicion1=dlmread('VRg1.txt','\t',1,0);

tiempo1=Medicion1(:,1)*1000000;	%en micro seg
tension1=Medicion1(:,2);
corriente1=tension1/12000;
corriente1=corriente1*1000; % en mA

derivada = diff(tension1) ./diff(tiempo1);

c = corriente1(2:end) ./derivada; %en nF

figure
hold on
plot(tiempo1(2:end),c,'b-','Linewidth',1)

xlabel('Tiempo t [us]')
ylabel('Capacidad [nF]')
grid minor

print('graficoC.png','-dpng');

