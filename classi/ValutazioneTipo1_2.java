package classi;

import java.util.ArrayList;

//valutazione di tipo centroide/frasi singole in termini di trasparenza, persuasione, coinvolgimento, fiducia
public class ValutazioneTipo1_2 {
    public String id;			//titolo Film
    public String configurazione;//configurazione = unigrammi/bigrammi/unibigrammi
    public String tecnica;			//normale, pmi
    public String TipoFrasi;		//centroide frasi singole
    public int locale;			//idFilm
    public int numeroContesti;	//1,2,3
    public ArrayList<Integer> listaContesti;	//es: 3,6
    
    public int trasparenza, persuasione, coinvolgimento, fiducia;
    
    ////////////////////////////////////COSTRUTTORI///////////////////////////////////////////////////
    public ValutazioneTipo1_2(String id, String configurazione, String citta, int locale, int numeroContesti, int trasparenza, int persuasione, int coinvolgimento, int fiducia, ArrayList<Integer> listaContesti) {
        this.id = id;
        this.configurazione = configurazione;
        //this.citta = citta;
        this.locale = locale;
        this.numeroContesti = numeroContesti;
        this.trasparenza = trasparenza;
        this.persuasione = persuasione;
        this.coinvolgimento = coinvolgimento;
        this.fiducia = fiducia;
        this.listaContesti = listaContesti;
    }
    public ValutazioneTipo1_2() {}


    /////////////////////////////GETTER-SETTER/////////////////////////////////
    public String getId() { return id;}
    public void setId(String id) { this.id = id;}

    public String getConfigurazione() { return configurazione;}
    public void setConfigurazione(String configurazione) { this.configurazione = configurazione;}

    public String getTecnica() { return tecnica;}
    public void setTecnica(String tecnica) { this.tecnica = tecnica;}
    
    public String getTipoFrasi() { return TipoFrasi;}
    public void setTipoFrasi(String TipoFrasi) { this.TipoFrasi = TipoFrasi;}

    public int getLocale() {return locale;}
    public void setLocale(int locale) { this.locale = locale; }

    public int getNumeroContesti() { return numeroContesti;}
    public void setNumeroContesti(int numeroContesti) { this.numeroContesti = numeroContesti;}

    
    public int getTrasparenza() { return trasparenza;}
    public void setTrasparenza(int trasparenza) { this.trasparenza = trasparenza;}

    public int getPersuasione() { return persuasione;}
    public void setPersuasione(int persuasione) { this.persuasione = persuasione;}

    public int getCoinvolgimento() {return coinvolgimento; }
    public void setCoinvolgimento(int coinvolgimento) { this.coinvolgimento = coinvolgimento; }

    public int getFiducia() { return fiducia; }
    public void setFiducia(int fiducia) { this.fiducia = fiducia;}

    public ArrayList<Integer> getListaContesti() { return listaContesti;}
    public void setListaContesti(ArrayList<Integer> listaContesti) { this.listaContesti = listaContesti;}

}