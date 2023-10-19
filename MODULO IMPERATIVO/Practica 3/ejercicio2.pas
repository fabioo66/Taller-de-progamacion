{2. Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee
código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de
producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto.
ii. Generar y retornar otro abb de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendida.
Nota: El módulo debe retornar los dos árboles.

b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.

c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.}


program ejercicio2;
type
  fec = record
    dia:integer;
    mes:integer;
    anio:integer;
  end;
  ventas = record
    codigo:integer;
    fecha:fec;
    cant:integer;
  end;
  
  ventas2 = record
    codigo:integer;
    cant:integer;
  end;
  
  arbol = ^nodo;
  nodo =record
    dato:ventas;
    HI:arbol;
    HD:arbol;
  end;
  arbol2 = ^nodo2;
  nodo2 = record
    dato:ventas2;
    HI:arbol2;
    HD:arbol2;
  end;

procedure leerfecha(var f: fec);
begin
  writeln('ingrese el dia');
  readln(f.dia);
  writeln('ingrese el anio');
  readln(f.anio);
  writeln('ingrese el mes');
  readln(f.mes);
end; 
 
procedure leerventa(var v: ventas);
var
  f: fec;
begin
  writeln('Ingrese el codigo de producto');
  readln(v.codigo);
  if(v.codigo <> 0)then begin
    leerfecha(f);
    writeln('Ingrese la cantidad de unidades vendidas');
    readln(v.cant);
  end;
end;

procedure agregar (var a:arbol; v:ventas);
begin
  if (a = nil) then begin
    new(A);
    a^.dato:= v; 
    a^.HI:= nil; 
    a^.HD:= nil;
  end
  else if (v.codigo <= a^.dato.codigo) then 
    agregar(a^.HI,v)
  else 
    agregar (a^.HD,v)   
end;

procedure agregar2 (var a:arbol2; v:ventas2);
begin
  if (a = nil) then begin
    new(A);
    a^.dato:= v; 
    a^.HI:= nil; 
    a^.HD:= nil;
  end
  else if (v.codigo <= a^.dato.codigo) then begin
    if (v.codigo = a^.dato.codigo) then
      v.cant:= v.cant + a^.dato.cant;
    agregar2(a^.HI,v)
  end
  else 
    agregar2(a^.HD,v)   
end;

procedure cargararbol(var a:arbol);
var
  v:ventas;
begin
  leerventa(v);
  if (v.codigo <> 0) then begin
    agregar(a,v);
    cargararbol(a);
  end;
end;

procedure recorrer (a:arbol; var a2:arbol2);
var
  v2:ventas2;
begin
  if (a <> nil) then begin
    v2.codigo:= a^.dato.codigo;
    v2.cant:= a^.dato.cant;
    agregar2(a2,v2);
    recorrer(a^.HI,a2);
    recorrer(a^.HD,a2);
  end;
end;


procedure arboles(var a:arbol; var a2:arbol2);
begin
  cargararbol(a);
  recorrer(a,a2);
end;

procedure cantvendidas(a:arbol; codigo:integer; var cant:integer);
begin
  if (a <> nil) then begin
    cantvendidas(a^.HI,codigo,cant);
    if (codigo = a^.dato.codigo) then
      cant:= cant + a^.dato.cant;
    cantvendidas(a^.HD,codigo,cant);
  end;
end;

procedure cantvendidas2(a:arbol2; codigo:integer; var cant:integer);
begin
  if (a <> nil) then begin
    cantvendidas2(a^.HI,codigo,cant);
    if (codigo = a^.dato.codigo) then
      cant:= cant + a^.dato.cant;
    cantvendidas2(a^.HD,codigo,cant);
  end;
end;

var
  a:arbol;
  a2:arbol2;
  codigo,cant,cant2,code:integer;
begin
  a:= nil;
  a2:= nil;
  arboles(a,a2);
  cant:= 0;
  writeln('ingrese el codigo para la busqueda del producto'); 
  readln(codigo);
  cantvendidas(a,codigo,cant);
  writeln('la cantidad total de ventas de este producto es ' , cant);
  cant2:= 0;
  writeln('ingrese el codigo para la busqueda del producto 2.0');
  readln(code);
  cantvendidas2(a2,code,cant2);
  writeln('la cantidad total de ventas de este producto es ' , cant2);
end.
