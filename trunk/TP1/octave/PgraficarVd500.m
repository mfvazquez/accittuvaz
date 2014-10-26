%-----------------------------------------------------
% Dispositivos Semiconductores 66.25/86.03
% TP 1 - Curvas características del transistor MOSFET
% Alumnos:
% 	*
%	* 91523 Vazquez, Matias Fernando
%-----------------------------------------------------


%---------------------------------------------------------------------------------------------------------------
% Grafico de la corriente ID en funcion de VDS, para VGS constante
%---------------------------------------------------------------------------------------------------------------

directorio = 'datos/P_VD_500/'

V=-5:0.1:0;

medicion1 = dlmread(strcat(directorio, 'medicion1.txt'),'\t',1,0);
medicion2 = dlmread(strcat(directorio, 'medicion2.txt'),'\t',1,0);
medicion3 = dlmread(strcat(directorio, 'medicion3.txt'),'\t',1,0);
simulacion1 = dlmread(strcat(directorio, 'simulacion.txt'),'\t',1,0);
simulacion2 = dlmread(strcat(directorio, 'simulacion2.txt'),'\t',1,0);
% '\t'="TAB"; como la primer fila es el encabezado, se omite esta fila en la lectura
simulacion1(:,2)=simulacion1(:,2)*1000;	% Normalización a mA
simulacion2(:,2)=simulacion2(:,2)*1000;

%-----------------------------------------------------      
% Ajuste de la corriente de saturacion de los MOSFET
% El objetivo del ajuste mediante 'fminserach' y la funcion auxiliar 'A_x_mas_B'
% es minimizar iterativamente el error cuadratico entre los valores de ID 
% medidos y el resultado de A*VDS+B , donde A y B son los parametros de ajuste
% Condiciones iniciales del ajuste elegidas: A=0.04 (kOhm^-1) y B=1 (mA)
% NOTA: observar que en el ajuste se utilizan ambas columnas, pero sólo se utilizan 
% algunas de las filas de los datos

Param=fmins('A_x_mas_B',[0.04 -0.5],[0,0.0001,0,0,0,0,0,0,0,],[],medicion1(1:7,:)');
ro_medicion1=1/Param(1)
ID_medicion1=Param(2)
lambda_medicion1=(-1/ro_medicion1)/(ID_medicion1)

Param=fmins('A_x_mas_B',[0.04 -0.5],[0,0.0001,0,0,0,0,0,0,0,],[],medicion2(1:7,:)');
ro_medicion2=1/Param(1)
ID_medicion2=Param(2)
lambda_medicion2=(-1/ro_medicion2)/(ID_medicion2)

Param=fmins('A_x_mas_B',[0.04 -0.5],[0,0.0001,0,0,0,0,0,0,0,],[],medicion3(1:7,:)');
ro_medicion3=1/Param(1)
ID_medicion3=Param(2)
lambda_medicion3=(-1/ro_medicion3)/(ID_medicion3)

Param=fmins('A_x_mas_B',[0.04 -0.5],[0,0.0001,0,0,0,0,0,0,0,],[],simulacion1(1:20,:)');
ro_simulacion1=1/Param(1)
ID_simulacion1=Param(2)
lambda_simulacion1=(-1/ro_simulacion1)/(ID_simulacion1)

Param=fmins('A_x_mas_B',[0.04 -0.5],[0,0.0001,0,0,0,0,0,0,0,],[],simulacion2(1:20,:)');
ro_simulacion2=1/Param(1)
ID_simulacion2=Param(2)
lambda_simulacion2=(-1/ro_simulacion2)/(ID_simulacion2)


%-----------------------------------------------------
%Gráfico de las curvas de los MOSFET
figure
hold on


plot(medicion1(:,1),medicion1(:,2),'ro','Markersize',5)
plot(medicion2(:,1),medicion2(:,2),'go','Markersize',5)
plot(medicion3(:,1),medicion3(:,2),'bo','Markersize',5)
plot(simulacion1(:,1),simulacion1(:,2),'k-','Linewidth',3)
plot(simulacion2(:,1),simulacion2(:,2),'y-','Linewidth',3)

fin = 30;

plot(V(1:fin),((V/ro_medicion1)+ID_medicion1)(1:fin),'r-','Linewidth',1)
plot(V(1:fin),((V/ro_medicion2)+ID_medicion2)(1:fin),'g-','Linewidth',1)
plot(V(1:fin),((V/ro_medicion3)+ID_medicion3)(1:fin),'b-','Linewidth',1)


legend(sprintf('M2 ro = %f kOhm y lambda = %f 1/V',ro_medicion1, lambda_medicion1),
	   sprintf('M4 ro = %f kOhm y lambda = %f 1/V',ro_medicion2, lambda_medicion2),
	   sprintf('M6 ro = %f kOhm y lambda = %f 1/V',ro_medicion3, lambda_medicion3),
	   sprintf('CD4007.lib ro = %f kOhm y lambda = %f 1/V',ro_simulacion1, lambda_simulacion1),
	   sprintf('Modelo modificado ro = %f kOhm y lambda = %f 1/V',ro_simulacion2, lambda_simulacion2),
	   'Location','northwest')
%-----------------------------------------------------
%Estos comandos agregan rotulos y detalles a los graficos
xlabel('Vds [V]')
ylabel('Id [mA]')
axis([-5 -0.4 -0.6 -0.35])
grid minor

print('P_ID_VDS_500.png','-dpng');

dif_ro_m1 = (abs(ro_medicion1 - ro_simulacion2)/ro_simulacion2)*100
dif_ro_s1 = (abs(ro_simulacion1 - ro_simulacion2)/ro_simulacion2)*100

dif_lambda_m1 = (abs(lambda_medicion1 - lambda_simulacion2)/lambda_simulacion2)*100
dif_lambda_s1 = (abs(lambda_simulacion1 - lambda_simulacion2)/lambda_simulacion2)*100

