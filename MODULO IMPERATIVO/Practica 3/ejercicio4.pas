{Implementar un programa modularizado para una librería que:
a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por código de producto. 
De cada producto deben quedar almacenados la cantidad total 
de unidades vendidas y el monto total. De cada venta se lee código de venta, código del producto vendido, 
cantidad de unidades vendidas y precio unitario. 
El ingreso de las ventas finaliza cuando se lee el código de venta -1.
b. Imprima el contenido del árbol ordenado por código de producto.
c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el código de 
producto con mayor cantidad de unidades vendidas.
d. Contenga un módulo que reciba la estructura generada en el punto a y un código de 
producto y retorne la cantidad de códigos menores que él que hay en la 
estructura.
e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de producto y 
retorne el monto total entre todos los códigos de productos 
comprendidos entre los dos valores recibidos (sin incluir).}

program ejercicio1clase4;
type
  venta = record
    codigov: integer;
    codigop: integer;
    cant: integer;
    precio:real;
  end;
  
  producto = record
    cantotal: integer;
    montototal: real;
    codigop: integer;
  end;
  
  arbol = ^nodo;
  nodo = record
    dato: producto;
    HI: arbol;
    HD: arbol;
  end;
  
procedure leerventa(var v: venta);
begin
  readln(v.codigov);
  if(v.codigov <> -1)then begin
    readln(v.codigop);
    readln(v.cant);
    readln(v.precio);
  end;
end;

procedure agregarproductos(var a: arbol; p: producto);
begin
  if(a = nil)then begin
    new(a);
    a^.dato:= p;
    a^.HI:= nil;
    a^.HD:= nil;
  end
  else if(p.codigop = a^.dato.codigop)then 
    a^.dato.cantotal:= a^.dato.cantotal + p.cantotal
  else if (p.codigop < a^.dato.codigop) then
    agregarproductos(a^.HI, p)
  else
    agregarproductos(a^.HD, p);
end;

procedure cargararbol(var a:arbol);
var
  v:venta;
  p:producto;
begin
  leerventa(v);
  if (v.codigov <> -1) then begin
    p.codigop:= v.codigop;
    p.cantotal:= v.cant;
    p.montototal:= v.precio * v.cant;
    agregarproductos(a,p);
    cargararbol(a);
  end;
end;

{b. Imprima el contenido del árbol ordenado por código de producto.}

procedure imprimircontenido(a: arbol);
begin
  if(a <> nil)then begin
    imprimircontenido(a^.HI);
    writeln(a^.dato.montototal:0:2 ,'      ', a^.dato.cantotal,'      ',a^.dato.codigop);
    imprimircontenido(a^.HD);
  end;
end;

{c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el código de 
producto con mayor cantidad de unidades vendidas.}

function maximo(a:arbol): integer;
begin
  if(a <> nil)then
    if(a^.HD = nil)then
      maximo:= a^.dato.codigop
    else
      maximo:= maximo(a^.HD)
  else
    maximo:= -1;
end;

{d. Contenga un módulo que reciba la estructura generada en el punto a y un código de 
producto y retorne la cantidad de códigos menores que él que hay en la 
estructura.}

procedure cantmenores(a:arbol; codigo:integer; var cant:integer);
begin
  if (a = nil) then 
    cant:= 0;
  else if (a^.dato.codigo < codigo) then
    cant:= cant + 1;
    cantmenores(a^.HI,codigo,cant);
    cantmenores(a^.HD,codigo,cant);
  end;
end;

{e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de producto y 
retorne el monto total entre todos los códigos de productos 
comprendidos entre los dos valores recibidos (sin incluir).}

var
  a: arbol;
  cant,codigo:integer;
begin 
  a:= nil;
  cargararbol(a);
  imprimircontenido(a);
  writeln(maximo(a));
  readln(codigo);
  cant:= 0;
  cantmenores(a,codigo,cant);
  writeln(cant);
end.
