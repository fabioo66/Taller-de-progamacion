package Practica_4;

public class Triangulo extends Figura{
    private double lado1;
    private double lado2;
    private double lado3;
    
    public Triangulo(double unLado1, double unLado2, double unLado3, String unColorL, String unColorR){
        super(unColorL, unColorR);
        setLado1(unLado1);
        setLado2(unLado2);
        setLado3(unLado3);
    }

    public double getLado1() {
        return lado1;
    }

    public double getLado2() {
        return lado2;
    }

    public double getLado3() {
        return lado3;
    }
    
    public void setLado1(double unLado1){
        lado1 = unLado1;
    }
    
    public void setLado2(double unLado2){
        lado2 = unLado2;
    }
    
    public void setLado3(double unLado3){
        lado3 = unLado3;
    }
    
    public double calcularArea(){
       double s = ((this.getLado1() + this.getLado2() + this.getLado3())/2);
       double area= Math.sqrt(s*(s-this.getLado1())*(s-this.getLado2())*(s-this.getLado3()));
       return area;
    }
    
    public double calcularPerimetro(){
        return(this.getLado1() + this.getLado2() + this.getLado3());
    }
    
    public String toString(){
        String aux = super.toString() + 
                     " Lado1 " + this.getLado1() +
                     " Lado2 " + this.getLado2() +
                     " Lado3 " + this.getLado3();
        return aux;
    }
}
