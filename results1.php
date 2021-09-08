<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<title>Filmando</title>
	<link href="css/style.css" rel="stylesheet">
	<link href="css/slider.css" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-light bg-dark">
		<a class="navbar-brand text-light" href="#">
			<img src="icons/movie2.png" width="30" height="30" alt=""> Filmando
		</a>
	</nav>

	<?php
	session_start();
	//echo $_SESSION['tecnica'] . ";" . $_SESSION['configurazione'] . ";" . implode(",", $_SESSION['contesti']) . ";" . $_SESSION['film'];
	//echo implode(",",  $_SESSION['testofrasi']);
	$spiegazione = "";
	if ($_SESSION['tecnica'] === "centroide")
		$spiegazione = $_SESSION['spiegazioneCentroide'];
	else
		$spiegazione = $_SESSION['spiegazioneSingole'];

	$path = "filesFilmando2/info utili/" . $_SESSION['film'] . ".txt";

	$file = fopen($path, "r") or die("Unable to open file!");
	$id = fgets($file);				//IDFILM
	$nome = fgets($file);			//TITOLO FILM
	$anno = fgets($file);			//ANNO
	$genere = fgets($file);			//GENERE
	$gen = explode(",", $genere);
	$numrating = fgets($file);		//NUMERO RATINGS IMDB
	$rating = fgets($file);			//RATING IMDB
	if (($attori = fgets($file)) !== false) {
		$act = explode(",", $attori);
	}
	fclose($file);
	?>
	<div class="container-fluid bg-light">
		<div class="row justify-content-md-center">
			<div class="col-xs-6 col-md-5 p-0">
				<div class="card bg-dark text-white border-0">
					<img class="card-img" src="poster/<?php echo $id ?>.jpg" alt="Card image">
					<div class="card-img-overlay d-flex flex-column justify-content-end align-items-start">
						<h3 class="card-text font-weight-light"><?php echo $nome ?></h3>
						<h6 class="card-text font-weight-light"><?php echo $anno ?></h6>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="card text-center bg-dark">
		<div class="card-body">
			<div class="row text-center">
				<div class="col-4 p-0">
					<img src="jpg/<?php echo $id ?>.jpg" class="card-img " style="width: 95px; height: 143px; alt=" Responsive image">
				</div>
				<div class="col-8 p-0">
					<h5 class="card-text">
						<?php
						foreach ($gen as $value)
							echo "<span class=\"badge badge-danger\">" . $value . "</span>";
						?>
					</h5>
					<h5 class="card-text">
						<?php
						if (isset($act)) {
							foreach ($act as $value2)
								echo "<span class=\"badge badge-primary\">" . $value2 . "</span>";
						}
						?>
					</h5>
					<h5 class="card-text">
						<span class="badge badge-warning"><?php echo $rating . "/10"; ?></span><br>
						<span class="badge badge-dark font-weight-light"><?php echo $numrating ?></span>
					</h5>
				</div>
			</div>

		</div>
	</div>

	<?php
	if (isset($_POST['valutazione1'])) {
		$path = "filesFilmando2/temp/report" . $_SESSION['tempo'] . ".txt";
		$file = fopen($path, "r") or die("Unable to open file!");
		$reportValutazione = fgets($file);

		$pref1 = $_POST['pref1'];       //trasparenza
		$pref2 = $_POST['pref2'];       //persuasione
		$pref3 = $_POST['pref3'];       //coinvolgimento
		$pref4 = $_POST['pref4'];       //fiducia

		$output = PHP_EOL . $reportValutazione . ";" . $pref1 . ";" . $pref2 . ";" . $pref3 . ";" . $pref4;
		$file = fopen("filesFilmando2/valutazione1.txt", "a") or die("Unable to open file!");
		fwrite($file, $output);
		fclose($file);
		header("location: results3.php");
	}
	?>

	<div class="card text-center bg-white">
		<div class="card-body">
			<h2 class="card-title">Justification 1</h2>
			<p class="card-text"><?php echo $spiegazione ?></p>
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

		<form action="" method="POST">
			<br>
			<div class="row justify-content-md-center text-center">

				<div class="col-md-3">
					<div class="slidecontainer">
						<label for="pref1">
							<h6>I understood why the movie was suggested to me:</h6>
						</label>
						<div align="center" class="font-weight-bold" id="valorepref1">3</div>
						<input type="range" min="1" max="5" value="3" class="slider" id="pref1" name="pref1" onfocus="coloreRange(this.id)" onclick="coloreRange(this.id)" onchange="coloreRange(this.id)">
					</div>
				</div>

				<div class="col-md-3">
					<div class="slidecontainer">
						<label for="pref2">
							<h6>The justification made the suggestion more convincing:</h6>
						</label>
						<div align="center" class="font-weight-bold" id="valorepref2">3</div>
						<input type="range" min="1" max="5" value="3" class="slider" id="pref2" name="pref2" onfocus="coloreRange(this.id)" onclick="coloreRange(this.id)" onchange="coloreRange(this.id)">
					</div>
				</div>

				<div class="col-md-3">
					<div class="slidecontainer">
						<label for="pref3">
							<h6>The justification allowed me to discover new information about the movie</h6>
						</label>
						<div align="center" class="font-weight-bold" id="valorepref3">3</div>
						<input type="range" min="1" max="5" value="3" class="slider" id="pref3" name="pref3" onfocus="coloreRange(this.id)" onclick="coloreRange(this.id)" onchange="coloreRange(this.id)">
					</div>
				</div>

				<div class="col-md-3">
					<div class="slidecontainer">
						<label for="pref4">
							<h6>The justification has increased my level of trust in the recommender system:</h6>
						</label>
						<div align="center" class="font-weight-bold" id="valorepref4">3</div>
						<input type="range" min="1" max="5" value="3" class="slider" id="pref4" name="pref4" onfocus="coloreRange(this.id)" onclick="coloreRange(this.id)" onchange="coloreRange(this.id)">
					</div>
				</div>

			</div>
			<div class="row justify-content-md-center text-center">
				<div class="col-md-4">
					<button type="submit" name="valutazione1" class="btn btn-primary btn-lg">Send feedback </button>
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
				<div> <a href="https://www.uniba.it/"><img src="icons/Logo_Uniba.png"></a> </div>
				<div> <a href="http://www.di.uniba.it/~swap/"><img height="60" src="icons/swap.PNG"></a></div>
			</div>
			<br>
		</div>
	</footer>
	<script src="js/slider.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>
