/*
B- Realice un programa que instancie un estante. Cargue varios libros. A partir del estante,
busque e informe el autor del libro “Mujercitas”.

 */
package Practica_3;

import PaqueteLectura.Lector;

public class Ejercicio_3 {

    public static void main(String[] args) {
        Estante E = new Estante();
        Libro L = null;
        Autor A;
        for(int i=0; i<5; i++){
            System.out.println("Ingrese el nombre, La biografia y el origen separados por un espacio");
            A = new Autor(Lector.leerString(), Lector.leerString(), Lector.leerString());
            
            System.out.println("Ingrese el Titulo del libro");
            String Titulo = Lector.leerString();
            E.setAgregarLibro(new Libro(Titulo, " Ufotable  ", 1980, A, " pepe1232132 ", 2500));
        }  
        System.out.println(E.getCantLibros());
        System.out.println(E.getEstaLleno());
        
        Libro libroaux;
        libroaux = E.getBusquedaLibro("Mujercitas");
        if(libroaux != null)
            System.out.println(libroaux.getPrimerAutor().toString());
        else
            System.out.println("No se encontro");
    }
}
