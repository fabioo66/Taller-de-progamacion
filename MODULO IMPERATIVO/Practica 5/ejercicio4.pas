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

program ejercicio4prac5;
type
  reclamo = record
    codigo: integer;
    DNI: integer;
    anio: integer;
    tipo: string;
  end;
  
  listareclamos = ^nodoreclamos;
  nodoreclamos = record
    dato: reclamo;
    sig: listareclamos;
  end;
  
  hoja = record
    DNI: integer;
    lista: listareclamos;
    cant: integer;
  end;
  
  arbol = ^nodo;
  nodo = record
    dato: hoja;
    HI: arbol;
    HD: arbol;
  end;
  
  listacodigos = ^nodocodigos;
  nodocodigos = record
    dato: integer;
    sig: listacodigos;
  end;

procedure leerreclamo(var r: reclamo);
begin
  writeln('Ingrese el codigo de reclamo');
  readln(r.codigo);
  if(r.codigo <> -1)then begin
    writeln('Ingrese el DNI de la persona');
    readln(r.DNI);
    writeln('Ingrese el año');
    readln(r.anio);
    writeln('Ingrese el tipo de reclamo');
    readln(r.tipo);
  end;
end;

procedure agregaradelante(var L: listareclamos; r:reclamo);
var
  nue: listareclamos;
begin
  new(nue);
  nue^.dato:= r;
  nue^.sig:= L;
  L:= nue;
end;

procedure agregarelemento(var a: arbol; r: reclamo);
var
  h: hoja;
begin
  if(a = nil)then begin
    new(a);
    h.DNI:= r.DNI;
    h.lista:= nil;
    h.cant:= 1;
    a^.dato:= h;
    agregaradelante(a^.dato.lista, r);
    a^.HI:= nil;
    a^.HD:= nil
  end
  else if(r.DNI = a^.dato.DNI)then begin
    agregaradelante(a^.dato.lista, r);
    a^.dato.cant:= a^.dato.cant + 1
  end
    else if(h.DNI < a^.dato.DNI)then
      agregarelemento(a^.HI, r)
    else
      agregarelemento(a^.HD, r);
end;

procedure cargararbol(var a:arbol);
var
  r: reclamo;
begin
  leerreclamo(r);
  if(r.codigo <> -1)then begin
    agregarelemento(a, r);
    cargararbol(a);
  end;
end;

{b}procedure cantreclamos(a: arbol; DNI: integer; var cant: integer);
begin
  if(a <> nil)then
    if(DNI = a^.dato.DNI)then
      cant:= a^.dato.cant
    else if(DNI < a^.dato.DNI)then
      cantreclamos(a^.HI, DNI, cant)
    else
      cantreclamos(a^.HD, DNI, cant);
end;

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

{d}procedure agregaradelante(var L: listacodigos; c: integer);
var
  nue: listacodigos;
begin
  new(nue);
  nue^.dato:= c;
  nue^.sig:= L;
  L:= nue;
end;


{d}procedure recorrerlista(L:listareclamos; anio: integer; var L2: listacodigos);

begin
  while(L <> nil)do begin
    if(anio = L^.dato.anio)then
      agregaradelante(L2, L^.dato.codigo);
    L:= L^.sig;
  end;
end;

{d}procedure recorrerarbol(a: arbol; anio: integer; var L2:listacodigos); 
begin
  if(a <> nil)then begin
    recorrerarbol(a^.HD, anio, L2);
    recorrerlista(a^.dato.lista, anio, L2);
    recorrerarbol(a^.HI, anio, L2);
  end;
end;

{d}procedure recorrerlista(L2: listacodigos);
begin
  while(L2 <> nil)do begin
    writeln(L2^.dato, '  ');
    L2:= L2^.sig;
  end;
end;

var
  a:arbol;
  cant, DNI, cant2, denei1, denei2, anio: integer;
  L2: listacodigos;
begin
  a:= nil;
  cargararbol(a);
  cant:= 0;
  writeln('Ingrese un DNI para chequear la cantidad de reclamos que realizo esa persona');
  readln(DNI);
  cantreclamos(a, DNI, cant);
  writeln('La cantidad de reclamos efectuados por esa persona es ', cant);
  cant:= 0;
  writeln('Ingrese dos DNI el primero menor que el otro para chequear la cantidad de reclamos entre los 2 dni');
  readln(denei1);
  readln(denei2);
  cantreclamosbetween(a, denei1, denei2, cant2);
  writeln('La cantidad de reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos es ', cant2);
  L2:= nil;
  writeln('Ingrese un anio');
  readln(anio);
  recorrerarbol(a, anio, L2);
  recorrerlista(L2);
end.
