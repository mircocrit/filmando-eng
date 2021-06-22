package frontend;

import java.io.File;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.util.TreeMap;



//CLASSE CHE MODELLA FILM
/* Questa classe modella i vari locali, costituiti da:
-	Id film;
-	url dell’immagine;
-	nome film;
*/
public class Locale{
    private int id, anno;
    private String url, nome, genere;
    private String attori;//FACOLTATIVO: ATTORI E REGISTI
    private String rating;
    private int numrating;
    
    public Locale() {this.attori = "";}
    public Locale(int id, String url, String nome, int anno, String genere, String attori) {
        this.id = id;		//56
        this.url = url;		//IMMAGINE (BASE64)
        this.nome = nome;	//NOME FILM
        this.anno = anno;	//ANNO FILM
        this.genere = genere; //GENERE FILM
        this.attori = attori; //ATTORI/REGISTI FILM
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    
    public int getAnno() { return anno; }
    public void setAnno(int anno) { this.anno = anno; }
    
    public String getGenere() { return genere; }
    public void setGenere(String genere) { this.genere = genere; }
    
    public String getRating() { return rating; }
	public void setRating(String rating) { this.rating = rating; }
	
	public int getNumrating() { return numrating; }
	public void setNumrating(int numrating) { this.numrating = numrating; }
    
    public String getAttori() { return attori; }
    public void setAttori(String attori) { this.attori = attori; }
    
    //metodo che legge le frasi di 1 locale e le restituisce in struttura con id + frase intera
    public static TreeMap<Integer, String> LeggiFrasiLocaleDAT(int locale) throws Exception {
    	ObjectInputStream ois = new ObjectInputStream(new FileInputStream(new File(
    			Configurazione.path + "filesFilmando2/frasi singoli items/intere dat/" + locale + ".dat")));
        TreeMap<Integer, String> mappaFrasi = (TreeMap<Integer, String>) ois.readObject();
        ois.close();
        return mappaFrasi;
    }
	
    
}
