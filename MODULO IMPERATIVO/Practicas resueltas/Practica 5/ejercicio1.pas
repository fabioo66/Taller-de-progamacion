{El administrador de un edificio de oficinas, cuenta en papel, con la información del pago
de las expensas de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se debe leer, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación -1.
b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no
se encontró la oficina.
d) Un módulo recursivo que retorne el monto total de las expensas.}

program ejercicio1;
const
    dimf = 300;
type 
    oficina = record
        codigo: integer;
        dni: integer;
        valor: real;
    end;

    vector = array[1..dimf] of oficina;

procedure leerOficina(var o: oficina);
begin
    writeln('Ingrese el codigo de la oficina');
    readln(o.codigo);
    if (o.codigo <> -1) then begin
        writeln('Ingrese el DNI del propietario');
        readln(o.dni);
        writeln('Ingrese el valor de la expensa');
        readln(o.valor);
    end;
end;

procedure cargarVector(var v: vector; var diml: integer);
var 
    o: oficina;
begin
    diml := 0;
    leerOficina(o);
    while ((diml < dimf) and (o.codigo <> -1)) do begin
        diml := diml + 1;
        v[diml] := o;
        leerOficina(o);
    end;
end;

procedure ordenarVector(var v: vector; diml: integer);
var
    i, j: integer;
    actual: oficina;
begin
    for i := 2 to diml do begin
        actual := v[i];
        j := i - 1;
        while ((j > 0) and (v[j].codigo > actual.codigo)) do begin
            v[j+1] := v[j];
            j := j - 1;
        end;
        v[j+1] := actual;
    end;
end;

function busquedaBinaria(v: vector; diml: integer; codigo: integer): integer;
var
    inicio, fin, medio: integer;
begin
    inicio := 1;
    fin := diml;
    while (inicio <= fin) do begin
        medio := (inicio + fin) div 2;
        if (v[medio].codigo = codigo) then
            busquedaBinaria := medio
        else if (v[medio].codigo < codigo) then
            inicio := medio + 1
        else
            fin := medio - 1;
    end;
    busquedaBinaria := 0;
end;

function montoTotal(v: vector; diml: integer): real;
begin
    if (diml = 0) then
        montoTotal := 0
    else
        montoTotal := v[diml].valor + montoTotal(v, diml - 1);
end;

var 
    v: vector;
    diml, codigo, pos: integer;
    monto: real;
begin
    cargarVector(v, diml);
    ordenarVector(v, diml);
    writeln('Ingrese el codigo de la oficina a buscar');
    readln(codigo);
    pos := busquedaBinaria(v, diml, codigo);
    if (pos <> 0) then
        writeln('El DNI del propietario es: ', v[pos].dni)
    else
        writeln('No se encontro la oficina');
    monto := montoTotal(v, diml);
    writeln('El monto total de las expensas es: ', monto:2:2);
end.