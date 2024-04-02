{3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.}

program ejercicio3;
type 
  lista = ^nodo;
  nodo = record
    dato: integer;
    sig: lista;
  end;
  
procedure agregaradelante(var L:lista; n:integer);
var
  nue: lista;
begin
  new(nue);
  nue^.dato:= n;
  nue^.sig:= L;
  L:= nue;
end; 
  
procedure cargarLista(var L:lista);
var
  n: integer;
begin
  n:= random(101);
  if(n <> 0)then begin
    agregaradelante(L,n);
    cargarLista(L);
  end;
end;

procedure imprimirLista(L:lista);
begin
  if(L <> nil)then begin
    imprimirLista(L^.sig);
    writeln(L^.dato);
  end;
end;

procedure minimo(L:lista; var min: integer);
begin
  if(L <> nil)then begin
    if(L^.dato < min)then
      min:= L^.dato;
    minimo(L^.sig, min);
  end;    
end;  

procedure maximo(L:lista; var max: integer);
begin
  if(L <> nil)then begin
    if(L^.dato > max)then
      max:= L^.dato;
    maximo(L^.sig, max);
  end;    
end;

procedure esta(L: lista; num: integer; var encontre: boolean);
begin
  if(L <> nil)and(encontre = false)then begin
    if(L^.dato = num)then
      encontre:= true;
    esta(L^.sig, num, encontre);
  end;
end;

VAR
  L: lista;
  min, max, num: integer;
  encontre: boolean;
BEGIN
  L:= nil;
  randomize;
  cargarLista(L);
  imprimirLista(L);
  min:= 9999;	
  minimo(L, min);
  max:= -9999;
  maximo(L,max);
  encontre:= false;
  writeln('Ingrese un num');
  readln(num);
  esta(L, num, encontre);
  writeln(encontre);	
END.
