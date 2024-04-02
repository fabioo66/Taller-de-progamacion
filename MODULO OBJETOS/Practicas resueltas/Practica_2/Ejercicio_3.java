/*
3- Se realizará un casting para un programa de TV. El casting durará a lo sumo 5 días y en
cada día se entrevistarán a 8 personas en distinto turno.
 a) Simular el proceso de inscripción de personas al casting. A cada persona se le pide
nombre, DNI y edad y se la debe asignar en un día y turno de la siguiente manera: las
personas primero completan el primer día en turnos sucesivos, luego el segundo día y así
siguiendo. La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los
40 cupos de casting.
Una vez finalizada la inscripción:
b) Informar para cada día y turno asignado, el nombre de la persona a entrevistar.
 */
package Practica_2;

import PaqueteLectura.Lector;
        
public class Ejercicio_3 {

    public static void main(String[] args) {
        // TODO code application logic here
    PersonaTest [][] matriz = new PersonaTest [5][8];
    PersonaTest P;
    /*inicializo matriz en null*/
    int i,j;
    for(i=0; i<5; i++)
        for(j=0; j<8; j++)
            matriz[i][j]= null;
    
    int turnos,dias=0;
    System.out.println("Ingrese el nombre de la persona");
    String nombre = Lector.leerString();        
    while(dias < 5 && !"ZZZ".equals(nombre)){
        turnos=0;
        while(turnos < 8 && !"ZZZ".equals(nombre)){ 
            System.out.println("Ingrese el DNI de la persona");
            int DNI = Lector.leerInt();
            System.out.println("Ingrese la edad de la persona");
            int edad = Lector.leerInt();
            P = new PersonaTest(nombre,DNI,edad);
            matriz[dias][turnos]= P;
            turnos++;
            System.out.println("Ingrese el nombre de la persona");
            nombre = Lector.leerString();
        }
        dias++;
    }

    dias = 0;
    while(dias < 5 ){
        turnos = 0;
        while(turnos < 8 && matriz[dias][turnos] != null){
            System.out.println("En el dia "+dias+ " y el turno "+turnos+" La persona a entrevistar es "+ matriz[dias][turnos].getNombre());
            turnos++;
        }
        dias++;
    }    
    }
}
