package Practica_4;

public class Ejercicio_2 {

    public static void main(String[] args) {
        Jugador J = new Jugador("Haaland ", 5000, 4, 222, 500);
        Entrenador E = new Entrenador("Guardiola ", 5000, 5, 11);
        
        System.out.println(J.toString());
        System.out.println(E.toString());
    }
    
}
