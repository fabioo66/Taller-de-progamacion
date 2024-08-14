{Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la
información de los autos en venta. Implementar un programa que:
a) Lea la información de los autos (patente, año de fabricación (2010..2018), marca y
modelo) y los almacene en dos estructuras de datos:
i. Una estructura eficiente para la búsqueda por patente.
ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
almacenar todos juntos los autos pertenecientes a ella.
b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
cantidad de autos de dicha marca que posee la agencia.
c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
la cantidad de autos de dicha marca que posee la agencia.
d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
la información de los autos agrupados por año de fabricación.
e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
modelo del auto con dicha patente.
f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
modelo del auto con dicha patente.}

program ejercicio2;
type
    aRango = 2010..2018;

    auto = record 
        patente: string;
        anio: aRango;
        marca: string;
        modelo: string;
    end;

    arbolPatente = ^nodoPatente;
    nodoPatente = record 
        dato: auto;
        HI: arbolPatente;
        HD: arbolPatente;
    end;

    listaAutos = ^nodoAutos;
    nodoAutos = record 
        dato: auto;
        sig: listaAutos;
    end;

    data = record 
        marca: string;
        lista: listaAutos;
    end;

    arbolLista = ^nodoLista;
    nodoLista = record 
        dato: data;
        HI: arbolLista;
        HD: arbolLista;
    end;

    vector = array [aRango] of listaAutos;

procedure leerAuto(var a: auto);
begin
    writeln('Ingrese la patente del auto');
    readln(a.patente);
    if (a.patente <> 'zzz') then begin
        writeln('Ingrese el año de fabricacion del auto');
        readln(a.anio);
        writeln('Ingrese la marca del auto');
        readln(a.marca);
        writeln('Ingrese el modelo del auto');
        readln(a.modelo);
    end;
end;

procedure insertarPorPatente(var aP: arbolPatente; a: auto);
begin
    if (aP = nil) then begin
        new(aP);
        aP^.dato := a;
        aP^.HI := nil;
        aP^.HD := nil 
    end
    else if (a.patente <= aP^.dato.patente) then 
        insertarPorPatente(ap^.HI, a)
    else 
        insertarPorPatente(ap^.HD, a);
end;

procedure agregarAdelante(var l: listaAutos; a: auto);
var 
    nue: listaAutos;
begin
    new(nue);
    nue^.dato := a;
    nue^.sig := nil;
    l := nue;
end;

procedure insertarPorMarca(var aL: arbolLista; a: auto);
begin 
    if (aL = nil) then begin
        new(aL);
        aL^.dato.marca := a.marca;
        aL^.dato.lista := nil;
        agregarAdelante(aL^.dato.lista, a);
        aL^.HI := nil;
        aL^.HD := nil
    end 
    else if (aL^.dato.marca = a.marca) then
        agregarAdelante(aL^.dato.lista, a)
    else if (a.marca <= aL^.dato.marca) then 
        insertarPorMarca(aL^.HI, a)
    else 
        insertarPorMarca(aL^.HD, a);
end;

procedure cargarArboles(var aP: arbolPatente; var aL: arbolLista);
var
    a: auto;
begin
    leerAuto(a);
    if(a.patente <> 'zzz')then begin
        insertarPorPatente(aP, a);
        insertarPorMarca(aL, a);
        cargarArboles(aP, aL);
    end;  
end;

procedure cantAutosMarcaPorPatente(aP: arbolPatente; marca: string; var cant: integer);
begin
    if (aP <> nil) then begin
        cantAutosMarcaPorPatente(aP^.HI, marca, cant);
        cantAutosMarcaPorPatente(aP^.HD, marca, cant);
        if (aP^.dato.marca = marca) then 
            cant := cant + 1;
    end;
end;

function tamanioLista(l: listaAutos): integer;
var 
    suma: integer;
begin
    suma := 0;
    while (l <> nil) do begin
        suma := suma + 1;
        l := l^.sig;
    end;
    tamanioLista := suma;
end;

function cantAutosMarcaPorLista(aL: arbolLista; marca: string): integer;
begin
    if (aL = nil) then 
        cantAutosMarcaPorLista := 0
    else begin
        if (aL^.dato.marca = marca) then 
            cantAutosMarcaPorLista := tamanioLista(aL^.dato.lista)
        else begin
            if (aL^.dato.marca < marca) then 
                cantAutosMarcaPorLista := cantAutosMarcaPorLista(aL^.HD, marca)
            else 
                cantAutosMarcaPorLista := cantAutosMarcaPorLista(aL^.HI, marca);
        end;
    end;
end;

procedure inicializarVector(var v: vector);
var 
    i: aRango;
begin 
    for i := 2010 to 2018 do 
        v[i] := nil;
end;

procedure cargarVectorPorPatente(aP: arbolPatente; var v: vector);
begin
    if (aP <> nil) then begin
        agregarAdelante(v[aP^.dato.anio], aP^.dato); 
        cargarVectorPorPatente(aP^.HI, v);
        cargarVectorPorPatente(aP^.HD, v);
    end;
end;

procedure devolverModeloPatente(aP: arbolPatente; patente: string; var modelo: string);
begin
    if (aP <> nil) then begin
        if (patente = aP^.dato.patente) then 
            modelo := aP^.dato.modelo
        else begin
            if (aP^.dato.patente < patente) then 
                devolverModeloPatente(aP^.HD, patente, modelo)
            else 
                devolverModeloPatente(aP^.HI, patente, modelo);
        end; 
    end;
end;

procedure buscarPatente(l: listaAutos; patente: string; var encontre: boolean; var modelo: string);
begin
    while ((l <> nil) and (not encontre)) do begin
        if (patente = l^.dato.modelo) then begin 
            encontre := true;
            modelo := l^.dato.modelo 
        end
        else 
            l := l^.sig;
    end;
end;

procedure devolverModeloLista(aL: arbolLista; patente: string; var encontre: boolean; var modelo: string);
begin
    if ((aL <> nil) and (not encontre)) then begin
        buscarPatente(aL^.dato.lista, patente, encontre, modelo);
        devolverModeloLista(aL^.HI, patente, encontre, modelo);
        devolverModeloLista(aL^.HD, patente, encontre, modelo);
    end;
end; 

var 
    a: auto;
    aP: arbolPatente;
    aL: arbolLista;
    v: vector;
    marca: string;
    cant: integer;
    modelo: string;
    encontre: boolean;
begin
    aP := nil;
    aL := nil;
    cargarArboles(aP, aL);
    writeln('Ingrese la marca a buscar');
    readln(marca);
    cantAutosMarcaPorPatente(aP, marca, cant);
    writeln('La cantidad de autos de la marca ', marca, ' es: ', cant);
    writeln('Ingrese la marca a buscar');
    readln(marca);
    cant := cantAutosMarcaPorLista(aL, marca);
    writeln('La cantidad de autos de la marca ', marca, ' es: ', cant);
    inicializarVector(v);
    cargarVectorPorPatente(aP, v);
    writeln('Ingrese la patente a buscar');
    readln(a.patente);
    devolverModeloPatente(aP, a.patente, modelo);
    writeln('El modelo del auto con patente ', a.patente, ' es: ', modelo);
    writeln('Ingrese la patente a buscar');
    readln(a.patente);
    encontre := false;
    devolverModeloLista(aL, a.patente, encontre, modelo);
    if (encontre) then 
        writeln('El modelo del auto con patente ', a.patente, ' es: ', modelo)
    else 
        writeln('No se encontro el auto con patente ', a.patente);
end.