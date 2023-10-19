{4.- Escribir un programa con:
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
menores a 100.
b. Un módulo recursivo que devuelva el máximo valor del vector.
c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector.}

program ejercicio4;
const
  dimf = 20;
type 
  vector = array[1..dimf]of integer;

procedure cargarvector(var v:vector; pos: integer);
var
  num: integer;
begin
  if(pos <= dimf)then begin 
    randomize;
    v[pos]:= random(99)+1;
    cargarvector(v, pos+1);
  end;
end; 

procedure maximo(v:vector; var max: integer; pos:integer);
begin
  if(pos <= dimf)then begin
    if(v[pos] > max)then
      max:= v[pos];
    maximo(v, max, pos+1);  
  end;
end;

procedure valortotal(v: vector; pos: integer; var suma: integer);
begin
  if(pos <= dimf)then begin
    suma:= suma + v[pos];
    valortotal(v, pos+1, suma);
  end;
end;
var
  v: vector;
  pos, max, suma: integer;
begin
  pos:= 1;
  cargarvector(v, pos);
  pos:= 1;
  max:= -9999;
  maximo(v, max, pos);
  writeln('el numero maximo es: ', max);
  pos:= 1;
  suma:= 0;
  valortotal(v, pos, suma);
  writeln('el valor total de la suma de todos los elementos del vector es: ', suma);
end.
