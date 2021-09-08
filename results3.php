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

	if ($_SESSION['tecnica'] === "centroide")
		$spiegazione1 =	$_SESSION['spiegazioneCentroide'];
	else
		$spiegazione1 =	$_SESSION['spiegazioneSingole'];
	$spiegazione2 = $_SESSION['spiegazioneBaseline'];

	?>

	<?php
	if (isset($_POST['valutazione3'])) {
		$path = "filesFilmando2/temp/report" . $_SESSION['tempo'] . ".txt";
		$file = fopen($path, "r") or die("Unable to open file!");
		$reportValutazione = fgets($file);

		$pref0 = $_POST['pref0'];       //best suggiestion
		$pref1 = $_POST['pref1'];       //understand why
		$pref2 = $_POST['pref2'];       //more convincing
		$pref3 = $_POST['pref3'];       //discover more
		$pref4 = $_POST['pref4'];       //trust level

		$output = PHP_EOL . $reportValutazione . ";" . $pref0 . ";" . $pref1 . ";" . $pref2 . ";" . $pref3 . ";" . $pref4;
		$file = fopen("filesFilmando2/valutazione3.txt", "a") or die("Unable to open file!");
		fwrite($file, $output);
		fclose($file);
		header("location: results4.php");
	}
	?>

	<div class="card text-center">
		<div class="card-body">
			<h2 class="card-title">Justification 1</h2>
			<p class="card-text"><?php echo $spiegazione1; ?></p>
			<h2 class="card-title">Justification 2</h2>
			<p class="card-text"><?php echo $spiegazione2; ?></p>
		</div>
	</div>

	<div class="container-fluid bg-light">
		<br>
		<form action="" method="POST">
			<div class="row justify-content-md-center text-center">

				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref0" style="color: #c62828;">
							<h5>Given that the goal of the system is to
								generate a justification which is adapted <br> on the different contexts
								of consumption,which justification style do you prefer?</h5>
						</label>
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
						<label for="pref1">
							<h6>I understood why the movie was suggested to me</h6>
						</label>
						<select class="form-control" name="pref1">
							<option value="0">Indifferent</option>
							<option value="1">Justification 1</option>
							<option value="2">Justification 2</option>
						</select>
					</div>
				</div>

				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref2">
							<h6>The justification made the suggestion more convincing.</h6>
						</label>
						<select class="form-control" name="pref2">
							<option value="0">Indifferent</option>
							<option value="1">Justification 1</option>
							<option value="2">Justification 2</option>
						</select>
					</div>
				</div>

				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref3">
							<h6>The justification allowed me to discover new information about the movie</h6>
						</label>
						<select class="form-control" name="pref3">
							<option value="0">Indifferent</option>
							<option value="1">Justification 1</option>
							<option value="2">Justification 2</option>
						</select>
					</div>
				</div>

				<div class="col-md-auto">
					<div class="form-group">
						<label for="pref4">
							<h6>The justification has increased my level of trust in recommender systems</h6>
						</label>
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
					<button type="submit" name="valutazione3" class="btn btn-primary btn-lg">Send feedback </button>
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
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>
