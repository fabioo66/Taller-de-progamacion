{3. Una facultad nos ha encargado procesar la información de sus alumnos de la carrera XXX.
Esta carrera tiene 30 materias. Implementar un programa con:
a. Un módulo que lea la información de los finales rendidos por los alumnos y los
almacene en dos estructuras de datos.
i. Una estructura que para cada alumno se almacenen sólo código y nota de las
materias aprobadas (4 a 10). De cada final rendido se lee el código del alumno, el
código de materia y la nota (valor entre 1 y 10). La lectura de los finales finaliza con
nota -1. La estructura debe ser eficiente para buscar por código de alumno.
ii. Otra estructura que almacene para cada materia, su código y todos los finales
rendidos en esa materia (código de alumno y nota).
b. Un módulo que reciba la estructura generada en i. y un código de alumno y retorne los
códigos y promedios de los alumnos cuyos códigos sean mayor al ingresado.
c. Un módulo que reciba la estructura generada en i., dos códigos de alumnos y un valor
entero, y retorne la cantidad de alumnos con cantidad de finales aprobados igual al
valor ingresado para aquellos alumnos cuyos códigos están comprendidos entre los dos
códigos de alumnos ingresados.}
program ejercicio3practica4;
type
  nrango = -1..10;
  finales = record
    codigoalu:integer;
    codigomat:integer;
    nota:nrango;
  end;
  
  info = record
    codigomat:integer;
    nota:integer;
  end;
  
    lista = ^nodo2;
  nodo2 = record
    dato:info;
    sig:lista;
  end;

  data = record
    codigoalu:integer;
    lista:lista;
  end;
  
  arbol = ^nodo;
  nodo = record
    dato:data;
    HI:arbol;
    HD:arbol;
  end;
  
  infonue = record
    codigoalu: integer;
    promedio: real;
  end;
  
  listanueva = ^nodonuevo;
  nodonuevo = record
    dato: infonue;
    sig: listanueva;
  end;
  
{i. Una estructura que para cada alumno se almacenen sólo código y nota de las
materias aprobadas (4 a 10). De cada final rendido se lee el código del alumno, el
código de materia y la nota (valor entre 1 y 10). La lectura de los finales finaliza con
nota -1. La estructura debe ser eficiente para buscar por código de alumno.}
  
procedure leerfinales(var f:finales);
begin
  readln(f.nota);
  if (f.nota <> -1) then begin
    readln(f.codigoalu);
    readln(f.codigomat);
  end;
end;

procedure agregarAdelante(L:lista; f:finales);
var
  nue:lista;
  i:info;
begin
  new(nue);
  i.codigomat:= f.codigomat;
  i.nota:= f.nota;
  nue^.dato:= i;
  nue^.sig:= L;
  L:= nue;
end;
  
procedure agregarelemento(var a:arbol; f:finales);
var
  d:data;
begin
  if(f.nota >= 4)then
    if (a = nil) then begin
      new(a);
      d.codigoalu:= f.codigoalu;
      d.lista:= nil;
      a^.dato:= d;
      agregarAdelante(a^.dato.lista,f);
      a^.HI:= nil;
      a^.HD:= nil;
    end
    else if (f.codigoalu = a^.dato.codigoalu) then
      agregarAdelante(a^.dato.lista,f)
      else if (f.codigoalu < a^.dato.codigoalu)then
        agregarelemento(a^.HI,f)
        else
          agregarelemento(a^.HD,f);  
end;

procedure cargararbol(var a:arbol);
var
  f:finales;
begin
  leerfinales(f);
  if (f.nota <> -1)then begin
    agregarelemento(a,f);
    cargararbol(a);
  end;
end;

{b. Un módulo que reciba la estructura generada en i. y un código de alumno y retorne los
códigos y promedios de los alumnos cuyos códigos sean mayor al ingresado.}

{b}function promedio(L:lista):real;
var
  suma, total: real;
begin
  suma:= 0;
  total:= 0;
  while(L <> nil)do begin
    total:= total + 1;
    suma:= suma + L^.dato.nota;
    L:= L^.sig;
  end;
  promedio:= (suma/total);  
end;

{b}procedure agregarAdelante2(var L: listanueva; d:data);
var
  nue: listanueva;
  i: infonue;
begin
  new(nue);
  i.codigoalu:= d.codigoalu;
  i.promedio:= promedio(d.lista);
  nue^.dato:= i;
  nue^.sig:= L;
  L:= nue;
end;  

{b}procedure retornarcodeprom(a: arbol; codigo: integer; var L: listanueva);
begin
  if(a <> nil)then 
    if(codigo < a^.dato.codigoalu)then begin
      agregaradelante2(L, a^.dato);
      retornarcodeprom(a^.HD, codigo, L);
      retornarcodeprom(a^.HI, codigo, L)
    end
    else
      retornarcodeprom(a^.HI, codigo, L);
end;

{b}procedure informarlista(L:listanueva);
begin
  if(L <> nil)then begin
    informarlista(L^.sig);
    writeln(L^.dato.codigoalu, '   ', L^.dato.promedio:0:2);
  end;
end;

var
  a:arbol;
  L: listanueva;
  codigo: integer;
begin
  cargararbol(a);
  L:= nil;
  writeln('Ingrese un codigo de alumno para retornar los códigos y promedios de los alumnos cuyos códigos sean mayor al ingresado');
  readln(codigo);
  retornarcodeprom(a, codigo, L);
  informarlista(L);
end.
