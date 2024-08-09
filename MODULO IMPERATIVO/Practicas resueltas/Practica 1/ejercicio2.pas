{El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}

program ejercicio2;
const
    dimF = 300;
type
    oficina = record
        codigo: integer;
        dni: integer;
        expensa: real;
    end;

    vector = array [1..dimF] of oficina;

procedure leerOficina(var o: oficina);
begin
    writeln('Ingrese el codigo de la oficina');
    readln(o.codigo);
    if (o.codigo <> -1) then begin
        writeln('Ingrese el DNI del propietario');
        readln(o.dni);
        writeln('Ingrese el valor de la expensa');
        readln(o.expensa);
    end;
end;

procedure cargarVector(var v: vector; var dimL: integer);
var
    o: oficina;
begin
    diml := 0;
    leerOficina(o);
    while ((diml < dimf) and (o.codigo <> -1)) do begin
        dimL := dimL + 1;
        v[dimL] := o;
        leerOficina(o);
    end;
end;

procedure ordenarVectorInsercion(var v: vector; dimL: integer);
var
    i, j: integer;
    actual: oficina;
begin
    for i := 2 to dimL do begin
        actual := v[i];
        j := i - 1;
        while ((j > 0) and (v[j].codigo > actual.codigo)) do begin
            v[j+1] := v[j];
            j := j - 1;
        end;
        v[j+1] := actual;
    end;
end;

procedure ordenarVectorSeleccion(var v: vector; dimL: integer);
var
    i, j, posMenor: integer;
    actual: oficina;
begin
    for i := 1 to dimL - 1 do begin
        posMenor := i;
        for j := i + 1 to dimL do begin
            if (v[j].codigo < v[posMenor].codigo) then
                posMenor := j;
        end;
        actual := v[i];
        v[i] := v[posMenor];
        v[posMenor] := actual;
    end;
end;

var
    v: vector;
    dimL: integer;
begin
    cargarVector(v, dimL);
    ordenarVectorInsercion(v, dimL);
    ordenarVectorSeleccion(v, dimL);
end.

