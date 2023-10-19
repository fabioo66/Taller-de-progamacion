/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Practica_1;

//Paso 1. importar la funcionalidad para generar datos aleatorios
import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;
public class Ejercicio_3 {

    public static void main(String[] args) {
	    //Paso 2. iniciar el generador aleatorio     
	 GeneradorAleatorio.iniciar();
        //Paso 3. definir la matriz de enteros de 5x5 e iniciarla con nros. aleatorios 
        int[][] matriz = new int[5][5];
        int i,j;
        for (i = 0; i < 5; i++)
            for (j = 0; j < 5; j++)
                matriz[i][j] = GeneradorAleatorio.generarInt(100);
            
        //Paso 4. mostrar el contenido de la matriz en consola
        for (i = 0; i < 5; i++){
            System.out.println("");
            for (j = 0; j < 5; j++)
                System.out.print("("+i+","+j+")"+ matriz[i][j]+ "|");
        }
        //Paso 5. calcular e informar la suma de los elementos de la fila 1
        int suma = 0;
        i = 1;
        for (j = 0; j < 5; j++)
            suma = suma + matriz[i][j];
        System.out.println("la suma de la fila 1 es " + suma);
        //Paso 6. generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz. 
        //        Luego, imprima el vector.
        int dimf = 5;
        int suma2;
        int [] vector = new int [dimf];
        for (i=0; i<dimf; i++)
            vector[i]=0;
        for(j=0; j<5; j++){
          suma2 = 0;
          for(i=0; i<5; i++)
              suma2= suma2 + matriz[i][j];
          vector[j]=suma2;
        }
        for(i=0; i<5; i++)
            System.out.println("El vector en la posicion "+i+" contiene "+ vector[i]);
        //Paso 7. lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su ubicación (fila y columna)
        //   y en caso contrario imprima "No se encontró el elemento"
        int num;
        System.out.println("Ingrese un numero");
        num = Lector.leerInt();
        boolean ok = false;
        int posi, posj;
        int fila = 0, columna = 0;
        posi= 0;
        while(posi < 5  && ok == false){
            posj=0;
            while(posj <5 && ok == false){
                if (matriz[posi][posj] == num){
                    ok=true;
                    fila= posi;
                    columna= posj;
                }    
                else
                    posj++;
            }    
            posi++;
        }
        if (ok == true)
            System.out.println("El elemento " +num+" se encuentra en la fila "+fila+" y en la columna " +columna);
        else
            System.out.println("no se encontro el elemento");
    }
}