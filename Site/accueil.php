<?php
    ini_set('display_errors', 1);
    error_reporting(E_ALL|E_STRICT);
    require("biblio.php");
    if(isset($_POST['matricule'])and isset($_POST['nom'])and isset($_POST['login'])and isset($_POST['password'])){
		$matricule    = $_POST['matricule'];
		$nom          = $_POST['password'];
		$login        = $_POST['login'];
		$password     = $_POST['password'];
		inserEtudiant($matricule, $nom, $login, $password);
		echo "Enrégistrement de <b>$nom </b> effectué avec succès</h1>";
   	}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<title>Accueil</title>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body>

<div id="general">
<form method="post" action="accueil.php">
<input type="submit" name="entrer" value="Afficher les comptes" />
<input type="hidden" name="login" value="$login" />
<input type="hidden" name="password" value="$password" />
</form>
<table>
<?php
// Afficher les étudiants enrégistrés
   if(isset($_POST['entrer'])){
	echo "<h2>Affichage des comptes</h2>";
	$chaine = afficheEtudiants();
	echo $chaine;
   }
?>
</table>
</div>
</body>
</html>
