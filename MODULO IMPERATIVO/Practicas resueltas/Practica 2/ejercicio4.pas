{Escribir un programa con:
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
menores a 100.
b. Un módulo recursivo que devuelva el máximo valor del vector.
c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector.}

program ejercicio4;
type
    vector = array[1..20] of integer;

procedure cargarVector(var v: vector; pos: integer);
begin
    if (pos <= 20) then begin
        v[pos] := random(99) + 1;
        cargarVector(v, pos + 1);
    end;
end;

function maximo(v: vector; pos, max: integer): integer;
begin
    if (pos <= 20) then begin
        if (v[pos] > max) then
            max := v[pos];
        max := maximo(v, pos + 1, max);
    end
    else
        maximo := max;
end;

function suma(v: vector; pos, sum: integer): integer;
begin
    if (pos <= 20) then begin
        sum := sum + v[pos];
        sum := suma(v, pos + 1, sum);
    end
    else
        suma := sum;
end;

var
    v: vector;
begin
    randomize;
    cargarVector(v, 1);
    writeln('El maximo valor del vector es: ', maximo(v, 1, 0));
    writeln('La suma de los valores del vector es: ', suma(v, 1, 0));
end.