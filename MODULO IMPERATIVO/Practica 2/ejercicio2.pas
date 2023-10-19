program ejercicio2practica2;

procedure imprimir(n:integer);
  begin
    if (n <> 0) then begin
      imprimir(n div 10);
      write(n mod 10, ' ');
    end;
  end;
  
var
  num:integer;
BEGIN
  read(num);
  while (num <> 0) do begin
    imprimir(num);
    writeln;
    read(num);
  end;
END.
