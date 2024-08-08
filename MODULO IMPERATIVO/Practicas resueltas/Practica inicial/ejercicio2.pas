{Implementar un programa que procese información de propiedades que están a la venta 
en una inmobiliaria.  Se pide: a)  Implementar  un  módulo  para  almacenar  en  una  estructura  adecuada,  las  propiedades 
agrupadas por zona. Las propiedades de una misma zona deben quedar almacenadas 
ordenadas por tipo de propiedad. Para cada propiedad debe almacenarse el código, el tipo de 
propiedad y el precio total. De cada propiedad se lee: zona (1 a 5), código de propiedad, tipo 
de  propiedad,  cantidad  de  metros  cuadrados  y  precio  del  metro  cuadrado.  La  lectura  finaliza 
cuando se ingresa el precio del metro cuadrado -1. b)  Implementar  un  módulo  que  reciba  la  estructura  generada  en  a),  un  número  de  zona  y  un  tipo  de 
propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido.}

program ejercicio1;
type 
    propiedad = record
        zona: zRango;
        codigo: integer;
        tipo: string;
        metrosCuadrados: integer;
        precioMetroCuadrado: real;
    end;

    propiedadGod = record 
        codigo: integer;
        tipo: string;
        precioTotal: real;
    end;

    lista = ^nodo;
    nodo = record
        dato: propiedad;
        sig: lista;
    end;

    vector = array [1..5] of lista;

procedure inicializarVector(var v: vector);
var
    i: integer;
begin
    for i := 1 to 5 do
        v[i] := nil;
end;

procedure leerPropiedad(var p: propiedad);
begin
    writeln('Ingrese el precio del metro cuadrado');
    readln(p.precioMetroCuadrado);
    if (p.precioMetroCuadrado <> -1) then begin
        writeln('Ingrese el codigo de la propiedad');
        readln(p.codigo);
        writeln('Ingrese el tipo de propiedad');
        readln(p.tipo);
        writeln('Ingrese la cantidad de metros cuadrados');
        readln(p.metrosCuadrados);
        writeln('Ingrese la zona de la propiedad');
        readln(p.zona);
    end;
end;

procedure cargarRegistro(var pGod: propiedadGod; p: propiedad);
begin
    pGod.codigo := p.codigo;
    pGod.tipo := p.tipo;
    pGod.precioTotal := p.metrosCuadrados * p.precioMetroCuadrado;
end;

procedure insertarOrdenado(var l: lista; pGod: propiedadGod);
var
    ant, act, nue: lista;
begin
    new(nue);
    nue^.dato := pGod;
    act := l;
    while (act <> nil) and (act^.dato.tipo < pGod.tipo) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act = ant) then
        l := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;

procedure cargarLista(var v: vector);
var
    p: propiedad;
    pGod: propiedadGod;
begin
    leerPropiedad(p);
    cargarRegistro(pGod, p);
    while (p.precioMetroCuadrado <> -1) do begin
        agregarAdelante(v[p.zona], pGod);
        leerPropiedad(p);
        cargarRegistro(pGod, p);
    end;
end;

procedure procesar(v: vector; zona: zRango; tipo: string);
var
    aux: lista;
begin
    aux := v[zona];
    while (aux <> nil) do begin
        if (aux^.dato.tipo = tipo) then
            writeln('Codigo de la propiedad: ', aux^.dato.codigo);
        aux := aux^.sig;
    end;
end;

var
    v: vector;
    zona: zRango;
    tipo: string;
begin
    inicializarVector(v);
    cargarLista(v);
    writeln('Ingrese la zona a buscar');
    readln(zona);
    writeln('Ingrese el tipo de propiedad a buscar');
    readln(tipo);
    procesar(v, zona, tipo);
end.