package classi;

import java.util.ArrayList;

//confronto fra frasi singole e centroide
public class ValutazioneTipo3 extends ValutazioneTipo1_2 {
    protected int preferenza0;//confronto
    
    ////////////////////////////////////////COSTRUTTORI////////////////////////////////////////////////
    public ValutazioneTipo3(String id, String configurazione, String citta, int locale, int numeroContesti, int trasparenza, int persuasione, int coivolgimento, int fiducia, ArrayList<Integer> listaContesti, int preferenza0) {
        super(id, configurazione, citta, locale, numeroContesti, trasparenza, persuasione, coivolgimento, fiducia, listaContesti);
        this.preferenza0 = preferenza0;
    }
    
    public ValutazioneTipo3(){}
    
    ////////////////////////////GETTER SETTER/////////////////
    public int getPreferenza0() {return preferenza0;}
    public void setPreferenza0(int preferenza0) { this.preferenza0 = preferenza0;}
}