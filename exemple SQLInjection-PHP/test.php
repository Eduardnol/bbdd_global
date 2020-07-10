<html>
<body>
        <FORM ACTION="test.php" METHOD="POST">
                Nom: <INPUT TYPE="text" NAME="name"><br>
                Login: <INPUT TYPE="text" NAME="login"><br>
                Cognom: <INPUT TYPE="text" NAME="cognom"><br>
                Carrer: <INPUT TYPE="text" NAME="carrer"><br>
                Nota Ingres: <INPUT TYPE="text" NAME="nota_ingres"><br>
        <INPUT TYPE="submit"VALUE="envia">
        </FORM>
</body>
</html>

<?php
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "universitat";
        $link = mysqli_connect($servername, $username, $password,$dbname);
        if (!$link) {
                echo "Error: No se pudo conectar a MySQL." . PHP_EOL;
                echo "errno de depuración: " . mysqli_connect_errno() . PHP_EOL;
                echo "error de depuración: " . mysqli_connect_error() . PHP_EOL;
                exit;
        }
        $login=isset($_REQUEST['login']) ? $_REQUEST['login']:'NULL!';
        $nom=isset($_REQUEST['nom']) ? $_REQUEST['nom']:'NULL!';
        $cognom=isset($_REQUEST['cognom']) ? $_REQUEST['cognom']:'NULL!';
        $carrer=isset($_REQUEST['carrer']) ? $_REQUEST['carrer']:'NULL!';
        $nota_ingres=isset($_REQUEST['nota_ingres']) ? $_REQUEST['nota_ingres']:'-1';
        
        $result= mysqli_query($link, 'INSERT INTO `alumne` (`login`, `nom`, `cognom`, `carrer`, `nota_ingres`) VALUES ($login, $nom, $cognom, $carrer, $nota_ingres);') or die("La consulta SQL <b>$sql</b> te un l'error: " .mysqli_error($link));
        mysqli_free_result($result);
        mysqli_close($link);

?>