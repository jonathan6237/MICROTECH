<html>
    <head>
        <meta charset="utf-8">
        <!-- importer le fichier de style -->
        <link rel="stylesheet" href="style.css" media="screen" type="text/css" />
    </head>
    <body style='background:#53af57; width:100%'>
        <div id="content">
            
            <a href='principale.php?deconnexion=true'><span>Déconnexion</span></a>
            
            <!-- tester si l'utilisateur est connecté -->
            <?php
                session_start();
                if(isset($_GET['deconnexion']))
                { 
                   if($_GET['deconnexion']==true)
                   {  
                      session_unset();
                      header("location:login.php");
                   }
                }
                else if($_SESSION['username'] !== ""){
                    $user = $_SESSION['username'];
                    // afficher un message
                    echo "<br>Bonjour $user, vous êtes connectés";
                }
            ?>
            
        </div>
        <div>
            <table align = center id ="table" border = '3' bgcolor = 'white' width = '50' cellpadding = '150'>
                <tr>
                    <td align = center><a href = 'accueil.php'>afficher les comptes</a></td>
                    <td align = center><a href = ''>Modifier un compte</a></td>
                    <td align = center><a href = ''>Bloquer/Débloquer un compte</a></td>
                </tr>
                <tr>
                    <td align = center><a href = ''>Créer un compte</a></td>
                    <td align = center><a href = ''>Faire une offre</a></td>
                    <td align = center><a href = ''>Supprimer un compte</a></td>
                </tr>
            </table>
        </div>
    </body>
</html>