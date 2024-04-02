program ejercicio2;
const
  dimf = 300;
type
  oficina = record
    codigo: integer;
    dni: integer;
    valor: real;
  end;
  
  vector = array[1..dimf] of oficina;
  
procedure leerOficina(var o:oficina);
begin
  writeln('Ingrese el codigo de identificacion');
  readln(o.codigo);
  if(o.codigo <> -1)then begin
    writeln('Ingrese el DNI del propietario');
    readln(o.dni);
    writeln('Ingrese el valor de la expensa');
    readln(o.valor);
  end;  
end;

procedure cargarVector(var v: vector; var diml: integer);
var
  o: oficina;
begin
  diml:= 0;
  leerOficina(o);
  while(diml < dimf)and(o.codigo <> -1)do begin
    diml:= diml + 1;
    v[diml]:= o;
  end;
end;

Procedure insercion(var v: Vector; dimL: integer);
var 
  i, j: integer;
  actual: oficina;			
begin
  for i:= 2 to dimL do begin 
    actual:= v[i];
    j:= i-1; 
    while (j > 0) and (v[j].codigo > actual.codigo)do begin
      v[j+1]:= v[j];
      j:= j - 1;                  
    end;  
    v[j+1]:= actual; 
  end;
end;

procedure seleccion(var v: vector; var diml: integer);
var 
  i, j, pos: integer; 
  o: oficina;	
begin
  for i:= 1 to (diml-1) do begin 
    pos := i;
    for j := i+1 to diml do
      if (v[j].codigo < v[pos].codigo)then 
        pos:= j;
        o:= v[pos];   
        v[pos]:= v[i];   
        v[i]:= o;
    end;
end;

var
  diml: integer;
  v: vector;
BEGIN
  cargarVector(v, diml);
  insercion(v,diml);
  seleccion(v,diml);	
END.
