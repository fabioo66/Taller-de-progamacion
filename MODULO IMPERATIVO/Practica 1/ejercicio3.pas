{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).}

program ejercicio3;
type  
  grango = 1..8;
  peliculas = record
    codigopeli: integer; 
    codigogenero: grango;
    puntaje: real;
  end;
  
  listapeliculas = ^nodopeliculas;
  nodopeliculas = record
    dato: peliculas;
    sig: listapeliculas;
  end;
  
  maximospuntajes = record
    codigo: integer;
    puntaje: real;
  end;
  
  vector1 = array[grango] of listapeliculas; 
  vector2 = array[grango] of maximospuntajes;
  
procedure leerpeliculas(var p: peliculas);  
begin
  readln(p.codigopeli);
  if(p.codigopeli <> -1) then begin
    readln(p.codigogenero);
    readln(p.puntaje);
  end;
end;

procedure agregaratras(var L: listapeliculas; var ult: listapeliculas; p: peliculas);
var
  nue: listapeliculas;
begin
  new(nue);
  nue^.dato:= p;
  nue^.sig:= nil;
  if(L = nil)then
    L:= nue;
  else
    ult^.sig:= nue;
  ult:= nue;
end;

procedure cargarvector1(var v1: vector1);
var
  p: peliculas;
  ult: listapeliculas;
begin
  leerpeliculas(p);
  while(p.codigopeli <> -1)do begin
    agregaratras(v[p.codigogenero], ult, p);
    leerpeliculas(p);
  end;
end;

procedure maximos(L: listapeliculas; var max: real; var maxcode: integer);
begin
  while(L <> nil) do begin
    if(L^.dato.puntaje > max)then begin
      max:= L^.dato.puntaje;
      maxcode:= L^.dato.codigopeli;
    end;
    L:= L^.sig;
  end;  
end;

procedure procesar(v1: vector1; v2: vector2);
var
  max: real;
  i, maxcode: integer;
begin
  for i:= 1 to 8 do begin
    max:= 0;
    maximos(v1[i], max, maxcode);
    v2[i].codigo:= maxcode;
    v2[i].puntaje:= max;
  end;  
end;

procedure insercion(var v2: vector2);
var
  i, j, pos: integer;
  actual: maximospuntajes; 
begin
  for i: 1 to (dimf-1) do begin
    actual:= v[i];
    j:= i-1; 
    while (j > 0) y (v[j].puntaje > actual.puntaje) do begin
      v[j+1]:= v[j];
      j:= j – 1;                  
    end;  
    v[j+1]:= actual; 
  end;  
 end;

procedure minymax(v2: vector2; var mincode, maxcode1: integer);
var
  max, min: real;
  i: integer;
begin
  max:= 0;
  min:= 0;
  for i:= 1 to 8 do begin
    if(v2[i].puntaje > max) then begin
      max:= v2[i].puntaje;
      maxcode:= v2[i].codigo;
    end
    else if(v2[i].puntaje < min) then begin
      min:= v2[i].puntaje;
      mincode:= v2[i].codigo;
    end;
  end;    
end;

var
  v2: vector2;
  v1: vector1;
  L: listapeliculas;
  max: real;
  maxcode, maxcode1, mincoode: integer;
begin
  L:= nil;
  cargarvector(v1);
  procesar(v1, v2);
  insercion(v2);
  minymax(v2, mincode, maxcode1);
  writeln('el código de película con mayor puntaje es: ', maxcode1, 'y el código de película con menor puntaje es: ', mincode);
end.

