program ejercicio1;
type
  rangoMaterias = 1..36;
  notaSinAplazos = 4..10;
  
  vectorMaterias = array [rangoMaterias] of notaSinAplazos;
  
  alumno = record
    apellido: string;
    numAlu: integer;
    anioIngreso: integer;
    materiasAprobadas: rangoMaterias;
    notas: vectorMaterias;
  end;
  
  listaAlumnos = ^nodoAlumnos;
  nodoAlumnos = record
    dato: alumno;
    sig: listaAlumnos;
  end;
  
procedure cargarVector(var v: vectorMaterias; diml: integer);
var
  i: integer;
begin
  for i:= 1 to diml do begin
    writeln('Ingrese la nota de la materia ', i);
    readln(v[i]);
  end;  
end;
  
procedure leerAlumno(var a:alumno);
begin
  writeln('Ingrese el apellido');
  readln(a.apellido);
  writeln('Ingrese el numero de alumno');
  readln(a.numAlu);
  writeln('Ingrese el año de ingreso');
  readln(a.anioIngreso);
  writeln('Ingrese la cantidad de materias aprobadas');
  readln(a.materiasAprobadas);
  cargarVector(a.notas, a.materiasAprobadas);
end;

procedure agregarAtras(var L, ult: listaAlumnos; a: alumno);
var
  nue: listaAlumnos;
begin
  new(nue);
  nue^.dato:= a;
  nue^.sig:= nil;
  if(L = nil)then
    L:= nue
  else
    ult^.sig:= nue;
  ult:= nue  
end;

procedure cargarLista(var L: listaAlumnos);
var
  a: alumno;
  ult: listaAlumnos;
begin
  repeat
    leerAlumno(a);
    agregarAtras(L, ult, a);
  until(a.numAlu = 11111)  
end;

function promedio(cantidadMaterias: integer; notas: vectorMaterias): real;
var
  suma, i: integer;
begin
  suma:= 0;
  for i:= 1 to cantidadMaterias do
    suma:= suma + notas[i];
  promedio:= suma/cantidadMaterias;
end;

procedure recorrerLista(L: listaAlumnos);
begin
  while(L <> nil)do begin
    writeln('El promedio del alumno ', L^.dato.numAlu, ' es ', promedio(L^.dato.materiasAprobadas, L^.dato.notas):0:2);
    L:= L^.sig;
  end;  
end;  

var
  L: listaAlumnos;
BEGIN
  L:= nil;
  cargarLista(L);
  recorrerLista(L);	
END.

