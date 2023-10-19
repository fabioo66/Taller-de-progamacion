{1.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto, los
almacene en un vector con dimensión física igual a 10 y retorne el vector.
b. Un módulo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector..
d. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.
e. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne una lista con los caracteres leídos.
f. Un módulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en el
mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en e) e imprima los valores de
la lista en orden inverso al que están almacenados.}

program ejercicio1;
const
  dimf = 10;
type
  vector = array[1..dimf]of char;
  
  lista = ^nodo;
  nodo = record
    dato: char;
    sig: lista;
  end;
  
procedure leercaracteres(var v:vector; var diml:integer);
var
  c: char;
begin
    diml:= diml + 1;
    readln(c);
    if(diml < dimf)then 
      v[diml]:= c;
    if(c <> '.') then 
      leercaracteres(v, diml);
end;  
{b}procedure imprimirvector(v: vector; diml:integer);
var
  i: integer;
begin
  for i:= 1 to diml do
    writeln(v[i])
end;  

{c}procedure recursivamente(v: vector; diml: integer);
begin
  if(diml > 0) then begin
    writeln(v[diml]);
    recursivamente(v,diml-1);
  end;
end;

procedure leerchar(var cant:integer);
var
  c: char;
begin
  readln(c);
  if (c <> '.') then begin
    cant:= cant + 1;
    leerchar(cant);
  end;  
end;

procedure agregaradelante(var L:lista; c:char);
var 
  nue: lista;
begin
  new(nue);
  nue^.dato:= c;
  nue^.sig:= L;
  L:= nue;
end;

procedure cargarlista(var L: lista);
var
  c: char;
begin
  readln(c);
  if(c <> '.')then begin
    agregaradelante(L,c);
    cargarlista(L);
  end;
end;   

procedure imprimirlista1(L: lista);
begin
  if(L <> nil) do begin
    imprimirlista1(L^.sig);
    writeln(L^.dato);
  end;
end;
   
procedure imprimirlista2(L: lista);
begin
  if(L <> nil) do begin
    writeln(L^.dato);
    imprimirlista2(L^.sig);
  end;
end;
    
var
  L: lista;
  diml:integer;
  v:vector;
  cant:integer;
begin
  diml:= 0;
  leercaracteres(v, diml);
  imprimirvector(v, diml);
  recursivamente(v, diml);
  cant:= 0;
  leerchar(cant);
  writeln(cant);
  cargarlista(L);
  imprimirlista1(L);
  imprimirlista2(L);
end.
