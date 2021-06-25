<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<title>Filmando</title>
	<link href="css/style.css" rel="stylesheet">
</head>

<body>
	<nav class="navbar navbar-light bg-dark">
		<a class="navbar-brand text-light" href="#">
			<img src="icons/movie2.png" width="30" height="30" alt=""> Filmando
		</a>
	</nav>

	<div class="container-fluid bg-light">
		<div class="row text-center">
			<div class="col">
				<h1 class="display-4">Indicate the context of consumption of the item </h1>
				<h3>(at least one)</h3>
			</div>
		</div>

		<form action="php/ServletGestioneRichiesta.php" method="POST" name="form">
			<script type="text/javascript">
				function checkButton() {
					attenzione = document.form.attenzione.value;	//ALTA ATTENZIONE/BASSA ATTENZIONE
					umore = document.form.umore.value;				//BUON UMORE/CATTIVO
					compagnia = document.form.compagnia.value;		//AMICI,FAMIGLIA,COPPIA

					tasto = document.getElementById('infoUtente');
					console.log(tasto.disabled);

					//DEVE ESSERE SELEZIONATO ALMENO 1 DELLE 3 COMBINAZIONI
					if (compagnia == 0 && umore == 0 && attenzione == 0) {
						tasto.disabled = true;
					} else {
						tasto.disabled = false;
					}
				}
			</script>

			<div class="row justify-content-md-center text-center">
				<div class="col-md-auto">
					<div class="form-group">
						<label for="attenzione">
							<h4>Your level of attention</h4>
						</label>
						<select class="form-control" name="attenzione" onchange="checkButton()">
							<option value="0">Indifferent</option>
							<option value="1">High</option>
							<option value="2">Low</option>
						</select>
					</div>
				</div>
				<div class="col-md-auto">
					<div class="form-group">
						<label for="compagnia">
							<h4>Your company</h4>
						</label>
						<select class="form-control" name="compagnia" onchange="checkButton()">
							<option value="0">Indifferent</option>
							<option value="3">Partner</option>
							<option value="4">Family</option>
							<option value="5">Friends</option>
						</select>
					</div>
				</div>
				<div class="col-md-auto">
					<div class="form-group">
						<label for="umore">
							<h4>Your mood</h4>
						</label>
						<select class="form-control" name="umore" onchange="checkButton()">
							<option value="0">Indifferent</option>
							<option value="6">Good</option>
							<option value="7">Not good</option>
						</select>
					</div>
				</div>
			</div>
			<br><br><br>

			<div class="row justify-content-md-center text-center">
				<div class="col">
					<button type="submit" id="infoUtente" class="btn btn-primary btn-lg" disabled>Suggest! </button>
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

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>

</html>