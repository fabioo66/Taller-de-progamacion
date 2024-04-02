package Practica_4;

public class Circulo extends Figura{
    private double radio;
    
    public Circulo (double unRadio, String unColorL, String unColorR){
        super(unColorL, unColorR);
        setRadio(unRadio);
    }

    public double getRadio() {
        return radio;
    }
    
    public void setRadio(double unRadio){
        radio = unRadio;
    }
    
    public double calcularArea(){
         return(Math.PI*radio*radio);
    }
    
    public double calcularPerimetro(){
        return(2*radio*Math.PI);
    }
    
    public String toString(){
        String aux = super.toString() +
                     " Radio " + this.getRadio();
        return aux;     
    }
}
