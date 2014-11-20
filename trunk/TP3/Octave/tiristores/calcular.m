close all;
clear all;

R = 0.1;

# ---------------- SIN DIODO Y CON DISPARO CORTO ----------------------

medicion=dlmread('mediciones/sin_diodo_disparo_corto.csv',',',2,0); # tiempo , inductor, resistencia (seg, V,V)
tiempo = medicion(:,1);
V_L = medicion(:,2);
V_R = medicion(:,3);
I = V_R / R;

figure
hold on
plot(tiempo, V_L, 'b-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Tension [V]')
axis([-0.0004 0.0025 -35 40])
grid minor
legend('Tension en el inductor sin diodo y con disparo corto','Location','Northeast')

print('V_L_sin_diodo_disparo_corto.png','-dpng');


figure
hold on
plot(tiempo, I, 'b-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Corriente [A]')
axis([-0.0004 0.0025 -0.2 0.35])
grid minor
legend('Corriente en el inductor sin diodo y con disparo corto','Location','Northeast')

print('I_L_sin_diodo_disparo_corto.png','-dpng');



# ---------------- CON DIODO Y CON DISPARO CORTO ----------------------

medicion=dlmread('mediciones/con_diodo_disparo_corto.csv',',',2,0); # tiempo , inductor, resistencia (seg, V,V)

tiempo = medicion(:,1);
V_L = medicion(:,2);
V_R = medicion(:,3);
I = V_R / R;

figure
hold on
plot(tiempo, V_L, 'b-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Tension [V]')
axis([-0.0002 0.0045 -35 32])
grid minor
legend('Tension en el inductor con diodo y con disparo corto','Location','Northeast')

print('V_L_con_diodo_disparo_corto.png','-dpng');


figure
hold on
plot(tiempo, I, 'b-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Corriente [A]')
axis([-0.0002 0.0045 -0.28 0.25])
grid minor
legend('Corriente en el inductor con diodo y con disparo corto','Location','Northeast')

print('I_L_con_diodo_disparo_corto.png','-dpng');

# ---------------- CON DIODO Y CON DISPARO LARGO ----------------------

medicion=dlmread('mediciones/con_diodo_disparo_largo.csv',',',2,0); # tiempo , inductor, resistencia (seg, V,V)

tiempo = medicion(:,1);
V_L = medicion(:,2);
V_R = medicion(:,3);
I = V_R / R;

figure
hold on
plot(tiempo, V_L, 'b-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Tension [V]')
axis([-0.0004 0.022 -26 32])
grid minor
legend('Tension en el inductor con diodo y con disparo largo','Location','Northeast')

print('V_L_con_diodo_disparo_largo.png','-dpng');


figure
hold on
plot(tiempo, I, 'b-', 'Linewidth',1)
xlabel('Tiempo [seg.]')
ylabel('Corriente [A]')
axis([-0.0004 0.022 -0.27 0.24])
grid minor
legend('Corriente en el inductor con diodo y con disparo largo','Location','Northeast')

print('I_L_con_diodo_disparo_largo.png','-dpng');
