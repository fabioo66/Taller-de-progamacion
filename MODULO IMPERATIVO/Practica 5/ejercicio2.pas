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
    readln(c.anioFabricacion);
    writeln('ingrese la marca del auto');
    readln(c.marca);
    writeln('Ingrese el modelo del auto');
    readln(c.modelo);
  end; 
end;

procedure agregarAuto(var a:arbolAuto; c: auto);
begin
  if(a <> nil)then begin
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
  if(a <> nil)then begin
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

procedure cantAutosBrand(a: arbolAuto; brand: string; var cant: integer; encontreBrand: boolean);
begin
  if(a <> nil)and(encontreBrand = false)then begin
    cantAutosBrand(a^.HI, brand,cant, encontreBrand);
    if(a^.dato.marca = brand)then begin
      cant:= cant + 1;
      encontreBrand:= true;
    end;
    cantAutosBrand(a^.HD, brand, cant, encontreBrand);
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

procedure cantAutosXMarca(a: arbolXMarca; marca: string; var cant: integer; encontreMarca: boolean);
begin
  if(a <> nil)and(encontreMarca = false)then begin
    if(a^.dato.marca = marca)then begin
      cant:= recorrerLista(a^.dato.autos);
      encontreMarca:= true
    end  
    else if(marca > a^.dato.marca)then
      cantAutosXMarca(a^.HD, marca, cant, encontreMarca)
    else 
      cantAutosXMarca(a^.HI, marca, cant, encontreMarca);
  end;     
end;

procedure cargarVector(a:arbolAuto; var v:vector);
begin
  if(a <> nil)then begin
    agregarAdelante(v[a^.dato.anioFabricacion], a^.dato);
    cargarVector(a^.HI, v);
    cargarVector(a^.HD, v);
  end;
end;

procedure buscarPatente(a:arbolAuto; patente: integer; encontre: boolean; var modelo: string);
begin
  if(a <> nil)and(encontre = false)then begin
    if(patente = a^.dato.patente)then begin
      encontre:= true;
      modelo:= a^.dato.modelo
    end  
    else if(patente > a^.dato.patente)then 
      buscarPatente(a^.HD, patente, encontre, modelo)
    else
      buscarPatente(a^.HI, patente, encontre, modelo);
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

procedure buscarPatenteXMarca(a:arbolXMarca; patente: integer; encontre: boolean; var modelo: string);
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
  encontreBrand, encontre: boolean;
BEGIN
  cargarArboles(a1,a2);
  writeln('Ingrese una marca');
  readln(brand);
  cant:= 0;
  encontreBrand:= false;
  cantAutosBrand(a1, brand, cant, encontreBrand);
  writeln('La cantidad de autos de la misma marca es: ',cant);
  cant:= 0;
  encontreBrand:= false;
  cantAutosXMarca(a2, brand, cant, encontreBrand);
  writeln('La cantidad de autos de la misma marca es: ',cant);
  cargarVector(a1,v);
  writeln('Ingrese una patente de auto');
  readln(patente);
  encontre:= false;
  buscarPatente(a1,	patente, encontre, modelo);
  writeln('el modelo del auto con la patente ', patente, ' es ', modelo);
  encontre:= false;
  buscarPatenteXMarca(a2, patente, encontre, modelo);
  writeln('el modelo del auto con la patente ', patente, ' es ', modelo);
END.

