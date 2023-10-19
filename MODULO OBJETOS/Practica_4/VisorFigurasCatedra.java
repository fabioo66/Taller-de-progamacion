package Practica_4;

public class VisorFigurasCatedra {
    private int mostradas;

    public VisorFigurasCatedra(){
        mostradas=0;
    }
    
    public void mostrar(Figura f){
        System.out.println(f.toString());
        mostradas++;
    }
    
    public int getMostradas() {
        return mostradas;
    }
}