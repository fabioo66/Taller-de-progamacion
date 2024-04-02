
package Practica_4;

public class Ejercicio_3 {

    public static void main(String[] args) {
        Persona P = new Persona("Fabio", 45579759, 19);
        Trabajador T = new Trabajador("Sergio", 48679567, 50, "Policia");
        
        System.out.println(P.toString());
        System.out.println(T.toString());
    }
    
}
