package Practica_4;

public class VisorFiguras {
    private int guardadas;
    private int capacidadMaxima = 5;
    private Figura [] vector;

    public VisorFiguras(){
        vector = new Figura[capacidadMaxima];
        for(int i = 0; i<capacidadMaxima; i++)
            vector[i]=null;
        guardadas = 0;
    }
    
    public void guardar(Figura f){
        if(guardadas < 5){
            vector[guardadas] = f;
            guardadas++;
        }    
        else
            System.out.println("No hay mas espacio para guardar figuras");
    }
    
    public boolean quedaEspacio(){
        return(guardadas < 5);
    }
    
    public void mostrar(){
        for(int i = 0; i<guardadas; i++)
            System.out.println(vector[i].toString());
    }
    
    public int getGuardadas() {
        return guardadas;
    }
}