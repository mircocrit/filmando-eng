<?php
session_start();

$path = "../filesFilmando2/temp/report". $_SESSION['tempo']. ".txt";
$file = fopen($path, "r") or die("Unable to open file!");
$reportValutazione = fgets($file);

$pref0 = $_POST['pref0'];       //best suggiestion
$pref1 = $_POST['pref1'];       //understand why
$pref2 = $_POST['pref2'];       //more convincing
$pref3 = $_POST['pref3'];       //discover more
$pref4 = $_POST['pref4'];       //trust level

$output = PHP_EOL . $reportValutazione . ";" . $pref0 .";" . $pref1 . ";" . $pref2 . ";" . $pref3 . ";" . $pref4;
$file = fopen("../filesFilmando2/valutazione3.txt", "a") or die("Unable to open file!");
fwrite($file, $output);
fclose($file);
     
header("location: ../results4.php");
