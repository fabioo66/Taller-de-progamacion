{1. El administrador de un edificio de oficinas, cuenta en papel, con la información del pago
de las expensas de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se debe leer, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación -1.}

program ejercicio1practica5;
const
  dimf = 300;
type
  oficina = record
    codigo:integer;
    dni:integer;
    valorexp:real;
  end;
  
  vector = array[1..dimf] of oficina;
  
{a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se debe leer, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación -1.}
  
procedure leeroficina(var o:oficina);
begin
  readln(o.codigo);
  if (o.codigo <> -1) then begin
    readln(o.dni);
    readln(o.valorexp);
  end;
end;

procedure cargarvector(var v:vector; var diml:integer);
var
  o:oficina;
begin
  diml:= 0;
  leeroficina(o);
  while (o.codigo <> -1) and (diml < dimf) do begin
    diml:= diml + 1;
    v[diml]:= o;
    leeroficina(o);
  end;
end;

{b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.}

Procedure insercion ( var v:vector; diml: integer );
var 
  i,j: integer; 
  actual:oficina;	
begin
  for i:= 2 to dimL do begin 
    actual:= v[i];
    j:= i-1; 
    while (j > 0) and (v[j].codigo > actual.codigo) do begin
        v[j+1]:= v[j];
        j:= j-1;                  
    end;  
    v[j+1]:= actual; 
  end;
end;

procedure recorrer(v:vector; diml:integer);
var
  i:integer;
begin
  for i:= 1 to diml do
    writeln(v[i].codigo);
end;

{c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no
se encontró la oficina.}

procedure dicotomica (vec:vector; dL:integer; valor:integer; var pos:integer);
var 
  pri, ult, medio : integer;
begin
  pos:= 0;
  pri:= 1 ;  
  ult:= dL;  
  medio := (pri + ult ) div 2 ;
  while  ( pri <= ult ) and ( valor <> vec[medio].codigo) do begin
    if ( valor < vec[medio].codigo ) then 
      ult:= medio -1 
    else
      pri:= medio + 1 ;
    medio := ( pri + ult ) div 2 ;
  end;
  if (pri <= ult) and (valor = vec[medio].codigo) then
    pos:= medio; 
end;

procedure busqueda(v:vector; diml:integer; codigo:integer);
var
  pos:integer;
begin
  dicotomica(v,diml,codigo,pos);
  if (pos = 0) then
    writeln('no se encontro la oficina')
  else
    writeln(v[pos].dni);
end;

{d) Un módulo recursivo que retorne el monto total de las expensas.}

procedure monto (v:vector; diml:integer; var total:real);
begin
  if (diml > 0) then begin
    total:= total + v[diml].valorexp;
    monto(v,diml-1,total);
  end;
end;

var
  v:vector;
  diml:integer;
  codigo:integer;
  total:real;
begin
  cargarvector(v,diml);
  insercion(v,diml);
  recorrer(v,diml);
  readln(codigo);
  busqueda(v,diml,codigo);
  total:= 0;
  monto(v,diml,total);
  writeln(total:0:2);
end.
