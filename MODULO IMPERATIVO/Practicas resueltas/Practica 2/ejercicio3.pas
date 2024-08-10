{Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.}

program ejercicio3;
type 
    lista = ^nodo;
    nodo = record
        dato: integer;
        sig: lista;
    end;

procedure agregarAdelante(var l: lista; num: integer);
var
    aux: lista;
begin
    new(aux);
    aux^.dato := num;
    aux^.sig := l;
    l := aux;
end;

procedure crearLista(var l: lista);
var
    num: integer;
begin
    num := random(99) + 1;
    if (num <> 0) then begin
        agregarAdelante(l, num);
        crearLista(l);
    end;
end;

function minimo(l: lista; min: integer): integer;
begin
    if (l = nil) then
        minimo := min
    else
        if (l^.dato < min) then
            min := l^.dato;
    minimo := minimo(l^.sig, min);
end;

function maximo(l: lista; max: integer): integer;
begin
    if (l = nil) then
        maximo := max
    else
        if (l^.dato > max) then
            max := l^.dato;
    maximo := maximo(l^.sig, max);
end;

function buscar(l: lista; num: integer): boolean;
begin
    if (l = nil) then
        buscar := false
    else
        if (l^.dato = num) then
            buscar := true
        else
            buscar := buscar(l^.sig, num);
end;

var 
    l: lista;
    min, max, num: integer;
begin
    randomize;
    l := nil;
    crearLista(l);
    min := minimo(l, 9999);
    max := maximo(l, -9999);
    write('Ingrese un numero para buscar en la lista: ');
    readln(num);
    if (buscar(l, num)) then
        writeln('El numero ', num, ' se encuentra en la lista.')
    else
        writeln('El numero ', num, ' no se encuentra en la lista.');
end.