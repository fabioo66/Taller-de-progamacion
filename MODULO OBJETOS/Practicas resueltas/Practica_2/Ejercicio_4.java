/*
 Implemente un programa que cargue un vector con a lo sumo 20 partidos disputados en
el campeonato. La información de cada partido se lee desde teclado hasta ingresar uno con
nombre de visitante “ZZZ” o alcanzar los 20 partidos. Luego de la carga:
- Para cada partido, armar e informar una representación String del estilo:
{EQUIPO-LOCAL golesLocal VS EQUIPO-VISITANTE golesVisitante }
- Calcular e informar la cantidad de partidos que ganó River.
- Calcular e informar el total de goles que realizó Boca jugando de local.
 */
package Practica_2;

import PaqueteLectura.Lector;

public class Ejercicio_4 {

    public static void main(String[] args) {
        int DF = 20;
        Partido P = null;
        Partido vector [] = new Partido [DF];
        
        int diml=0;
        System.out.println("Ingrese el nombre del equipo visitante");
        String nombrevisitante= Lector.leerString();
        while(diml < DF && !nombrevisitante.equals("ZZZ")){
            System.out.println("Ingrese el equipo local");
            String nombrelocal = Lector.leerString();
            System.out.println("Ingrese la cantidad de goles del equipo visitante");
            int golesvisitante = Lector.leerInt();
            System.out.println("Ingrese la cantidad de goles del equipo local");
            int goleslocal = Lector.leerInt();
            P = new Partido(nombrelocal, nombrevisitante, goleslocal, golesvisitante);
            vector[diml] = P;
            diml++;
            System.out.println("Ingrese el nombre del equipo visitante");
            nombrevisitante= Lector.leerString();
        }
        int cant=0, golesboca = 0;
        for(int i=0; i<diml; i++){
            System.out.println(vector[i].getLocal()+ "  "+vector[i].getGolesLocal()+" | "+vector[i].getGolesVisitante()+"  "+vector[i].getVisitante());
            if(vector[i].getGanador().equals("River"))
                cant++;
            if(vector[i].getLocal().equals("Boca"))
                golesboca= golesboca + vector[i].getGolesLocal();
        }
        System.out.println("La cantidad de partidos que gano el CARP es "+cant);
        System.out.println("La cantidad de goles que hizo Boca de local es "+golesboca);
    } 
}
