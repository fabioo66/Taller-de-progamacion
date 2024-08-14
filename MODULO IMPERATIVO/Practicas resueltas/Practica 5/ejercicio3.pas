program ejercicio3;
type 
    rRango = 1..10;

    producto = record 
        codigo: integer;
        rubro: rRango;
        stock: integer;
        precio: real;
    end;

    productoSinRubro = record 
        codigo: integer;
        stock: integer; 
        precio: real;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record 
        dato: productoSinRubro;
        HI: arbol;
        HD: arbol;
    end;

    vector = array [rRango] of arbol;

procedure leerProducto(var p: producto);
begin
    writeln('Ingrese el codigo del producto');
    readln(p.codigo);
    if (p.codigo <> -1) then begin
        writeln('Ingrese el rubro del producto');
        readln(p.rubro);
        writeln('Ingrese el stock del producto');
        readln(p.stock);
        writeln('Ingrese el precio del producto');
        readln(p.precio);
    end;
end;

procedure asignarProducto(var p1: productoSinRubro; p2: producto);
begin
	p1.codigo:= p2.codigo;
	p1.stock:= p2.stock;
    p1.precio:= p2.precio;
end;

procedure insertarProducto(var a: arbol; p: producto);
begin
    if (a = nil) then begin
        new(a);
        asignarProducto(a^.dato, p);
        a^.HI := nil;
        a^.HD := nil
    end
    else begin
        if (p.codigo <= a^.dato.codigo) then 
            insertarProducto(a^.HI, p)
        else 
            insertarProducto(a^.HD, p);
    end;
end;

procedure inicializarVector(var v: vector);
var 
    i: rRango;
begin
    for i := 1 to 10 do 
        v[i] := nil;
end;

procedure cargarVector(var v: vector);
var 
    p: producto;
begin
    leerProducto(p);
    if (p.codigo <> -1) then begin 
        insertarProducto(v[p.rubro], p);
        cargarVector(v);
    end;
end;

{b}
function existeCodigo(a: arbol; codigo: integer): boolean;
begin
    if (a = nil) then 
        existeCodigo := false
    else begin 
        if (a^.dato.codigo = codigo)then 
            existeCodigo := true
        else begin 
            if (a^.dato.codigo < codigo) then 
                existeCodigo := existeCodigo(a^.HD, codigo)
            else 
                existeCodigo := existeCodigo(a^.HI, codigo);
        end;
    end;
end;

procedure buscarCodigo(v: vector; rubro: rRango; codigo: integer; var existe: boolean);
begin
    existe := existeCodigo(v[rubro], codigo);
end;

{c}
procedure retornarMaximo(a:arbol; var stock, codigo: integer);
begin
	if(a^.HD <> nil) then
		retornarMaximo(a^.HD, stock, codigo)
	else begin
		stock:= a^.dato.stock;
		codigo:= a^.dato.codigo;
	end;
end; 

procedure retornarValores(a: arbol; var stock, codigo: integer);
begin
    if(a <> nil)then 
        retornarMaximo(a, stock,codigo)
    else begin
		stock:= -1;
		codigo:= -1;
	end;
end;

{d}
procedure retornar(v: vector);
var 
    i, stock, codigo:integer;
begin
    for i:= 1 to 10 do begin
        retornarValores(v[i], stock, codigo);
        writeln('El codigo mayor ( ',codigo, ' ) tiene de stock ', stock);
    end;  
end;

procedure retornarCantidad(a:arbol; code1, code2: integer; var cant: integer);
begin
    if(a <> nil)then begin
        if(code1 > a^.dato.codigo)then begin
            if(code2 < a^.dato.codigo)then begin
                cant:= cant + 1;
                retornarCantidad(a^.HI, code1, code2, cant);
                retornarCantidad(a^.HD, code1, code2, cant)
            end  
            else
                retornarCantidad(a^.HI, code1, code2, cant)
        end
    else
        retornarCantidad(a^.HD, code1, code2, cant);     
    end;        
end;

procedure retornar2(v:vector; code1, code2: integer);
var
    cant, i: integer;
begin
    for i:= 1 to 10 do begin
        cant := 0;
        retornarCantidad(v[i], code1, code2, cant);
        writeln('La cantidad de productos en el rubro ', i, ' con codigos entre los dos valores ingresados es ', cant);
    end;
end;

var 
    v: vector;
    rubro, codigo: integer;
    existe: boolean;
begin
    inicializarVector(v);
    cargarVector(v);
    writeln('Ingrese el rubro a buscar');
    readln(rubro);
    writeln('Ingrese el codigo a buscar');
    readln(codigo);
    buscarCodigo(v, rubro, codigo, existe);
    if (existe) then 
        writeln('El codigo ', codigo, ' existe en el rubro ', rubro)
    else 
        writeln('El codigo ', codigo, ' no existe en el rubro ', rubro);
    retornar(v);
    writeln('Ingrese el primer codigo');
    readln(codigo);
    writeln('Ingrese el segundo codigo');
    readln(rubro);
    retornar2(v, codigo, rubro);
end.