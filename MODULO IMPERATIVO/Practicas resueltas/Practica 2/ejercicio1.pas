{Implementar un programa que invoque a los siguientes módulos.
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
    dimF = 10;
type
    vector = array [1..dimF] of char;

    lista = ^nodo;
    nodo = record
        dato: char;
        sig: lista;
    end;

{a}
procedure leerVector(var v: vector; var dimL: integer);
var 
    c: char;
begin
    writeln('Ingrese un caracter');
    readln(c)
    if (diml < dimf) and (c <> '.') then begin
        diml := diml + 1;
        v[diml] := c;
        leerVector(v, diml);
    end;
end;

{b}
procedure imprimirVector(v: vector; dimL: integer);
var
    i: integer;
begin
    for i := 1 to dimL do
        write(v[i], ' ');
end;

{c}
procedure imprimirVectorRec(v: vector; dimL: integer);
begin
    if (dimL > 0) then begin
        write(v[dimL], ' ');
        imprimirVectorRec(v, dimL-1);
    end;
end;    

{d}
function cantidadCaracteres(): integer;
var
    c: char;
begin
    writeln('Ingrese un caracter');
    readln(c);
    if (c <> '.') then
        cantidadCaracteres := 1 + cantidadCaracteres()
    else
        cantidadCaracteres := 0;
end;

procedure agregarAdelante(var l: lista; c: char);
var
    nuevo: lista;
begin
    new(nuevo);
    nuevo^.dato := c;
    nuevo^.sig := l;
    l := nuevo;
end;

{e}
procedure crearLista(var l: lista);
var
    c: char;
begin
    writeln('Ingrese un caracter');
    readln(c);
    if (c <> '.') then begin
        agregarAdelante(l, c);
        crearLista(l);
end;

{f}
procedure imprimirLista(l: lista);
begin   
    if (l <> nil) then begin
        write(l^.dato, ' ');
        imprimirLista(l^.sig);
    end;
end;

{g}
procedure imprimirListaInversa(l: lista);
begin
    if (l <> nil) then begin
        imprimirListaInversa(l^.sig);
        write(l^.dato, ' ');
    end;
end;

var
    v: vector;
    dimL: integer;
    l: lista;  
begin
    dimL := 0;
    l := nil;
    leerVector(v, dimL);
    imprimirVector(v, dimL);
    imprimirVectorRec(v, dimL);
    writeln('La cantidad de caracteres leidos es: ', cantidadCaracteres());
    crearLista(l);
    imprimirLista(l);
    imprimirListaInversa(l);
end.