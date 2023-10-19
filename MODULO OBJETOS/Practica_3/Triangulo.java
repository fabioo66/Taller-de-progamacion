package Practica_3;


public class Triangulo {
    private double Lado1;
    private double Lado2;
    private double Lado3;
    private String ColorRelleno;
    private String ColorLinea;
    
    public Triangulo(){
    
    }
    
    public Triangulo(double unLado1, double unLado2, double unLado3, String unBackground, String unContorno){
        Lado1 = unLado1;
        Lado2 = unLado2;
        Lado3 = unLado3;
        ColorRelleno = unBackground;
        ColorLinea = unContorno;
    } 

    public double getLado1() {
        return Lado1;
    }

    public double getLado2() {
        return Lado2;
    }

    public double getLado3() {
        return Lado3;
    }

    public String getColorRelleno() {
        return ColorRelleno;
    }

    public String getColorLinea() {
        return ColorLinea;
    }

   public void setLado1(double unLado){
       Lado1 = unLado;
   }
   
   public void setLado2(double unLado){
       Lado2 = unLado;
   }
   
   public void setLado3(double unLado){
       Lado3 = unLado;
   }
   
   public void setColorRelleno(String unColor){
       ColorRelleno = unColor;
   }
   
   public void setColorLinea(String unaLinea){
       ColorLinea = unaLinea;
   }
   
   public double calcularPerimetro(){
       double perimetro;
       perimetro = Lado1 + Lado2 + Lado3;
       return perimetro;
   }

   public double calcularArea(){
       double s = (Lado1+Lado2+Lado3)/2;
       double area= Math.sqrt(s*(s-Lado1)*(s-Lado2)*(s-Lado3));
       return area;
   }   

    @Override
    public String toString() {
        return "Triangulo{" + "Lado1=" + Lado1 + ", Lado2=" + Lado2 + ", Lado3=" + Lado3 + ", ColorRelleno=" + ColorRelleno + ", ColorLinea=" + ColorLinea + '}';
    }
   
}
