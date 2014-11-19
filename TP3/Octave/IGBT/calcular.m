close all;
clear all;

f = 100e3; #Hz
T = 1/f; #seg
to = -3.25520e-05; #seg
tf = -2.25120e-05;

# ------------------------ TENSION Y CORRIENTE EN R_G -----------

Medicion_Vr18=dlmread('mediciones/Vrg_rg=18.csv',',',2,0); # tiempo (seg), Vg(Volt), Vr(Volt), Ve(Volt)
tiempo18 = Medicion_Vr18(:,1);
Vr18 = Medicion_Vr18(:,3) - Medicion_Vr18(:,2);
Vr18_max= max(Vr18);
Ir18_max = Vr18_max/18;
Vg18 = Medicion_Vr18(:,2);

Medicion_Vr1k=dlmread('mediciones/Vrg_rg=1k.csv',',',2,0); # tiempo (seg), Vg(Volt), Vr(Volt), Ve(Volt)
tiempo1k = Medicion_Vr1k(:,1) + 0.465e-5;
Vr1k = Medicion_Vr1k(:,3) - Medicion_Vr1k(:,2);
Vr1k_max = max(Vr1k);
Ir1k_max = Vr1k_max / 1e3;
Vg1k = Medicion_Vr1k(:,2);

figure
hold on
plot(tiempo18,Vr18,'b-','Linewidth',1)
plot(tiempo1k,Vr1k,'g-','Linewidth',1)
legend(sprintf('Vr con R = 18 Ohm I_max = %e A', Ir18_max),
		sprintf('Vr con R = 1 kOhm I_max = %e A', Ir1k_max),
	   'Location','Northoutside')

xlabel('Tiempo [seg.]')
ylabel('Tension [V]')
axis([to tf -11 10])
grid minor

print('tension_Vr.png','-dpng');


# ------------ CALCULO DE CAPACIDAD ---------------------

Ig18 = Vr18 / 18;
dV18 = diff(Vg18)./diff(tiempo18);
C18 = Ig18(1:end-1) ./dV18;
#C18(~isfinite(C18))= 0; # valores inf y nan igual a cero
C18_max = max(C18)


Ig1k = Vr1k / 1e3;
dV1k = diff(Vg1k)./diff(tiempo1k);
C1k = Ig1k(1:end-1) ./dV1k;
C1k(~isfinite(C1k))= 0; # valores inf y nan igual a cero
C1k_max = max(C1k)


figure
hold on
plot(tiempo18(1:end-1),C18,'b-','Linewidth',1)
legend('Capacidad con Rg = 18',
	   'Location','Northoutside')
xlabel('Tiempo [seg.]')
ylabel('Capacidad [F]')
grid minor
print('capacidad18.png','-dpng');

figure
hold on
plot(tiempo18,Vg18,'b-','Linewidth',1)
legend('Vg con Rg = 18',
	   'Location','Northoutside')
xlabel('Tiempo [seg.]')
ylabel('Tension [V]')
grid minor
print('Vg18.png','-dpng');



#------------- CORRIENTE DEL IGBT Y POTENCIA SIN L -------------------------

Medicion=dlmread('mediciones/Vc_sin_L.csv',',',2,0); # tiempo (seg), Vg(Volt), Vr(Volt), Ve(Volt)
tiempo = Medicion(:,1);
Vc = Medicion(:,3);
Ve = Medicion(:,4);

Ie = Ve / 0.1;

figure
hold on
plot(tiempo, Ie, 'r-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Corriente [A]')
grid minor

legend('Corriente sin inductor',
	   'Location','Northoutside')

print('corriente_sin_L.png','-dpng');

Vce = Vc - Ve;
P = Vce .* Ie;

ito = find(tiempo==to);
itf = find(tiempo==tf);
Pm_sin_L = (1/T) * trapz(tiempo(ito:itf), P(ito:itf))


figure
hold on
plot(tiempo, P, 'r-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Potencia [W]')
axis([to to+T -2 12])
grid minor

legend(sprintf('Potencia sin inductor  Pm = %e W', Pm_sin_L),
	   'Location','Northoutside')

print('Potencia_sin_L.png','-dpng');

#------------------- CORRIENTE DEL IGBT Y POTENCIA CON L

Medicion=dlmread('mediciones/Vc_con_L.csv',',',2,0); # tiempo (seg), Vg(Volt), Vr(Volt), Ve(Volt)
tiempo = Medicion(:,1);
Vc = Medicion(:,3);
Ve = Medicion(:,4);

Ie = Ve / 0.1;

figure
hold on
plot(tiempo, Ie, 'r-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Corriente [A]')
axis([to tf -1.5 3])
grid minor

legend('Corriente con inductor',
	   'Location','Northoutside')

print('corriente_con_L.png','-dpng');

Vce = Vc - Ve;
P = Vce .* Ie;

ito = find(tiempo==to);
itf = find(tiempo==tf);
Pm_con_L = (1/T) * trapz(tiempo(ito:itf), P(ito:itf))

figure
hold on
plot(tiempo, P, 'r-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Potencia [W]')
axis([to to+T -6 30])
grid minor

legend(sprintf('Potencia con inductor  Pm = %e W', Pm_con_L),
	   'Location','Northoutside')

print('Potencia_con_L.png','-dpng');
