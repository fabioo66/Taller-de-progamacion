{3. Un supermercado requiere el procesamiento de sus productos. De cada producto se
conoce código, rubro (1..10), stock y precio unitario. Se pide:
a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. La lectura finaliza con el código de producto igual a -1.
b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
de producto y retorne si dicho código existe o no para ese rubro.
c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.
d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
ingresados.}

program ejercicio3prac5;
type
  rangorubro = 1..10;
  producto = record
    codigo: integer;
    rubro: rangorubro;
    stock: integer;
    precio: real;
  end;
  
  arbol = ^nodo;
  nodo = record
    dato: producto;
    HI: arbol;
    HD: arbol;
  end;
  
  vector = array [rangorubro] of arbol;

procedure leerproducto(var p:producto);
begin
  writeln('Ingrese el codigo del producto');
  readln(p.codigo);
  if(p.codigo <> -1)then begin
    writeln('Ingrese el rubro (num de 1 a 10)');
    readln(p.rubro);
    writeln('Ingrese el stock disponible');
    readln(p.stock);
    writeln('Ingrese el precio del producto');
    readln(p.precio);
  end;
end;

procedure agregarproducto(var a:arbol; p:producto);
begin
  if(a = nil)then begin
    new(a);
    a^.dato:= p;
    a^.HI:= nil;
    a^.HD:= nil
  end
  else if(p.codigo <= a^.dato.codigo)then
    agregarproducto(a^.HI, p)
  else
    agregarproducto(a^.HD, p);
end;

procedure inicializarvector(var v:vector);
var
  i:integer;
begin
  for i:= 1 to 10 do
    v[i]:= nil;
end;

procedure cargarvector(var v:vector);
var
  p:producto;
begin
  leerproducto(p);
  if(p.codigo <> -1)then begin
    agregarproducto(v[p.rubro], p);
    cargarvector(v);
  end;
end;

{b}function recorrer(a:arbol; codigo: integer): boolean;
begin
  if(a = nil)then
    recorrer:= false
  else if(codigo = a^.dato.codigo)then
    recorrer:= true
  else if(codigo > a^.dato.codigo)then
    recorrer:= recorrer(a^.HD, codigo)
  else
    recorrer:= recorrer(a^.HI, codigo);
end;

{b}procedure existe(v: vector; codigo, rubro: integer);
begin
  if(recorrer(v[rubro], codigo))then
    writeln('el codigo ingresado existe en este rubro')
  else
    writeln('el codigo ingresado no existe en este rubro');
end;

{c}procedure devolvermax(a:arbol; var codigomax: integer; var stockmax: integer);
begin
  if(a <> nil)then
    if(a^.HD = nil)then begin
      codigomax:= a^.dato.codigo;
      stockmax:= a^.dato.stock
    end
    else
      devolvermax(a^.HD, codigomax, stockmax)
  else
    codigomax:= -1;
end;

{c}procedure maxcodigo(v: vector);
var
  i, codigomax, stockmax: integer;
begin
  for i:= 1 to 10 do begin
    devolvermax(v[i], codigomax, stockmax);
    writeln('El mayor codigo de rubro en la posicion ', i, ' es ', codigomax , ' y su stock es ', stockmax);
  end;
end;

{d}procedure contarbetween(a: arbol; code1, code2: integer; var cant: integer);
begin
  if(a <> nil)then 
    if(code1 <= a^.dato.codigo)then begin
      if(code2 >= a^.dato.codigo)then begin
        cant:= cant + 1;
        contarbetween(a^.HI, code1, code2, cant);
        contarbetween(a^.HD, code1, code2, cant);
      end
      else
        contarbetween(a^.HI, code1, code2, cant);
    end 
  else
    contarbetween(a^.HD, code1, code2, cant);
end;

{d}procedure cantproductos(v: vector; code1, code2, cant: integer);
var
  i: integer;
begin
  for i:= 1 to 10 do begin
    cant:= 0;
    contarbetween(v[i], code1, code2, cant);
    writeln('La cantidad de productos en el rubro ', i , ' con codigos entre los dos valores ingresados es ', cant);
  end;
end;

var
  v: vector;
  codigo, rubro, code1, code2, cant: integer;
begin
  inicializarvector(v);
  cargarvector(v);
  writeln('Ingrese un rubro (numero entre 1 y 10) para chequear');
  readln(rubro);
  writeln('Ingrese un codigo de producto para chequear');
  readln(codigo);
  existe(v, codigo, rubro);
  maxcodigo(v);
  writeln('Ingrese un codigo, el primero menor, separados de un enter');
  readln(code1);
  readln(code2);
  cantproductos(v, code1, code2, cant);
end.
