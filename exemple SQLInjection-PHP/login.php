<?php
include('connexio.php');
include('formulari.php');

$user = isset($_POST["username"]) ? $_POST["username"] : "";
$pass = isset($_POST["password"]) ? $_POST["password"] : "";

if($user == "" || $pass == "")  
	mostraLogin();
else {
	$flag = comprovaLogin($user, $pass);

	if ($flag > 0){
		echo '<b><u>ACCÈS APROVAT</u></b><br><br>BENVINGUT <b>'.$user.',</b><br>';
		echo '<br>Aquí et fem constar un resum de la nostra BBDD:<br><br>';
		imprimeix();
	}else{
		echo '<b><u>ACCÈS DENEGAT</u></b><br><br>Prova-ho de nou <a href="login.php">aquí</a>';
	}
}
?>
