package Practica_4;

public class Ejercicio_1 {

    public static void main(String[] args) {
        Triangulo T = new Triangulo(30, 30, 30, " Amarillo ", " Azul ");
        Circulo C = new Circulo(30, " Verde ", " Cyan ");
        
        System.out.println(T.toString());
        System.out.println(C.toString());
        
        T.despintar();
        System.out.println(T.toString());
        
        C.despintar();
        System.out.println(C.toString());
    }
    
}
