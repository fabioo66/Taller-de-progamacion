package Practica_3;
import PaqueteLectura.GeneradorAleatorio;

public class Habitacion {
    private boolean ocupada;
    private double precio;
    private Cliente cliente;
    
    public Habitacion(){
        GeneradorAleatorio.iniciar();
        ocupada = false;
        precio = 2000 + GeneradorAleatorio.generarInt(6001);
        cliente = null;
}

    public boolean estaOcupada() {
        return ocupada;
    }

    public double getPrecio() {
        return precio;
    }

    public Cliente getCliente() {
        return cliente;
    }
    
    public void setOcupada(boolean unOk){
        ocupada = unOk;
    }
    
    public void setPrecio(double unPrecio){
        precio = unPrecio;
    }
    
    public void setCliente(Cliente unCliente){
        cliente = unCliente;
    }
    
    public void aumentarPrecioHabitacion(double unPrecio){
        precio = precio + unPrecio;
    }
        
    public void ingresarCliente(Cliente unCliente){
        setOcupada(true);
        setCliente(unCliente);
    }    
}