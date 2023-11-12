program ejercicio3;
type
  grango = 1..8;
  pelicula = record
    codigoPelicula: integer;
    codigoGenero: grango;
    puntaje: real;
  end;
  
  listaPeliculas = ^nodoPeliculas;
  nodoPeliculas = record
    dato: pelicula;
    sig: listaPeliculas;
  end;
  
  puntajePromedio = record
    codigo: integer;
    puntaje: real;
  end;
  
  vector = array[grango] of listaPeliculas;
  vectorCodigos = array[grango] of puntajePromedio;
  
procedure leerPelicula(var p:pelicula);
begin
  writeln('Ingrese el codigo de la pelicula');
  readln(p.codigoPelicula);
  if(p.codigoPelicula <> -1)then begin
    writeln('Ingrese el codigo de genero de la pelicula');
    readln(p.codigoGenero);
    writeln('Ingrese el puntaje promedio');
    readln(p.puntaje);
  end;  
end;

procedure agregarAtras(var L, ult: listaPeliculas; p: pelicula);
var
  nue: listaPeliculas;
begin
  new(nue);
  nue^.dato:= p;
  nue^.sig:= nil;
  if(L = nil)then
    L:= nue
  else
    ult^.sig:= nue;
  ult:= nue;
end;

procedure cargarVector(var v:vector);
var
  p: pelicula;
  ult: listaPeliculas;
begin
  leerPelicula(p);
  while(p.codigoPelicula <> -1)do begin
    agregarAtras(v[p.codigoGenero], ult, p);
    leerPelicula(p);
  end;
end;

procedure inicializarListas(var v: vector);
var
  i: integer;
begin
  for i:= 1 to 8 do
    v[i]:= nil;
end;

procedure maximos(L: listaPeliculas; var max: real; maxCode: integer);
begin
  max:= -9999;
  while(L <> nil)do begin
    if(L^.dato.puntaje > max)then begin
      max:= L^.dato.puntaje;
      maxCode:= L^.dato.codigoPelicula;
    end;
    L:= L^.sig;
  end;  
end;

procedure procesar(v:vector; var v2: vectorCodigos; var maxCode: integer);
var
  i: integer;
  max: real;
begin
  for i:= 1 to 8 do begin
    max:= 0;
    maximos(v[i], max, maxCode);
    v2[i].codigo:= maxCode;
    v2[i].puntaje:= max;
  end;  
end;

procedure insercion(var v2: vectorCodigos);
var
  i, j: integer;
  actual: puntajePromedio; 
begin
  for i:= 1 to (8-1) do begin
    actual:= v2[i];
    j:= i-1; 
    while (j > 0) and (v2[j].puntaje > actual.puntaje) do begin
      v2[j+1]:= v2[j];
      j:= j - 1;                  
    end;  
    v2[j+1]:= actual; 
  end;  
end;

procedure maxYMinimo(v2: vectorCodigos; var maxCode, minCode: integer);
var
  i: integer;
  maxPuntaje, minPuntaje: real;
begin
  maxPuntaje:= -9999;
  minPuntaje:= 9999;
  for i:= 1 to 8 do begin
    if(v2[i].puntaje > maxPuntaje)then begin
      maxPuntaje:= v2[i].puntaje;
      maxCode:= v2[i].codigo
    end  
    else if(v2[i].puntaje < minPuntaje)then begin
      minPuntaje:= v2[i].puntaje;
      minCode:= v2[i].codigo;
    end;
  end;      
end;

var
  v: vector;
  v2: vectorCodigos;
  maxCode, minCode: integer;
BEGIN
  cargarVector(v);	
  procesar(v, v2, maxCode);
  insercion(v2);
  maxYMinimo(v2, maxCode, minCode);
  writeln('El codigo de pelicula con mayor puntaje es ', maxCode, ' y el de menor puntaje es ', minCode);	
END.

