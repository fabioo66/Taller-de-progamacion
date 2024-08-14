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

{i}
function numSocioMasGrande(a: arbol): integer;
begin
    if(a^.HD = nil) then
        numSocioMasGrande := a^.dato.numSocio
    else
        numSocioMasGrande := numSocioMasGrande(a^.HD);
end;

{ii}
procedure datosSocioMasChico(a: arbol; var s: socio);
begin
    if (a^.HI = nil) then
        s := a^.dato
    else
        datosSocioMasChico(a^.HI, s);
end;

{iii}
procedure numSocioMayorEdad(a: arbol; max: integer; var num: integer);
begin
    if (a <> nil) then begin
        if (a^.dato.edad > max) then begin
            max := a^.dato.edad;
            num := a^.dato.numSocio;
        end;
        numSocioMayorEdad(a^.HI, max, num);
        numSocioMayorEdad(a^.HD, max, num);
    end;
end;

{iv}
procedure aumentarEdad(a: arbol);
begin
    if (a <> nil) then begin
        a^.dato.edad := a^.dato.edad + 1;
        aumentarEdad(a^.HI);
        aumentarEdad(a^.HD);
    end;
end;

{v}
function existeNumSocio(a: arbol; num: integer): boolean;
begin
    if (a = nil) then
        existeNumSocio := false
    else begin
        if (a^.dato.numSocio = num) then
            existeNumSocio := true
        else begin
            if (num < a^.dato.numSocio) then
                existeNumSocio := existeNumSocio(a^.HI, num)
            else
                existeNumSocio := existeNumSocio(a^.HD, num);
        end;
    end;
end;

{vi}
function existeNombre(a: arbol; nombre: string): boolean;
begin
    if (a <> nil) then begin
        if (a^.dato.nombre = nombre) then
            existeNombre := true
        else
            existeNombre := existeNombre(a^.HI, nombre) or existeNombre(a^.HD, nombre);
    end
    else
        existeNombre := false;
end;

{vii}
function cantidadSocios(a: arbol): integer;
begin
    if (a = nil) then
        cantidadSocios := 0
    else
        cantidadSocios := 1 + cantidadSocios(a^.HI) + cantidadSocios(a^.HD);
end;

{viii}
function sumaEdades(a: arbol): integer;
begin
    if (a = nil) then
        sumaEdades := 0
    else
        sumaEdades := a^.dato.edad + sumaEdades(a^.HI) + sumaEdades(a^.HD);
end;

{ix}
procedure numerosSocioEnOrden(a: arbol);
begin
    if (a <> nil) then begin
        numerosSocioEnOrden(a^.HI);
        writeln(a^.dato.numSocio);
        numerosSocioEnOrden(a^.HD);
    end;
end;

{x}
procedure numerosSocioParesEnOrdenDecreciente(a: arbol);
begin
    if (a <> nil) then begin
        numerosSocioParesEnOrdenDecreciente(a^.HD);
        numerosSocioParesEnOrdenDecreciente(a^.HI);
        if (a^.dato.numSocio mod 2 = 0) then
            writeln(a^.dato.numSocio);
    end;
end;

var
    a: arbol;
    s: socio;
    num: integer;
    nombre: string;
begin
    a := nil;
    cargarArbol(a);
    writeln('Numero de socio mas grande: ', numSocioMasGrande(a));
    datosSocioMasChico(a, s);
    writeln('Datos del socio con el numero de socio mas chico: ');
    writeln('Numero de socio: ', s.numSocio);
    writeln('Nombre: ', s.nombre);
    writeln('Edad: ', s.edad);
    numSocioMayorEdad(a, 0, num);
    writeln('Numero de socio con mayor edad: ', num);
    aumentarEdad(a);
    writeln('Ingrese un numero de socio: ');
    readln(num);
    if (existeNumSocio(a, num)) then
        writeln('Existe un socio con ese numero')
    else
        writeln('No existe un socio con ese numero');
    writeln('Ingrese un nombre: ');
    readln(nombre);
    if (existeNombre(a, nombre)) then
        writeln('Existe un socio con ese nombre')
    else
        writeln('No existe un socio con ese nombre');
    writeln('Cantidad de socios: ', cantidadSocios(a));
    writeln('Promedio de edad de los socios: ', sumaEdades(a) / cantidadSocios(a));
    writeln('Numeros de socio en orden creciente: ');
    numerosSocioEnOrden(a);
    writeln('Numeros de socio pares en orden decreciente: ');
    numerosSocioParesEnOrdenDecreciente(a);
end.