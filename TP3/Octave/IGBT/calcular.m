close all;
clear all;

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
axis([-3.25e-5 -2.25e-5 -11 10])
grid minor

print('tension_Vr.png','-dpng');


# ------------ CALCULO DE CAPACIDAD ---------------------

Ig18 = Vr18 / 18;
dV18 = diff(Vg18)./diff(tiempo18);
C18 = Ig18(1:end-1) ./dV18;
C18(~isfinite(C18))= 0;
C18_max = max(C18)

Ig1k = Vr1k / 1e3;
dV1k = diff(Vg1k)./diff(tiempo1k);
C1k = Ig1k(1:end-1) ./dV1k;
C1k(~isfinite(C1k))= 0;
C1k_max = max(C1k)


figure
hold on

plot(tiempo18(1:end-1),C18,'b-','Linewidth',1)
plot(tiempo1k(1:end-1),C1k,'g-','Linewidth',1)

legend(sprintf('C con R = 18 Ohm C_max = %e F', C18_max),
		sprintf('C con R = 1 kOhm C_max = %e F', C1k_max),
	   'Location','Northoutside')

axis([-3.25e-5 -2.25e-5 -5e-8 8e-8])
xlabel('Tiempo [seg.]')
ylabel('Capacidad [F]')
grid minor

print('Capacidad.png','-dpng');
