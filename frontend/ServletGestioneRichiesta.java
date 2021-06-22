
public class ServletGestioneRichiesta extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Configurazione.tipoRandom();//SCELTA CONFIGURAZIONE RANDOM: unigrammi, bigrammi, unibigrammi
        Configurazione.tecnicaRandom();//SCELTA TECNICA RANDOM: normale, pmi
        
        String configurazione = Configurazione.TipoLemmi;//ASSEGNO CONFIGURAZ GENERATA
        String tecnica = Configurazione.tecnica;		//ASSEGNO TECNICA GENERATA
        System.out.println("//////////////////////////////////////GESTIONE RICHIESTA//////////////////////////////////");
        System.out.println("CONFIGURAZIONE: " + configurazione);
        System.out.println("TECNICA: " + tecnica);
        int contatoreVuoti=0;
        
        HashSet<Integer> contesti = new HashSet<>();

        Map<String, String[]> parametri = request.getParameterMap();



        try {
            System.out.println("CONTESTI selezionati: " + contesti);	//[2,3,6]
            int locale = selezioneFilm(contesti);//selezione FILM da suggerire
            System.out.println("FILM suggerito: " + locale + "\n");			//11
    
//////////////////LETTURA FRASI INTERE del dataset .dat, messe in mappaFrasi (4	testo)
            TreeMap<Integer, String> mappaFrasi = Locale.LeggiFrasiLocaleDAT(locale);
            
            ///////////////////////////////SELEZIONE FRASI////////////////////////////////////////////         
            ArrayList<Integer> frasiCentroide = selezioneFrasiCentroide(locale,contesti, mappaFrasi);
            System.out.println("ID frasi centroide: " + frasiCentroide);//[2289,393,3283]
            stampaFrasiCentroide(frasiCentroide, mappaFrasi);
            
            HashMap<Integer, Integer> frasiSingole= selezioneFrasiSingole(locale,contesti, mappaFrasi);
            System.out.println("ID frasi singole: " + frasiSingole);	//[7,54; 3,456]
            stampaFrasiSingole(frasiSingole, mappaFrasi);

            

        	///////////////////SCELGO 1 SPIEGAZIONE A CASO FRA CENTROIDE E FRASI SINGOLE///////////
        	//Configurazione.tipoFrasiRandom();//SCELTA TIPOFRASI RANDOM:centroide, frasi singole 	
        	String tipoFrasi = Configurazione.TipoFrasi;
        	System.out.println("Tecnica: " + tipoFrasi);
            
            //////////////////////////////CREO STRINGA DA INVIARE/////////////////////////////////////////////////
            String tempo = request.getParameter("tempo").trim();
            String url = "generazioneSpiegazioni?tempo=" + tempo + "&configurazione=" + configurazione + "&locale=" + locale;
            String idFrasiCentroide = "";
            String idFrasiSingole = "";
            //CENTROIDE
            for (int s : frasiCentroide){////[2289,393,3283]
                idFrasiCentroide += "&centroide=" + s;
            }
            url += idFrasiCentroide + "&";            
            //FRASI SINGOLE
            for (int contesto : frasiSingole.keySet()){//[4,7]
                idFrasiSingole += "&frasiSingole=" + contesto + ":" + frasiSingole.get(contesto);
            }
            url += idFrasiSingole;
            
            /////////////////SCRITTURA REPORT//////////////////////////////////////////////////////
            		//1588974892939;	unigrammi;		6;		2;					2,3
            int numeroContesti = frasiSingole.size();
            String listaContesti = "";
            for (int c : frasiSingole.keySet()){
                listaContesti += c + ",";
            }
            listaContesti = listaContesti.substring(0, listaContesti.length()-1);
            scriviReport(tempo, configurazione, tecnica, tipoFrasi, locale, numeroContesti, listaContesti);
            ///////////////////////////////////////////////////////////////////////////
            
            response.sendRedirect(url);
            //generazioneSpiegazioni?tempo=28282912
            //&configurazione=unigrammi
            //&locale=112
            //&centroide=2289&centroide=393&centroide=3283
            //&frasiSingole=4:234&frasiSingole=7:113     
            
        } catch (Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
            String s = "\n"+e.toString();
            for (StackTraceElement st : e.getStackTrace()){
                s += "\n"+st;
            }
            s += "--------------";
            Files.write(Paths.get(Configurazione.path + "filesFilmando2/logwherexp.txt"), s.getBytes(), StandardOpenOption.APPEND);
        }
    }
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //il metodo legge la top10 di quei contesti e seleziona 1 film a caso fra quelli selezionati
    public static int selezioneFilm(HashSet<Integer> contesti) throws Exception{
    	HashMap<HashSet<Integer>, HashSet<Integer>> contestiItemTop10 = leggiTop10File();//DESERIALIZZO TOP 10
        System.out.println("TOP10 film per CONTESTI: " + contestiItemTop10.get(contesti));	//PRENDO TOP10 FILM PER QUEL CONTESTO
        //PRENDO UN FILM A CASO FRA I 10
        int dimensione = contestiItemTop10.get(contesti).size();		
        Configurazione.number= new Random();
        int locale = (int)contestiItemTop10.get(contesti).toArray()[Configurazione.number.nextInt(dimensione)];
        return locale;
    }
    
    //tale metodo restituisce la lista delle 3 frasi associate a quel film per quei contesti (centroide)
    public static ArrayList<Integer> selezioneFrasiCentroide(int locale, HashSet<Integer> contesti, TreeMap<Integer, String> mappaFrasi) throws Exception{
    	HashMap<HashSet<Integer>, HashMap<Integer, ArrayList<Integer>>> matriceContestiItemFrasi = leggiMatrice1();	//DESERIALIZZAZIONE MATRICE CONTESTI ITEM FRASI
        ArrayList<Integer> frasiCentroide = new ArrayList<>();
        frasiCentroide = matriceContestiItemFrasi.get(contesti).get(locale); //LISTA FRASI per il FILM
        return frasiCentroide; 
    }
    
    //tale metodo restituisce la mappa delle n frasi associate a quel film per quegli n contesti (frasi singole)
    public static HashMap<Integer, Integer> selezioneFrasiSingole(int locale, HashSet<Integer> contesti, TreeMap<Integer, String> mappaFrasi) throws Exception{
    	HashMap<Integer, HashMap<Integer, Integer>> localiContestiFrasi = leggiMatrice2();	//film 23 , contesto 5 --> frase 5646				
    	HashMap<Integer, Integer> frasiSingole = new HashMap<>();   
    	for (int c : contesti){	//[4,7]	//CONTESTI SELEZIONATI
    		frasiSingole.put(c, localiContestiFrasi.get(locale).get(c));
    	}																		//288		//7	--->frase n 54
    	return frasiSingole;
    }

    /*il metodo scrive in un file di nome report+idutente.txt i dati
    idUtente = tempo	1591979843680
    configurazione 		bigrammi
    tecnica 			pmi
    idFilm				138
    n contesti			3
    listacontesti		2,4
    */
    public static void scriviReport(String tempo, String configurazione, String tecnica, String tipoFrasi, int locale, int numeroContesti, String listaContesti) throws FileNotFoundException {
    	PrintWriter report = new PrintWriter(
    		Configurazione.path + "filesFilmando2/temp/report" + tempo +".txt");
    				//1588974892939;	unigrammi;				pmi				centroide			6;					2;					2,3
    	System.out.println(tempo + ";" + configurazione +  ";" + tecnica + ";" + tipoFrasi + ";" + locale + ";" + numeroContesti + ";" + listaContesti);
    	report.println(tempo + ";" + configurazione +  ";" + tecnica + ";" + tipoFrasi + ";" + locale + ";" + numeroContesti + ";" + listaContesti);
    	
    	report.flush();
    	report.close();
    }
    
    
    public static HashMap<HashSet<Integer>, HashSet<Integer>> leggiTop10File() throws Exception{
    	ObjectInputStream ois = new ObjectInputStream(new FileInputStream(new File(
    			Configurazione.path + "filesFilmando2/"  + Configurazione.tecnica + "/" + Configurazione.TipoLemmi + "/serialized/top10combinazioni-items.dat")));	//mirko: top5combinazioni-items-bari
    	HashMap<HashSet<Integer>, HashSet<Integer>> contestiItemTop10 = (HashMap<HashSet<Integer>, HashSet<Integer>>)ois.readObject();
    	ois.close();
    	return contestiItemTop10;
    }
    
    public static HashMap<HashSet<Integer>, HashMap<Integer, ArrayList<Integer>>> leggiMatrice1() throws Exception {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(new File(
        		Configurazione.path + "filesFilmando2/"  + Configurazione.tecnica + "/" + Configurazione.TipoLemmi + "/serialized/contesti-item-frasi.dat")));
        HashMap<HashSet<Integer>, HashMap<Integer, ArrayList<Integer>>> matriceContestiItemFrasi = (HashMap<HashSet<Integer>, HashMap<Integer, ArrayList<Integer>>>) ois.readObject();
        ois.close();
        return matriceContestiItemFrasi;
    }
    
    public static HashMap<Integer, HashMap<Integer, Integer>> leggiMatrice2() throws Exception {
    	ObjectInputStream ois = new ObjectInputStream(new FileInputStream(new File(
    		Configurazione.path + "filesFilmando2/"  + Configurazione.tecnica + "/" + Configurazione.TipoLemmi + "/serialized/locali-contesto-frase.dat")));
    	HashMap<Integer, HashMap<Integer, Integer>> localiContestiFrasi = (HashMap<Integer, HashMap<Integer, Integer>>) ois.readObject();
    	ois.close();
    	return localiContestiFrasi;
    }
    
    
/////////////////////////////////////////////////////STAMPE////////////////////////////////////////////////////////////
    public static void stampaFrasiCentroide(ArrayList<Integer> frasiCentroide, TreeMap<Integer, String> mappaFrasi) {
        ArrayList<String> frasiIntere = new ArrayList<>();
        for (int id : frasiCentroide) {	////[2289,393,3283]
            frasiIntere.add(mappaFrasi.get(id));//prendo il testo
        }
        int contatore = 0;
        for (String frase : frasiIntere){
            contatore++;
            System.out.println(contatore + ":\t" + frase);
        }
        System.out.println();
    }
    
    
    public static void stampaFrasiSingole(HashMap<Integer, Integer> frasiSingole, TreeMap<Integer, String> mappaFrasi ) {
    	for (int c : frasiSingole.keySet()){//[4,7]
    		System.out.print(Configurazione.contesti.get(c) + ":\t " + mappaFrasi.get(frasiSingole.get(c)) + "\n");
    	}
    }
    
}
