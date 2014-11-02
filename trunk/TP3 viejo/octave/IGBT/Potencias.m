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

Corriente_aux1=Corriente1(:,2);
Corriente_aux2=Corriente2(:,2);
Corriente_aux3=Corriente3(:,2);

Tension_aux1=Tension1(:,2);
Tension_aux2=Tension2(:,2);
Tension_aux3=Tension3(:,2);

Potencia1=Tension_aux1.*Corriente_aux1;
Potencia2=Tension_aux2.*Corriente_aux2;
Potencia3=Tension_aux3.*Corriente_aux3;

tiempo=Corriente1(:,1);

t=tiempo(2)-tiempo(1);
Energia_disipada1=t/1000000*sum(Potencia1(95:end))
Energia_disipada2=t/1000000*sum(Potencia2(95:end))
Energia_disipada3=t/1000000*sum(Potencia3(95:end))
frec=100000;
T=1/frec;
Potencia_media1=1/T*t/1000000*sum(Potencia1(95:end))
Potencia_media2=1/T*t/1000000*sum(Potencia2(95:end))
Potencia_media3=1/T*t/1000000*sum(Potencia3(95:end))

figure
hold on
plot(tiempo(250:end-200),Potencia1(250:end-200),'k-','Linewidth',1)
xlabel('Tiempo [micro seg]')
ylabel('Potencia [W]')
axis([-2 2 -2 1500])
grid minor
print('Potencia1.png','-dpng');

figure
hold on
plot(tiempo(95:end),Potencia2(95:end),'k-','Linewidth',1)
xlabel('Tiempo [micro seg]')
ylabel('Potencia [W]')
axis([-5 5 -2000 2500])
grid minor
print('Potencia2.png','-dpng');

figure
hold on
plot(tiempo,Potencia3,'k-','Linewidth',1)
xlabel('Tiempo [micro seg]')
ylabel('Potencia [W]')
axis([-1 1 -2 2000])
grid minor
print('Potencia3.png','-dpng');
