package Practica_3;

public class Ejercicio_2 {

    public static void main(String[] args) {
        Autor autor = new Autor("Pedro"," Empezo a escribir hace 10 años","Brandsen");
        
        Autor autor2 = new Autor("Fabio","horrible y bostero cagon","desconocido");
        
        Libro libro1= new  Libro( "Java: A Beginner's Guide",   
                                 "Mcgraw-Hill", 2014,   
                                 autor , "978-0071809252", 21.72);
        Libro libro2= new Libro("Learning Java by Building Android Games",  
                              "CreateSpace Independent Publishing", 
                               autor2, "978-1512108347");
        System.out.println(libro1.toString());
        System.out.println(libro2.toString());
        System.out.println("Precio del libro2: " +libro2.getPrecio());
        System.out.println("Año edición del libro2: " +libro2.getAñoEdicion());
        Libro libro3= new Libro(); 
        
        
        
        System.out.println(libro1.toString());
        System.out.println(libro2.toString());
    }
}
