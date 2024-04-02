package Practica_4;

public class TemperaturaPromedioMensual extends Estacion{
    private double matriz[][];
    private int dimf;
    private int anioDeInicio;
    private double temperatura;
    
    public TemperaturaPromedioMensual(String unNombre, double unaLatitud, double unaLongitud, int N, int A, double unaTemperatura){
        super(unNombre, unaLatitud, unaLongitud);
        setDimf(N);
        setAnioDeInicio(A);
        setTemperatura(unaTemperatura);
        matriz = new double [dimf][12];
        for(int i=0; i<dimf; i++)
            for(int j=0; j<12; j++)
                matriz[i][j] = temperatura;
    }
    
    public int getDimf(){
        return dimf;
    }
    
    public int getAnioDeInicio(){
        return anioDeInicio;
    }
    
    public void setDimf(int N){
        dimf = N;
    }
    
    public void setAnioDeInicio(int A){
        anioDeInicio = A;
    }
    
    public void setTemperatura(double unaTemperatura){
        temperatura = unaTemperatura;
    }

}    


