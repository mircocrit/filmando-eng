package classi;

public class Math {
	//////////////////////////////////////////CALCOLA PERCENTUALI///////////////////////
	public static String perc(int valore, int totale){
		String percentuale = "";
		float v = (float)valore/totale*100;
		percentuale = String.format("%.2f", v) + "%";
		return percentuale;
	}
	
	public static String perc(double valore){
		String percentuale = String.format("%.2f", valore*100) + "%";
		return percentuale;
	}
	
	public static String dec(double valore){
		String decimale = String.format("%.2f", valore);
		return decimale;
	}
}
