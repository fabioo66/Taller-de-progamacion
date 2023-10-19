/* Escriba un programa que lea las alturas de los 15 jugadores de un equipo de
básquet y las almacene en un vector. Luego informe:
- la altura promedio
- la cantidad de jugadores con altura por encima del promedio
NOTA: Dispone de un esqueleto para este programa en Ej02Jugadores.java
package tema1;
*/
package Practica_1;
//Paso 1: Importar la funcionalidad para lectura de datos
import PaqueteLectura.Lector;

public class Ejercicio_2 {

  
    public static void main(String[] args) {
        //Paso 2: Declarar la variable vector de double 
        int dimf = 15;
        //Paso 3: Crear el vector para 15 double 
        double [] vector = new double [dimf];
        //Paso 4: Declarar indice y variables auxiliares a usar
        int i;
        double altura;
        double prom;
        int cant = 0;
        double suma = 0;
        //Paso 6: Ingresar 15 numeros (altura), cargarlos en el vector, ir calculando la suma de alturas
        for (i = 0; i<dimf; i++){
            System.out.println("Ingrese la altura del jugador");
            altura = Lector.leerDouble();
            vector[i]=altura;
            suma= suma + altura;
        }   
        //Paso 7: Calcular el promedio de alturas, informarlo
        prom=(double)suma/15;
        System.out.println("El promedio de alturas es " + prom);
        //Paso 8: Recorrer el vector calculando lo pedido (cant. alturas que están por encima del promedio)
        for (i = 0; i<dimf; i++)
            if (vector[i] > prom)
              cant++;
        //Paso 9: Informar la cantidad.
        System.out.println("La cantidad de jugadores con la altura mayor que el promedio es " + cant);
    } 
}
