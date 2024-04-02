program ejercicio3;
type 
  rangoRubro = 1..10;
  producto = record
    codigo: integer;
    rubro: rangoRubro;
    stock: integer;
    precio: real;
  end;
  
  arbol = ^nodoArbol;
  nodoArbol = record
    dato: producto;
    HI: arbol;
    HD: arbol;
  end;
  
  productoSinRubro = record
    codigo: integer;
    stock: integer;
    precio: real;
  end;  
  
  vector = array[rangoRubro]of arbol;
  
procedure leerProducto(var p:producto);
begin
  writeln('Ingrese el codigo del producto');
  readln(p.codigo);
  if(p.codigo <> -1)then begin
    writeln('Ingrese el rubro (1..100)');
    readln(p.rubro);
    writeln('Ingrese el stock del producto');
    readln(p.stock);
    writeln('Ingrese el precio unitario');
    readln(p.precio);
  end;
end;  

procedure asignarProducto(var p1: productoSinRubro; p2: producto);
begin
	p1.codigo:= p2.codigo;
	p1.stock:= p2.stock;
    p1.precio:= p2.precio;
end;

procedure agregarProducto(var a:arbol; p: producto);
begin
  if(a <> nil)then begin
    new(a);
    asignarProducto(a^.dato, p);
    a^.HI:= nil;
    a^.HD:= nil
  end
  else if(p.codigo < a^.dato.codigo)then
    agregarProducto(a^.HI, p)
  else
    agregarProducto(a^.HD, p);
end;

procedure inicializarPunteros(var v: vector);
var 
  i: integer;
begin
  for i:= 1 to 10 do
    v[i]:= nil;
end;

procedure cargarVector(var v:vector);
var
  p: producto;
begin
  leerProducto(p);
  while(p.codigo <> -1)do begin
    agregarProducto(v[p.rubro], p);
    leerProducto(p);
  end;
end;

procedure buscarCodigoArbol(a: arbol; codigo: integer; var encontre: boolean);
begin
  if(a <> nil)then begin
    if(a^.dato.codigo = codigo)then
      encontre:= true
    else 
		if(codigo > a^.dato.codigo)then
			buscarCodigoArbol(a^.HD, codigo, encontre)
		else 
			buscarCodigoArbol(a^.HI, codigo, encontre);
  end;
end;

function buscarCodigoAbb(a: arbol; codigo: integer): boolean);
begin
	if(a = nil)then 
		buscarCodigoAbb:= false
	else
		if(a^.dato.codigo = codigo)then
			buscarCodigoAbb:= true
		else 
			if(codigo > a^.dato.codigo)then
				buscarCodigoAbb:= buscarCodigoAbb(a^.HD, codigo)
			else 
				buscarCodigoAbb:= buscarCodigoAbb(a^.HI, codigo)
end;


procedure buscarCodigo(v: vector; rubro, codigo: integer; var encontre: boolean);
begin
  encontre:= false;
  buscarCodigoArbol(v[rubro], codigo, encontre);
end;

procedure retornarValores(a:arbol; var stock, codigo: integer);
begin
  if(a <> nil)then 
    retornarMaximo(a, stock,codigo);
    else begin
		stock:= -1;
		codigo:= -1;
	end;
    
end;

procedure retornarMaximo(a:arbol; var stock, codigo: integer);
begin
	if(a^.HD <> nil) then
		retornarMaximo(a^.HD, stock, codigo);
	else begin
		stock:= a^.dato.stock;
		codigo:= a^.dato.codigo;
	end;
end; 

procedure retornar(v:vector);
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

procedure retornar2(v:vector; code1,code2: integer);
var
  cant, i: integer;
begin
  for i:= 1 to 10 do begin
    cant := 0;
    retornarCantidad(v[i], code1, code2, cant);
    writeln('La cantidad de productos en el rubro ', i, ' con codigos entre los dos valores ingresados es ', cant);
  end;
end;

VAR
  v:vector;
  rubro, codigo, code1, code2: integer;
  encontre: boolean;
BEGIN
  inicializarPunteros(v);
  cargarVector(v);
  writeln('Ingrese un rubro');
  readln(rubro);
  writeln('Ingrese un codigo');
  readln(codigo);
  buscarCodigo(v, rubro, codigo, encontre);
  writeln(encontre);
  retornar(v);
  writeln('Ingrese un codigo');
  readln(code1);
  writeln('Ingrese un codigo');
  readln(code2);
  retornar2(v, code1, code2);
END.
