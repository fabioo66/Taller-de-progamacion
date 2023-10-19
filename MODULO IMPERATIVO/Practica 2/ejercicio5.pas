program ejercicio5practica2;
type
  indice = 1..100;
  vector = array[1..30] of integer;

  Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
   Var 
    medio : indice;

 Begin
     medio := (ini + fin ) div 2 ;
     While  ( ini <= fin ) and ( dato <> v[medio]) do begin
         if ( dato < v[medio] ) then 
           fin:= medio -1 
         else ini:= medio+1 ;
         medio := ( ini + fin ) div 2 ;
     end;
     if (ini <= fin) and (dato = v[medio]) then 
       pos:= medio
     else
       pos:= -1;
end;
Var
  v:vector;
  ini,fin,pos:indice;
  dato:integer;
BEGIN
  readln(ini);
  readln(fin);
  readln(dato);
  busquedaDicotomica(v,ini,fin,dato,pos);
END.
