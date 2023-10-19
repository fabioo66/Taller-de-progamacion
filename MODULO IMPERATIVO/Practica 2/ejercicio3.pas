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

procedure cargarlista(var L:lista);
var
  num: integer;
begin
  randomize;
  num:= random(99)+1;
  if(num <> 0) then begin
    agregaradelante(L, num);
    cargarlista(L);
  end;
end;

procedure minimo(L: lista; var min: integer);
begin
  min:= 9999;
  if(L <> nil)then begin
    if(L^.dato < min)then
      min:= L^.dato;
    minimo(L^.sig, min);  
  end;
end;

procedure maximo(L: lista; var max: integer);
begin
  max:= -9999;
  if(L <> nil)then begin
    if(L^.dato > max)then
      max:= L^.dato;
    maximo(L^.sig, max);  
  end;
end;

procedure esta(L: lista);
var
  encontre: boolean;
  num: integer;
begin
  encontre: false;
  readln(num);
  if(L <> nil)then begin
    if(L^.dato = num)then
      encontre: true;
    if(encontre = true)then
      writeln('el numero: ', num, 'se encuentra en la lista);
    else
      writeln('el numero: ', num, 'no se encuentra en la lista);  
    esta(L^.sig);  
  end;   
end;

var
  L: lista;
  min, max: integer;
begin
  L:= nil; 
  cargarlista(L);
  minimo(L, min);
  writeln(min);
  maximo(L, max);
  esta(L);
end.  
