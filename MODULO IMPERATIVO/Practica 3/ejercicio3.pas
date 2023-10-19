{3. Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y los almacene en
una estructura de datos. De cada alumno se lee legajo, DNI, año de ingreso y los códigos y
notas de los finales rendidos. La estructura generada debe ser eficiente para la búsqueda por
número de legajo. La lectura de los alumnos finaliza con legajo 0 y para cada alumno el ingreso
de las materias finaliza con el código de materia -1.
b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso de
aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande.
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
f. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.
g. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}


program Hello;
type
  final = record
    codigo:integer;
    nota:integer;
  end;

  lista = ^nodo;
  nodo = record
    dato:final;
    sig:lista;
  end;
  alumno = record
    legajo:integer;
    dni:integer;
    anio:integer;
    finales:lista;
  end;
  
  arbol = ^nodo1;
  nodo1 = record
    dato:alumno;
    HI:arbol;
    HD:arbol;
  end;
  
  
procedure leerfinal(var f:final);
begin
  writeln('ingrese el codigo del final');
  readln(f.codigo);
  writeln('ingrese la nota del final');
  readln(f.nota);
end;

procedure agregarAdelante(var L:lista; f:final);
var
  nue:lista;
begin
  new(nue);
  nue^.dato:= f;
  nue^.sig:= L;
  L:= nue;
end;

procedure cargarlista(var L:lista);
var
  f:final;
begin
  leerfinal(f);
  while (f.codigo <> -1) do begin
    agregarAdelante(L,f);
    leerfinal(f);
  end;
end;

procedure leeralumno(a:alumno);
begin
  writeln('ingrese el numero de legajo');
  readln(a.legajo);
  if (a.legajo <> 0) then begin
    writeln('ingrese el numero de dni');
    readln(a.dni);
    writeln('ingrese el anio');
    readln(a.anio);
    cargarlista(a.finales);
  end;
end;

procedure agregar(var a:arbol; alum:alumno);
begin
  if (a = nil) then begin
    new(a);
    a^.dato:= alum;
    a^.HI:= nil;
    a^.HD:= nil;
  end
  else if (alum.legajo <= a^.dato.legajo) then
    agregar(a^.HI,alum)
  else
    agregar(a^.HD,alum);
end;
  
procedure cargararbol(var a:arbol);
var
  alum:alumno;
begin
  leeralumno(alum);
  if (alum.legajo <> 0) then begin
    agregar(a,alum);
    cargararbol(a);
  end;
end;

{b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso de
aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.}

procedure legajoinf(a:arbol; valor:integer);
begin
  if (a <> nil) then begin
    legajoinf(a^.HI,valor);
    legajoinf(a^.HD,valor);
    if (a^.dato.legajo < valor) then 
      writeln('el nro de legajo de este alumno es menor a ' , valor ,' : ', a^.dato.dni, a^.dato.anio);
  end;
end;

{c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande.}

procedure mayorlegajo (a:arbol; var max:integer);
begin
  if (a <> nil) then begin
    max:= a^.dato.legajo;
    mayorlegajo(a^.HD,max);
  end;
end;

{d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.}

procedure mayordni(a:arbol; var maxdni:integer);
begin
  if (a <> nil) then begin
    if (a^.dato.dni > maxdni) then
      maxdni:= a^.dato.dni;
    mayordni(a^.HI,maxdni);
    mayordni(a^.HD,maxdni);
  end;
end;

{e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.}

procedure legajoimpar(a:arbol; var cant:integer);
begin
  if (a <> nil) then begin
    if (a^.dato.legajo mod 2 <> 0) then
      cant:= cant + 1;
    legajoimpar(a^.HI,cant);
    legajoimpar(a^.HD,cant);
  end;
end;

{f. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del
alumno con mayor promedio.}

function promedio(L:lista):real;
var
  cantnotas,cantexamenes:integer;
begin
  cantnotas:= 0;
  cantexamenes:= 0;
  while (L <> nil) do begin
    cantexamenes:= cantexamenes + 1;
    cantnotas:= cantnotas + L^.dato.nota;
    L:= L^.sig;
  end;
    promedio:= (cantnotas/cantexamenes);
end;

procedure mayorpromedio(a:arbol; var legajomax:integer; var prom:real);
var
  p:real;
begin
  if (a <> nil) then begin
    p:= promedio(a^.dato.finales);
    if (p > prom) then begin
      prom:= p;
      legajomax:= a^.dato.legajo;
    end;
    mayorpromedio(a^.HI,legajomax,prom);
    mayorpromedio(a^.HD,legajomax,prom);
  end;
end;

{g. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

procedure promediosup(a:arbol; valor:real);
var
  p:real;
begin
  if (a <> nil) then begin
    p:= promedio(a^.dato.finales);
    if (p > valor) then
      writeln('el promedio de este alumno supera al numero ingresado', a^.dato.legajo, ' promedio: ', p);
    promediosup(a^.HI,valor);
    promediosup(a^.HD,valor);
  end;
end;

var
  a:arbol;
  num,legajoprom,valor:integer;
  maxlegajo,maxdni:integer;
  prom:real;
begin
  cargararbol(a);
  
  read(num);
  legajoinf(a,num);
  
  mayorlegajo(a,maxlegajo);
  
  maxdni:= -1;
  mayordni(a,maxdni);
  
  prom:= -1;
  mayorpromedio(a,legajoprom,prom);
  
  read(valor);
  promediosup(a,valor);
end.
