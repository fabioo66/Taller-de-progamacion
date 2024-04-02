package Practica_4;

public class Trabajador extends Persona{
    private String profesion;
    
    public Trabajador(String unNombre, int unDNI, int unaEdad, String unaProfesion){
        super(unNombre, unDNI, unaEdad);
        setProfesion(unaProfesion);
    }

    public String getProfesion() {
        return profesion;
    }

    public void setProfesion(String profesion) {
        this.profesion = profesion;
    }
    
    public String toString(){
        String aux;
        aux = super.toString() + " soy "+ getProfesion();
        return aux;
    }
}
