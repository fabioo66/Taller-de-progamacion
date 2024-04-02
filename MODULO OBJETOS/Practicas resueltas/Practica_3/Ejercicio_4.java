package Practica_3;

public class Ejercicio_4 {

    public static void main(String[] args) {
        Hotel H = new Hotel(5);
        for(int i=0; i<5; i++)
            H.agregarHabitacion(i);
        System.out.println(H.toString());
        H.aumentarPrecioTodasLasHabitaciones(10000);
        System.out.println(H.toString());
    }
}
