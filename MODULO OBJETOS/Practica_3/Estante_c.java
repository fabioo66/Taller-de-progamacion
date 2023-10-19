/*
 Defina una clase para representar estantes. Un estante almacena a lo sumo 20 libros.
Implemente un constructor que permita iniciar el estante sin libros. Provea métodos para:
(i) devolver la cantidad de libros que almacenados (ii) devolver si el estante está lleno
(iii) agregar un libro al estante (iv) devolver el libro con un título particular que se recibe.
 */
package Practica_3;


public class Estante_c {
    private Libro[] vectorLibros;
    private int cantLibros;
    private int unaCantMax;
    
    public Estante_c(){
        vectorLibros = new Libro[unaCantMax];
        for(int i=0; i<unaCantMax; i++)
            vectorLibros[i]=null;
        cantLibros = 0;
    }
    
    public int getCantLibros(){
        return cantLibros;
    }
    
    public boolean getEstaLleno(){
        boolean aux;
        return aux = cantLibros == unaCantMax;
    }
    
    public void setUnaCantMax(int dimf){
        unaCantMax = dimf;
    }
    
    public void setAgregarLibro(Libro unLibro){
        if(cantLibros < unaCantMax){
            vectorLibros[cantLibros]= unLibro;
            cantLibros++;
        }
        else
            System.out.println("No se pudo agregar, el estante esta lleno");
    }
    
    public Libro getBusquedaLibro(String unTitulo){
        int pos=0;
        while(pos < cantLibros && !vectorLibros[pos].getTitulo().equals(unTitulo))
            pos++;
        if(vectorLibros[pos].getTitulo().equals(unTitulo))
            return vectorLibros[pos];
        else  
            return null;   
    }
}