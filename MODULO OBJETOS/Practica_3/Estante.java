/*
 Defina una clase para representar estantes. Un estante almacena a lo sumo 20 libros.
Implemente un constructor que permita iniciar el estante sin libros. Provea métodos para:
(i) devolver la cantidad de libros que almacenados (ii) devolver si el estante está lleno
(iii) agregar un libro al estante (iv) devolver el libro con un título particular que se recibe.
 */
package Practica_3;


public class Estante {
    private Libro[] vectorLibros;
    private int cantLibros;
    
    
    public Estante(){
        vectorLibros = new Libro[20];
        for(int i=0; i<20; i++)
            vectorLibros[i]=null;
        cantLibros = 0;
    }
    
    public int getCantLibros(){
        return cantLibros;
    }
    
    public boolean getEstaLleno(){
        boolean aux;
        return aux = cantLibros == 20;
    }
    
    public void setAgregarLibro(Libro unLibro){
        if(cantLibros < 20){
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
        if(pos < cantLibros)
            return vectorLibros[pos];
        else  
            return null;   
    }
}
