package Practica_4;

public abstract class Empleado {
    private String nombre;
    private double sueldo;
    private int antiguedad;

    public Empleado(String unNombre, double unSueldo, int unaAntiguedad){
        setNombre(unNombre);
        setSueldo(unSueldo);
        setAntiguedad(unaAntiguedad);
    }
    
    public String toString(){
        String aux = "nombre " + getNombre() +
                     "sueldo a cobrar " + this.calcularSueldoACobrar() + 
                     " efectividad "  + this.calcularEfectividad();        
             return aux;
       }

    public String getNombre() {
        return nombre;
    }

    public double getSueldo() {
        return sueldo;
    }

    public int getAntiguedad() {
        return antiguedad;
    }
    
    public void setNombre(String unNombre){
        nombre = unNombre;
    }
    
    public void setSueldo(double unSueldo){
        sueldo = unSueldo;
    }
    
    public void setAntiguedad(int unaAntiguedad){
        antiguedad= unaAntiguedad;
    }
    
    public abstract double calcularEfectividad();
    public abstract double calcularSueldoACobrar();
}