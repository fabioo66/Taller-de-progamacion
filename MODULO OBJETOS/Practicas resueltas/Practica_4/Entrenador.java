package Practica_4;

public class Entrenador extends Empleado{
    private int cantCampeonatosGanados;
    
    
    public Entrenador(String unNombre, double unSueldo, int unaAntiguedad, int cantCampeonatos){
        super(unNombre, unSueldo, unaAntiguedad);
        setCantCampeonatosGanados(cantCampeonatos);
    }

    public int getCantCampeonatosGanados() {
        return cantCampeonatosGanados;
    }

    public void setCantCampeonatosGanados(int cantCampeonatosGanados) {
        this.cantCampeonatosGanados = cantCampeonatosGanados;
    }
    
    public double calcularEfectividad(){
        return(double)getCantCampeonatosGanados()/this.getAntiguedad();
    }
    
    public double calcularSueldoACobrar(){
        if(getCantCampeonatosGanados() <= 4)
            return(this.getSueldo()+(this.getSueldo()*0.1*this.getAntiguedad())+5000);
        else if(getCantCampeonatosGanados() <= 10)
            return(this.getSueldo()+(this.getSueldo()*0.1*this.getAntiguedad())+30000);
        else
            return(this.getSueldo()+(this.getSueldo()*0.1*this.getAntiguedad())+50000);
    }
}
