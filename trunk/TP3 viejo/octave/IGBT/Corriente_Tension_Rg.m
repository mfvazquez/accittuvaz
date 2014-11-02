close all;
clear all;

Medicion1=dlmread('VRg1.txt','\t',1,0);
Medicion2=dlmread('VRg2.txt','\t',1,0);

tiempo1=Medicion1(:,1)*1000000;	%en micro seg
tension1=Medicion1(:,2);
corriente1=tension1/12000;
corriente1=corriente1*1000;
tension_rg1=(corriente1/1000)*18;

tiempo2=Medicion2(:,1)*1000000;	%en micro seg
tension2=Medicion2(:,2);
corriente2=tension2/12000;
corriente2=corriente2*1000;
tension_rg2=(corriente2/1000)*1000;

t=(tiempo1(2)-tiempo1(1))/1000000;
Imed1=(1/0.00001)*t*sum(corriente1(95:end)/1000)
Imed2=(1/0.00001)*t*sum(corriente2(95:end)/1000)

figure
hold on
plot(tiempo1(320:400),tension_rg1(320:400)*1000,'k-','Linewidth',1)
xlabel('Tiempo [micro seg]')
ylabel('Tension [mV]')
axis([-5 5 -10 40])
grid minor
print('Vrg1.png','-dpng');

figure
hold on
plot(tiempo2(95:end),tension_rg2(95:end),'k-','Linewidth',1)
xlabel('Tiempo [micro seg]')
ylabel('Tension [V]')
axis([-5 5 0 1])
grid minor
print('Vrg2.png','-dpng');