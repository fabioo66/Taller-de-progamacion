program codigosNecesarios;

//arbol de listas
procedure agregarAdelante(var L:lista; d:dato);
var
  nue: lista;
begin
  new(nue);
  nue^.dato:= d;
  nue^.sig:= L;
  L:= nue;
end;

procedure agregarDato(var a:arbol; d:dato);
begin
  if(a = nil)then begin
    new(a);
    a^.dato.num:= d.num;
    a^.dato.productos:= nil;
    agregarAdelante(a^.dato.productos, d);
    a^.HI:= nil;
    a^.HD:= nil
  end
  else begin
    if(a^.dato.num = d.num)then
      agregarAdelante(a^.dato.productos, d)
    else if(d.num < a^.dato.num)then
      agregarDato(a^.HI, d)
    else
      agregarDato(a^.HD; d);
  end;      
end;  

procedure crearArbol(var a:arbol);
var
  d:dato;
begin
  leerProducto(d);
  if(a.num <> -1)then
    agregarDato(a,d); 
    crearArbol(a);
end;

//vector de arboles
procedure agregarProducto(var a:arbol; p:producto);
begin
  if(a = nil)then begin
    new(a);
    a^.dato:= p;
    a^.HI:= nil;
    a^.HD:= nil
  end
  else if(p.codigo < a^.dato.codigo)then
    agregarProducto(a^.HI, p)
  else
    agregarProducto(a^.HD, p);
end;

procedure inicializarPunteros(var v:vector);
var
  i: integer;
begin
  for i:= 1 to 10 do
    v[i]:= nil;
end;

procedure cargarVector(var v:vector);
var
  p:producto
begin
  leerProducto(p);
  while(p.codigo <> -1)do begin
    agregarProducto(v[p.rubro], p);
    leerProducto(p);
  end;
end;

//Algoritmos para busqueda sin tomar en cuenta el orden

//preOrden
procedure preOrden(a:arbol);
begin
  if(a <> nil)then begin
    preOrden(a^.HI);
    preOrden(a^.HD);
    //codigo
  end;
end:

//enOrden
procedure enOrden(a:arbol);
begin
  if(a <> nil)then begin
    enOrden(a^.HI);
    //codigo
    enOrden(a^.HD);
end;

//postOrden
procedure postOrden(a:arbol);
begin
  if(a <> nil)then begin
    //codigo
    postOrden(a^.HI);
    postOrden(a^.HD);
  end;
end;

//Algoritmos para la busqueda eficiente
//Maximos, un elemento del nodo y el nodo entero:

function maximo(a:arbol): integer;
begin
  if(a^.HD = nil)then 
    maximo:= a^.dato.codigo;
  else
    maximo:= maximo(a^.HD); 
end;

function maximoDevolverNodo(a:arbol): arbol;
begin
  if(a = nil)then
    maximoDevolverNodo:= nil
  else
    if(a^.HD = nil)then
      maximoDevolverNodo:= a^.dato
    else
      maximoDevolverNodo:= maximoDevolverNodo(a^.HD); 
end;

//Minimos, un elemento del nodo y el nodo entero:

function minimo(a:arbol): integer;
begin
  if(a^.HI = nil)then
    minimo:= a^.dato.codigo
  else
    minimo:= minimo(a^.HI);
end;

function minimoDevolverNodo(a:arbol): arbol;
begin
  if(a = nil)then
    minimoDevolverNodo:= 9999
  else
    if(a^.HI = nil)then
      minimoDevolverNodo:= a^.dato
    else
      minimoDevolverNodo:= minimoDevolverNodo(a^.HI);
end;

//informar la cantidad de datos menores a un dato ingresado por teclado

function cantidadMenor(a:arbol; codigo:integer):integer;
begin
  if(a = nil)then
    cantidadMenor:=0
  else begin
    if(codigo < a^.dato.codigo)then
      cantidadMenor:=cantidadMenor(a^.hi,codigo)
    else
      cantidadMenor:=cantidadMenor(a^.hi,codigo) + 1 + cantidadMenor(a^.hd,codigo);
  end;
end;

////informar la cantidad de datos mayores a un dato ingresado por teclado

function cantidadMayor(a:arbol; codigo:integer):integer;
begin
  if(a = nil)then
    cantidadMayor:=0
  else begin
    if(codigo > a^.dato.codigo)then
      cantidadMayor:=cantidadMenor(a^.HD,codigo)
    else
      cantidadMayor:=cantidadMayor(a^.HD,codigo) + 1 + cantidadMayor(a^.HI,codigo);
  end;
end;

//buscar un elemento de forma eficiente

function buscarElemento(a:arbol; codigo: integer): boolean;
begin
  if(a = nil)then
    buscarElemento:= true;
  else
    if(a^.dato.codigo = codigo)then
      buscarElemento:= true
    else if(codigo > a^.dato.codigo)then
      buscarElemento:= buscarElemento(a^.HD, codigo)
    else
      buscarElemento:= buscarElemento(a^.HI, codigo);
end;

//ejemplo devolver la categoria del producto del codigo ingresado

procedure devolverCategoria(a:arbol; codigo: integer; var categoria: string);
begin
  if(a <> nil)then begin
    if(a^.dato.codigo = codigo)then
      categoria:= a^.dato.categoria
    else if(codigo > a^.dato.codigo)then
      devolverCategoria(a^.HD, codigo, categoria)
    else
      devolverCategoria(a^.HI, codigo, categoria)
  end;
end;

//devolver informacion dentro de 2 rangos ingresados por teclado

procedure entreCodigos(a:arbol; code1,code2: integer; var cant: integer);
begin
  if(a <> nil)then begin
    if(code1 > a^.dato.codigo)then begin
      if(code1 < a^.dato.codigo)then begin
        cant:= cant + a^.dato.cantProductos;
        entreCodigos(a^.HI, code1, code2, cant);
        entreCodigos(a^.HD, code1, code2, cant)
      end
      else
        entreCodigos(a^.HI, code1, code2, cant);
    end
  else
    entreCodigos(a^.HD, code1, code2, cant);
  end;          
end;

//Imprimir lista de forma recursiva
//enOrden

procedure RecursivamenteOrdenado(L:lista);
begin
  if(L <> nil) do begin
    RecursivamenteOrdenado(L^.sig);
    writeln(L^.dato);
  end;
end;

//al reves

procedure RecursivamenteAlReves(L: lista);
begin
  if(L <> nil) do begin
    writeln(L^.dato);
    RecursivamenteAlReves(L^.sig);
  end;
end;

//imprimir vector
//enOrden

procedure recursivamenteOrden(v:vector; diml: integer); //si el vector no tiene diml, diml sera la cantidad de elementos
begin
  if(diml > 0)then begin
    recursivamenteOrden(v,diml-1);
    writeln(v[diml]);
  end;  
end;

procedure RecursivamenteAlReves(v:vector; diml: integer);
begin
  if(diml > 0)then begin
    writeln(v[diml]);
    recursivamenteOrden(v,diml-1);
  end;  
end;

//codigos de ordenacion de vectores
//insercion

Procedure insercion(var v: Vector; dimL: integer);
var 
  i, j: integer;
  actual: oficina;			
begin
  for i:= 2 to dimL do begin 
    actual:= v[i];
    j:= i-1; 
    while (j > 0) and (v[j].codigo > actual.codigo)do begin
      v[j+1]:= v[j];
      j:= j - 1;                  
    end;  
    v[j+1]:= actual; 
  end;
end;

//seleccion

procedure seleccion(var v: vector; var diml: integer);
var 
  i, j, pos: integer; 
  o: oficina;	
begin
  for i:= 1 to (diml-1) do begin 
    pos := i;
    for j := i+1 to diml do
      if (v[j].codigo < v[pos].codigo)then 
        pos:= j;
        o:= v[pos];   
        v[pos]:= v[i];   
        v[i]:= o;
    end;
end;

BEGIN
  writeln('Puto el que lee');	
END.

