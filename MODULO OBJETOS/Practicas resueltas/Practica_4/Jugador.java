package Practica_4;

public class Jugador extends Empleado{
    private int cantGoles;
    private int partidosJugados;
    
    public Jugador(String unNombre, double unSueldo, int unaAntiguedad, int unaCantGoles, int partidosJugados){
        super(unNombre, unSueldo, unaAntiguedad);
        setCantGoles(unaCantGoles);
        setPartidosJugados(partidosJugados);
    }

    public int getCantGoles() {
        return cantGoles;
    }

    public void setCantGoles(int unaCantGoles) {
        this.cantGoles = unaCantGoles;
    }

    public int getPartidosJugados() {
        return partidosJugados;
    }

    public void setPartidosJugados(int partidosJugados) {
        this.partidosJugados = partidosJugados;
    }
    
    public double calcularEfectividad(){
        return(double)getCantGoles()/getPartidosJugados();
    }
    
    public double calcularSueldoACobrar(){
        if(calcularEfectividad() > 0.5)
            return((this.getSueldo()*2)+(this.getSueldo()*0.1*this.getAntiguedad()));
        else
            return(this.getSueldo()+(this.getSueldo()*0.1*this.getAntiguedad()));
    }
}