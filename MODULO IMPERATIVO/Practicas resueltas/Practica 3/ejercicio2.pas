{Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee
código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de
producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendida.
Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.}

program ejercicio2;
type
    venta = record
        codProducto: integer;
        fecha: string;
        cantUnidades: integer;
    end;

    producto = record
        codProducto: integer;
        cantUnidades: integer;
    end;

    arbolVentas = ^nodoVentas;
    nodoVentas = record
        dato: venta;
        HI: arbolVentas;
        HD: arbolVentas;
    end;

    arbolProductos = ^nodoProductos;
    nodoProductos = record
        dato: producto;
        HI: arbolProductos;
        HD: arbolProductos;
    end;

procedure leerVenta(var v: venta);
begin
    writeln('Ingrese el codigo de producto: ');
    readln(v.codProducto);
    if (v.codProducto <> 0) then begin
        writeln('Ingrese la fecha de la venta: ');
        readln(v.fecha);
        writeln('Ingrese la cantidad de unidades vendidas: ');
        readln(v.cantUnidades);
    end;
end;

procedure insertarVenta(var a: arbolVentas; v: venta);
begin
    if (a = nil) then begin
        new(a);
        a^.dato := v;
        a^.HI := nil;
        a^.HD := nil;
    end
    else
        if (v.codProducto < a^.dato.codProducto) then
            insertarVenta(a^.HI, v)
        else
            insertarVenta(a^.HD, v);
end;

procedure insertarProducto(var a: arbolProductos; v: venta);    
begin
    if (a = nil) then begin
        new(a);
        a^.dato.codProducto := v.codProducto;
        a^.dato.cantUnidades := v.cantUnidades;
        a^.HI := nil;
        a^.HD := nil;
    end
    else if (v.codProducto = a^.dato.codProducto) then
        a^.dato.cantUnidades := a^.dato.cantUnidades + v.cantUnidades
    else if (v.codProducto < a^.dato.codProducto) then
        insertarProducto(a^.HI, v)
    else
        insertarProducto(a^.HD, v);
end;

procedure cargarArboles(var aVentas: arbolVentas; var aProductos: arbolProductos);
var
    v: venta;
begin
    leerVenta(v);
    while (v.codProducto <> 0) do begin
        insertarVenta(aVentas, v);
        insertarProducto(aProductos, v);
        leerVenta(v);
    end;
end;

function cantUnidadesVendidas(a: arbolVentas; codProducto: integer): integer;
begin
    if (a = nil) then
        cantUnidadesVendidas := 0
    else if (codProducto = a^.dato.codProducto) then
        cantUnidadesVendidas := a^.dato.cantUnidades + cantUnidadesVendidas(a^.HI, codProducto) + cantUnidadesVendidas(a^.HD, codProducto)
    else if (codProducto < a^.dato.codProducto) then
        cantUnidadesVendidas := cantUnidadesVendidas(a^.HI, codProducto)
    else
        cantUnidadesVendidas := cantUnidadesVendidas(a^.HD, codProducto);
end;

function cantUnidadesVendidasProductos(a: arbolProductos; codProducto: integer): integer;
begin
    if (a = nil) then
        cantUnidadesVendidasProductos := 0
    else if (codProducto = a^.dato.codProducto) then
        cantUnidadesVendidasProductos := a^.dato.cantUnidades
    else if (codProducto < a^.dato.codProducto) then
        cantUnidadesVendidasProductos := cantUnidadesVendidasProductos(a^.HI, codProducto)
    else
        cantUnidadesVendidasProductos := cantUnidadesVendidasProductos(a^.HD, codProducto);
end;

var
    aVentas: arbolVentas;
    aProductos: arbolProductos;
    codProducto: integer;
begin
    aVentas := nil;
    aProductos := nil;
    cargarArboles(aVentas, aProductos);
    writeln('Ingrese el codigo de producto para saber la cantidad de unidades vendidas: ');
    readln(codProducto);
    writeln('La cantidad de unidades vendidas del producto ', codProducto, ' es: ', cantUnidadesVendidas(aVentas, codProducto));
    writeln('La cantidad de unidades vendidas del producto ', codProducto, ' es: ', cantUnidadesVendidasProductos(aProductos, codProducto));
end.