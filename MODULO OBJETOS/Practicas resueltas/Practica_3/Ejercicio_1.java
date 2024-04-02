package Practica_3;

import PaqueteLectura.Lector;

public class Ejercicio_1 {


    public static void main(String[] args) {
        Triangulo T;
        System.out.println("Ingrese el Lado 1");
        double Lado1 = Lector.leerDouble();
        System.out.println("Ingrese el Lado 2");
        double Lado2 = Lector.leerDouble();
        System.out.println("Ingrese el Lado 3");
        double Lado3 = Lector.leerDouble();
        System.out.println("Ingrese el color de relleno");
        String fondo = Lector.leerString();
        System.out.println("Ingrese el color de linea");
        String contorno = Lector.leerString();
        T = new Triangulo(Lado1,Lado2,Lado3,fondo,contorno);
        System.out.println("El area del triangulo es "+ T.calcularArea()+" y el perimetro es "+ T.calcularPerimetro());
        System.out.println(T.toString());
    }
}
