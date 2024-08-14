{Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
reclamos efectuados por ese DNI.
c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
los reclamos realizados en el año recibido.}

program ejercicio4;
type 
    reclamo = record 
        codigo: integer;
        dni: integer;
        anio: integer;
        tipo: string;
    end; 

    listaReclamos = ^nodoLista;
    nodoLista = record 
        dato: reclamo;
        sig: listaReclamos;
    end;

    data = record 
        dni: integer;
        lista: listaReclamos;
        cant: integer;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record 
        dato: data;
        HI: arbol;
        HD: arbol;
    end;

procedure leerReclamo(var r: reclamo);
begin
    writeln('Ingrese el codigo del reclamo');
    readln(r.codigo);
    if (r.codigo <> -1) then begin
        writeln('Ingrese el DNI de la persona');
        readln(r.dni);
        writeln('Ingrese el anio del reclamo');
        readln(r.anio);
        writeln('Ingrese el tipo de reclamo');
        readln(r.tipo);
    end;
end;

procedure agregarAdelante(var l: listaReclamos; r: reclamo);    
var 
    nue: listaReclamos;
begin
    new(nue);
    nue^.dato := r;
    nue^.sig := l;
    l := nue;
end;

procedure insertarReclamo(var a: arbol; r: reclamo);
var 
    d: data;
begin 
    if (a = nil) then begin 
        new(a);
        d.dni := r.DNI;
        d.lista := nil;
        d.cant := 1;
        a^.dato := d;
        agregarAdelante(a^.dato.lista, r);
        a^.HI := nil;
        a^.HD := nil
    end 
    else begin 
        if (a^.dato.dni = r.dni) then begin 
            agregarAdelante(a^.dato.lista, r);
            a^.dato.cant := a^.dato.cant + 1;
        end
        else begin 
            if (r.dni <= a^.dato.dni) then 
                insertarReclamo(a^.HI, r)
            else 
                insertarReclamo(a^.HD, r);
        end;
    end;
end;

procedure cargarArbol(var a: arbol);
var 
    r: reclamo;
begin
    leerReclamo(r);
    if (r.codigo <> -1) then begin 
        insertarReclamo(a, r);
        cargarArbol(a);
    end;
end;

{b}
function cantReclamos(a: arbol; dni: integer): integer;
begin 
    if (a = nil) then 
        cantReclamos := 0
    else begin 
        if (a^.dato.dni = dni) then 
            cantReclamos := a^.dato.cant
        else begin 
            if (a^.dato.dni < dni) then 
                cantReclamos := cantReclamos(a^.HD, dni)
            else 
                cantReclamos := cantReclamos(a^.HI, dni);
        end;
    end;
end;

{c}
procedure cantreclamosbetween(a: arbol; denei1, denei2: integer; var cant2: integer);
begin
    if(a <> nil)then 
        if(denei1 < a^.dato.DNI)then begin
            if(denei2 > a^.dato.DNI)then begin
                cant2:= cant2 + a^.dato.cant;
                cantreclamosbetween(a^.HD, denei1, denei2, cant2);
                cantreclamosbetween(a^.HI, denei1, denei2, cant2)
            end
            else
                cantreclamosbetween(a^.HD, denei1, denei2, cant2)
        end
        else
            cantreclamosbetween(a^.HI, denei1, denei2, cant2);
end;

{d}
procedure recorrerLista(l: listaReclamos; anio: integer);
begin
    if(l <> nil)then begin
        if(l^.dato.anio = anio)then
            writeln('El codigo del reclamo es: ', l^.dato.codigo);
        recorrerLista(l^.sig, anio);
    end;
end;

procedure reclamosAnio(a: arbol; anio: integer);
begin
    if(a <> nil)then begin
        reclamosAnio(a^.HI, anio);
        recorrerLista(a^.dato.lista, anio);
        reclamosAnio(a^.HD, anio);
    end;
end;

var 
    a: arbol;
    dni, dni1, dni2, cant, anio: integer;
begin
    a := nil;
    cargarArbol(a);
    writeln('Ingrese el DNI para saber la cantidad de reclamos');
    readln(dni);
    writeln('La cantidad de reclamos es: ', cantReclamos(a, dni));
    writeln('Ingrese dos DNI para saber la cantidad de reclamos entre ellos');
    readln(dni1);
    readln(dni2);
    cant := 0;
    cantreclamosbetween(a, dni1, dni2, cant);
    writeln('La cantidad de reclamos entre los dos DNI es: ', cant);
    writeln('Ingrese el anio para saber los codigos de los reclamos');
    readln(anio);
    reclamosAnio(a, anio);
end.