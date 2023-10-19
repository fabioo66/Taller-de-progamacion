/*
 * Un edificio de oficinas está conformado por 8 pisos (1..8) y 4 oficinas por piso
(1..4). Realice un programa que permita informar la cantidad de personas que
concurrieron a cada oficina de cada piso. Para esto, simule la llegada de personas al
edificio de la siguiente manera: a cada persona se le pide el nro. de piso y nro. de
oficina a la cual quiere concurrir. La llegada de personas finaliza al indicar un nro.
de piso 9. Al finalizar la llegada de personas, informe lo pedido.
 */
package Practica_1;

import PaqueteLectura.Lector;

public class Ejercicio_4 {
    public static void main(String[] args){    
    int i, j, nropiso, nroffice;
    int matriz [][] = new int [8][4];
    for(i=0; i<8; i++)
        for(j=0; j<4; j++)
            matriz[i][j]= 0;
    System.out.println("Ingrese un numero de piso");
    nropiso= Lector.leerInt();
    System.out.println("Ingrese un numero de oficina");
    nroffice= Lector.leerInt();
    while(nropiso != 9 && nroffice < 4){
        matriz[nropiso][nroffice]++;
        System.out.println("Ingrese un numero de piso");
        nropiso= Lector.leerInt();
        System.out.println("Ingrese un numero de oficina");
        nroffice= Lector.leerInt();
    }
    for(i=0; i<8; i++)
        for(j=0; j<4; j++)
            System.out.print("("+i+","+j+")"+matriz[i][j]+"|");
    }
}
