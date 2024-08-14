{Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
h. Un módulo recursivo que reciba la estructura generada en h. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).}

program ejercicio2;
type
    prestamo = record
        ISBN: integer;
        numSocio: integer;
        dia: integer;
        mes: integer;
        cantDias: integer;
    end;

    lista = ^nodoLista;
    nodoLista = record
        dato: prestamo;
        sig: lista;
    end;

    data = record
        ISBN: integer;
        lista: lista;
    end;

    arbolPrestamos = ^nodoArbolPrestamos;
    nodoArbolPrestamos = record
        dato: prestamo;
        HI: arbolPrestamos;
        HD: arbolPrestamos;
    end;

    arbolListas = ^nodoArbolListas;
    nodoArbolListas = record
        dato: data;
        HI: arbolListas;
        HD: arbolListas;
    end;

    reg = record
        ISBN: integer;
        cant: integer;
    end;

    lista2 = ^nodoLista2;
    nodoLista2 = record
        dato: reg;
        sig: lista2;
    end;

procedure leerPrestamo(var p: prestamo);
begin
    writeln('Ingrese el ISBN del libro');
    readln(p.ISBN);
    if (p.ISBN <> -1) then begin
        writeln('Ingrese el numero de socio');
        readln(p.numSocio);
        writeln('Ingrese el dia del prestamo');
        readln(p.dia);
        writeln('Ingrese el mes del prestamo');
        readln(p.mes);
        writeln('Ingrese la cantidad de dias prestados');
        readln(p.cantDias);
    end;
end;

procedure agregarAdelante(var l: lista; p: prestamo);
var
    aux: lista;
begin
    new(aux);
    aux^.dato:= p;
    aux^.sig:= l;
    l:= aux;
end;

procedure insertarArbolPrestamos(var a: arbolPrestamos; p: prestamo);
begin
    if (a = nil) then begin
        new(a);
        a^.dato:= p;
        a^.HI:= nil;
        a^.HD:= nil;
    end
    else if (p.ISBN < a^.dato.ISBN) then
        insertarArbolPrestamos(a^.HI, p)
    else
        insertarArbolPrestamos(a^.HD, p);
end;

procedure sumarprestamo(var a2:arbol2; d:data; p:prestamo);
begin  
    if (a2 = nil) then begin
        d.lista:= nil;
        new(a2);
        a2^.dato:= d;
        agregaradelante(a2^.dato.lista, p);
        a2^.HI:= nil;
        a2^.HD:= nil;
    end
    else if (a2^.dato.ISBN = d.ISBN) then
        agregaradelante(a2^.dato.lista, p)
    else if (p.ISBN < a2^.dato.ISBN) then
        sumarprestamo(a2^.HI, d, p)
    else
        sumarprestamo(a2^.HD, d, p);
end;

procedure cargarArboles(var a1: arbolPrestamos; var a2: arbolListas);
var
    p: prestamo;
    d: data;
begin
    leerPrestamo(p);
    if (p.ISBN <> -1) then begin
        insertarArbolPrestamos(a1, p);

        d.ISBN:= p.ISBN;
        sumarprestamo(a2, d, p);

        cargarArboles(a1, a2);
    end;
end;

{b}
function ISBNmasGrande(a: arbolPrestamos): integer;
begin
    if (a^.HD = nil) then
        ISBNmasGrande:= a^.dato.ISBN
    else
        ISBNmasGrande:= ISBNmasGrande(a^.HD);
end;

{c}
function ISBNmasChico(a: arbolListas): integer;
begin
    if (a^.HI = nil) then
        ISBNmasChico:= a^.dato.ISBN
    else
        ISBNmasChico:= ISBNmasChico(a^.HI);
end;

{d}
function cantidadPrestamosSocio(a: arbolPrestamos; numSocio: integer): integer;
begin
    if (a = nil) then
        cantidadPrestamosSocio:= 0
    else if (a^.dato.numSocio = numSocio) then
        cantidadPrestamosSocio:= 1 + cantidadPrestamosSocio(a^.HI, numSocio) + cantidadPrestamosSocio(a^.HD, numSocio)
    else
        cantidadPrestamosSocio:= cantidadPrestamosSocio(a^.HI, numSocio) + cantidadPrestamosSocio(a^.HD, numSocio);
end;

{e}
procedure devolverCantidadPrestamos(l: lista; numSocio: integer; var cant: integer);
begin
    while (l <> nil) then begin
        if (l^.dato.numSocio = numSocio) then
            cant:= cant + 1;
        l:= l^.sig;
    end;
end;

{e}
procedure cantidadPrestamosSocio2(a: arbolListas; numSocio: integer; var cant: integer);
begin
    if (a <> nil) then begin
        cantidadPrestamosSocio2(a^.HI, numSocio, cant);
        devolverCantidadPrestamos(a^.dato.lista, numSocio, cant);
        cantidadPrestamosSocio2(a^.HD, numSocio, cant);
    end;
end;

{f}
procedure insertarOrdenado(var l: lista2; r: reg);
var
    ant, act, aux: lista2;
begin
    new(aux);
    aux^.dato:= r;
    act:= l;
    ant:= l;
    while (act <> nil) and (act^.dato.ISBN < r.ISBN) do begin
        ant:= act;
        act:= act^.sig;
    end;
    if (ant = act) then
        l:= aux
    else
        ant^.sig:= aux;
    aux^.sig:= act;
end;

{f}
procedure cargarlista(a: arbolPrestamos; var L:lista2);
var
    r: reg;
begin
    if (a <> nil) then begin
        cargarlista(a^.HI,L);
        if (a^.dato.ISBN = l^.dato.ISBN) then 	
            l^.dato.cant:= l^.dato.cant + 1
        else begin
            r.ISBN := a^.dato.ISBN;
            r.cant := 1;
            insertarOrdenado(l, r);
        end;
        cargarlista(a^.HD,L);
    end;
end;

{g}
function recorrerlista(l: lista):integer;
var
    cant:integer;
begin
    cant:= 0;
    while (L <> nil) do begin
        cant:= cant + 1;
        L:= L^.sig;
    end;
    recorrerlista:= cant;
end;

{g}
procedure cargarlista2(a: arbolListas; var l: lista2);
var
    r: reg;
begin
    if (a <> nil) then begin
        cargarlista2(a^.HI, l);
        r.ISBN := a^.dato.ISBN;
        r.cant := recorrerlista(a^.dato.lista);
        insertarOrdenado(L, r);
        cargarLista(a^.HD, l);
    end;
end;

{h}
procedure imprimirLista2(l: lista2);
begin
    if (l <> nil) then begin
        writeln('ISBN: ', l^.dato.ISBN);
        writeln('Cantidad de veces prestado: ', l^.dato.cant);
        imprimirLista2(l^.sig);
    end;
end;

{i}
function cantidadEntreISBN(a: arbolPrestamos; min, max: integer): integer;
begin
    if (a = nil) then
        cantidadEntreISBN:= 0
    else if (a^.dato.ISBN >= min) and (a^.dato.ISBN <= max) then
        cantidadEntreISBN:= 1 + cantidadEntreISBN(a^.HI, min, max) + cantidadEntreISBN(a^.HD, min, max)
    else
        cantidadEntreISBN:= cantidadEntreISBN(a^.HI, min, max) + cantidadEntreISBN(a^.HD, min, max);
end;

{j}
function cantidadEntreISBN2(a: arbolListas; min, max: integer): integer;
begin
    if (a = nil) then
        cantidadEntreISBN2:= 0
    else if (a^.dato.ISBN >= min) and (a^.dato.ISBN <= max) then
        cantidadEntreISBN2:= recorrerlista(a^.dato.lista) + cantidadEntreISBN2(a^.HI, min, max) + cantidadEntreISBN2(a^.HD, min, max)
    else
        cantidadEntreISBN2:= cantidadEntreISBN2(a^.HI, min, max) + cantidadEntreISBN2(a^.HD, min, max);
end;

var
    a1: arbolPrestamos;
    a2: arbolListas;
    min, max, numSocio: integer;
    cant: integer;
    l: lista2;
begin
    a1:= nil;
    a2:= nil;
    cargarArboles(a1, a2);

    writeln('ISBN mas grande: ', ISBNmasGrande(a1));
    writeln('ISBN mas chico: ', ISBNmasChico(a2));

    writeln('Ingrese un numero de socio');
    readln(numSocio);
    writeln('Cantidad de prestamos realizados al socio: ', cantidadPrestamosSocio(a1, numSocio));
    cantidadPrestamosSocio2(a2, numSocio, cant);
    writeln('Cantidad de prestamos realizados al socio: ', cant);

    cargarlista(a1, l);
    imprimirLista2(l);

    cargarlista2(a2, l);
    imprimirLista2(l);

    writeln('Ingrese un ISBN minimo');
    readln(min);
    writeln('Ingrese un ISBN maximo');
    readln(max);
    writeln('Cantidad de prestamos entre los ISBN: ', cantidadEntreISBN(a1, min, max));
    writeln('Cantidad de prestamos entre los ISBN: ', cantidadEntreISBN2(a2, min, max));
end.
