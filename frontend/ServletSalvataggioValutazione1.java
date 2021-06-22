package frontend;


import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Scanner;
/*
Questa servlet, ottiene le informazioni delle valutazioni sulle frasi centroide dell’utente, 
e le salva su un file chiamato valutazioni1<timestamp>.txt per poi reindirizzare il browser alla pagina result3.jsp.
*/
@WebServlet("/salvaValutazione1")
public class ServletSalvataggioValutazione1 extends HttpServlet {

	 public void doGet(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException {
        String tempo = request.getParameter("tempo").trim();

        Scanner report = new Scanner(new File(Configurazione.path + "filesFilmando2/temp/report"+ tempo + ".txt"));
        String reportValutazione = report.nextLine();
        report.close();

        String pref1 = request.getParameter("pref1");	//trasparenza (1-5)
        String pref2 = request.getParameter("pref2");	//persuasione (1-5)
        String pref3 = request.getParameter("pref3");	//coinvolgimento (1-5)
        String pref4 = request.getParameter("pref4");	//fiducia (1-5)
        				//		... +						;2;	2;	4;	1
        System.out.println(pref1 + "," + pref2 + "," + pref3 + "," + pref4);
        String output = "\n" + reportValutazione + ";" + pref1 + ";" + pref2 + ";" + pref3 + ";" + pref4;
        Files.write(Paths.get(Configurazione.path + "filesFilmando2/valutazione1.txt"), output.getBytes(), StandardOpenOption.APPEND);
        
        String url = "pagine/results3.jsp?tempo="+ tempo;

        response.sendRedirect(url);
    }
}
