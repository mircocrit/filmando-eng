<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html lang="en">
<%@ page import="frontend.Locale"%>
<%@ page import="frontend.Configurazione"%>

<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.security.Timestamp"%>
<!-- in questa pagina:
	1) viene mostrato il film suggerito insieme alla spiegazione basata sul centroide o frasi singole, 
	7) viene chiesto all’utente di valutarne 4 aspetti: 	trasparenza, persuasione, coinvolgimento, fiducia. 
	Queste informazioni vengono inserite tramite un form, che viene elaborato dalla servlet ServletSalvataggioValutazione1.jsp.
	se centroide o  ServletSalvataggioValutazione2.jsp se frasi singole.
-->

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<title>Filmando</title>
	<link href="../css/style.css" rel="stylesheet">
	<link href="../css/slider.css" rel="stylesheet">
</head>

<body>
	<!--<button onclick="goFunction()" id="myBtn" title="Go to Feedback">Leave a Feedback</button>	-->
	<nav class="navbar navbar-light bg-dark">
  		<a class="navbar-brand text-light" href="#">
   			<img src="../movie2.png" width="30" height="30" alt=""> Filmando
 	 	</a>
	</nav>

	<%
		System.out.println("////////////////////////////INIZIO RESULT1//////////////////////////////");
		String tempo = request.getParameter("tempo").trim();

		HashMap<String, ArrayList<Integer>> fraseContesti = new HashMap<String, ArrayList<Integer>>();
		int locale = Integer.parseInt(request.getParameter("locale").trim());

		///////////////////////////////////LETTURA SPIEGAZIONI SALVATE, a caso o centroide  o singolo////////////////////////////////////////////
		Scanner in = new Scanner(new File(Configurazione.path + "filesFilmando2/temp/spiegazioni" + tempo + ".txt"));
		///////////////////SCELGO 1 SPIEGAZIONE A CASO FRA CENTROIDE E FRASI SINGOLE///////////
		String spiegazione = "";

		if (Configurazione.TipoFrasi.equals("centroide")) { //CENTROIDE
			spiegazione = in.nextLine(); //centroide
			in.close();
			System.out.println("Tecnica: centroide");
		} else { //SINGOLE
			in.nextLine();
			spiegazione = in.nextLine(); //frasi singole
			in.close();
			System.out.println("Tecnica: frasi singole");
		}
		System.out.println("spiegazione:\t" + spiegazione);
		System.out.println("--------------------------------------FINE RESULT1----------------------------------------\n");

	////////////////LETTURA TITOLO FILM + IMMAGINE BASE64//////////////////////////////                    
	
		Scanner infoLocale = new Scanner(new File(Configurazione.path + "filesFilmando2/info utili/" + locale + ".txt"));
		boolean flag = false;
		Locale l = new Locale();
		l.setId(Integer.parseInt(infoLocale.nextLine()));//IDFILM
		l.setNome(infoLocale.nextLine().replaceAll("'", ""));//TITOLO FILM
		l.setAnno(Integer.parseInt(infoLocale.nextLine()));//ANNO
		l.setGenere(infoLocale.nextLine());//GENERE
		String[] genres = l.getGenere().split(",");
		String[] actors = null;
		
		l.setNumrating(Integer.parseInt(infoLocale.nextLine()));//NUMERO RATINGS IMDB
		l.setRating(infoLocale.nextLine());//RATING IMDB
		
		if (infoLocale.hasNextLine()){
			flag = true;
			l.setAttori(infoLocale.nextLine());
			actors = l.getAttori().split(",");
		}
		infoLocale.close();//CHIUDO FILE
		////DEBUG A CONSOLE DATI
		System.out.println(
			"Nome: " + l.getNome() + "\t IDFilm: " + l.getId() + "\t Anno: " + l.getAnno() + "\t Genere: " + l.getGenere());
		//DEBUG, STAMPA TECNICA
		//out.println(Configurazione.tecnica + "  " + Configurazione.TipoLemmi + "  " + Configurazione.TipoFrasi + "\n" );
 		//System.out.println(Configurazione.path + "filesFilmando2/jpg/"+ l.getId() + ".jpg");
	%>
	<div class="container-fluid bg-light">
		<div class="row justify-content-md-center">
			<div class="col-xs-6 col-md-5 p-0">
				<div class="card bg-dark text-white border-0">
		  			<img class="card-img" src= "../poster/<%out.println(l.getId());%>.jpg"  alt="Card image">
		  			<div class="card-img-overlay d-flex flex-column justify-content-end align-items-start" >
		    			<h3 class="card-text font-weight-light"><% out.println(l.getNome());%></h3>
		    			<h6 class="card-text font-weight-light"><% out.println(l.getAnno());%></h6>
		 	 		</div>
				</div>
			</div>
		</div>	
	</div>
	
	<div class="card text-center bg-dark" >
		<div class="card-body">
			<div class="row text-center">
				<div class="col-4 p-0">
    				<img src= "../jpg/<%out.println(l.getId());%>.jpg" class="card-img " style="width: 95px; height: 143px; alt="Responsive image">
    			</div>
    			<div class="col-8 p-0">
					<h5 class="card-text">
					<% for (String a : genres) 
						out.println("<span class=\"badge badge-danger\">"+ a + "</span>");%>
					</h5>
					<h5 class="card-text">
    				<% if(flag==true)	
    					for (String act : actors) 
    						out.println("<span class=\"badge badge-primary\">"+ act + "</span>");%>
    				</h5>
    				<h5 class="card-text">
    					<span class="badge badge-warning"><% out.println(l.getRating() + "/10");%></span><br>
    					<span class="badge badge-dark font-weight-light"><% out.println(l.getNumrating());%></span>
    				</h5>
    			</div>
    		</div>
    		
    		<!-- <h6 class="card-text"><span class="badge badge-dark">IMDB tot. Ratings:</span>  <span class="badge badge-dark"><% //out.println(l.getNumrating());%></span></h6> -->
		</div>
	</div>
	
	<div class="card text-center bg-white" >
 		<div class="card-body">
   			<h2 class="card-title">Justification 1</h2>
   			<p class="card-text"><% out.println(spiegazione); %></p>
 			</div>
	</div>
		
	
	
		
	<div class="container-fluid bg-light">
		<br>
		<div class="row text-center">
			<div class="col">				
			<h5 style="color: #c62828;">
			Given that the goal of the system is to generate a justification which is 
			adapted on the different contexts of consumption, please, answer the following questions<br>
			</h5>
			<h6>- 1 indicates that you are in total disagreement<br> 
				- 5 indicates that you are in total agreement </h6>
			</div>	
		</div>
		
		<form action="../salvaValutazione1">
			
			<br>
			<div class="row justify-content-md-center text-center">

				<div class="col-md-3">
					<div class="slidecontainer">
   						<label for="pref1"><h6>I understood why the movie was suggested to me:</h6></label>
   						<div align="center" class="font-weight-bold" id="valorepref1">3</div>
    					<input type="range" min="1" max="5" value="3" class="slider" id="pref1" name="pref1" 
    					onfocus="coloreRange(this.id)" onclick="coloreRange(this.id)" onchange="coloreRange(this.id)">
  					</div>
				</div>
				
				<div class="col-md-3">
					<div class="slidecontainer">
   						<label for="pref2"><h6>The justification made the suggestion more convincing:</h6></label>
   						<div align="center" class="font-weight-bold" id="valorepref2">3</div>
    					<input type="range" min="1" max="5" value="3" class="slider" id="pref2" name="pref2" 
    					onfocus="coloreRange(this.id)" onclick="coloreRange(this.id)" onchange="coloreRange(this.id)">
  					</div>
				</div>
				
				<div class="col-md-3">
					<div class="slidecontainer">
   						<label for="pref3"><h6>The justification allowed me to discover new information about the movie</h6></label>
   						<div align="center" class="font-weight-bold" id="valorepref3">3</div>
    					<input type="range" min="1" max="5" value="3" class="slider" id="pref3" name="pref3" 
    					onfocus="coloreRange(this.id)" onclick="coloreRange(this.id)" onchange="coloreRange(this.id)">
  					</div>
				</div>

				<div class="col-md-3">
					<div class="slidecontainer">
   						<label for="pref4"><h6>The justification has increased my level of trust in the recommender system:</h6></label>
    					<div align="center" class="font-weight-bold" id="valorepref4">3</div>
    					<input type="range" min="1" max="5" value="3" class="slider" id="pref4" name="pref4" 
    					onfocus="coloreRange(this.id)" onclick="coloreRange(this.id)" onchange="coloreRange(this.id)">
  					</div>
				</div>

			</div>	
			<div class="row justify-content-md-center text-center">
				<div class="col-md-4"> 
					<input type="hidden" id="tempo" name="tempo" value="<%out.println(tempo);%>">
					<button type="submit" id="valutazione1" class="btn btn-primary btn-lg">Send feedback </button>
				</div>
			</div>
			
		</form>	
		<br>	
	</div>
		
	
<footer> 
	<div class="footer bg-info">
		<h2 align="center">Progetto di Tesi di Laurea in Informatica</h2>
		<p class="lead" align="center">Laureando: <b>Mirco Sipone</b></p>
		<p class="lead" align="center">Relatore: dott. <b>Cataldo Musto</b></p>
		
		<div class="d-flex justify-content-center">
			<div> <a href="https://www.uniba.it/"><img src="../Logo_Uniba.png"></a> </div>
			<div> <a href="http://www.di.uniba.it/~swap/"><img height="60" src="../swap.PNG"></a></div>
		</div>
		<br>
	</div>
</footer>
	<script src="../js/slider.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>	
</body>

</html>
