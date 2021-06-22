<?php
session_start();

date_default_timezone_set('UTC');
$_SESSION['tempo'] = date('l jS \of F Y h:i:s A');
$eta = $_POST['eta'];
$genere = $_POST['genere'];
$titolo = $_POST['titoloStudio'];
$frequenza = $_POST['frequenza'];
$recSys = $_POST['recSys'];

$output = $_SESSION['tempo'] . "," . $eta . "," . $genere . ";" . $titolo + ";" . $frequenza + ";" . $recSys . "\n";

$file = fopen("../filesFilmando2/utenti.txt", "a") or die("Unable to open file!");
fwrite($file, $output);
fclose($myfile);
header("location: ../pagine/sceltaContesti.html");
