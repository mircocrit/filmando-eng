package classi;

public class Utente{
    private String id;	//1231814411
    private String genere;	//M/F
    private String usoRecSys;	//si,no
    private int eta;			//fascia eta
    private int titoloStudio;	//tds
    private int frequenzaUscite;	//NO

    //////////////////////////COSTRUTTORE//////////////////////////////////
    public Utente(String id, String genere, String usoRecSys, int eta, int titoloStudio, int frequenzaUscite) {
        this.id = id;
        this.genere = genere;
        this.usoRecSys = usoRecSys;
        this.eta = eta;
        this.titoloStudio = titoloStudio;
        this.frequenzaUscite = frequenzaUscite;
    }
    public Utente(){}

    ///////////////////////////////GETTER SETTER//////////////////////////////////
    public String getId() {return id;}
    public void setId(String id) {this.id = id;}

    public String getGenere() {return genere;}
    public void setGenere(String genere) {this.genere = genere;}

    public String getUsoRecSys() {return usoRecSys;}
    public void setUsoRecSys(String usoRecSys) {this.usoRecSys = usoRecSys;}

    public int getEta() { return eta;}
    public void setEta(int eta) {this.eta = eta;}

    public int getTitoloStudio() {return titoloStudio;}
    public void setTitoloStudio(int titoloStudio) {this.titoloStudio = titoloStudio;}

    public int getFrequenzaUscite() { return frequenzaUscite;}
    public void setFrequenzaUscite(int frequenzaUscite) {this.frequenzaUscite = frequenzaUscite;}
}

