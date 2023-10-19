/*
B- Realizar un programa que instancie un círculo, le cargue información leída de teclado e
informe en consola el perímetro y el área. 
 */
package Practica_3;

import PaqueteLectura.Lector;

public class Ejercicio_5 {

    public static void main(String[] args) {
        System.out.println("Ingrese el radio del circulo");
        double radio = Lector.leerDouble();
        System.out.println("Leer el color de relleno del circulo");
        String relleno = Lector.leerString();
        System.out.println("Ingrese el color del contorno");
        String linea = Lector.leerString();
        Circulo c = new Circulo(radio, relleno, linea);
        System.out.println("El perimetro del circulo es "+c.calcularPerimetro()+" y el area es "+c.calcularArea());
    }
}
