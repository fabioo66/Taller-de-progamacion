{Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el
siguiente encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
en el vector.}

program ejercicio5;
const
    dimF = 20;
type
    vector = array[1..dimF] of integer;

procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
var 
    medio : indice;
begin
    medio := (ini + fin ) div 2 ;
    while (ini <= fin ) and ( dato <> v[medio]) do begin
        if ( dato < v[medio] ) then 
            fin:= medio -1 
        else ini:= medio+1 ;
            medio := (ini + fin) div 2 ;
    end;
    if (ini <= fin) and (dato = v[medio]) then 
        pos:= medio
    else
        pos:= -1;
end;

var
    v: vector;
    pos, i, dato: integer;
begin
    randomize;
    for i := 1 to dimF do
        v[i] := random(99) + 1;
    writeln('Ingrese el dato a buscar: ');
    readln(dato);
    busquedaDicotomica(v, 1, dimF, dato, pos);
    if (pos = -1) then
        writeln('El dato no se encuentra en el vector.')
    else
        writeln('El dato se encuentra en la posicion: ', pos);
end.