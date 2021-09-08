<?php
session_start();

echo $_SESSION['configurazione'] . "<br>";
echo $_SESSION['film']. "<br>";
echo $_SESSION['tecnica'] . "<br>";
$contesti = $_SESSION['contesti'];
$tecnica = $_SESSION['tecnica'];
$centroide = $_SESSION['centroide'];
$frasisingole = $_SESSION['frasisingole'];
if ($tecnica === "centroide")
    echo implode(",", $centroide) . "<br>";
else
    echo implode(",", $frasisingole) . "<br>";

$path2 = "../filesFilmando2/Scheda Film.txt";
$file2 = fopen($path2, "r") or die("Unable to open Scheda Film!");
while (($line = fgets($file2)) !== false) {
    $pieces = explode(";", $line);
    if ($pieces[0] === $_SESSION['film']) {
        $titoloFilm = $pieces[1];
        echo $pieces[0] . ":" . $pieces[1] . "<br>";
    }
}
$_SESSION['titolo'] = $titoloFilm;

$path = "../filesFilmando2/frasi singoli items/intere/" . $_SESSION['film'] . ".txt";
$file = fopen($path, "r") or die("Unable to open frasi intere file!");
$testofrasi = array();
while (($line = fgets($file)) !== false) {
    $pieces = explode(";", $line);
    if ($tecnica === "centroide") {
        foreach ($centroide as $value) {
            if (trim($pieces[1]) === trim($value))
                $testofrasi[$pieces[1]] = $pieces[2];
        }
    } else {
        foreach ($frasisingole as $value) {
            if (trim($pieces[1]) === trim($value))
                $testofrasi[$pieces[1]] = $pieces[2];
        }
    }
}
$_SESSION['testofrasi'] = $testofrasi;
echo print_r($testofrasi) . "<br>";



$numeroContesti = count($contesti);

if ($tecnica === "centroide") {
    $spiegazioneCentroide = "";

    if ($numeroContesti == 1) {
        $spiegazioneCentroide .= "I recommend you <b>" . $titoloFilm . "</b> for the context you have selected, ";
    } else {
        $spiegazioneCentroide .= "I recommend you <b>" . $titoloFilm . "</b> for the contexts you have selected, ";
    }
    $spiegazioneCentroide .= "because people who liked the movie think that <b>";

    $count = 0;
    foreach ($testofrasi as $frase) {
        $spiegazioneCentroide .= $frase . "</b>";
        $count++;
        if ($count == 1)    $spiegazioneCentroide .= " and that <b>";
        if ($count == 2)    $spiegazioneCentroide .= ". Moreover, they said that <b>";
    }
    $spiegazioneCentroide .= ".</b>";
    echo $spiegazioneCentroide . "</br>";
    $_SESSION['spiegazioneCentroide'] = $spiegazioneCentroide;
}

if ($tecnica === "frasisingole") {
    $spiegazioneSingole = "I recommend you <b>" . $titoloFilm . "</b> because people who liked the movie think that <b>";
    $cont = 0;
    foreach ($testofrasi as $frase) {
        /*
        switch ($context){
            case 1:
                $spiegazioneSingole .= " it's suitable for <b>high attention</b> contexts because <b>";
                break;
            case 2:
                $spiegazioneSingole .= " it's suitable if you <b>don't</b> want to <b>be focused</b> on it because <b>";
                break;
            ///////////////////////////
            case 3:
                $spiegazioneSingole .= " it's perfect to spend an evening in <b>sweet company</b> because <b>";
                break;
            case 4:
                $spiegazioneSingole .= " it's perfect to watch in <b>family</b> with your <b>children</b> because <b>";
                break;
            case 5:
                $spiegazioneSingole .= " it's perfect to watch with your <b>friends</b> because <b>";
                break;
            case 6:
                $spiegazioneSingole .= " it's perfect to watch in <b>good mood</b> because <b>";
                break;
            case 7:
                $spiegazioneSingole .= " it's perfect to watch in a <b>bad mood</b> because <b>";
                break;
            }
            */
        $cont++;
        if ($cont == 1)   $spiegazioneSingole .= $frase . "</b>";
        if ($cont == 2)   $spiegazioneSingole .= ", and that <b>" . $frase . "</b>";
        if ($cont == 3)   $spiegazioneSingole .= "; moreover, <b>" . $frase . "</b>";
    }
    $spiegazioneSingole .= ".</b>";
    echo $spiegazioneSingole . "</br>";
    $_SESSION['spiegazioneSingole'] = $spiegazioneSingole;
}

/*
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
                    //togliere perch� a tutti quelli che non sono ultimi
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
    */




$_SESSION['spiegazioneBaseline'] = "";

/*
    String spiegazioneBaseline = generazioneBaseline(frasiSingole, locale);
    System.out.println(spiegazioneBaseline + "\n");//STAMPA A VIDEO BASELINE	
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
*/

$_SESSION['spiegazioneBaseline2'] = "";

/*
    String spiegazioneBaseline2 = generazioneBaseline2(frasiSingole, locale);
    System.out.println(spiegazioneBaseline2 + "\n");//STAMPA A VIDEO BASELINE DISTRIBUZIONALE
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
    */


header("location: ../results1.php");
