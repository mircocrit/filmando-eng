<?php
session_start();

$date = new DateTime();
$_SESSION['tempo'] = $date->format('YmdHis');
$eta = $_POST['eta'];
$genere = $_POST['genere'];
$titolo = $_POST['titoloStudio'];
$frequenza = $_POST['frequenza'];
$recSys = $_POST['recSys'];

$output = $_SESSION['tempo'] . "," . $eta . "," . $genere . ";" . $titolo . ";" . $frequenza . ";" . $recSys . "\n";
echo $output;

$file = fopen("../filesFilmando2/utenti.txt", "a") or die("Unable to open file!");
fwrite($file, $output);
fclose($file);
header("location: ../pagine/sceltaContesti.html");
