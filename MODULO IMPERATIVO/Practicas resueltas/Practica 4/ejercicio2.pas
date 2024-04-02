program ejercicio2clase3;
type
  info = record
    isbn:integer;
    cant:integer;
  end;
  
  listacant = ^nodocant;
  nodocant = record
    dato:info;
    sig:listacant;
  end;
  
  fecha= record
    dia: integer;
    mes: integer;
  end;
  prestamo = record
    ISBN: integer;
    numero: integer;
    diaymes: fecha;
    cantdias: integer;
  end;
  
  arbol = ^nodo;
  nodo = record
    dato: prestamo;
    HI: arbol;
    HD: arbol;
  end;
  
  Lista = ^nodolista;
  nodolista = record
    dato: prestamo;
    sig: lista;
  end;
  
  data = record
    ISBN: integer;
    lista: Lista; 
  end;
  
  arbol2 = ^nodo2;
  nodo2 = record
    dato: data;
    HI: arbol2;
    HD: arbol2;
  end;
  
procedure leerfecha(var f:fecha);
begin
  writeln('Ingrese el dia');
  readln(f.dia);
  writeln('ingrese el mes');
  readln(f.mes);
end;
  
procedure leerprestamo(var p: prestamo);
begin
  writeln('Ingrese el ISBN del libro');
  readln(p.ISBN);
  if(p.ISBN <> -1)then begin
    writeln('Ingrese el numero de socio');
    readln(p.numero);
    leerfecha(p.diaymes);
    writeln('Ingrese la cantidad de días prestados');
    readln(p.cantdias);
  end;
end;

procedure agregarprestamos(var a: arbol; p: prestamo);
begin
  if(a = nil)then begin
    new(a);
    a^.dato:= p;
    a^.HI:= nil;
    a^.HD:= nil;
  end
  else if(p.ISBN <= a^.dato.ISBN)then
    agregarprestamos(a^.HI, p)
  else
    agregarprestamos(a^.HD, p);
end;

procedure agregaradelante(var L:lista; p: prestamo);
var
  nue: lista;
begin
  new(nue);
  nue^.dato:= p;
  nue^.sig:= L;
  L:= nue;
end;

procedure sumarprestamo(var a2:arbol2; d:data; p:prestamo);
begin  
  if(a2 = nil)then begin
    d.lista:= nil;
    new(a2);
    a2^.dato:= d;
    agregaradelante(a2^.dato.lista, p);
    a2^.HI:= nil;
    a2^.HD:= nil;
  end
  else if(a2^.dato.ISBN = d.ISBN)then
    agregaradelante(a2^.dato.lista, p)
    else if(p.ISBN < a2^.dato.ISBN)then
      sumarprestamo(a2^.HI,d, p)
      else
        sumarprestamo(a2^.HD,d, p);
end;



procedure cargararbol(var a:arbol; var a2: arbol2);
var
  p: prestamo;
  d: data;
begin
  leerprestamo(p);
  if(p.ISBN <> -1)then begin
    agregarprestamos(a, p);
    
    d.ISBN:= p.ISBN; 
    sumarprestamo(a2, d, p);
    
    cargararbol(a, a2);
  end;    
end;



{b}function maximo(a: arbol): integer;
begin
  if(a <> nil)then
    if(a^.HD = nil)then
      maximo:= a^.dato.ISBN
    else
      maximo:= maximo(a^.HD)
  else
    maximo:= -1;    
end;

{c}function min(a2: arbol2): integer;
begin
  if(a2 <> nil)then
    if(a2^.HI = nil)then
      min:= a2^.dato.ISBN
    else
      min:= min(a2^.HI)
  else
    min:= 9999;
end;

{d}procedure cantprestamos(a:arbol; numsocio: integer; var cant: integer);
begin
  if(a <> nil) then begin
    cantprestamos(a^.HI, numsocio, cant);
    if(numsocio = a^.dato.numero)then
      cant:= cant + 1;
    cantprestamos(a^.HD, numsocio, cant);
  end;
end;

{e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.}

function contarlista(L: lista; numsocio2: integer): integer;
var
  cant: integer;
begin
  cant:= 0;
  while(L <> nil)do begin
    if(numsocio2 = L^.dato.numero)then 
      cant:= cant + 1;
    L:= L^.sig;
  end;
  contarlista:= cant;
end;

{e}procedure cantprestamos(a2: arbol2; numsocio2: integer; var cant2: integer);
begin
  if(a2 <> nil)then begin
    cantprestamos(a2^.HI, numsocio2, cant2);
    cant2:= cant2 + contarlista(a2^.dato.lista, numsocio2);
    cantprestamos(a2^.HD, numsocio2, cant2);
  end;   
end;

{f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.}

procedure agregarAtras(var L,ult:listacant; i:info);
var
  nue:listacant;
begin
  new(nue);
  nue^.dato:= i;
  nue^.sig:= nil;
  if (L = nil) then
    L:= nue
  else
    ult^.sig:= nue;
  ult:= nue;
end;

procedure cargarlista(a:arbol; var L:listacant);
var
  i:info;
  ult:listacant;
begin
  if (a <> nil) then begin
    cargarlista(a^.HI,L);
    if (a^.dato.isbn = L^.dato.isbn) then 	
      L^.dato.cant:= L^.dato.cant + 1
    else begin
      i.isbn:= a^.dato.isbn;
      i.cant:= 1;
      agregarAtras(L,ult,i);
    end;
    cargarlista(a^.HD,L);
  end;
end;

{procedure informarlista(L:lista);
begin
  while (L <> nil) do begin
    writeln('el isbn es : ' , L^.dato.isbn , ' y la cantidad que se presto es : ', L^.dato.cant);
    L:= L^.sig;
  end;
end;}

{g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.}

function recorrerlista(L:lista):integer;
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

procedure cargarlista2(a:arbol2; var L:listacant);
var
  i:info;
  ult:listacant;
begin
  if (a <> nil) then begin
    cargarlista2(a^.HI,L);
   
    i.isbn:= a^.dato.isbn;
    i.cant:= recorrerlista(a^.dato.lista);
    agregarAtras(L,ult,i);

    cargarlista2(a^.HD,L);
  end;
end;

{i}procedure prestamosbetween(a: arbol; code1, code2: integer; var cantp: integer);
begin
  if(a <> nil)then 
    if(code1 <= a^.dato.ISBN)then begin
      if(code2 >= a^.dato.ISBN)then begin
        cantp:= cantp + 1;
        prestamosbetween(a^.HI, code1, code2, cantp);
        prestamosbetween(a^.HD, code1, code2, cantp)
      end
      else
        prestamosbetween(a^.HI, code1, code2, cantp);
    end 
  else
    prestamosbetween(a^.HD, code1, code2, cantp);
end;

{j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).}

function recorrer(L: lista): integer;
var
  cant: integer;
begin
  cant:= 0;
  while(L <> nil)do begin
    cant:= cant + 1;
    L:= L^.sig;
  end;
  recorrer:= cant;
end;

{j}procedure prestamosbetween2(a2: arbol2; codigo1, codigo2: integer; var cantprestamos: integer);
begin
  if(a2 <> nil)then 
    if(codigo1 <= a2^.dato.ISBN)then begin
      if(codigo2 >= a2^.dato.ISBN)then begin
        cantprestamos:= cantprestamos + recorrer(a2^.dato.lista);
        prestamosbetween2(a2^.HI, codigo1, codigo2, cantprestamos);
        prestamosbetween2(a2^.HD, codigo1, codigo2, cantprestamos)
      end
      else
        prestamosbetween2(a2^.HI, codigo1, codigo2, cantprestamos);
    end 
  else
    prestamosbetween2(a2^.HD, codigo1, codigo2, cantprestamos);
end;

var
  L,L2:listacant;
  a:arbol;
  a2:arbol2;
  cant, numsocio, cantp, code1, code2, numsocio2, cant2, codigo1, codigo2, prestamoscant: integer;
begin
  a:= nil;
  a2:= nil;
  cargararbol(a,a2);
  writeln('EL ISBN mas grande es ', maximo(a));
  writeln('EL ISBN mas chico es ', min(a2));
  cargarlista(a,L);
  cargarlista2(a2,L2);
  cant:= 0;
  writeln('Ingrese un numero de socio para chequear la cantidad de prestamos realizados a dicho socio');
  readln(numsocio);
  cantprestamos(a, numsocio, cant);
  writeln('la cantidad de prestamos realizados a dicho socio ', cant);
  cant2:= 0;
  writeln('Ingrese un numero de socio para ver la cantidad de prestamos que realizo');
  readln(numsocio2);
  cantprestamos(a2,numsocio2,cant2);
  writeln('la cantidad de préstamos realizados a dicho socio es ', cant2);
  cantp:= 0; 
  writeln('Ingresar dos numeros el primero mayor que el otro separado de un enter');
  readln(code1);
  readln(code2);
  prestamosbetween(a, code1, code2, cantp);
  writeln('la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos es ', cantp);
  prestamoscant:= 0;
  writeln('Ingresar dos numeros el primero mayor que el otro separado de un enter');
  readln(codigo1);
  readln(codigo2);
  prestamosbetween2(a2, codigo1, codigo2, prestamoscant);
  writeln('la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos es ', prestamoscant);
end.
