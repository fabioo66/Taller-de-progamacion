package Practica_3;

import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Hotel {
    private Habitacion [] vector;
    private int cantHabitaciones;
    
    public Hotel(int N){
        setCantHabitaciones(N);
        vector = new Habitacion[cantHabitaciones];
        
        GeneradorAleatorio.iniciar();
        
        for (int i = 0; i < cantHabitaciones ;i++){
            Habitacion aux = new Habitacion();
            vector[i] = aux;
            
        }
    }
    public int getCantHabitaciones(){
        return cantHabitaciones;
    }
    
    public void setCantHabitaciones(int N){
        cantHabitaciones = N;
    }
    
    public Habitacion getHabitacion(int i){
        return vector[i];
}
    
    public void agregarHabitacion(int unaPosicion){
        System.out.println("ingre el nombre dni y edad separados por un enter");
        Cliente c = new Cliente(Lector.leerString(), Lector.leerInt(),Lector.leerInt());
        vector[unaPosicion].ingresarCliente(c);
    }
    
    public void aumentarPrecioTodasLasHabitaciones(double unPrecio){
        for (int i = 0; i < cantHabitaciones; i++)
           vector[i].aumentarPrecioHabitacion(unPrecio);
    }

    public String toString() {
    String result ="";

    for (int i = 0; i < cantHabitaciones; i++) {
        result += "{Habitación " + (i + 1) + ": costo " + vector[i].getPrecio();

        if (vector[i].estaOcupada()) {
            result += ", ocupada, información del cliente: " + vector[i].getCliente().toString();
        } else {
            result += ", libre";
        }

        result += "}\n";
    }

    return result;
    }
}
