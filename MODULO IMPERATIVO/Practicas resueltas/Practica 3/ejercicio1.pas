{Escribir un programa que:
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
    socio = record
        numSocio: integer;
        nombre: string;
        edad: integer;
    end;

    arbol = ^nodo;
    nodo = record
        dato: socio;
        HI: arbol;
        HD: arbol;
    end;    

procedure leerSocio(var s: socio);
begin
    writeln('Ingrese el numero de socio: ');
    readln(s.numSocio);
    if (s.numSocio <> 0) then begin
        writeln('Ingrese el nombre del socio: ');
        readln(s.nombre);
        writeln('Ingrese la edad del socio: ');
        readln(s.edad);
    end;
end;

procedure insertar(var a: arbol; s: socio);
begin
    if (a = nil) then begin
        new(a);
        a^.dato := s;
        a^.HI := nil;
        a^.HD := nil;
    end
    else
        if (s.numSocio <= a^.dato.numSocio) then
            insertar(a^.HI, s)
        else
            insertar(a^.HD, s);
end;

procedure cargarArbol(var a: arbol);
var
    s: socio;
begin
    leerSocio(s);
    while (s.numSocio <> 0) do begin
        insertar(a, s);
        leerSocio(s);
    end;
end;

function numSocioMasGrande(a: arbol): integer;
begin
    if(a^.HD = nil) then
        numSocioMasGrande := a^.dato.numSocio
    else
        numSocioMasGrande := numSocioMasGrande(a^.HD);
end;

procedure datosSocioMasChico(a: arbol; var s: socio);
begin
    if (a^.HI = nil) then
        s := a^.dato
    else
        datosSocioMasChico(a^.HI, s);
end;

procedure numSocioMayorEdad(a: arbol; max: integer; var num: integer);
begin
    if (a^.dato.edad > max) then begin
        max := a^.dato.edad;
        num := a^.dato.numSocio;
    end;
    if (a^.HI <> nil) then
        numSocioMayorEdad(a^.HI, max, num);
    if (a^.HD <> nil) then
        numSocioMayorEdad(a^.HD, max, num);
end;

procedure aumentarEdad(a: arbol);