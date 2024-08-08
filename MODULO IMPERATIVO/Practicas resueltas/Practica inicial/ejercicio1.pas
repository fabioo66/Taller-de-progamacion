{Implementar  un  programa  que  procese la información  de los  alumnos  de  la  Facultad  de 
Informática.  a)  Implementar  un  módulo  que  lea  y  retorne,  en  una  estructura  adecuada,  la  información  de 
todos  los  alumnos.  De  cada  alumno  se  lee  su  apellido,  número  de  alumno,  año  de  ingreso, 
cantidad de materias aprobadas (a lo sumo 36) y nota obtenida (sin contar los aplazos) en cada 
una  de  las  materias  aprobadas.  La  lectura  finaliza  cuando  se  ingresa  el  número  de  alumno 
11111, el cual debe procesarse. b)  Implementar  un  módulo  que  reciba  la  estructura  generada  en  el inciso  a)  y  retorne  número 
de alumno y promedio de cada alumno. c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de 
materias  aprobadas  de  cada  alumno,  y  si  además  se  desean  registrar  los  aplazos?  ¿cómo 
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?}

program ejercicio1;
const
    cantMaterias = 36;
type
    alumno = record
        apellido: string;
        numAlumno: integer;
        anioIngreso: integer;
        cantMateriasAprobadas: integer;
        notas: vector;
    end;

    vector = array [1..cantMaterias] of integer;

    lista = ^nodo;
    nodo = record
        dato: alumno;
        sig: lista;
    end;

procedure leerAlumno(var a: alumno);
var
    i: integer;
begin
    writeln('Ingrese el apellido del alumno');
    readln(a.apellido);
    writeln('Ingrese el numero de alumno');
    readln(a.numAlumno);
    writeln('Ingrese el anio de ingreso');
    readln(a.anioIngreso);
    writeln('Ingrese la cantidad de materias aprobadas');
    readln(a.cantMateriasAprobadas);
    for i := 1 to a.cantMateriasAprobadas do begin
        writeln('Ingrese la nota de la materia ', i);
        readln(a.notas[i]);
    end;
end;

procedure agregarAdelante(var l: lista; a: alumno);
var
    nuevo: lista;
begin
    new(nuevo);
    nuevo^.dato := a;
    nuevo^.sig := l;
    l := nuevo;
end;

procedure cargarLista(var l: lista);
var     
    a: alumno;
begin
    repeat
        leerAlumno(a);
        agregarAdelante(l, a);
    until (a.numAlumno = 11111);
end;

function promedio(v: vector; cantMateriasAprobadas: integer): real;
var
    i, suma: integer;
begin
    suma := 0;
    for i := 1 to cantMateriasAprobadas do
        suma := suma + v[i];
    promedio := suma / cantMateriasAprobadas;
end;

procedure procesar(l: lista);
var 
begin
    while (l <> nil) do begin
        writeln('Numero de alumno: ', l^.dato.numAlumno, ' Promedio: ', promedio(l^.dato.notas, l^.dato.cantMateriasAprobadas):0:2);
        l := l^.sig;
    end;
end;

var
    l: lista;
begin
    l := nil;
    cargarLista(l);
    procesar(l);
end.

{c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de 
materias  aprobadas  de  cada  alumno,  y  si  además  se  desean  registrar  los  aplazos?  ¿cómo 
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?}

{Si no se sabe de antemano la cantidad de materias aprobadas de cada alumno, se puede cambiar la estructura de datos tipo vector por un lista de enteros, y se puede agregar un campo en la estructura alumno que indique la cantidad de materias aprobadas.}