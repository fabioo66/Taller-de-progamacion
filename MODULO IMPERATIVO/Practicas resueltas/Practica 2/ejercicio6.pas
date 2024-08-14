{Realizar un programa que lea números y que utilice un módulo recursivo que escriba el
equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa
el número 0 (cero).
Ayuda: Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2.
¿Cómo obtenemos los dígitos que componen al número? ¿Cómo achicamos el número para la
próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111}

program ejercicio6;

procedure decimalABinario(num: integer);
begin
    if (num < 2) then
        write(num)
    else begin
        decimalABinario(num div 2);
        write(num mod 2);
    end;
end;

var
    num: integer;
begin
    writeln('Ingrese un numero: ');
    readln(num);
    while (num <> 0) do begin
        decimalABinario(num);
        writeln;
        writeln('Ingrese un numero: ');
        readln(num);
    end;
end.