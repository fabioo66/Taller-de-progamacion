{Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1. b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).}

program ejercicio3;
type 
    gRango = 1..8;

    pelicula = record
        codigo: integer;
        genero: gRango;
        puntaje: real;
    end;

    lista = ^nodo;
    nodo = record
        dato: pelicula;
        sig: lista;
    end;

    vector = array [gRango] of lista;
    vectorContador = array [gRango] of integer;

procedure inicializarListas(var v: vector);
var
    i: integer;
begin
    for i := 1 to 8 do
        v[i] := nil;
end;

procedure inicializarVectorContador(var v: vectorContador);
var
    i: integer;
begin
    for i := 1 to 8 do
        v[i] := 0;
end;

procedure leerPelicula(var p: pelicula);
begin
    writeln('Ingrese el codigo de la pelicula');
    readln(p.codigo);
    if (p.codigo <> -1) then begin
        writeln('Ingrese el codigo de genero');
        readln(p.genero);
        writeln('Ingrese el puntaje promedio');
        readln(p.puntaje);
    end;
end;

procedure agregarAtras(var pri, ult: lista; p: pelicula);
var
    aux: lista;
begin
    new(aux);
    aux^.dato := p;
    aux^.sig := nil;
    if (pri = nil) then
        pri := aux
    else
        ult^.sig := aux;
    ult := aux;
end;

procedure cargarVector(var v: vector);
var
    p: pelicula;
    pri, ult: lista;
begin
    leerPelicula(p);
    while (p.codigo <> -1) do begin
        agregarAtras(v[p.genero], ult, p);
        leerPelicula(p);
    end;
end;

procedure maximoPuntaje(var v: vector; var vc: vectorContador);
var
    i: integer;
    max: real;
    actual: lista;
begin
    for i := 1 to 8 do begin
        actual := v[i];
        max := -1;
        while (actual <> nil) do begin
            if (actual^.dato.puntaje > max) then begin
                max := actual^.dato.puntaje;
                vc[i] := actual^.dato.codigo;
            end;
            actual := actual^.sig;
        end;
    end;
end;

procedure ordenarVector(var vc: vectorContador);
var
    i, j, posMenor, actual: integer;
begin
    for i := 1 to 7 do begin
        posMenor := i;
        for j := i + 1 to 8 do begin
            if (vc[j] < vc[posMenor]) then
                posMenor := j;
        end;
        actual := vc[i];
        vc[i] := vc[posMenor];
        vc[posMenor] := actual;
    end;
end;

var 
    v: vector;
    vc: vectorContador;
begin
    inicializarListas(v);
    inicializarVectorContador(vc);
    cargarVector(v);
    maximoPuntaje(v, vc);
    ordenarVector(vc);
    writeln('El codigo de la pelicula con mayor puntaje es: ', vc[8]);
    writeln('El codigo de la pelicula con menor puntaje es: ', vc[1]);
end.