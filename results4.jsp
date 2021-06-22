<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html lang="en">
<%@ page import="frontend.Locale"%>
<%@ page import="frontend.Configurazione"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!--  Questa pagine mostra 2 spiegazioni: 
	1) la prima è quella scelta dall’utente tra il centoride e le frasi singole per contesto 
				(randomica nel caso in cui l’utente ha selezionato "indifferente"); 
	2) la seconda è quella basata sulla baseline
	3) Successivamente, tramite un form, vengono richieste all’utente le stesse informazioni della pagina precedente, 
	L’elaborazione passa alla sevlet ServletSalvataggioValutazione4.jsp.	
	-->

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<title>Filmando</title>
	<link href="../css/style.css" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-light bg-dark">
  		<a class="navbar-brand text-light" href="#">
   			<img src="../movie2.png" width="30" height="30" alt=""> Filmando
 	 	</a>
	</nav>

	<%
		String tempo = request.getParameter("tempo").trim();
		String pref = request.getParameter("pref").trim();

		Scanner in = new Scanner(new File(Configurazione.path + "filesFilmando2/temp/spiegazioni" + tempo + ".txt"));
		String spiegazione1 = "";

		if (Configurazione.TipoFrasi.equals("centroide")) { //CENTROIDE
			spiegazione1 = in.nextLine(); //centroide
			in.nextLine();
			System.out.println("Tecnica: centroide");
		} else { //SINGOLE
			in.nextLine();
			spiegazione1 = in.nextLine(); //frasi singole
			System.out.println("Tecnica: frasi singole");
		}

		//4) LEGGO BASELINE DISTRIBUZIONALE
		//in.nextLine();
		String baseline = in.nextLine();//4 rigo
		in.close();

		System.out.println("////////////////////////////INIZIO RESULT4//////////////////////////////");
		System.out.println("spiegazione" + Configurazione.TipoFrasi + ":\t" + spiegazione1);
		System.out.println("Baseline:\t" + baseline);
		System.out.println("--------------------------------------FINE RESULT4----------------------------------------\n");
	%>
	
	<div class="card text-center">
		<div class="card-body">
			<h2 class="card-title">Justification 1</h2>
				<p class="card-text"><% out.println(spiegazione1); %></p>
				<h2 class="card-title">Justification 2</h2>
				<p class="card-text"><% out.println(baseline); %></p>
		</div>
	</div>

	
	<div class="container-fluid bg-light">
		<br>
		<form action="../salvaValutazione4">
			<div class="row justify-content-md-center text-center">
			
				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref0" style="color: #c62828;">
						<h5>Given that the goal of the system is to
				 		generate a justification which is adapted <br> on the different contexts 
						 of consumption,which justification style do you prefer?</h5></label>
						<select class="form-control" name="pref0">
							<option value="0">Indifferent</option>
							<option value="1">Justification 1</option>
							<option value="2">Justification 2</option>
						</select>
					</div>
				</div>
			</div>

			<div class="row justify-content-md-center text-center">
				<h5 style="color: #c62828;">
				Please indicate which justification style better matches the following sentences:</h5>
			</div>

			<div class="row justify-content-md-center text-center">
				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref1"><h6>I understood why the movie was suggested to me</h6></label>
						<select class="form-control" name="pref1">
							<option value="0">Indifferent</option>
							<option value="1">Justification 1</option>
							<option value="2">Justification 2</option>
						</select>
					</div>
				</div>

				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref2"><h6>The justification made the suggestion more convincing.</h6></label>
						<select class="form-control" name="pref2">
							<option value="0">Indifferent</option>
							<option value="1">Justification 1</option>
							<option value="2">Justification 2</option>
						</select>
					</div>
				</div>

				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref3"><h6>The justification allowed me to discover new information about the movie</h6></label>
						<select class="form-control" name="pref3">
							<option value="0">Indifferent</option>
							<option value="1">Justification 1</option>
							<option value="2">Justification 2</option>
						</select>
					</div>
				</div>

				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref4"><h6>The justification has increased my level of trust in recommender systems</h6></label>
						<select class="form-control" name="pref4">
							<option value="0">Indifferent</option>
							<option value="1">Justification 1</option>
							<option value="2">Justification 2</option>
						</select>
					</div>
				</div>
				
			</div>
			<div class="row justify-content-md-center text-center">
				<div class="col"> 
					<input type="hidden" id="tempo" name="tempo" value="<%out.println(tempo);%>"> 
					<input type="hidden" id="precedente" name="precedente" value="<%out.println(pref);%>">
					<button type="submit" id="valutazione4" class="btn btn-primary btn-lg">Send feedback </button>
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
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>	
</body>

</html>
