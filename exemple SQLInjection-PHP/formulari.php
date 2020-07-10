<?php
function mostraLogin() { ?>
<html>
<head>
	<title>Benvingut a la pàgina de Login</title>
</head>
<style>
	h1 {color:#000000; text-align:center; font-size: 15pt}
	td {color:#000000; text-align:right; font-size: 12pt}
</style>
<body>
	<h1>Accès Web</h1>
	<form action="login.php" method="POST">
	<table style='border:1px solid #000000;' align='center'>
		<tr><td> Usuari: <input type='text' name='username'/></tr>
		<tr><td> Password: <input type='password' name='password'/></tr>
		<tr><td> <input type='submit' value='Accedeix!'/></tr>
	</table>
	</form>
</body>
</html>
<?php } ?>
