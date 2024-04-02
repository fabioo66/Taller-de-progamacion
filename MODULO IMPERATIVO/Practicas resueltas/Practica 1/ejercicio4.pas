{4.- Una librería requiere el procesamiento de la información de sus productos. De cada
producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
métodos vistos en la teoría.
e. Muestre los precios del vector resultante del punto d).
f. Calcule el promedio de los precios del vector resultante del punto d).}

program ejercicio4;
const
  dimf = 30;
type
  crango = 1..8;
  productos = record
    codigoproducto: integer;
    codigorubro: crango;
    precio: real;
  end;  
  
  lista = ^nodo;
  nodo = record
    dato: productos;
    sig: lista;
  end;
  
  vector1 = array[crango]of lista;
  vector2 = array[1..dimf]of productos;
  
procedure leerproducto(var p:productos);
begin
  readln(p.precio);
  if(p.precio <> 0)then begin
    readln(p.codigoproducto);
    readln(p.codigorubro);
  end;
end;

procedure insertarordenado(var L: lista; p: productos);
var
  nue, act, ant: lista;
begin
  new(nue);
  act:= L;
  ant:= L;
  while(act <> nil) and (p.codigorubro > act^.dato.codigorubro)do begin
    ant:= act;
    act:= act^.sig;
  end;
  if(ant = act)then
    L:= nue
  else
    ant^.sig:= nue;
  nue^.sig:= act
end;

procedure cargarvector(var v1: vector1);
var
  p: productos;
begin
  leerproducto(p);
  while(p.precio <> 0)do begin
    insertarordenado(v1[p.codigorubro], p);
    leerproducto(p);
  end; 
end;     

procedure informarcodes(v1:vector1);
var
  i: integer;
begin
  for i:= 1 to 8 do begin
    while(v1[i] <> nil)do begin
      writeln(v1[i]^.dato.codigoproducto);
      v1[i]:= v1[i]^.sig;
    end;
  end;
end; 

procedure cargarvector(var v2: vector2; var diml: integer; v1: vector1);  
begin
  diml:= 0;
  while(v1[3] <> nil) or (diml < dimf)do begin
    diml:= diml + 1;
    v2[diml]:= v1[3]^.dato;
    v1[3]:= v1[3]^.sig;
  end;
end;

procedure insercion(var v2: vector2; var diml: integer);
var
  i, j: integer;
  actual: productos;
begin
  for i:= 2 to diml do begin
    actual:= v2[i];
    j:= i-1;
    while(j > 0) and (v2[j].precio > actual.precio) do begin
      v2[j+1]:= v2[j];
      j:= j-1; 
    end;
    v2[j+1]:= actual;
  end;  
end;

procedure informarvector2(v2: vector2; diml: integer);
var
  i: integer;
begin
  for i:= 1 to diml do 
    writeln(v2[i].precio);
end;

function promedio(v2: vector2; diml: integer): real;
var
  suma: real;
  i: integer;
begin
  suma:= 0;
  for i:= 1 to diml do begin
    suma:= suma + v2[i].precio;
  end;
  promedio:= (suma/diml);  
end;

var
  v1: vector1;
  L: lista;
  v2: vector2;
  diml: integer;
begin
  cargarvector(v1);
  L:= nil;
  informarcodes(v1);
  cargarvector(v2, diml, v1);
  insercion(v2, diml);
  informarvector2(v2, diml);
  writeln('el promedio de los precios es: ', promedio(v2, diml));
end.
