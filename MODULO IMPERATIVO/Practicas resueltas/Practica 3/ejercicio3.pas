{Implementar un programa que contenga:
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

program ejercicio3;
type
    final = record
        codMateria: integer;
        nota: real;
    end;

    alumno = record
        legajo: integer;
        DNI: integer;
        anioIngreso: integer;
        finales: lista;
    end;

    lista = ^nodo;
    nodo = record
        dato: final;
        sig: lista;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record
        dato: alumno;
        HI: arbol;
        HD: arbol;
    end;   

procedure leerFinal(var f: final);
begin
    writeln('Ingrese el codigo de materia: ');
    readln(f.codMateria);
    if (f.codMateria <> -1) then begin
        writeln('Ingrese la nota del final: ');
        readln(f.nota);
    end;
end;

procedure insertarFinal(var l: lista; f: final);
var
    aux: lista;
begin
    new(aux);
    aux^.dato := f;
    aux^.sig := l;
    l := aux;
end;

procedure leerAlumno(var a: alumno);
var
    f: final;
begin
    a.finales := nil;
    writeln('Ingrese el legajo del alumno: ');
    readln(a.legajo);
    if (a.legajo <> 0) then begin
        writeln('Ingrese el DNI del alumno: ');
        readln(a.DNI);
        writeln('Ingrese el año de ingreso del alumno: ');
        readln(a.anioIngreso);
        a.cantFinales := 0;
        a.finales := nil;
        leerFinal(f);
        while (f.codMateria <> -1) do begin
            a.cantFinales := a.cantFinales + 1;
            insertarFinal(a.finales, f);
            leerFinal(f);
        end;
    end;
end;

procedure insertar(var a: arbol; al: alumno);
begin
    if (a = nil) then begin
        new(a);
        a^.dato := al;
        a^.HI := nil;
        a^.HD := nil;
    end
    else
        if (al.legajo <= a^.dato.legajo) then
            insertar(a^.HI, al)
        else
            insertar(a^.HD, al);
end;

{a}
procedure cargarArbol(var a: arbol);
var
    al: alumno;
begin
    leerAlumno(al);
    while (al.legajo <> 0) do begin
        insertar(a, al);
        leerAlumno(al);
    end;
end;

{b}
procedure DNIyAnioIngresoMenorA(a: arbol; valor: integer);
begin
    if (a <> nil) then begin
        if (a^.dato.legajo < valor) then
            writeln('DNI: ', a^.dato.DNI, ' Anio de ingreso: ', a^.dato.anioIngreso);
        DNIyAnioIngresoMenorA(a^.HI, valor);
        DNIyAnioIngresoMenorA(a^.HD, valor);
    end;
end;

{c}
function legajoMasGrande(a: arbol): integer;
begin
    if (a^.HD = nil) then
        legajoMasGrande := a^.dato.legajo
    else
        legajoMasGrande := legajoMasGrande(a^.HD);
end;

{d}
procedure DNIgrande(a: arbol; var max: integer);
begin
    if (a <> nil) then begin
        if (a^.dato.DNI > max) then
            max := a^.dato.DNI;
        DNIgrande(a^.HI, max);
        DNIgrande(a^.HD, max);
    end;
end;

{e}
procedure cantAlumnosLegajoImpar(a: arbol; var cant: integer);
begin
    if (a <> nil) then begin
        if (a^.dato.legajo mod 2 <> 0) then
            cant := cant + 1;
        cantAlumnosLegajoImpar(a^.HI, cant);
        cantAlumnosLegajoImpar(a^.HD, cant);
    end;
end;

{f}
procedure devolverPromedio(l: lista; var promedio: real);
var
    cant: integer;
    suma: real;
begin
    suma := 0;
    cant := 0;
    while (l <> nil) do begin
        suma := suma + l^.dato.nota;
        cant := cant + 1;
        l := l^.sig;
    end;
    promedio := suma / cant;
end;

{f}
procedure promedioMayor(a: arbol; var max: real; var legajo: integer);
var 
    promedio: real;
begin
    if (a <> nil) then begin
        devolverPromedio(a^.dato.finales, promedio);
        if (promedio > max) then begin
            max := promedio;
            legajo := a^.dato.legajo;
        end;
        promedioMayor(a^.HI, max, legajo);
        promedioMayor(a^.HD, max, legajo);
    end;
end;

{g}
procedure promedioMayorA(a: arbol; valor: real);
begin
    if (a <> nil) then begin
        devolverPromedio(a^.dato.finales, promedio);
        if (promedio > valor) then
            writeln('Legajo: ', a^.dato.legajo, ' Promedio: ', promedio);
        promedioMayorA(a^.HI, valor);
        promedioMayorA(a^.HD, valor);
    end;
end;

var
    a: arbol;
    valor: integer;
    max: integer;
    cant: integer;
    promedio: real;
begin
    a := nil;
    cargarArbol(a);
    writeln('Ingrese un valor para buscar los alumnos con legajo menor a ese valor: ');
    readln(valor);
    DNIyAnioIngresoMenorA(a, valor);
    max := legajoMasGrande(a);
    writeln('El legajo mas grande es: ', max);
    max := 0;
    DNIgrande(a, max);
    writeln('El DNI mas grande es: ', max);
    cant := 0;
    cantAlumnosLegajoImpar(a, cant);
    writeln('La cantidad de alumnos con legajo impar es: ', cant);
    max := 0;
    promedio := 0;
    promedioMayor(a, promedio, max);
    writeln('El legajo del alumno con mayor promedio es: ', max, ' con un promedio de: ', promedio:2:2);
    writeln('Ingrese un valor para buscar los alumnos con promedio mayor a ese valor: ');
    readln(valor);
    promedioMayorA(a, valor);
end.
