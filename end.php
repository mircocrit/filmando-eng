<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<title>Filmando</title>
	<link href="css/style.css" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-light bg-dark">
		<a class="navbar-brand text-light" href="#">
			<img src="icons/movie2.png" width="30" height="30" alt=""> Filmando
		</a>
	</nav>
	<?php
	session_start();

	$film = $_SESSION['film'];
	$titolo = $_SESSION['titolo'];
	$listaFilm = $_SESSION['top10'];
	?>

	<div class="container-fluid bg-light">
		<br>
		<div class="row justify-content-md-center text-center">
			<div class="col">
				<h1 class="display-4">Thanks for participating to the experiment!</h1>
			</div>
		</div>
		<div class="row justify-content-center text-center">
			<h4>If you want to repeat the experiment <a href="index.html" class="btn btn-primary" role="button"> click here </a></h4>
		</div>


		<div class="card">
			<div class="card-body">
				<div class="row justify-content-center text-center">
					<h4>Movies related to <?php echo $titolo; ?></h4>
				</div>

				<div class="row justify-content-center text-center">
					<div class="col-4 col-sm-3 col-md-2">
						<img src="jpg/<?php echo $film ?>.jpg" class="img-fluid" alt="Responsive image">
					</div>
				</div>

				<div class="row justify-content-md-center text-center">
					<?php
					$file2 = fopen("filesFilmando2/Scheda Film.txt", "r") or die("Unable to open file!");
					while (($line = fgets($file2)) !== false) {
						$pieces = explode(";", $line);
						foreach ($listaFilm as $temp) {
							if ($temp == $pieces[0] && $temp != $film) {
								$titolo = $pieces[1];
								echo "<div class=\"col-4 col-sm-3 col-md-2\">";
								echo "<h6>" . $titolo . "</h6>";
								echo "<img src=\"jpg/" . $temp . ".jpg\" 	class=\"img-fluid\" alt=\"Responsive image\">";
								echo "</div>";
							}
						}
					}
					?>
				</div>

				<br><br>
			</div>
		</div>
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
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>