program ejercicio2;
type
  zrango = 1..5;
  propiedad = record
    zona: zrango;
    codigo: integer;
    tipo: string;
    cantMetros: integer;
    precioXMetro: real;
  end;
  
  propiedadTotal = record
    codigo: integer;
    tipo: string;
    precioTotal: real;
  end;
  
  listaPropiedades = ^nodoPropiedades;
  nodoPropiedades = record
    dato: propiedadTotal;
    sig: listaPropiedades;
  end;
  
  vector = array[zrango] of listaPropiedades;
  
procedure leerPropiedad(var p: propiedad; var prop: propiedadTotal);
begin
  writeln('Ingrese el precio de los metros cuadrados');
  readln(p.precioXMetro);
  if(p.precioXMetro <> -1)then begin
    writeln('Ingrese la zona de la propiedad');
    readln(p.zona);
    writeln('Ingrese el codigo de la propiedad');
    readln(p.codigo);
    writeln('Ingrese el tipo de propiedad');
    readln(p.tipo);
    writeln('Ingrese la cantidad de metros cuadrados');
    readln(p.cantMetros);
    prop.codigo:= p.codigo;
    prop.tipo:= p.tipo;
    prop.precioTotal:= p.cantMetros * p.precioXMetro;
  end;
end;

procedure agregarPropiedad(var L: listaPropiedades; prop: propiedadTotal);
var
  nue,act,ant: listaPropiedades;
begin
  new(nue);
  nue^.dato:= prop;
  act:= L;
  ant:= L;
  while(L <> nil) and (prop.tipo > L^.dato.tipo)do begin
    ant:= act;
    act:= act^.sig;
  end;
  if(act = ant)then
    L:= nue
  else
    ant^.sig:= nue;
  nue^.sig:= act;
end;

procedure cargarPropiedades(var v: vector);
var
  p: propiedad;
  prop: propiedadTotal;
begin
  leerPropiedad(p, prop);
  while(p.precioXMetro <> -1)do begin
    agregarPropiedad(v[p.zona], prop);
    leerPropiedad(p,prop);
  end;
end; 

procedure cargarPropiedades(var v: vector);
var
  p: propiedad;
  prop: propiedadTotal;
begin
  leerPropiedad(p, prop);
  while(p.precioXMetro <> -1)do begin
    agregarPropiedad(v[p.zona], prop);
    leerPropiedad(p,prop);
  end;
end;    

procedure retornarCodigos(v: vector; numZona: integer; tipo: string);
begin
  while(v[numZona] <> nil)do begin
    if(v[numZona]^.dato.tipo = tipo)then
      writeln('La propiedad con codigo ', v[numZona]^.dato.codigo, ' es de la zona ', numZona, ' y del tipo ', tipo);
    v[numZona]:= v[numZona]^.sig;
  end;   
end;   
    
VAR
  v: vector;
  zona: integer;
  tipo: string; 
BEGIN
  inicializarListas(v);
  cargarPropiedades(v);
  writeln('Ingrese zona a buscar');
  readln(zona);
  writeln('Ingrese tipo a buscar');
  readln(tipo);
  retornarCodigos(v, zona, tipo);
END.

