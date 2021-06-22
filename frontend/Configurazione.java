package frontend;

import java.util.HashMap;
import java.util.Random;

/*
La classe configurazione contiene 
- l'attributo tipoLemma, che indica quale configurazione è utilizzata (unigrammi,  bigrammi, unibigrammi)
- il numero dei film e numero dei contesti; 
- il path della cartella dei file
- la lista dei nomi dei contesti
*/

public class Configurazione {
    public static String TipoLemmi = "unigrammi";
    //public static String TipoLemmi = "bigrammi";
    //public static String TipoLemmi = "unibigrammi";
    
    public static Random number = new Random();
    
    public static String tecnica = "normale";
    //public static String tecnica = "pmi";
    
    public static String TipoFrasi = "frasisingole";	//frasisingole
    //public static String TipoFrasi = "centroide";	//centroide
    //public static String path = "";	//DEPLOY
    public static String path = "C:\\Users\\Mirco\\Desktop\\";	//RUN COMPLETA
    public static Integer numeroLocali = 288;					//RUN COMPLETA
    //public static String path = "D:\\Università\\INFORMATICA\\3 anno\\TESI\\review based explanation\\";	//DEBUG
    //public static Integer numeroLocali = 5;		//DEBUG
    
    public static Integer numeroContesti = 7;
    public static HashMap<Integer, String> contesti = new HashMap<>();
    static {
        contesti.put(1, "High Attention");
        contesti.put(2, "Low Attention");
        contesti.put(3, "Couple");
        contesti.put(4, "Babies");
        contesti.put(5, "Friends");
        contesti.put(6, "Good Mood");
        contesti.put(7, "Bad Mood");
    }
    
    //Il metodo  tipoRandom() imposta casualemente una delle 3 configurazioni.
    public static void tipoRandom(){
    	number= new Random();
        int p = number.nextInt(3);
        if (p == 0){            TipoLemmi = "unigrammi";} 
        else if (p == 1){       TipoLemmi = "bigrammi";} 
        else {            		TipoLemmi = "unibigrammi";}
    }
    
    //Il metodo  tecnicaRandom() imposta casualemente una delle 2 tecniche.
    public static void tecnicaRandom(){
    	number= new Random();
        boolean value = number.nextBoolean();
        if (value == true){  	tecnica = "normale";} 
        else {        			tecnica = "pmi";}
    }
    
    public static void tipoFrasiRandom(){
    	number= new Random();
        boolean value2 = number.nextBoolean();
        if (value2 == true){  	TipoFrasi = "centroide";} 
        else {        			TipoFrasi = "frasisingole";}
    }
    
    
    
}
