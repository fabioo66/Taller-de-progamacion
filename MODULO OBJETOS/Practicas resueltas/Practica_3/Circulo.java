/*
A- Definir una clase para representar círculos. Los círculos se caracterizan por su radio
(double), el color de relleno (String) y el color de línea (String).
Provea un constructor que reciba todos los datos necesarios para iniciar el objeto.
Provea métodos para:
- Devolver/modificar el valor de cada uno de sus atributos (métodos get y set)
- Calcular el perímetro y devolverlo (método calcularPerimetro)
- Calcular el área y devolverla (método calcularArea)
 */
package Practica_3;

public class Circulo {
    private double radio;
    private String relleno;
    private String linea;
    
    public Circulo(double unRadio, String unRelleno, String unaLinea){
        radio = unRadio;
        relleno = unRelleno;
        linea = unaLinea;
    }

    public double getRadio() {
        return radio;
    }

    public String getRelleno() {
        return relleno;
    }

    public String getLinea() {
        return linea;
    }

    public void setRadio(double unRadio){
        radio = unRadio;
    }
    
    public void setRelleno(String unRelleno){
        relleno = unRelleno;
    }
    
    public void setLinea(String unaLinea){
        linea = unaLinea;
    }
    
    public double calcularPerimetro(){
        double aux;
        aux = 2*radio*Math.PI;
        return aux;
    }
    
    public double calcularArea(){
        double aux;
        aux = Math.PI*radio*radio;
        return aux;
    }
}
