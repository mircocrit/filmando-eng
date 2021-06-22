package classi;

import java.util.ArrayList;

//confronto migliore/baseline
public class ValutazioneTipo4 extends ValutazioneTipo3 {
    //private int preferenzaPrecedente;
    
    ////////////////////////////////////////COSTRUTTORI////////////////////////////////////////////////
    public ValutazioneTipo4(String id, String configurazione, String citta, int locale, int numeroContesti, int trasparenza, int persuasione, int coivolgimento, int fiducia, ArrayList<Integer> listaContesti, int preferenza0) {
        super(id, configurazione, citta, locale, numeroContesti, trasparenza, persuasione, coivolgimento, fiducia, listaContesti, preferenza0);
        //this.preferenzaPrecedente = preferenzaPrecedente;
    }
    public ValutazioneTipo4(){}
    
    ////////////////////////////GETTER SETTER/////////////////
    //public int getPreferenzaPrecedente() { return preferenzaPrecedente; }
    //public void setPreferenzaPrecedente(int preferenzaPrecedente) { this.preferenzaPrecedente = preferenzaPrecedente; }
}