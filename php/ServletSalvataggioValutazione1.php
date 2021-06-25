<?php
session_start();

$path = "../filesFilmando2/temp/report". $_SESSION['tempo']. ".txt";
$file = fopen($path, "r") or die("Unable to open file!");
$reportValutazione = fgets($file);

$pref1 = $_POST['pref1'];       //trasparenza
$pref2 = $_POST['pref2'];       //persuasione
$pref3 = $_POST['pref3'];       //coinvolgimento
$pref4 = $_POST['pref4'];       //fiducia


$output = PHP_EOL . $reportValutazione . ";" . $pref1 . ";" . $pref2 . ";" . $pref3 . ";" . $pref4;
$file = fopen("../filesFilmando2/valutazione1.txt", "a") or die("Unable to open file!");
fwrite($file, $output);
fclose($file);

header("location: ../results3.php");