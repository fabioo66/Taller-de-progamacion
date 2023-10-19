package Practica_3;

public class Autor {
    private String nombre;
    private String biografia;
    private String origen;
    
    public Autor(){

    }
    
    public Autor(String unNombre, String unaBiografia, String unOrigen){
        nombre = unNombre;
        biografia = unaBiografia;
        origen = unOrigen;
    }

    public String getNombre() {
        return nombre;
    }

    public String getBiografia() {
        return biografia;
    }

    public String getOrigen() {
        return origen;
    }
    
    public void setNombre(String unNombre){
        nombre = unNombre;
    }
    
    public void setBiografia(String unaBiografia){
        biografia = unaBiografia;
    }
    
    public void setOrigen(String unOrigen){
        origen = unOrigen;
    }
    
    public String toString(){
        String aux;
        aux = "El nombre del autor es " +nombre+ " su biografia es " +biografia+ " y su origen es " +origen;
        return aux;
    }
}