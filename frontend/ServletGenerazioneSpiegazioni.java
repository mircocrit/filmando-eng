package frontend;


import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.*;

@WebServlet("/generazioneSpiegazioni")
/*Questa servlet serve a creare il file delle spiegazioni spiegazioni<timestamp>.txt .
In base ai parametri degli IdFrase passati alla servlet, viene letta:
1) lista ID delle frasi del centroide
2) lista ID delle frasi per contesti singoli
3) lista ID della frasi della baseline;
4) vengono lette le frasi intere dai file di testo e di oggetti 
5) tramite un template per tipo di spiegazione,
vengono generate le 3 spiegazioni e salvate su un file chiamato spiegazioni<timestamp>.txt
6) viene inviato alla pagina result1.jsp tramite metodo GET l'id del film scelto.
*/
public class ServletGenerazioneSpiegazioni extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	// Strutture parametri
        ArrayList<Integer> frasiCentroide = new ArrayList<Integer>();
        HashMap<Integer, Integer> frasiSingole = new HashMap<Integer, Integer>();
        int locale = 0;
        
        String configurazione = "";//PER REPORT
        try{
            Map<String, String[]> mappaParametri = request.getParameterMap();	// RICEZIONE PARAMETRI DALLA GET
            //generazioneSpiegazioni?tempo=28282912		&configurazione=unigrammi		&locale=112
            //&centroide=2289&centroide=393&centroide=3283		&frasiSingole=4:234&frasiSingole=7:113
            for (String parametro : mappaParametri.keySet()) {
                if (parametro.equals("centroide")){
                    for (String frase : mappaParametri.get(parametro)){
                        frasiCentroide.add(Integer.parseInt(frase));//AGGIUNGO ID FRASI
                    }
                }
                else if (parametro.equals("frasiSingole")){
                    for (String contestoFrase : mappaParametri.get(parametro)){
                        int contesto = Integer.parseInt(contestoFrase.split(":")[0]);//IDCONTESTO
                        int frase = Integer.parseInt(contestoFrase.split(":")[1]);	//IDFRASE
                        frasiSingole.put(contesto, frase);
                    }
                } 
                else if (parametro.equals("locale")){
                    locale = Integer.parseInt(mappaParametri.get(parametro)[0]);//IDFILM
                } 
                else if (parametro.equals("configurazione")){
                    configurazione = mappaParametri.get(parametro)[0];
                }
            }
    	
/////////////////////////////////////////2) SPIEGAZIONI CENTROIDE///////////////////////////////////////////////////
            System.out.println("\n-------------------------------INIZIO GENERAZIONE SPIEGAZIONI-----------------------------");
            String titoloLocale = getTitoloLocale(locale);
      //////////////////////////LETTURA FRASI INTERE FILM .dat///////////////////
            TreeMap<Integer, String> mappaFrasi = Locale.LeggiFrasiLocaleDAT(locale);

      /////////////////////////////////CALCOLO N CONTESTI/////////////////////////////////////////  
            int numeroContesti = frasiSingole.size();            
///////////////////////////////////////2) SPIEGAZIONI CENTROIDE//////////////////////////////////////////
            System.out.println("////////////////////////////////2) SPIEGAZIONE CENTROIDE://////////////////////////////////////////");
            String spiegazioneCentroide = generazioneCentroide(frasiCentroide, mappaFrasi, numeroContesti, titoloLocale);//GENERAZIONE SPIEGAZIONE CENTROIDE
            System.out.println(spiegazioneCentroide + "\n"); //STAMPA A VIDEO CENTROIDE
            
            ///////////////////////////1) SPIEGAZIONI GIUSTAPPOSIZIONE FRASI SINGOLE//////////////////////////////////////////
            System.out.println("////////////////////////////////1) SPIEGAZIONE GIUSTAPPOSIZIONE FRASI SINGOLE://////////////////////////////////////////");//GENERAZIONE SPIEGAZIONI FRASI SINGOLE 
            String spiegazioneSingole = generazioneFrasiSingole(frasiSingole, mappaFrasi, numeroContesti, titoloLocale);
    		System.out.println(spiegazioneSingole + "\n");//STAMPA A VIDEO FRASI SINGOLE
    		
    		
            //////////////////////////////////3) BASELINE PUCARIELLO/////////////////////////// 
            System.out.println("////////////////////////////////3) SPIEGAZIONE BASELINE://////////////////////////////////////////");
            String spiegazioneBaseline = generazioneBaseline(frasiSingole, locale);
            System.out.println(spiegazioneBaseline + "\n");//STAMPA A VIDEO BASELINE	
            
            	///////////////////////////////4) BASELINE DISTRIBUZIONALE/////////////////////////// 
            System.out.println("////////////////////////////////4) SPIEGAZIONE BASELINE DISTRIBUZIONALE://////////////////////////////////////////");
            String spiegazioneBaseline2 = generazioneBaseline2(frasiSingole, locale);
            System.out.println(spiegazioneBaseline2 + "\n");//STAMPA A VIDEO BASELINE DISTRIBUZIONALE	
            
///////////////////////////////////SCRITTURA SPIEGAZIONI SU FILE//////////////////////////////////////
            ///////////////SCRITTURA SU FILE SPIEGAZIONI
            String tempo = request.getParameter("tempo").trim();
            PrintWriter spiegazioni = new PrintWriter(
            		Configurazione.path + "filesFilmando2/temp/spiegazioni" + tempo + ".txt");
            spiegazioni.println(spiegazioneCentroide);	//1 rigo
            spiegazioni.println(spiegazioneSingole);	//2 rigo
            spiegazioni.println(spiegazioneBaseline);	//3 rigo
            spiegazioni.println(spiegazioneBaseline2);	//4 rigo
            spiegazioni.flush();
            spiegazioni.close();
            
            System.out.println("--------------------------FINE GENERAZIONE SPIEGAZIONI------------------------------\n\n");
            
            /////////////////////////////INVIO DATI A RESULT1 PER STAMPA
            String url = "pagine/results1.jsp?tempo=" + tempo + "&locale=" + locale;
            response.sendRedirect(url);
        
        } catch (Exception e){
            e.printStackTrace();
        
        }

    }
    
//////////////////////////////////////////////GENERAZIONE SPIEGAZIONI///////////////////////////////////////////////
//Tale metodo genera le spiegazioni attraverso il centroide, passandogli la lista delle frasi centroide, le frasi intere e il n dei contesti
    public static String generazioneCentroide(ArrayList<Integer> frasiCentroide, TreeMap<Integer, String> mappaFrasi, int numeroContesti, String titoloLocale) {
    	String spiegazioneCentroide = "";
        if (numeroContesti == 1){
            spiegazioneCentroide += "I recommend you <b>" + titoloLocale + "</b> for the context you have selected, ";
        } 
        else {														//PLURALE
            spiegazioneCentroide += "I recommend you <b>" + titoloLocale + "</b> for the contexts you have selected, ";
        }
        spiegazioneCentroide += "because people who liked the movie think that <b>";

		//////////////////////////////////////
        int count=0;
        for (int frase : frasiCentroide){
            String f = mappaFrasi.get(frase).trim().replace("\"", "").replace("(","").replace(")","");
            if (f.charAt(f.length()-1) == '.' || f.charAt(f.length()-1) == ';')
            	f = f.substring(0, f.length()-1);
            if(f.split(" ")[0].toLowerCase().equals("a") || f.split(" ")[0].toLowerCase().equals("an"))		{f = "it's " + f.substring(0,1).toLowerCase() + f.substring(1); }//AGGIUNGI IT'S CON LE FRASI CON A DAVANTI
            spiegazioneCentroide += f.substring(0,1).toLowerCase() + f.substring(1) + " </b>";
            count++;
            if(count<3) {
            	if(count==1)	spiegazioneCentroide += " and that <b>";//1 ITERATA
            	if(count==2)	spiegazioneCentroide += ". Moreover, they said that <b>";//2 ITERATA
            }
        }
        spiegazioneCentroide += ".</b>";
        return spiegazioneCentroide;	//FINE SPIEGAZIONI CENTROIDE
    }
    ///////////////////////////////////////////////////////////////////////
    
    
/////////////////////////////////////////////////////////////////////////////////////////////
//Tale metodo genera le spiegazioni attraverso la gisutapposizione, passandogli la lista delle frasi singole per contesto, le frasi intere e il n dei contesti 
    public static String generazioneFrasiSingole(HashMap<Integer, Integer> frasiSingole, TreeMap<Integer, String> mappaFrasi, int numeroContesti, String titoloLocale) {
		HashMap<String, ArrayList<Integer>> fraseContesti = new HashMap<String, ArrayList<Integer>>();
		//{He's always loved the movie but it somehow never made it to our shelf.=[3], 
		//If you love enormously entertaining action movies, then this is the movie for you.=[2], 
		String spiegazioneSingole = "I recommend you <b>" + titoloLocale + "</b> because people who liked the movie think that";
        ////////////////////////////CREAZ FRASE CONTESTI/////////////////////////////////
		int cont = 0;
        for (int c : frasiSingole.keySet()){
            if (fraseContesti.containsKey(mappaFrasi.get(frasiSingole.get(c)))){
                fraseContesti.get(mappaFrasi.get(frasiSingole.get(c))).add(c);
            }
            else {
                ArrayList<Integer> temp = new ArrayList<Integer>();
                fraseContesti.put(mappaFrasi.get(frasiSingole.get(c)), temp);
                fraseContesti.get(mappaFrasi.get(frasiSingole.get(c))).add(c);
            }
        }
        System.out.println(fraseContesti);
        //////////////////////////////////////solo da 2 frase in poi/////////////////
        for (String f : fraseContesti.keySet()){
            cont++;
            if (cont == 2 || cont == 4){
                spiegazioneSingole += ", and that"; //2 FRASE
            }
            else if (cont == 3){
                spiegazioneSingole += "; moreover,"; //3 FRASE
            }
            else if (cont == 5){//NON ABBIAMO 5 CONTESTI
                spiegazioneSingole += "; finally, they said that ";
            }
            //CASO IN CUI ABBIAMO UNA STESSA FRASE PER 2 CONTESTI DIVERSI (ES: Frasi singole: {2=3195, 6=3195}
            if (fraseContesti.get(f).size() != 1){
                String parteFraseContesti = "";//PREPARAZIONE PARTE PRECEDENTE
                
                for (int i=0; i<fraseContesti.get(f).size(); i++){
                    if (i > 0) 		cont++;
                    int c = fraseContesti.get(f).get(i);
                    switch (c){
                        case 1:
                            parteFraseContesti += " it's suitable for <b>high attention</b> contexts because ";
                            break;
                        case 2:
                            parteFraseContesti += " it's suitable if you <b>don't</b> want to <b>be focused</b> on it because ";
                            break;
                        ///////////////////////////
                        case 3:
                            parteFraseContesti += " it's perfect to spend an evening in <b>sweet company</b> because ";
                            break;
                        case 4:
                            parteFraseContesti += " it's perfect to watch in <b>family</b> with your <b>children</b> because ";
                            break;
                        case 5:
                            parteFraseContesti += " it's perfect to watch with your <b>friends</b> because ";
                            break;
                        //////////////////////////////////
                        case 6:
                            parteFraseContesti += " it's perfect to watch in <b>good mood</b> because ";
                            break;
                        case 7:
                            parteFraseContesti += " it's perfect to watch in a <b>bad mood</b> because ";
                            break;

                    }
                    //togliere perchè a tutti quelli che non sono ultimi
                    if (i <= fraseContesti.get(f).size()-1){
                        parteFraseContesti = parteFraseContesti.split("because ")[0];
                    }
                    if (i != fraseContesti.get(f).size()-1){
                        if (i < fraseContesti.get(f).size()-2){
                            parteFraseContesti += ", ";
                        } 
                        else {
                            parteFraseContesti += " and ";
                        }
                    } 
                    else{
                        parteFraseContesti += " because: ";
                    }
                }
                //RIMOZIONE . E ; ALLA FINE
                if (f.charAt(f.length()-1) == '.' || f.charAt(f.length()-1) == ';')//rimuovo , o ;
                	f = f.substring(0, f.length()-1);
                
                String fr2 = f.replace("\"","").replace("(","").replace(")","");//RIMOZIONE DI "",(,)..
                if(fr2.split(" ")[0].toLowerCase().equals("a") || fr2.split(" ")[0].toLowerCase().equals("an") )		{fr2 = "it's " + fr2.substring(0,1).toLowerCase() + fr2.substring(1); }//AGGIUNGI IT'S CON LE FRASI CON A DAVANTI
                spiegazioneSingole += parteFraseContesti + "<b>" + fr2.substring(0,1).toLowerCase() + fr2.substring(1) +"</b>";	//spiegazioneSingole += parteFraseContesti + "<b>" + f +"</b>";

            }
            
            else {	
            	
           ///////////////////////////CONTESTO SINGOLO/////////////////////////////
                int c = fraseContesti.get(f).get(0);
                switch (c){
                    case 1:
                        spiegazioneSingole += " it's suitable for <b>high attention</b> contexts because ";
                        break;
                    case 2:
                        spiegazioneSingole += " it's suitable if you <b>don't</b> want to <b>be focused</b> on it because ";
                        break;
                    
                    case 3:
                        spiegazioneSingole += " it's perfect to spend an evening in <b>sweet company</b> because ";
                        break;
                    case 4:
                        spiegazioneSingole += " it's perfect to watch in <b>family</b> with your <b>children</b> because ";
                        break;
                    case 5:
                        spiegazioneSingole += " it's perfect to watch with your <b>friends</b> because ";
                        break;
                    
                    case 6:
                        spiegazioneSingole += " it's perfect to watch in <b>good mood</b> because ";
                        break;
                    case 7:
                        spiegazioneSingole += " it's perfect to watch in a <b>bad mood</b> because ";
                        break;
                }
                String fr = mappaFrasi.get(frasiSingole.get(c)).replace("\"","").replace("(","").replace(")","");
                //RIMOZIONE . E ; ALLA FINE
                if (fr.charAt(fr.length()-1) == '.' || fr.charAt(fr.length()-1) == ';')//rimuovo , o ;
                	fr = fr.substring(0, fr.length()-1);
                if(fr.split(" ")[0].toLowerCase().equals("a") || fr.split(" ")[0].toLowerCase().equals("an") )		{fr = "it's " + fr.substring(0,1).toLowerCase() + fr.substring(1); }//AGGIUNGI IT'S CON LE FRASI CON A DAVANTI
                spiegazioneSingole += "<b>" + fr.substring(0,1).toLowerCase() + fr.substring(1) +"</b>";
            }//FINE ELSE (CONT SINGOLO)
            
        }
        spiegazioneSingole += ".";

        return spiegazioneSingole;	//FINE SPIEGAZIONE GIUSTAPPOSIZIONE FRASI SINGOLE
    }
    
    
 //////////////////////////////////////BASELINE////////////////////////////////////////////   
    //Tale metodo genera la spiegazione baseline come MEDIA di tutti i CONTESTI
    public static String generazioneBaseline2(HashMap<Integer, Integer> frasiSingole,  int locale) throws FileNotFoundException {
 	   String spiegazioneBaseline = "I recommend you <b>" + getTitoloLocale(locale)  + "</b> because people who watched the movie think that ";
       Scanner baseline = new Scanner(new File(Configurazione.path + "filesFilmando2/baseline2.txt" ));

       while (baseline.hasNextLine()){
           String rigaBaseline = baseline.nextLine();
           int localeRigaBaseline = Integer.parseInt(rigaBaseline.split(";")[0]);
           if (locale == localeRigaBaseline){
        	   String fr = rigaBaseline.split(";")[1];
               spiegazioneBaseline += "<b>" + fr.substring(0,1).toLowerCase() + fr.substring(1) + "</b>";
           }
      }
      baseline.close();
      spiegazioneBaseline.replace("\"", "").replace("(","").replace(")","");
      return spiegazioneBaseline;
    }
    
 ///////////////////////////////////////////////////////////////////   
    //il metodo genera la spiegazone baseline PUCARIELLO
    public static String generazioneBaseline(HashMap<Integer, Integer> frasiSingole,  int locale) throws FileNotFoundException {
 	   String spiegazioneBaseline = "";     
       Scanner baseline = new Scanner(new File(	
             Configurazione.path + "filesFilmando2/baseline.txt" ));
       spiegazioneBaseline = "";
           
       while (baseline.hasNextLine()){
           String rigaBaseline = baseline.nextLine();
           int localeRigaBaseline = Integer.parseInt(rigaBaseline.split(";")[0]);
           if (locale == localeRigaBaseline){
                spiegazioneBaseline = rigaBaseline.split(";")[1] + "</b>";
           }
       }
       baseline.close();
       spiegazioneBaseline.replaceAll("\"", "");
       return spiegazioneBaseline;
    }
    
    
    
    //PER AGGIUNGERE IL TITOLO DEL FILM
    public static String getTitoloLocale(int locale) throws FileNotFoundException {
    	Scanner infoLocale = new Scanner(new File(
            Configurazione.path + "filesFilmando2/info utili/" + locale + ".txt"));
        infoLocale.nextLine();  //IDFILM
        String nomeLocale = infoLocale.nextLine().replaceAll("'", "");//TITOLO FILM
        infoLocale.close();
        return nomeLocale;
    }

    
}
