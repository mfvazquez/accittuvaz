function error_cuadr=A_x_mas_B(Param,puntos)

	A=Param(1);
	B=Param(2);
	x=puntos(1,:);
	y=puntos(2,:);
	
% La función devuelve el error cuadratico, es decir, la sumatoria de los cuadrados de 
% la diferencia entre los datos experimentales de y y la función de ajuste:

	error_cuadr=sum((y-(A*x+B)).^2);

endfunction
