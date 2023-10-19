program ejercicio2practica5;
type
  cadena20 = string[20];
  arango = 2010..2018;
  car = record
    patente:integer;
    anio:arango;
    marca:cadena20;
    modelo:cadena20;
  end;
  
  arbol = ^nodo;
  nodo = record
    dato:car;
    HI:arbol;
    HD:arbol;
  end;
    
  listaautos = ^nodoautos;
  nodoautos = record
    dato: car;
    sig: listaautos;
  end;
  
  carxbrand = record
    marca: string;
    lista: listaautos;
  end;
  
  arbol2 = ^nodo2;
  nodo2 = record
    dato: carxbrand;
    HI:arbol2;
    HD:arbol2;
  end;
  
  car2 = record
    marca: string;
    modelo: string;
    patente: integer;
    anio: arango;
  end;
  
  vector = array[arango] of listaautos;
  
{a}procedure leerauto(var c:car);
begin
  readln(c.patente);
  if (c.patente <> -1) then begin
    readln(c.anio);
    readln(c.marca);
    readln(c.modelo);
  end;
end;
  
{a}procedure agregarauto(var a:arbol; c:car);
begin
  if (a = nil) then begin
    new(a);
    a^.dato:= c;
    a^.HI:= nil;
    a^.HD:= nil;
  end
  else if (c.patente <= a^.dato.patente) then
    agregarauto(a^.HI,c)
  else
    agregarauto(a^.HD,c);
end;

{a.ii}procedure agregaradelante(var L:listaautos; c: car);
var
  nue: listaautos;
begin
  new(nue);
  nue^.dato:= c;
  nue^.sig:= L;
  L:= nue;
end;
 
{a.ii}procedure agregarmarca(var a2: arbol2; c: car);
var
  b: carxbrand;
begin
  if(a2 = nil)then begin
    new(a2);
    b.marca:= c.marca;
    b.lista:= nil;
    a2^.dato:= b;
    agregaradelante(a2^.dato.lista, c);
    a2^.HI:= nil;
    a2^.HD:= nil;
  end
  else if(b.marca = a2^.dato.marca)then
    agregaradelante(a2^.dato.lista, c)
    else if(b.marca < a2^.dato.marca)then 
      agregarmarca(a2^.HI, c)
    else
      agregarmarca(a2^.HD, c);
end;

{a}procedure cargararboles(var a:arbol; var a2: arbol2);
var
  c: car;
begin
  leerauto(c);
  if (c.patente <> -1) then begin
    agregarauto(a,c);
    
    agregarmarca(a2, c);
    
    cargararboles(a, a2);
  end;
end;

{b}procedure cantcarsamebrand(a: arbol; brand: string; var cant: integer);
begin
  if(a <> nil)then begin
    cantcarsamebrand(a, brand, cant);
    if(a^.dato.marca = brand)then
      cant:= cant + 1;
    cantcarsamebrand(a, brand, cant);
  end;
end;

{c}function recorrerlista(l: listaautos): integer;
var
  cant: integer;
begin
  cant:= 0;
  while(L <> nil)do begin
    cant:= cant + 1;
    L:= L^.sig;
  end;
  recorrerlista:= cant;
end;

{c}procedure cantcarsamebrand2(a2: arbol2; brand2: string; var cant2: integer);
begin
  if(a2 <> nil)then begin
    if(a2^.dato.marca = brand2)then
      cant2:= recorrerlista(a2^.dato.lista)
    else if(brand2 > a2^.dato.marca)then
      cantcarsamebrand2(a2^.HD,brand2,cant2)
    else
      cantcarsamebrand2(a2^.HI,brand2,cant2);  
  end;        
end;

{d}procedure inicializarvector(var v:vector);
var
  i:integer;
begin
  for i:= 2010 to 2018 do
    v[i]:= nil;
end;

{d}procedure nuevaestructura(a: arbol; var v: vector);
begin
  if(a <> nil)then begin
    nuevaestructura(a^.HI, v);
    agregaradelante(v[a^.dato.anio], a^.dato);
    nuevaestructura(a^.HD, v);
  end;
end;

{e}procedure buscarpatente(a: arbol; patente: integer; var modelo: string);
begin
  if(a <> nil)then begin
    if(a^.dato.patente = patente)then
      modelo:= a^.dato.modelo
    else if(patente > a^.dato.patente)then
      buscarpatente(a^.HD, patente, modelo)
    else
      buscarpatente(a^.HI, patente, modelo)
  end;
end;

{f}procedure recorrerlista(l: listaautos; patente2: integer; var modelo2: string; var encontre: boolean);
begin
  encontre:= false;
  while(L <> nil)and(encontre = false)do begin
    if(L^.dato.patente = patente2)then begin 
      modelo2:= L^.dato.modelo;
      encontre:= true;
    end;
    L:= L^.sig;
  end;
end;

{f}procedure recorrerarbol2(a2: arbol2; patente2: integer; var encontre: boolean);
var
  modelo2: string;
begin
  if(a2 <> nil)and(encontre = false)then begin
    recorrerarbol2(a2^.HI,patente2, encontre);
    recorrerlista(a2^.dato.lista, patente2, modelo2, encontre);
    if(encontre = true)then
      writeln('El modelo del auto de dicha patente es: ', modelo2);
    recorrerarbol2(a2^.HD,patente2, encontre)
  end
  else
    writeln('No se encontro un auto con esa misma patente');
end;

var
  a:arbol;
  a2: arbol2;
  cant, cant2, patente, patente2: integer;
  brand, brand2, modelo: string;
  v: vector; 
  encontre: boolean;
begin
  cargararboles(a, a2);
  writeln('Ingrese una marca para chequear la cantidad de autos de dicha marca que posee la agencia');
  readln(brand);
  cant:= 0;
  cantcarsamebrand(a, brand, cant);
  writeln('La cantidad de autos de dicha marca que posee la agencia es: ', cant);
  writeln('Ingrese una marca para chequear la cantidad de autos de dicha marca que posee la agencia');
  readln(brand2);
  cant2:= 0;
  cantcarsamebrand2(a2, brand2, cant2);
  writeln('La cantidad de autos de dicha marca que posee la agencia es: ', cant2);
  inicializarvector(v);
  nuevaestructura(a,v);
  writeln('Ingrese una patente para ver a que modelo de auto coincide');
  readln(patente);
  buscarpatente(a,patente,modelo);
  writeln('El modelo del auto que coincide con esa patente es: ', modelo);
  writeln('Ingrese una patente para ver a que modelo de auto coincide');
  readln(patente2);
  recorrerarbol2(a2,patente2, encontre);
end.
