close all;
clear all;

Medicion1=dlmread('Ve1.txt','\t',1,0);
Medicion2=dlmread('Ve2.txt','\t',1,0);
Medicion3=dlmread('Ve3.txt','\t',1,0);
Tension1=dlmread('Vc1.txt','\t',1,0);
Tension2=dlmread('Vc2.txt','\t',1,0);
Tension3=dlmread('Vc3.txt','\t',1,0);

Medicion1(:,1)=Medicion1(:,1)*1000000;	%tiempo en micro seg
Medicion2(:,1)=Medicion2(:,1)*1000000;
Medicion3(:,1)=Medicion3(:,1)*1000000;
Tension1(:,1)=Tension1(:,1)*1000000;
Tension2(:,1)=Tension2(:,1)*1000000;
Tension3(:,1)=Tension3(:,1)*1000000;

Corriente1=Medicion1;
Corriente1(:,2)=Corriente1(:,2)/0.1;

Corriente2=Medicion2;
Corriente2(:,2)=Corriente2(:,2)/0.1;

Corriente3=Medicion3;
Corriente3(:,2)=Corriente3(:,2)/0.1;

figure
hold on
plot(Corriente1(:,1),Corriente1(:,2),'k-','Linewidth',1)
xlabel('t [micro seg]')
ylabel('I_{C} [A]')
axis([-1 1 -2 27])
grid minor
print('Ic1.png','-dpng');

figure
hold on
plot(Corriente2(:,1),Corriente2(:,2),'k-','Linewidth',1)
xlabel('t [micro seg]')
ylabel('I_{C} [A]')
axis([-1 1 -2 35])
grid minor
print('Ic2.png','-dpng');

figure
hold on
plot(Corriente3(:,1),Corriente3(:,2),'k-','Linewidth',1)
xlabel('t [micro seg]')
ylabel('I_{C} [A]')
axis([-1 1 -2 27])
grid minor
print('Ic3.png','-dpng');



