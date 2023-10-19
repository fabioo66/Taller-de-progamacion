/*
 Realice un programa que cree un objeto persona con datos leídos desde teclado. Luego
muestre en consola la representación de ese objeto en formato String. 
 */
package Practica_2;
import PaqueteLectura.Lector;
public class Ejercicio_1 {
    public static void main(String[] args) {
        PersonaTest Pt;
        Pt = new PersonaTest();
        System.out.println("Ingrese el nombre de la persona");
        String nombre = Lector.leerString();
        Pt.setNombre(nombre);
        System.out.println("Ingrese la edad de la persona");
        int edad = Lector.leerInt();
        Pt.setEdad(edad);
        System.out.println("Ingrese el DNI de la persona");
        int DNI = Lector.leerInt();
        Pt.setDNI(DNI);
        System.out.println(Pt.toString());
    }
}
