{Implementar un programa modularizado para una librería que:
a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados la cantidad total de
unidades vendidas y el monto total. De cada venta se lee código de venta, código del
producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las
ventas finaliza cuando se lee el código de venta -1.
b. Imprima el contenido del árbol ordenado por código de producto.
c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.
d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.
e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).}

program ejercicio1;
type 
    venta = record
        codVenta: integer;
        codProducto: integer;
        cantUnidades: integer;
        precioUnitario: real;
    end;

    producto = record
        codProducto: integer;
        cantUnidadesVendidas: integer;
        montoTotal: real;
    end;

    arbol = ^nodo;
    nodo = record
        dato: producto;
        HI: arbol;
        HD: arbol;
    end;

procedure leerVenta(var v: venta);
begin
    writeln('Ingrese el codigo de venta');
    readln(v.codVenta);
    if (v.codVenta <> -1) then
    begin
        writeln('Ingrese el codigo de producto');
        readln(v.codProducto);
        writeln('Ingrese la cantidad de unidades vendidas');
        readln(v.cantUnidades);
        writeln('Ingrese el precio unitario');
        readln(v.precioUnitario);
    end;
end;

procedure agregarproductos(var a: arbol; p: producto);
begin
    if(a = nil)then begin
        new(a);
        a^.dato:= p;
        a^.HI:= nil;
        a^.HD:= nil;
    end
    else if(p.codigop = a^.dato.codigop)then begin
        a^.dato.cantUnidadesVendidas:= a^.dato.cantUnidadesVendidas + p.cantUnidadesVendidas;
        a^.dato.montototal:= a^.dato.montototal + p.montototal;
    end
    else if (p.codigop < a^.dato.codigop) then
        agregarproductos(a^.HI, p)
    else
        agregarproductos(a^.HD, p);
end;

procedure cargarArbol(var a: arbol);
var
    v: venta;
    p: producto;
begin
    leerVenta(v);
    while(v.codVenta <> -1)do begin
        p.codProducto:= v.codProducto;
        p.cantUnidadesVendidas:= v.cantUnidades;
        p.montoTotal:= v.cantUnidades * v.precioUnitario;
        agregarproductos(a, p);
        leerVenta(v);
    end;
end;

procedure imprimirArbol(a: arbol);
begin
    if(a <> nil)then begin
        imprimirArbol(a^.HI);
        writeln('Codigo de producto: ', a^.dato.codProducto);
        writeln('Cantidad de unidades vendidas: ', a^.dato.cantUnidadesVendidas);
        writeln('Monto total: ', a^.dato.montoTotal:2:2);
        imprimirArbol(a^.HD);
    end;
end;

procedure maximoCantidadUnidadesVendidas(a: arbol; var max: integer; var cod: integer);
begin
    if(a <> nil)then begin
        if(a^.dato.cantUnidadesVendidas > max)then begin
            max:= a^.dato.cantUnidadesVendidas;
            cod:= a^.dato.codProducto;
        end;
        maximoCantidadUnidadesVendidas(a^.HI, max, cod);
        maximoCantidadUnidadesVendidas(a^.HD, max, cod);
    end;
end;

function cantidadMenores(a: arbol; cod: integer): integer;
begin
    if(a = nil)then
        cantidadMenores:= 0
    else if(a^.dato.codProducto < cod)then
        cantidadMenores:= 1 + cantidadMenores(a^.HI, cod) + cantidadMenores(a^.HD, cod)
    else
        cantidadMenores:= cantidadMenores(a^.HI, cod);
end;

function montoTotalEntreCodigos(a: arbol; cod1, cod2: integer): real;
begin
    if(a = nil)then
        montoTotalEntreCodigos:= 0
    else if(a^.dato.codProducto > cod1) and (a^.dato.codProducto < cod2)then
        montoTotalEntreCodigos:= a^.dato.montoTotal + montoTotalEntreCodigos(a^.HI, cod1, cod2) + montoTotalEntreCodigos(a^.HD, cod1, cod2)
    else if(a^.dato.codProducto < cod1)then
        montoTotalEntreCodigos:= montoTotalEntreCodigos(a^.HD, cod1, cod2)
    else
        montoTotalEntreCodigos:= montoTotalEntreCodigos(a^.HI, cod1, cod2);
end;

var
    a: arbol;
    max, cod: integer;
begin
    a:= nil;
    cargarArbol(a);
    writeln('Contenido del arbol ordenado por codigo de producto');
    imprimirArbol(a);
    max:= -1;
    cod:= -1;
    maximoCantidadUnidadesVendidas(a, max, cod);
    writeln('El codigo de producto con mayor cantidad de unidades vendidas es: ', cod);
    writeln('La cantidad de codigos menores que ', cod, ' es: ', cantidadMenores(a, cod));
    writeln('El monto total entre los codigos de productos comprendidos entre 1 y 5 es: ', montoTotalEntreCodigos(a, 1, 5):2:2);
end.