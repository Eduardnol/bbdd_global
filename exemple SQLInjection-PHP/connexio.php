<?php
function connecta() {
  $db_host="localhost"; $db_nom="web";	 $db_user="root"; $db_pass="";
  $conn = @mysqli_connect($db_host, $db_user, $db_pass, $db_nom) ;
  if (mysqli_connect_errno()) {
    echo "No es pot connectar: ". mysqli_connect_error();
    exit();
  }
  return $conn;
}

function imprimeix() {
	$conn = connecta();
	$sql = 'SELECT nom, cognom, telefon, email FROM Agenda';
	$result = mysqli_query($conn, $sql) or die('La consulta següent té un 	error:<br>nSQL: <b>$sql</b>');

	while ($row = mysqli_fetch_array($result))	{ 
		echo '<table border=1 cellspacing=0 width=200>';
			echo '<tr><th>'.$row["nom"].' '.$row["cognom"].'</th></tr>';
			echo '<tr><td>'.$row["email"].'</td></tr>';
			echo '<tr><td>'.$row["telefon"].'</td></tr><br>';
		echo '</table>';
	}
	
	mysqli_free_result($result);
	mysqli_close($conn);
} 

function comprovaLogin($user, $pass) {
	$conn = connecta();
	$sql = "SELECT username FROM Usuari WHERE username='$user' AND password= '$pass'";
	$result = mysqli_query($conn, $sql);
	$flag = mysqli_num_rows($result);
	
	mysqli_close($conn);
	return $flag;
}
?>
