package Practica_4;

public abstract class Estacion {
    private String nombre;
    private double latitud;
    private double longitud;
    
    public Estacion(String unNombre, double unaLatitud, double unaLongitud){
        setNombre(unNombre);
        setLatitud(unaLatitud);
        setLongitud(unaLongitud);
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }          
}
