%-----------------------------------------------------
% Dispositivos Semiconductores 66.25/86.03
% http://www.fi.uba.ar/materias/6625
%  Contenido: Funcion auxiliar para el ajuste de curvas de MOSFETs del TP N�1 en Octave
%  Autor: Ing. Ariel Lutenberg
%  Fecha: 29 de Junio de 2008
%  Modificado por:
%   - Diego Fanego (12 de marzo de 2010)
%   - Sebasti�n Carbonetto (17 de septiembre de 2013)
%-----------------------------------------------------

%El objetivo del ajuste mediante esta funcion y 'fminserach' es minimizar 
% iterativamente el error cuadratico entre los valores de Y medidos y el 
% resultado de Y = A*X+B , donde A y B son los par�metros de ajuste, y 
% dependiendo de la curva a ajustar, se relacionar�n con los par�metros
% el�ctricos de alguna manera

function error_cuadr=A_x_mas_B(Param,puntos)

	A=Param(1);
	B=Param(2);
	x=puntos(1,:);
	y=puntos(2,:);

%-----------------------------------------------------
% La funci�n devuelve el error cuadratico, es decir, la sumatoria de los cuadrados de 
% la diferencia entre los datos experimentales de y y la funci�n de ajuste:

	error_cuadr=sum((y-(A*x+B)).^2);

endfunction
