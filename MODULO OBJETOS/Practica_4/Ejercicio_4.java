package Practica_4;

public class Ejercicio_4 {

    public static void main(String[] args) {
        VisorFigurasCatedra visor = new VisorFigurasCatedra();

        Cuadrado c1 = new Cuadrado(10,"Violeta","Rosa");
        Rectangulo r= new Rectangulo(20,10,"Azul","Celeste");
        Cuadrado c2= new Cuadrado(30,"Rojo","Naranja");

        visor.mostrar(c1);
        visor.mostrar(r);
        visor.mostrar(c2);

        System.out.println(visor.getMostradas());
    }    
} 

