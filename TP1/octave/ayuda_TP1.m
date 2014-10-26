%-----------------------------------------------------
% Dispositivos Semiconductores 66.25/86.03
% http://www.fi.uba.ar/materias/6625
%  Contenido: Archivo de ayuda/guía para el TP Nº1 para Octave
%  Autor: Ing. Ariel Lutenberg
%  Fecha: 29 de Junio de 2008
%  Modificado por: 
%   - Diego Fanego (6 de abril de 2010)
%   - Sebastián Carbonetto (17 de septiembre de 2013)
%-----------------------------------------------------

close all;
clear all;

%-----------------------------------------------------
% INTROUDCCION
% Este SCRIPT se ha realizado para ayudar a los estudiantes a cargar los datos obtenidos para la elaboracion del TP#1
% y su análisis por métodos numéricos con el programa OCTAVE. Este SCRIPT es totalmente compatible con MATLAB salvo por
% algunas funciones específicas que cambian la forma de ingresar los argumentos.
% Ante cualquier duda sobre el uso de alguna de las funciones, utilizar el commando "octave> help <funcion>"
%-----------------------------------------------------

%-----------------------------------------------------
% INGRESO DE DATOS
% Hay dos formas de ingresar datos. Una es manual, inicializando los vectores explícitamente con los datos registrados 
% en las mediciones.
% Por ejemplo: Mediciones experimentales del MOSFET Nº1:
% Fila 1: VGS (V) / Fila 2: ID (mA)
NMOSFET_1=[1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.2 2.4 2.6 2.8 3.0 3.5 4.0 4.5 5.0;...
          0 0.01 0.02 0.04 0.06 0.1 0.16 0.3 0.5 0.75 1.03 1.36 2.35 3.54 4.94 6.48];
NMOSFET_1=NMOSFET_1';	% Este comando es para transponer la matriz y que los datos queden en columnas.

% La segunda opción es tener los datos guardados en un archivo de texto plano, como un CSV (comma separated values), o 
% cualquier otro (típicamente se utiliza el "TAB" como delimitador. En ese caso, los datos luego son cargados por la 
% función 'dlmread'
% DATA = dlmread (FILE, SEP, R0, C0) donde FILE es el archivo, SEP el delimitador, y R0 y C0 son las filas y columnas 
% donde comienzan los "datos utiles".
% Para el archivo generado por LTSpice con los datos de la simulación, podría invocarse por ejemplo (la línea se encuentra 
% originalmente comentada para ser modificada por los estudiantes y evitar que OCTAVE nos en mensaje de error
%NMOSFET_SIM=dlmread('SIM_NMOSFET_id_vgs.txt','\t',1,0);	% '\t'="TAB"; como la primer fila es el encabezado, se omite esta fila en la lectura
%NMOSFET_SIM(:,2)=NMOSFET_SIM(:,2)*1000	% Normalización a mA



%-----------------------------------------------------      
% Ajuste de los parametros k y VT de los MOSFET
% El objetivo del ajuste mediante 'fminserach' y la funcion auxiliar 'A_x_mas_B'
% es minimizar iterativamente el error cuadratico entre los valores de raiz(ID) 
% medidos y el resultado de A*x+B , donde
% A = raiz(k)
% B = -raiz(k)*VT
% Condiciones iniciales del ajuste elegidas: k=0.5 mA/V^2 y VT=1.5
% => A = 0.707
% => B = -1.06
% NOTA: observar que en el ajuste se utilizan ambas columnas, pero sólo se utilizan 
% algunas de las filas de los datos.
% NOTA2: A pesar de que los valores por defecto de las opciones de fminsearch 
% son todos 0, hay que ponerlos explicitamente ("[0,0,0,0,0,0]") para
% asegurarnos que funcione bien.
rNMOSFET_1=NMOSFET_1;					% Se inicializa una nueva matriz
rNMOSFET_1(:,2)=sqrt(rNMOSFET_1(:,2));	% Se toma raiz a toda la columna de corrientes. Unidad: raiz(mA)
Param=fminsearch('A_x_mas_B',[.707 -1.06],[0,0,0,0,0,0],[],rNMOSFET_1(5:end-2,:)');	% Param es un vector donde el primer elemento es A y el segundo B
																				% Es fundamental transponer la matriz para que fminsearch funcione
k_NMOSFET_1=Param(1)^2;	% mA/V^2
VT_NMOSFET_1=-Param(2)/Param(1);


%-----------------------------------------------------
% Gráfico de las curvas de los MOSFET
% 'figure' crea una nueva figura
% 'plot' realiza el grafico (X;Y) 
%   -> tipear "help plot" para ver opciones, colores, formatos, etc.
% 'hold on' indica que el siguiente grafico se realiza sobre el anterior
% Se debe hacer una figura para cada tipo de transistor. Una figura para los NMOS, 1 figura para los PMOS.

% Para graficar las curvas TEORICAS, nos ayudamos de un vector auxiliar para las tensiones
V=0:0.1:5;

%----------
% Primero se grafica la raiz de la corriente en funcion de la tension
figure
hold on
plot(rNMOSFET_1(:,1),rNMOSFET_1(:,2),'bo','Markersize',5)
% Primero deben graficarse todoas las mediciones y simulaciones, luego los ajustes
plot(V(15:end),sqrt(k_NMOSFET_1)*(V(15:end)-VT_NMOSFET_1),'b-','Linewidth',2)
LEYENDA1=sprintf('MOSFET 1: k=%2.3g mA/V^2 - VT=%4.3g V',k_NMOSFET_1,VT_NMOSFET_1);
% LEYENDA2= ...
legend(LEYENDA1,'Location','Northwest')
%legend(LEYENDA1,LEYENDA2,LEYENDA3,LEYENDA4,'Location','Northwest')

%Estos comandos agregan rotulos y detalles a los graficos
xlabel('Tension V_{GS} [Volts]')
ylabel('Raiz Corriente raiz(I_D) [raiz(mA)]')
axis([0 5 0 2.5])
grid minor

% Una vez generada la imagen, se imprime a un archivo (recordar "help print" para obtener ayuda con la funcion).
print('fig_nmos_rid_vgs.png','-dpng');

%----------
% Luego, se debe graficar la curva cuadrática.
figure
hold on
plot(NMOSFET_1(:,1),NMOSFET_1(:,2),'bo','Markersize',5)
% Primero deben graficarse todoas las mediciones y simulaciones, luego los ajustes
plot(V(15:end),k_NMOSFET_1*(V(15:end)-VT_NMOSFET_1).^2,'b-','Linewidth',2)
legend(LEYENDA1,'Location','Northwest')
%legend(LEYENDA1,LEYENDA2,LEYENDA3,LEYENDA4,'Location','Northwest')

%Estos comandos agregan rotulos y detalles a los graficos
xlabel('Tension V_{GS} [Volts]')
ylabel('Corriente I_D [mA]')
axis([0 5 0 5])
grid minor

print('fig_nmos_id_vgs.png','-dpng');

%---------------------------------------------------------------------------------------------------------------
% Grafico de la transconductancia gm calculada;
%  - A partir del cociente de diferencias
%  - A partir de gm=2*raiz(k*ID)
%---------------------------------------------------------------------------------------------------------------
% Para graficar las curvas TEORICAS, nos ayudamos de un vector auxiliar para las tensiones
I=0:0.1:7;

% Calculamos gm como cociente de diferencias
gm_NMOSFET1=diff(NMOSFET_1(:,2)/1000)./diff(NMOSFET_1(:,1));

figure
hold on
plot(NMOSFET_1(2:end,2),gm_NMOSFET1,'bo','Markersize',5)
% Primero deben graficarse todoas las mediciones y simulaciones, luego los cálculos teóricos
plot(I,2*sqrt(k_NMOSFET_1/1000*I/1000),'b-','Linewidth',2)		% /1000 es para normalizar las unidades de gm
legend(LEYENDA1,'Location','Northwest')
%legend(LEYENDA1,LEYENDA2,LEYENDA3,LEYENDA4,'Location','Northwest')

%-----------------------------------------------------
%Estos comandos agregan rotulos y detalles a los graficos
xlabel('Corriente I_D [mA]')
ylabel('g_m [Ohm^-^1]')
axis([0 7 0 0.005])
grid minor

print('fig_nmos_gm_id.png','-dpng');

%---------------------------------------------------------------------------------------------------------------
% Grafico de la corriente ID en funcion de VDS, para VGS constante
%---------------------------------------------------------------------------------------------------------------

%-----------------------------------------------------
%Ingreso de los datos de las curvas como vectores de dos filas y N columnas
% Fila 1: VGS / Fila 2: ID
NMOSFET_1=[0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.75 2.0 2.5 3.0 3.5 4.0;...
          0.24 0.34 0.43 0.5 0.56 0.61 0.66 0.69 0.72 0.74 0.76 0.77 0.79 0.8 0.82 0.84 0.87 0.9 0.93 0.96];
NMOSFET_1=NMOSFET_1';	% Este comando es para transponer la matriz y que los datos queden en columnas.
%NMOSFET_1=dlmread('MED_NMOSFET_id_vds_1mA.txt','\t',1,0);

%-----------------------------------------------------      
% Ajuste de la corriente de saturacion de los MOSFET
% El objetivo del ajuste mediante 'fminserach' y la funcion auxiliar 'A_x_mas_B'
% es minimizar iterativamente el error cuadratico entre los valores de ID 
% medidos y el resultado de A*VDS+B , donde A y B son los parametros de ajuste
% Condiciones iniciales del ajuste elegidas: A=0.04 (kOhm^-1) y B=1 (mA)
% NOTA: observar que en el ajuste se utilizan ambas columnas, pero sólo se utilizan 
% algunas de las filas de los datos
Param=fminsearch('A_x_mas_B',[0.04 1],[0,0,0,0,0,0],[],NMOSFET_1(12:end,:)');
ro_NMOSFET_1=1/Param(1);
ID_NMOSFET_1=Param(2);
lambda_NMOSFET_1=1/Param(2)/Param(1);


%-----------------------------------------------------
%Gráfico de las curvas de los MOSFET
figure
hold on
plot(NMOSFET_1(:,1),NMOSFET_1(:,2),'b*','Markersize',5)
% Primero deben graficarse todas las mediciones y simulaciones, luego los ajustes
plot(V,(V/ro_NMOSFET_1)+ID_NMOSFET_1,'b-','Linewidth',2)
LEYENDA1=sprintf('MOSFET 1: ro=%0.3g KOhm, lambda=%0.3g V^{-1}',ro_NMOSFET_1,lambda_NMOSFET_1);
% LEYENDA2= ...
legend(LEYENDA1,'Location','SouthEast')
%legend(LEYENDA1,LEYENDA2,LEYENDA3,LEYENDA4,'Location','SouthEast')

%-----------------------------------------------------
%Estos comandos agregan rotulos y detalles a los graficos
xlabel('Tension V_{DS} [Volts]')
ylabel('Corriente I_D [mA]')
axis([0 5 0 1.2])
grid minor

print('fig_nmos_id_vds.png','-dpng');
