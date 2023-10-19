{El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}

program ejercicio2;
const
  dimf = 300;
type
  dig = 0..9; 
  oficinas = record
    codigo: dig;
    DNI: dig;
    valor: real;
  end;

  vector = array[1..dimf] of oficinas;

procedure leeroficina(var o: oficinas);
begin
  readln(o.codigo);
  if(o.codigo = -1)then begin
    readln(o.DNI);
    readln(o.valor);
  end;
end;

procedure cargarvector(var v:vector; var diml: integer);
var
  o: oficinas
begin
  diml:= 0;
  leeroficina(o);
  while(o.codigo = -1)do begin
    diml:= diml + 1;
    v[diml]:= oficinas;
    leeroficina(o);
  end;
end;

Procedure insercion(var v: Vector; dimL: integer);
var 
  i, j: integer;
  actual: oficinas;			
begin
  for i:= 2 to dimL do begin 
    actual:= v[i];
    j:= i-1; 
    while (j > 0) y (v[j].codigo > actual.codigo)do begin
      v[j+1]:= v[j];
      j:= j – 1;                  
    end;  
    v[j+1]:= actual; 
  end;
end;

procedure seleccion(var v: vector; var diml: integer);
var 
  i, j, pos: integer; 
  item: oficinas;	
begin
  for i:= 1 to (dimLog-1) do begin 
    pos := i;
    for j := i+1 to dimLog do
      if (v[j].codigo < v[pos].codigo)then 
        pos:= j;
        item:= v[pos];   
        v[pos]:= v[i];   
        v[i]:= item;
    end;
end;

VAR
  v: vector;
  diml: integer;
BEGIN
  cargarvector(v, diml);
  insercion(v, diml);
  seleccion(v, diml);
END.

