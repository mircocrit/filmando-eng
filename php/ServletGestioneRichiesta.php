<?php
session_start();

$configurazione = rand(0, 2);
if ($configurazione === 0)      $configurazione = "unigrammi";
else if ($configurazione === 1) $configurazione = "bigrammi";
else $configurazione = "unibigrammi";

$tecnica = rand(0, 1);
if ($tecnica === 0)   $tecnica = "normale";
else $tecnica = "pmi";

echo $configurazione . "," . $tecnica. "<br>";

$tecnica = "normale";
$_SESSION['configurazione'] = $configurazione;
$_SESSION['tecnica'] = $tecnica;

$eta =      (isset($_POST['attenzione']) && $_POST['attenzione'] !== "0")  ? $_POST['attenzione'] : null;
$genere =   (isset($_POST['compagnia']) &&  $_POST['compagnia'] !== "0")   ? $_POST['compagnia'] : null;
$titolo =   (isset($_POST['umore']) &&      $_POST['umore'] !== "0")       ? $_POST['umore'] : null;

$context  = array();
if ($eta !== null)       array_push($context, $eta);
if ($genere !== null)    array_push($context, $genere);
if ($titolo !== null)    array_push($context, $titolo);
$_SESSION['contesti'] = $context;

$contextstring =  implode(",", $context);
echo $contextstring . "<br>";


//TOP 10 FILM
$top10film = array();
$path = "../../filesFilmando2/"  . $tecnica . "/" . $configurazione . "/top10combinazioni-items.txt";
$file = fopen($path, "r") or die("Unable to open file!");
while (($line = fgets($file)) !== false) {
    $pieces = explode("\t", $line);
    if ($pieces[0] === $contextstring) {
        array_push($top10film, $pieces[1], $pieces[2], $pieces[3], $pieces[4], $pieces[5], $pieces[6], $pieces[7], $pieces[8], $pieces[9], $pieces[10]);
    }
}
echo "TOP10 film per CONTESTI: " . "[" . implode(",", $top10film) . "]" . "<br>";
$_SESSION['top10'] = $top10film;
$locale = array_rand($top10film);
$_SESSION['film'] = trim($top10film[$locale]);
echo "FILM suggerito: " . $_SESSION['film'] . "<br>";
fclose($file);


//CENTROIDE
$frasicentroide = array();
$path2 = "../../filesFilmando2/"  . $tecnica . "/" . $configurazione . "/contesti-item-frasi.txt";
$file2 = fopen($path2, "r") or die("Unable to open file!");
while (($line2 = fgets($file2)) !== false) {
    $pieces = explode("\t", $line2);
    if ($pieces[0] === $contextstring) {
        if ($pieces[1] === $_SESSION['film']) {
            $idfrase = explode(",", $pieces[2]);
            array_push($frasicentroide, $idfrase[0], $idfrase[1], $idfrase[2]);
        }
    }
}
echo "ID frasi centroide: " . implode(",", $frasicentroide) . "<br>";
$_SESSION['centroide'] = $frasicentroide;


//FRASI SINGOLE
$frasisingole = array();
$path3 = "../../filesFilmando2/"  . $tecnica . "/" . $configurazione . "/contesti-item-frasi-singole.txt";
$file3 = fopen($path3, "r") or die("Unable to open file!");
while (($line3 = fgets($file3)) !== false) {
    $pieces = explode("\t", $line3);
    if ($pieces[0] === $contextstring) {
        if ($pieces[1] === $_SESSION['film']) {
            $idfrase = explode(",", $pieces[2]);
            array_push($frasisingole, $idfrase[0]);
            if (isset($idfrase[1])) array_push($frasisingole, $idfrase[1]);
            if (isset($idfrase[2])) array_push($frasisingole, $idfrase[2]);
        }
    }
}
echo "ID frasi singole: " . implode(",", $frasisingole) . "<br>";
$_SESSION['frasisingole'] = $frasisingole;


$tipoFrasi = rand(0, 1);
if ($tipoFrasi === 0)   $tipoFrasi = "centroide";
else $tipoFrasi = "frasisingole";
$_SESSION['tecnica'] = $tipoFrasi;
echo "Tecnica: " . $tipoFrasi. "<br>";

//REPORT
$output = $_SESSION['tempo'] . ";" . $configurazione .  ";" . $tecnica . ";" . $tipoFrasi . ";" . $_SESSION['film'] . ";" . count($context) . ";" . $contextstring;
$file = fopen("../../filesFilmando2/temp/report". $_SESSION['tempo']. ".txt", "w") or die("Can't create file!");
fwrite($file, $output);
fclose($file);

header("location: ServletGenerazioneSpiegazioni.php");