{Se desea procesar la información de las ventas de productos de un comercio (como máximo
50).
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el
día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99
unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El
ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos
valores que se ingresan como parámetros.
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a
mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).}

program ejercicio1;
type
    cRango = 1..15;
    dRango = 1..31;

    venta = record
        dia: dRango;
        codigo: cRango;
        cantidad: integer;
    end;

    vector = array [1..50] of venta;

procedure leerVenta(var v: venta); 
begin
    with v do begin
        writeln('Ingrese el dia de la venta: ');
        readln(dia);
        if (dia <> 0) then begin
            codigo:= random(15)+1;
            writeln('Ingrese la cantidad vendida: ');
            readln(cantidad);
        end;
    end;
end;

{a}
procedure cargarVector(var v: vector; var dimL: integer);
var
    vta: venta;
begin
    dimL:= 0;
    leerVenta(vta);
    while (vta.dia <> 0) and (dimL < 50) do begin
        dimL := dimL + 1;
        v[dimL] := vta;
        leerVenta(vta);
    end;
end;

{b}
procedure mostrarVector(v: vector; dimL: integer);
var
    i: integer;
begin
    for i:= 1 to dimL do 
        writeln('Dia: ', v[i].dia, ' Codigo: ', v[i].codigo, ' Cantidad: ', v[i].cantidad);
end;

{c}
procedure ordenarVector(var v: vector; dimL: integer);
var
    i, j: integer;
    actual: venta;
begin
    for i:= 2 to dimL do begin
        actual:= v[i];
        j:= i-1;
        while (j > 0) and (v[j].codigo > actual.codigo) do begin
            v[j+1]:= v[j];
            j:= j-1;
        end;
        v[j+1]:= actual;
    end;
end;

{d}
procedure mostrarVectorOrdenado(v: vector; dimL: integer);
begin
    mostrarVector(v, dimL);
end;

{e}
procedure eliminarVentas(var v: vector; var dimL: integer; min, max: cRango);
var
    i, j: integer;
begin
    j:= 0;
    for i:= 1 to dimL do begin
        if (v[i].codigo < min) or (v[i].codigo > max) then begin
            j:= j+1;
            v[j]:= v[i];
        end;
    end;
    dimL:= j;
end;

{procedure eliminar(var v:vector; var diml: integer; var pude: boolean; code1, code2: integer);
var
  i, pos1, pos2, j, z: integer;
  ok1, ok2: boolean;
begin
  ok1:= false;
  ok2:= false;
  pude:= false;
  for i:= 1 to diml do begin
    if(v[i].codigo > code1) and (ok1 = false)then begin
      pos1:= i;
      ok1:= true;
    end
    else if(v[i].codigo < code2) and (ok2 = false)then
      pos2:= i;
      ok1:= true;
    end;  
  end;
  for z:= 1 to (pos2 - pos1) do begin
    for j:= 1 to (diml-1) do begin
      if(j >= pos1)then
        v[j]:= v[j+1]; 
    end;
    dL:= dL - 1;
  end;       
  pude:= true;
end;}

{f}
procedure mostrarVectorEliminado(v: vector; dimL: integer);
begin
    mostrarVector(v, dimL);
end;

{g}
procedure informarVentas(v: vector; dimL: integer);
var
    i, codigoActual, total: integer;
begin
    i:= 1;
    while (i <= dimL) do begin
        codigoActual:= v[i].codigo;
        total:= 0;
        while (i <= diml) and (v[i].codigo = codigoActual) do begin
            total:= total + v[i].cantidad;
            i:= i+1;
        end;
        writeln('Codigo: ', codigoActual, ' Cantidad total vendida: ', total);
    end;
end;

{h}
procedure mostrarInformacion(v: vector; dimL: integer);
begin
    informarVentas(v, dimL);
end;

var
    v: vector;
    dimL, min, max: integer;
begin
    randomize;
    cargarVector(v, dimL);
    writeln('Vector original: ');
    mostrarVector(v, dimL);
    ordenarVector(v, dimL);
    writeln('Vector ordenado: ');
    mostrarVectorOrdenado(v, dimL);
    writeln('Ingrese el minimo y el maximo de los codigos a eliminar: ');
    readln(min, max);
    eliminarVentas(v, dimL, min, max);
    writeln('Vector eliminado: ');
    mostrarVectorEliminado(v, dimL);
    writeln('Informacion de ventas: ');
    informarVentas(v, dimL);
end.