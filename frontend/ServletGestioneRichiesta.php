
<?php
$configurazione = rand(0, 2);
if ($configurazione === 0)      $configurazione = "unigrammi";
else if ($configurazione === 1) $configurazione = "bigrammi";
else $configurazione = "unibigrammi";

$tecnica = rand(0, 1);
if ($tecnica === 0)   $tecnica = "normale";
else $tecnica = "pmi";

//echo $configurazione . "," . $tecnica;

$tecnica = "normale";
$configurazione = "unigrammi";
$_SESSION['configurazione'] = $configurazione;

$eta =      (isset($_POST['attenzione']) && $_POST['attenzione'] !== "0")  ? $_POST['attenzione'] : null;
$genere =   (isset($_POST['compagnia']) &&  $_POST['compagnia'] !== "0")   ? $_POST['compagnia'] : null;
$titolo =   (isset($_POST['umore']) &&      $_POST['umore'] !== "0")       ? $_POST['umore'] : null;

$context  = array();
if ($eta !== null)       array_push($context, $eta);
if ($genere !== null)    array_push($context, $genere);
if ($titolo !== null)    array_push($context, $titolo);
$contextstring =  "[" . implode(",", $context) . "]";

$path = "" . "../filesFilmando2/"  . $tecnica . "/" . $configurazione . "/top10combinazioni-items.txt";

$file = fopen($path, "r") or die("Unable to open file!");
echo $contextstring . "<br>";

$top10film = array();
while (($line = fgets($file)) !== false) {
    $pieces = explode("\t", $line);
    if ($pieces[0] === $contextstring) {
        array_push($top10film, $pieces[1], $pieces[2], $pieces[3], $pieces[4], $pieces[5], $pieces[6], $pieces[7], $pieces[8], $pieces[9], $pieces[10]);
        echo "TOP10 film per CONTESTI: " . "[" . implode(",", $top10film) . "]" . "<br>";
    }
}

$locale = array_rand($top10film);
$_SESSION['film'] = $top10film[$locale];
echo "FILM suggerito: " . $_SESSION['film'] . "<br>";

//&centroide=2289&centroide=393&centroide=3283
//&frasiSingole=4:234&frasiSingole=7:113     


/*
//////////////////LETTURA FRASI INTERE del dataset .dat, messe in mappaFrasi (4	testo)
    TreeMap<Integer, String> mappaFrasi = Locale.LeggiFrasiLocaleDAT(locale);
            
    ///////////////////////////////SELEZIONE FRASI////////////////////////////////////////////         
    ArrayList<Integer> frasiCentroide = selezioneFrasiCentroide(locale,contesti, mappaFrasi);
    System.out.println("ID frasi centroide: " + frasiCentroide);//[2289,393,3283]
    stampaFrasiCentroide(frasiCentroide, mappaFrasi);

    //tale metodo restituisce la lista delle 3 frasi associate a quel film per quei contesti (centroide)
    //contesti-item-frasi.dat
    public static ArrayList<Integer> selezioneFrasiCentroide(int locale, HashSet<Integer> contesti, TreeMap<Integer, String> mappaFrasi) throws Exception{
    	HashMap<HashSet<Integer>, HashMap<Integer, ArrayList<Integer>>> matriceContestiItemFrasi = leggiMatrice1();	//DESERIALIZZAZIONE MATRICE CONTESTI ITEM FRASI
        ArrayList<Integer> frasiCentroide = new ArrayList<>();
        frasiCentroide = matriceContestiItemFrasi.get(contesti).get(locale); //LISTA FRASI per il FILM
        return frasiCentroide; 
    }
       
    //////////////////////////////////////////////////////////////////////////////////////////////////
    HashMap<Integer, Integer> frasiSingole= selezioneFrasiSingole(locale,contesti, mappaFrasi);
    System.out.println("ID frasi singole: " + frasiSingole);	//[7,54; 3,456]
    stampaFrasiSingole(frasiSingole, mappaFrasi);

    //tale metodo restituisce la mappa delle n frasi associate a quel film per quegli n contesti (frasi singole)
    locali-contesto-frase.dat
    public static HashMap<Integer, Integer> selezioneFrasiSingole(int locale, HashSet<Integer> contesti, TreeMap<Integer, String> mappaFrasi) throws Exception{
    	HashMap<Integer, HashMap<Integer, Integer>> localiContestiFrasi = leggiMatrice2();	//film 23 , contesto 5 --> frase 5646				
    	HashMap<Integer, Integer> frasiSingole = new HashMap<>();   
    	for (int c : contesti){	//[4,7]	//CONTESTI SELEZIONATI
    		frasiSingole.put(c, localiContestiFrasi.get(locale).get(c));
    	}																		//288		//7	--->frase n 54
    	return frasiSingole;
    }



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
            
        }
    }
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    
    
    

    /*il metodo scrive in un file di nome report+idutente.txt i dati
    idUtente = tempo	1591979843680
    configurazione 		bigrammi
    tecnica 			pmi
    idFilm				138
    n contesti			3
    listacontesti		2,4
    
    public static void scriviReport(String tempo, String configurazione, String tecnica, String tipoFrasi, int locale, int numeroContesti, String listaContesti) throws FileNotFoundException {
    	PrintWriter report = new PrintWriter(
    		Configurazione.path + "filesFilmando2/temp/report" + tempo +".txt");
    				//1588974892939;	unigrammi;				pmi				centroide			6;					2;					2,3
    	System.out.println(tempo + ";" + configurazione +  ";" + tecnica + ";" + tipoFrasi + ";" + locale + ";" + numeroContesti + ";" + listaContesti);
    	report.println(tempo + ";" + configurazione +  ";" + tecnica + ";" + tipoFrasi + ";" + locale + ";" + numeroContesti + ";" + listaContesti);
    	
    	report.flush();
    	report.close();
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
*/