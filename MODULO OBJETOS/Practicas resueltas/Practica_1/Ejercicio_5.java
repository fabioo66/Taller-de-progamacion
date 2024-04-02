/*
 * El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen
(con puntaje de 1 a 10) los siguientes aspectos: (0) Atención al cliente (1) Calidad
de la comida (2) Precio (3) Ambiente.
Escriba un programa que lea desde teclado las calificaciones de los cinco clientes
para cada uno de los aspectos y almacene la información en una estructura. Luego
imprima la calificación promedio obtenida por cada aspecto.
 */
package Practica_1;
import PaqueteLectura.Lector;
public class Ejercicio_5 {
    public static void main(String[] args){
      int matriz [][] = new int [5][4];
      int i,j;
      int atencion, comida, precio, ambiente, suma;
      for (i = 0; i < 5; i++)
        for (j = 0; j < 4; j++){
            System.out.println("ingrese el puntaje correspondiente a la categoria "+j);
            matriz[i][j] = Lector.leerInt();
        }    
      for(i=0; i<5; i++)
        for(j=0; j<4; j++)
            System.out.print("("+i+","+j+")"+matriz[i][j]+"|");
      
      for(j=0; j<4; j++){ 
          suma = 0;
          for (i=0; i<5; i++)
              suma = suma + matriz[i][j];
          double promedio = (double)suma/5;
          System.out.println("El promedio del aspecto "+j+" es "+promedio);
      }    
    }
}
