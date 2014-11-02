close all;
clear all;

Medicion1=dlmread('Med1_tiristor.txt','\t',1,0);
Medicion2=dlmread('Med2_tiristor.txt','\t',1,0);
Medicion3=dlmread('Med3_tiristor.txt','\t',1,0);

Tiempo1=Medicion1(:,1)*1000;
Tension1=Medicion1(:,3);
Corriente1=Tension1/0.1*1000;

Tiempo2=Medicion2(:,1)*1000;
Tension2=Medicion2(:,3);
Corriente2=Tension2/0.1*1000;

Tiempo3=Medicion3(:,1)*1000;
Tension3=Medicion3(:,3);
Corriente3=Tension3/0.1*1000;

figure
hold on
plot(Tiempo1,Corriente1,'k-','Linewidth',1)
xlabel('Tiempo [mseg]')
ylabel('Corriente [mA]')
axis([0 1.2 -100 300])
grid minor
print('Corriente1.png','-dpng');

figure
hold on
plot(Tiempo2,Corriente2,'k-','Linewidth',1)
xlabel('Tiempo [mseg]')
ylabel('Corriente [mA]')
axis([0 1.2 -150 250])
grid minor
print('Corriente2.png','-dpng');

figure
hold on
plot(Tiempo3,Corriente3,'k-','Linewidth',1)
xlabel('Tiempo [mseg]')
ylabel('Corriente [mA]')
axis([0 1.2 -200 500])
grid minor
print('Corriente3.png','-dpng');



