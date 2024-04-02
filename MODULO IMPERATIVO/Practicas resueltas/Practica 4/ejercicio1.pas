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
  writeln('ingrese el codigo de venta');
  readln(v.codigov);
  if(v.codigov <> -1)then begin
    writeln('ingrese el codigo de producto');
    readln(v.codigop);
    writeln('ingrese la cantidad de unidades vendidas');
    readln(v.cant);
    writeln('ingrese el precio');
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
  else if(p.codigop = a^.dato.codigop)then begin
    a^.dato.cantotal:= a^.dato.cantotal + p.cantotal;
    a^.dato.montototal:= a^.dato.montototal + p.montototal;
  end
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
    writeln('El monto total del codigo de producto, ', a^.dato.codigop, ' es ', a^.dato.montototal:0:2 ,' y la cantidad de unidades vendidas es ', a^.dato.cantotal);
    imprimircontenido(a^.HD);
  end;
end;

{c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el código de 
producto con mayor cantidad de unidades vendidas.}

procedure maxcantv(a:arbol; var codigomax: integer; max: integer);
begin
  if(a <> nil)then begin
    maxcantv(a^.HI, codigomax, max);
    if(a^.dato.cantotal > max)then begin
      max:= a^.dato.cantotal;
      codigomax:= a^.dato.codigop;
    end;
    maxcantv(a^.HD, codigomax, max);
  end;
end;

{d. Contenga un módulo que reciba la estructura generada en el punto a y un código de 
producto y retorne la cantidad de códigos menores que él que hay en la 
estructura.}

{procedure cantmenores(a:arbol; num: integer; var cant: integer);
begin
  if(a <> nil)then begin
    if(num > a^.dato.codigop)then begin
      cant:= cant + 1;
      cantmenores(a^.HD, num, cant)
    end
    else
      cantmenores(a^.HI, num, cant);
  end;
end;}


procedure cantmenores (a:arbol; var cant:integer; num:integer);
begin
  if (a <> nil) then 
    if(num > a^.dato.codigop)then begin
      cant:= cant + 1;
      cantmenores(a^.HI,cant,num);
      cantmenores(a^.HD,cant,num);
    end
    else
      cantmenores(a^.HI,cant,num);
end;

procedure informarbetween(a:arbol; code1, code2: integer; var monto: real);
begin
  if(a <> nil)then
    if(code1 < a^.dato.codigop)then begin
      if (code2 > a^.dato.codigop) then begin
        monto:= monto + a^.dato.montototal;
        informarbetween(a^.HI,code1,code2,monto);
        informarbetween(a^.HD,code1,code2,monto);
      end
      else
        informarbetween(a^.HI,code1,code2,monto);
      end
    else
      informarbetween(a^.HD,code1,code2,monto);
end;

var
  a: arbol;
  num, cant, codigomax, max, code1, code2:integer;
  monto:real;
begin 
  a:= nil;
  cargararbol(a);
  imprimircontenido(a);
  max:= -9999;
  maxcantv(a,codigomax,max);
  writeln('el codigo de producto que tiene mas ventas es: ', codigomax);
  writeln('Ingrese un codigo para chequear la cantidad de codigos menores a el');
  readln(num);
  cant:= 0;
  cantmenores(a, cant, num);
  writeln('la cantidad de codigos menores al codigo ingresado es: ', cant);
  writeln('ingrese dos codigos separados por un enter, el primer codigo debe ser menor que el segundo');
  readln(code1);
  readln(code2);
  monto:= 0;
  informarbetween(a,code1,code2,monto);
  writeln('el monto entre los dos codigos leidos es: ' , monto:0:2);
end.
