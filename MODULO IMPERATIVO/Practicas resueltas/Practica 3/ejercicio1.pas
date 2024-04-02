{1. Escribir un programa que:
a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol
binario de búsqueda. De cada socio se lee número de socio, nombre y edad. La lectura finaliza
con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como
parámetro y que :
i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.
ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo
recursivo que retorne dicho socio.
iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que
retorne dicho valor.
iv. Aumente en 1 la edad de todos los socios.
v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a
un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a
un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha
cantidad.
viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso
vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.
xi. Informe los números de socio en orden creciente.
x. Informe los números de socio pares en orden decreciente.}


program ejercicio1;
type 
  socios = record
    numero: integer;
    nombre: string;
    edad: integer;
  end;
  
  arbol = ^nodo;
  nodo = record
    dato: socios;
    HI: arbol;
    HD: arbol;
  end;
  
 procedure leersocio(var s: socios);
 begin
   writeln('ingrese el numero del socio');
   readln(s.numero);
   if(s.numero <> 0)then begin
     writeln('ingrese el nombre del socio');
     readln(s.nombre);
     writeln('ingrese la edad del socio');
     readln(s.edad);
   end;
 end;
 
 procedure agregarsocio(var a: arbol; s:socios);
 begin  
   if(a = nil)then begin
     new(a);
     a^.dato:= s;
     a^.HI:= nil;
     a^.HD:= nil;
   end
   else if(s.numero <= a^.dato.numero) then
     agregarsocio(a^.HI, s)
   else
     agregarsocio(a^.HD, s);
 end;

procedure cargararbol(var a:arbol);
var
  s: socios;
begin
  leersocio(s);
  if(s.numero <> 0)then begin
    agregarsocio(a, s);
    cargararbol(a);
  end;
end;

{i}procedure maximop (a:arbol; var max:integer);
begin
  if (a <> nil) then begin
    max:= a^.dato.numero;
    maximop(a^.HD, max);
  end;
end;

{ii}procedure minimo(a: arbol; var min: socios);
begin
  if(a <> nil)then begin
    min:= a^.dato;
    minimo(a^.HI, min);
  end;
end;

{iii}procedure socioviejo(a: arbol; edadmaxima: integer; var numeromax: integer);
begin
  if(a <> nil)then begin
    socioviejo(a^.HI, edadmaxima, numeromax);
    if(a^.dato.edad > edadmaxima)then begin
      edadmaxima:= a^.dato.edad;
      numeromax:= a^.dato.numero;
    end;
    socioviejo(a^.HD, edadmaxima, numeromax)
  end;
end;

{iv}procedure aumentaredad(a:arbol);
begin
  if(a <> nil)then begin
    aumentaredad(a^.HI);
    a^.dato.edad:= a^.dato.edad + 1;
    aumentaredad(a^.HD);
  end;
end;

{v}procedure esta(a: arbol; num: integer; var encontre:boolean);
begin
  if(a <> nil)and(encontre = false)then begin
    esta(a^.HI, num, encontre);
    if(a^.dato.numero = num)then
      encontre:= true;
    esta(a^.HD, num, encontre);
  end;
end;

{vi}procedure buscarnombre(a:arbol; nombre: string; var ok:boolean);
begin
  if(a <> nil)and(ok = false)then begin
    buscarnombre(a^.HI, nombre, ok);
    if(a^.dato.nombre = nombre)then
      ok:= true;
    buscarnombre(a^.HD, nombre, ok);
  end;
end;

{viii}procedure cantyedad(a:arbol; var suma, total: integer);
begin
  if(a <> nil)then begin
    cantyedad(a^.HI, suma, total);
    suma:= suma + a^.dato.edad;
    total:= total + 1;
    cantyedad(a^.HD, suma, total);
  end;
end;

{ix}procedure informarnumero(a: arbol);
begin
  if(a <> nil) then begin
    informarnumero(a^.HI);
    writeln(a^.dato.numero);
    informarnumero(a^.HD);
  end;
end;

{x}Procedure postOrden(a:arbol);
begin
  if (a <> nil) then begin
    postOrden (a^.HI);
    postOrden (a^.HD);
    if(a^.dato.numero mod 2 = 0)then
      writeln(a^.dato.numero);
  end;
end;

var
  max, edadmaxima, numeromax, total, suma, num:integer;
  min: socios;
  a:arbol;
  nombre: string;
  encontre, ok: boolean;
begin
  a:= nil;
  cargararbol(a);
  maximop(a, max);
  writeln('el numero de socio mas grande es: ', max);
  minimo(a, min);
  writeln('el socio con el numero mas chico es: ', min.nombre , ' tiene ', min.edad , ' años y su numero es ', min.numero);
  edadmaxima:= -9999;
  socioviejo(a, edadmaxima, numeromax);
  writeln('el numero de socio de mayor edad es: ', numeromax);
  aumentaredad(a);
  writeln('ingrese un numero para chequear si existe');
  readln(num);
  esta(a, num, encontre);
  writeln(encontre);
  writeln('ingrese un nombre para chequear si existe');
  readln(nombre);
  buscarnombre(a, nombre, ok);
  writeln(ok);
  total:= 0;
  suma:= 0;
  cantyedad(a, suma, total);
  writeln('la cantidad de socios es: ', total);
  writeln('el promedio de edad de todos los socios es: ', suma/total:0:2);
  informarnumero(a);
  postOrden(a);
end.
