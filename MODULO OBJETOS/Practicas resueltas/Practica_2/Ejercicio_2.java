/*
 Utilizando la clase Persona. Realice un programa que almacene en un vector a lo sumo
15 personas. La información (nombre, DNI, edad) se debe generar aleatoriamente hasta
obtener edad 0. Luego de almacenar la información:
 - Informe la cantidad de personas mayores de 65 años.
 - Muestre la representación de la persona con menor DNI.
 */
package Practica_2;
import PaqueteLectura.GeneradorAleatorio;
public class Ejercicio_2 {
    public static void main(String[] args) {
        int DF = 16;
        PersonaTest vector [] = new PersonaTest [DF];
        PersonaTest P;
        GeneradorAleatorio.iniciar();
        String nombre = GeneradorAleatorio.generarString(10);
        int DNI = GeneradorAleatorio.generarInt(99999999), edad = GeneradorAleatorio.generarInt(100), pos = -1;
        while(edad != 0 && pos < DF-1){
            P = new PersonaTest();
            P.setNombre(nombre);
            P.setDNI(DNI);
            P.setEdad(edad);
            pos++;
            vector[pos]= P;
            nombre = GeneradorAleatorio.generarString(10);
            DNI = GeneradorAleatorio.generarInt(99999999);
            edad = GeneradorAleatorio.generarInt(100);
        }
        int i;
        for( i = 0; i<pos; i++)
            System.out.println(vector[i].toString());
        /*Informo el vector*/
        int cant = 0, min = 99999999;
        String datos = null;
        for( i = 0; i<pos; i++){
            if(vector[i].getEdad() > 65)
                cant++;
            if(vector[i].getDNI() < min){
                min = vector[i].getDNI();
                datos = vector[i].toString();
            }
        }
        System.out.println("La cantidad de personas con la edad mayor a 65 es: "+ cant);
        System.out.println("la representación de la persona con menor DNI es: "+datos);
    }   
}
