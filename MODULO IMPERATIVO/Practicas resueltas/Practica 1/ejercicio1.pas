{1.- Se desea procesar la información de las ventas de productos de un comercio (como máximo
50).
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el
día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99
unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El
ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos
valores que se ingresan como parámetros.
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a
mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g}

program ejercicio1prac1;
type
  drango = 0..31;
  crango = 1..15;
  urango = 0..99;
  ventas = record
    dia: drango;
    codigo: crango;
    cantvendida: urango;
  end;
  
  vector = array[1..50]of ventas;
  
  Lista = ^nodo
  nodo = record
    dato:ventas;
    sig:lista;

procedure leerventa(var venta: ventas);
begin
  readln(venta.dia);
  if(venta.dia <> 0)then begin
    randomize;
    venta.codigo:= random(15)+ 1;
    readln(venta.cantvendida);
  end;
end; 
  
{A}procedure cargarvector(var v: vector; var diml:integer);
var
  venta: ventas
begin
  diml:= 0;
  leerventa(venta);
  while(venta.dia <> 0)and (diml < 50)do begin 
    diml:= diml + 1
    v[diml]:= venta;
    leerventa(venta);
  end;
end;

{B}procedure informarvector(v:vector; diml:integer);
var 
  i: integer;
begin
  for i:= 1 to diml do begin
    writeln('El dia ' , v[i].dia , 'con el codigo ' , v[i].codigo , ' se realizaron esta cantidad de ventas ' , v[i].cantvendidas);
  end;
end;

{C}procedure insercion ( var v: vector; diml: integer );
var 
  i, j: i; 
  actual: ventas;	
begin
 for i:= 2 to diml do begin 
     actual:= v[i];
     j:= i-1; 
     while (j > 0) y (v[j].codigo > actual.codigo) do      
       begin
         v[j+1]:= v[j];
         j:= j – 1;                  
       end;  
     v[j+1]:= actual; 
 end;
end;

procedure eliminar(var v:vector; var diml: integer; var pude: boolean; code1, code2: integer);
var
  i, pos1, pos2, j, z: integer;
  ok1, ok2: boolean;
begin
  ok1:= false;
  ok2:= false;
  pude:= false;
  for i:= 1 to diml do begin
    if(v[i].codigo > code1) and (ok1 = false)then begin
      pos1:= i;
      ok1:= true;
    end
    else if(v[i].codigo < code2) and (ok2 = false)then
      pos2:= i;
      ok1:= true;
    end;  
  end;
  for z:= 1 to (pos2 - pos1) do begin
    for j:= 1 to (diml-1) do begin
      if(j >= pos1)then
        v[j]:= v[j+1]; 
    end;
    dL:= dL - 1;
  end;       
  pude:= true;
end;

procedure agregaratras(L: lista; v: ventas; var ult: lista);
var
  nue: lista;
begin
  new(nue);
  nue^.dato:= v;
  nue^.sig:= nil;
  if(L = nil) then
    L:= nue			
  else				
    ULT^.sig := nue; 	
  ULT := nue;
end;

{g}function espar(num: integer):boolean;
begin
  espar:= num mod 2 = 0
end;

{g}procedure cargarlista(v:vector; diml:integer; var L:lista; var cantvendida:integer);
var
  ult: lista;
  i: integer;
begin
  cantvendida:= 0;
  L:= nil;
  for i:= 1 to diml do begin
    if (cumple(v[i].codigo)) then
      agregaratras(L, v[i], ult);
    cantvendida:= cantvendida + v[i].cantvendida;
  end;
end;

var
  v: vector;
  diml, cantvendida, code1, code2: integer;
begin
  cargarvector(v,diml);
  informarvector(v,diml);
  insercion(v, diml);
  informarvector(v,diml);
  read(code1);
  read(code2);
  eliminar(v, diml, pude, code1, code2);
  cargarlista(v, diml, L, cantvendida);
  informarvector(v,diml);
end.
