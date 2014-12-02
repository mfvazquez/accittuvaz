close all;
clear all;

Medicion=dlmread('tp4.txt','\t',1,0);
tiempo = Medicion(:,1);
tiempo = tiempo*1e3; #de s a ms
vin = Medicion(:,2);
vin = vin*1e3; #de V a mV
vout = Medicion(:,3);
vout = vout*1e3; #de V a mV

figure
hold on
plot(tiempo,vin,'b-','Linewidth',1)
plot(tiempo,vout,'g-','Linewidth',1)
legend('entrada',
		'salida',
	   'Location','North')

xlabel('Tiempo [ms]')
ylabel('Tension [mV]')
axis([0 10 -300 300])
grid minor

print('grafico.png','-dpng');

vout_max = max(vout)
vout_min = min(vout)
