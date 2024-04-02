program ejercicio2;
type
  arango= 2010..2018;
  auto = record
    patente: integer;
    anioFabricacion: arango;
    marca: string;
    modelo: string;
  end;
  
  arbolAuto = ^nodoAuto;
  nodoAuto = record
    dato: auto;
    HI: arbolAuto;
    HD: arbolAuto;
  end;
  
  lista = ^nodoLista;
  nodoLista = record
    dato: auto;
    sig: lista;
  end;
  
  autoXMarca = record
    marca: string;
    autos: lista;
  end;
  
  arbolXMarca = ^nodoXMarca;
  nodoXMarca = record
    dato: autoXMarca;
    HI: arbolXMarca;
    HD: arbolXMarca;
  end;
  
  vector = array[arango]of lista;
  
procedure leerAuto(var c: auto);
begin
  writeln('Ingrese la patente del auto');
  readln(c.patente);
  if(c.patente <> -1)then begin
    writeln('Ingrese el anio de fabricacion del auto');
    //readln(c.anioFabricacion);
    c.anioFabricacion:=random(9)+2010;
    //random()*0.156;
    writeln(c.anioFabricacion);
    writeln('ingrese la marca del auto');
    readln(c.marca);
    writeln('Ingrese el modelo del auto');
    readln(c.modelo);
  end; 
end;

procedure agregarAuto(var a:arbolAuto; c: auto);
begin
  if(a = nil)then begin
    new(a);
    a^.dato:= c;
    a^.HI:= nil;
    a^.HD:= nil
  end
  else if(c.patente <= a^.dato.patente)then
    agregarAuto(a^.HI, c)
  else
    agregarAuto(a^.HD, c);
end;

procedure agregarAdelante(var L: lista; c: auto);
var
  nue: lista;
begin
  new(nue);
  nue^.dato:= c;
  nue^.sig:= L;
  L:= nue;
end;

procedure agregarXMarca(var a: arbolXMarca; c: auto);
begin
  if(a = nil)then begin
    new(a);
    a^.dato.marca:= c.marca;
    a^.dato.autos:= nil;
    agregarAdelante(a^.dato.autos, c);
    a^.HI:= nil;
    a^.HD:= nil
  end
  else begin
    if(c.marca = a^.dato.marca)then
      agregarAdelante(a^.dato.autos, c)
    else if(c.marca <= a^.dato.marca)then
      agregarXMarca(a^.HI, c)
    else
      agregarXMarca(a^.HD, c);
  end;         
end;

procedure cargarArboles(var a1: arbolAuto; var a2:arbolXMarca);
var
  c: auto;
begin
  leerAuto(c);
  if(c.patente <> -1)then begin
    agregarAuto(a1, c);
    agregarXMarca(a2,c);
    cargarArboles(a1,a2);
  end;  
end;

procedure cantAutosBrand(a: arbolAuto; brand: string; var cant: integer);
begin
  if(a <> nil)then begin
    cantAutosBrand(a^.HI, brand,cant);
    if(a^.dato.marca = brand)then 
      cant:= cant + 1;
    cantAutosBrand(a^.HD, brand, cant);
  end;
end;

function recorrerLista(L: lista): integer;
var
  cant: integer;
begin
  cant:= 0;
  while(L <> nil)do begin
    cant:= cant + 1;
    L:= L^.sig;
  end;
  recorrerLista:= cant;
end;

procedure cantAutosXMarca(a: arbolXMarca; marca: string; var cant: integer);
begin
  if(a <> nil)then begin
    if(a^.dato.marca = marca)then 
      cant:= recorrerLista(a^.dato.autos)
    else if(marca > a^.dato.marca)then
      cantAutosXMarca(a^.HD, marca, cant)
    else 
      cantAutosXMarca(a^.HI, marca, cant);
  end;     
end;

{function contarMarca(a: arbolXMarca; marca: string): integer;
begin
	if ( a = nil) then
		contarMarca:=0
	else begin
		if (a^.dato.marca = marca)
			contarMarca:=recorrerLista(a^.dato.autos)
		else if (a^.dato.marca < marca)
			contarMarca:=contarMarca(a^.hd,marca)
		else
			contarMarca:=contarMarca(a^.hi,marca);
	end;
end;}

procedure inicializarVector(var v: vector);
var
	i:integer;
begin
	for i:= 2010 to 2018 do
		v[i]:=nil;
end;

procedure cargarVector(a:arbolAuto; var v:vector);
begin
  if(a <> nil)then begin
    agregarAdelante(v[a^.dato.anioFabricacion], a^.dato);
    cargarVector(a^.HI, v);
    cargarVector(a^.HD, v);
  end;
end;

procedure buscarPatente(a:arbolAuto; patente: integer; var modelo: string);
begin
  if(a <> nil)then begin
    if(patente = a^.dato.patente) then 
      modelo:= a^.dato.modelo
    else if(patente > a^.dato.patente)then 
      buscarPatente(a^.HD, patente, modelo)
    else
      buscarPatente(a^.HI, patente, modelo);
  end;      
end;

procedure buscarPatenteEnLista(L: lista; patente: integer; var encontre: boolean; var modelo:string);
begin
  encontre:= false;
  while(L <> nil)and(encontre = false)do begin
    if(patente = L^.dato.patente)then begin
      encontre:= true;
      modelo:= L^.dato.modelo;
    end;  
    L:= L^.sig;
  end;
end;

procedure buscarPatenteXMarca(a:arbolXMarca; patente: integer; var encontre: boolean; var modelo: string);
begin
  if(a <> nil)and(encontre = false)then begin
    buscarPatenteEnLista(a^.dato.autos, patente, encontre, modelo);
    buscarPatenteXMarca(a^.HI, patente, encontre, modelo);
    buscarPatenteXMarca(a^.HD, patente, encontre, modelo);
  end;  
end;

VAR
  a1: arbolAuto;
  a2: arbolXMarca;
  v: vector;
  brand, modelo: string;
  cant, patente: integer;
  encontre: boolean;
BEGIN
	randomize;
  cargarArboles(a1,a2);
  writeln('Ingrese una marca');
  readln(brand);
  cant:= 0;
  cantAutosBrand(a1, brand, cant);
  writeln('La cantidad de autos de la misma marca es: ',cant);
  cant:= 0;
  cantAutosXMarca(a2, brand, cant);
  writeln('La cantidad de autos de la misma marca es: ',cant);
  inicializarVector(v);
  cargarVector(a1,v);
  writeln('Ingrese una patente de auto');
  readln(patente);
  buscarPatente(a1,	patente, modelo);
  writeln('el modelo del auto con la patente ', patente, ' es ', modelo);
  encontre:= false;
  buscarPatenteXMarca(a2, patente, encontre, modelo);
  if(encontre)then
    writeln('el modelo del auto con la patente ', patente, ' es ', modelo);
END.
