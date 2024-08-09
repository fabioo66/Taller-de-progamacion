{Una librería requiere el procesamiento de la información de sus productos. De cada
producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
métodos vistos en la teoría.
e. Muestre los precios del vector resultante del punto d).
f. Calcule el promedio de los precios del vector resultante del punto d).}

program ejercicio4;
const
    dimF = 30;
type
    cRango = 1..8;

    producto = record
        codigo: integer;
        rubro: cRango;
        precio: real;
    end;

    lista = ^nodo;
    nodo = record
        dato: producto;
        sig: lista;
    end;

    vectorRubros = array [cRango] of lista;
    vectorProductos = array [1..dimF] of producto;

procedure inicializarListas(var v: vector);
var
    i: integer;
begin
    for i := 1 to dimF do
        v[i] := nil;
end;

procedure leerProducto(var p: producto);
begin
    writeln('Ingrese el precio');
    readln(p.precio);
    if (p.precio <> 0) then begin
        writeln('Ingrese el codigo del producto');
        readln(p.codigo);
        writeln('Ingrese el codigo de rubro');
        readln(p.rubro);
    end;
end;

procedure insertarOrdenado(var l: lista; p: producto);
var
    ant, act, nuevo: lista;
begin
    new(nuevo);
    nuevo^.dato := p;
    act := l;
    while ((act <> nil) and (act^.dato.codigo < p.codigo)) do begin
        ant := act;
        act := act^.sig;
    end;
    if (ant = act) then
        l := nuevo
    else
        ant^.sig := nuevo;
    nuevo^.sig := act;
end;

procedure cargarVector(var v: vectorRubros);
var
    p: producto;
begin
    leerProducto(p);
    while (p.precio <> 0) do begin
        insertarOrdenado(v[p.rubro], p);
        leerProducto(p);
    end;
end;

procedure imprimirRubros(var v: vectorRubros);
var
    i: integer;
    aux: lista;
begin
    for i := 1 to 8 do begin
        aux := v[i];
        writeln('Rubro ', i);
        while (aux <> nil) do begin
            writeln('Codigo: ', aux^.dato.codigo);
            aux := aux^.sig;
        end;
    end;
end;

procedure cargarVectorProductos(v: vectorRubros; var vP: vectorProductos; var dimL: integer);
var
    i: integer;
    aux: lista;
begin
    dimL := 0;
    for i := 1 to dimF do begin
        aux := v[3];
        while ((aux <> nil) and (dimL < dimF)) do begin
            dimL := dimL + 1;
            vP[dimL] := aux^.dato;
            aux := aux^.sig;
        end;
    end;
end;

procedure ordenarVectorInsercion(var v: vectorProductos; dimL: integer);
var
    i, j: integer;
    actual: producto;
begin
    for i := 2 to dimL do begin
        actual := v[i];
        j := i - 1;
        while ((j > 0) and (v[j].precio > actual.precio)) do begin
            v[j+1] := v[j];
            j := j - 1;
        end;
        v[j+1] := actual;
    end;
end;

procedure imprimirVector(v: vectorProductos; dimL: integer);
var
    i: integer;
begin
    for i := 1 to dimL do
        writeln('Precio: ', v[i].precio:4:2);
end;

function promedioVector(v: vectorProductos; dimL: integer): real;
var
    i: integer;
    suma: real;
begin
    suma := 0;
    for i := 1 to dimL do
        suma := suma + v[i].precio;
    promedioVector := suma / dimL;
end;

var
    vRubros: vectorRubros;
    vProductos: vectorProductos;
    dimL: integer;
begin
    inicializarListas(vRubros);
    cargarVector(vRubros);
    imprimirRubros(vRubros);
    cargarVectorProductos(vRubros, vProductos, dimL);
    ordenarVectorInsercion(vProductos, dimL);
    imprimirVector(vProductos, dimL);
    writeln('Promedio de precios: ', promedioVector(vProductos, dimL):4:2);
end.