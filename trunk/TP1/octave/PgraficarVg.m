%-----------------------------------------------------
% Dispositivos Semiconductores 66.25/86.03
% TP 1 - Curvas características del transistor MOSFET
% Alumnos:
% 	*
%	* 91523 Vazquez, Matias Fernando
%-----------------------------------------------------

% CONSTANTES

directorio = 'datos/P_VG/'

V=-5:0.1:0;
I=-5:0.1:0;

%---------- INGRESO DE DATOS ------------------------

simulacion1 = dlmread(strcat(directorio, 'simulacion.txt'),'\t',1,0);
medicion1 = dlmread(strcat(directorio, 'medicion1.txt'),'\t',1,0);
medicion2 = dlmread(strcat(directorio, 'medicion2.txt'),'\t',1,0);
medicion3 = dlmread(strcat(directorio, 'medicion3.txt'),'\t',1,0);
simulacion2 = dlmread(strcat(directorio, 'simulacion2.txt'),'\t',1,0);
% '\t'="TAB"; como la primer fila es el encabezado, se omite esta fila en la lectura
simulacion1(:,2)=simulacion1(:,2)*1000;	% Normalización a mA
simulacion2(:,2)=simulacion2(:,2)*1000;

%---------- AJUSTES ---------------------------------

rsimulacion1 =simulacion1;					% Se inicializa una nueva matriz
rsimulacion1(:,2)=sqrt(-rsimulacion1(:,2));	% Se toma raiz a toda la columna de corrientes. Unidad: raiz(mA)
Param=fmins('A_x_mas_B',[.707 -1.06],[0,0.0001,0,0,0,0,0,0,0,],[],rsimulacion1(1:30,:)');	% Param es un vector donde el primer elemento es A y el segundo B
k_spice_simulacion1=(Param(1)^2)/1000
ksimulacion1=Param(1)^2	% mA/V^2
VTsimulacion1=-Param(2)/Param(1)


rmedicion1 = medicion1;					% Se inicializa una nueva matriz
rmedicion1(:,2)=sqrt(-rmedicion1(:,2));	% Se toma raiz a toda la columna de corrientes. Unidad: raiz(mA)
Param=fmins('A_x_mas_B',[.707 -1.06],[0,0.0001,0,0,0,0,0,0,0,],[],rmedicion1(1:end-1,:)');	% Param es un vector donde el primer elemento es A y el segundo B						
k_spice_medicion1=(Param(1)^2)*2/1000   % A/V^2
kmedicion1=Param(1)^2
VTmedicion1=-Param(2)/Param(1)


rmedicion2 = medicion2;					% Se inicializa una nueva matriz
rmedicion2(:,2)=sqrt(-rmedicion2(:,2));	% Se toma raiz a toda la columna de corrientes. Unidad: raiz(mA)
Param=fmins('A_x_mas_B',[.707 -1.06],[0,0.0001,0,0,0,0,0,0,0,],[],rmedicion2(1:end-1,:)');	% Param es un vector donde el primer elemento es A y el segundo B				% Es fundamental transponer la matriz para que fmins funcione
k_spice_medicion2=(Param(1)^2)*2/1000   % A/V^2
kmedicion2=Param(1)^2	% mA/V^2
VTmedicion2=-Param(2)/Param(1)


rmedicion3 = medicion3;					% Se inicializa una nueva matriz
rmedicion3(:,2)=sqrt(-rmedicion3(:,2));	% Se toma raiz a toda la columna de corrientes. Unidad: raiz(mA)
Param=fmins('A_x_mas_B',[.707 -1.06],[0,0.0001,0,0,0,0,0,0,0,],[],rmedicion3(1:end-1,:)');	% Param es un vector donde el primer elemento es A y el segundo B
k_spice_medicion3=(Param(1)^2)*2/1000   % A/V^2
kmedicion3=Param(1)^2	% mA/V^2
VTmedicion3=-Param(2)/Param(1)

rsimulacion2 =simulacion2;					% Se inicializa una nueva matriz
rsimulacion2(:,2)=sqrt(-rsimulacion2(:,2));	% Se toma raiz a toda la columna de corrientes. Unidad: raiz(mA)
Param=fmins('A_x_mas_B',[.707 -1.06],[0,0.0001,0,0,0,0,0,0,0,],[],rsimulacion2(1:30,:)');	% Param es un vector donde el primer elemento es A y el segundo B
k_spice_simulacion2=(Param(1)^2)/1000
ksimulacion2=Param(1)^2	% mA/V^2
VTsimulacion2=-Param(2)/Param(1)

%---------- GRAFICOS --------------------------------

% GRAFICOS DE LA RAIZ DE LA CORRIENTE

m1_inicio0 = 37;
m2_inicio0 = 38;
m3_inicio0 = 38;
s1_inicio0 = 37;
s2_inicio0 = 50;


figure
hold on

plot(rmedicion1(:,1),rmedicion1(:,2),'ro','Markersize',5)
plot(rmedicion2(:,1),rmedicion2(:,2),'go','Markersize',5)
plot(rmedicion3(:,1),rmedicion3(:,2),'bo','Markersize',5)
plot(rsimulacion1(:,1),rsimulacion1(:,2),'k-','Linewidth',3)
plot(rsimulacion2(:,1),rsimulacion2(:,2),'y-','Linewidth',3)

plot(V(1:m1_inicio0),sqrt(kmedicion1)*(-V(1:m1_inicio0)+VTmedicion1),'r-','Linewidth',1)
plot(V(1:m2_inicio0),sqrt(kmedicion2)*(-V(1:m2_inicio0)+VTmedicion2),'g-','Linewidth',1)
plot(V(1:m3_inicio0),sqrt(kmedicion3)*(-V(1:m3_inicio0)+VTmedicion3),'b-','Linewidth',1)


L = legend(
	    sprintf('M2 k = %f mA/V^2  Vt= %f V', kmedicion1, VTmedicion1),
	    sprintf('M4 k = %f mA/V^2  Vt= %f V', kmedicion2, VTmedicion2),
	    sprintf('M6 k = %f mA/V^2  Vt= %f V', kmedicion3, VTmedicion3),
	    sprintf('CD4007.lib.lib k = %f mA/V^2  Vt= %f V', ksimulacion1, VTsimulacion1),
	    sprintf('Modelo modificado k = %f mA/V^2  Vt= %f V', ksimulacion2, VTsimulacion2),
	    'location', 'Northeast');


%Estos comandos agregan rotulos y detalles a los graficos
xlabel('Vgs [V]')
ylabel('Id^(1/2) [mA^(1/2)]')
axis([-5 0 0 2.5])
grid minor

% Una vez generada la imagen, se imprime a un archivo (recordar "help print" para obtener ayuda con la funcion).
print('P_sqrtID_VG.png','-dpng');


% GRAFICOS DE LAS CURVAS
% Luego, se debe graficar la curva cuadrática.
figure
hold on


plot(medicion1(:,1),medicion1(:,2),'ro','Markersize',5)
plot(medicion2(:,1),medicion2(:,2),'go','Markersize',5)
plot(medicion3(:,1),medicion3(:,2),'bo','Markersize',5)
plot(simulacion1(:,1),simulacion1(:,2),'k-','Linewidth',3)
plot(simulacion2(:,1),simulacion2(:,2),'y-','Linewidth',3)

plot(V(1:m1_inicio0),-kmedicion1*(V(1:m1_inicio0)-VTmedicion1).^2,'r-','Linewidth',1)
plot(V(1:m2_inicio0),-kmedicion2*(V(1:m2_inicio0)-VTmedicion2).^2,'g-','Linewidth',1)
plot(V(1:m3_inicio0),-kmedicion3*(V(1:m3_inicio0)-VTmedicion3).^2,'b-','Linewidth',1)


% Primero deben graficarse todoas las mediciones y simulaciones, luego los ajustes
L = legend(
	   sprintf('M2 k = %f mA/V^2  Vt= %f V', kmedicion1, VTmedicion1),
	   sprintf('M4 k = %f mA/V^2  Vt= %f V', kmedicion2, VTmedicion2),
	   sprintf('M6 k = %f mA/V^2  Vt= %f V', kmedicion3, VTmedicion3),
   	    sprintf('CD4007.lib k = %f mA/V^2  Vt= %f V', ksimulacion1, VTsimulacion1),
	    sprintf('Modelo modificado k = %f mA/V^2  Vt= %f V', ksimulacion2, VTsimulacion2),
	   'location', 'southeast');

%Estos comandos agregan rotulos y detalles a los graficos
xlabel('Vgs [V]')
ylabel('Id [mA]')
axis([-5 0 -7 0])
grid minor

print('P_ID_VG.png','-dpng');


%---------------------------------------------------------------------------------------------------------------
% Grafico de la transconductancia gm calculada;
%  - A partir del cociente de diferencias
%  - A partir de gm=2*raiz(k*ID)
%---------------------------------------------------------------------------------------------------------------
% Para graficar las curvas TEORICAS, nos ayudamos de un vector auxiliar para las tensiones

% Calculamos gm como cociente de diferencias
gm_simulacion1=diff(simulacion1(:,2)/1000)./diff(simulacion1(:,1));
gm_simulacion2=diff(simulacion2(:,2)/1000)./diff(simulacion2(:,1));

gm_medicion1=diff(medicion1(:,2)/1000)./diff(medicion1(:,1));
gm_medicion2=diff(medicion2(:,2)/1000)./diff(medicion2(:,1));
gm_medicion3=diff(medicion3(:,2)/1000)./diff(medicion3(:,1));


figure
hold on


plot(medicion1(2:end,2),gm_medicion1,'ro','Markersize',5)
plot(medicion2(2:end,2),gm_medicion2,'go','Markersize',5)
plot(medicion3(2:end,2),gm_medicion3,'bo','Markersize',5)

plot(simulacion1(2:end,2),gm_simulacion1,'k-','Linewidth',3)
plot(simulacion2(2:end,2),gm_simulacion2,'y-','Linewidth',3)

plot(I,2*sqrt(-kmedicion1/1000*I/1000),'r-','Linewidth',1)
plot(I,2*sqrt(-kmedicion2/1000*I/1000),'g-','Linewidth',1)
plot(I,2*sqrt(-kmedicion3/1000*I/1000),'b-','Linewidth',1)



L = legend(sprintf('M2 k = %f mA/V^2  Vt= %f V', kmedicion1, VTmedicion1),
	   sprintf('M4 k = %f mA/V^2  Vt= %f V', kmedicion2, VTmedicion2),
	   sprintf('M6 k = %f mA/V^2  Vt= %f V', kmedicion3, VTmedicion3),
   	   sprintf('CD4007.lib k = %f mA/V^2  Vt= %f V', ksimulacion1, VTsimulacion1),
	   sprintf('Modelo modificado k = %f mA/V^2  Vt= %f V', ksimulacion2, VTsimulacion2),
	   'location', 'southwest');

%-----------------------------------------------------
%Estos comandos agregan rotulos y detalles a los graficos
xlabel('Id [mA]')
ylabel('gm [1/Ohm]')
axis([-5 0 0 0.0035])
grid minor

print('P_GM_ID.png','-dpng');

difK_m1=(abs((kmedicion1 - ksimulacion2))/ksimulacion2)*100
difK_s1=(abs((ksimulacion1 - ksimulacion2))/ksimulacion2)*100

difVT_m1=(abs((VTmedicion1 - VTsimulacion2))/VTsimulacion2)*100
difVT_s1=(abs((VTsimulacion1 - VTsimulacion2))/VTsimulacion2)*100
