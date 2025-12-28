		Script PowerShell pour l'assemblage d'un Webtoon :

        Bref: il assemble toutes les images verticalement dans une ou plusieurs images JPG de hauteur $maxHeight , avant il vérifie et uniformise le formats, 
        les largeurs, les DPI et l'espace entre les scènes en recherchant les zones de couleur unie horizontales.

        Il y a 7 fonctions principales dans ce script :

    1.a		Ce script va rechercher et convertir toutes les images .webp .png .jpeg en .jpg et les convertir et remplacer dans le répertoire.
    1.b     Il va analyser les images jpg du répertoire pour vérifier si sont bien des images JPG valides.
        Principalement il recherchera les images corrompues ou mal encodées avec la mauvaise extension.
        en cas d'image corrompue il listera les fichiers dans un rapport d'erreur et s'arrêtera.
    1.c     il va vérifier et unifier leurs largeurs et leurs résolutions DPI en recherchant quelle sont les plus utilisées.
    1.d     Il va vérifier si un assemblage d'images est déjà présent dans le répertoire et le supprimer !
        Attention si des fichiers avec $prefix="WebToon n°" sont présent dans le répertoire il les éffacera !
    1.e     Il va renommer les images s'il y a du padding dans les noms de fichiers.(1.jpg,2.jpg,..,10.jpg en 01.jpg,02.jpg,..,10.jpg)
    1.f     il recherchera les espaces horizontaux de couleurs unies de plus de 50 pixels ($transihaut) pour uniformiser les espaces entre les scènes.
        Cette opération est assez longue et peut prendre plusieurs minutes en fonction du nombre d'images à traiter.
        a l'issue de cette opération il calculara le nombre d'images possible a assembler en fonction de la hauteur max définie (pondération) et ajustera la variable $maxHeight
    1.g     Il assemblera toutes les images à la suite sur une hauteur max de 60000 pixels ($maxHeight) et recherchera des lignes horizontales complètes
            de couleur unie dans l'image afin de faire une coupure entre deux images.

        Lancement du script :

    2.En ligne de commande il est possible de lancer le scripts directement en ligne de commande avec les paramètres suivants : 
            AssembJPG.ps1 "C:\Chemin\durépertoire\aassember" "true1" "true1" "true1"
                1er paramètre : Chemin du répertoire à assembler
                2ème paramètre : true pour uniformiser les largeurs des images
                3ème paramètre : true pour uniformiser les résolutions DPI des images
                4ème paramètre : true pour uniformiser les espaces entre les scènes

    2.b Il est possible de double cliquer directement sur le script pour le lancer la sélection du choix des paramètres se fera à l'exécution
	
    2.c Lancer le script depuis le menu contextuel de l'explorateur de fichier en ajoutant une clé dans le registre.
	    Ajouter la clé dans le registre pour pouvoir le lancer depuis le menu contextuel: (copier/coller le texte ci-dessous dans un fichier .reg)
			Windows Registry Editor Version 5.00

			[HKEY_CLASSES_ROOT\Folder\shell\AssembleJPG]
			@=""
			"MUIVerb"="Assemble les images JPG verticalement"
            "Icon"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
            00,25,00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,41,00,\
            73,00,73,00,65,00,6d,00,62,00,6c,00,65,00,4a,00,50,00,47,00,2e,00,69,00,63,\
            00,6f,00,00,00
			"Position"="1"

			[HKEY_CLASSES_ROOT\Folder\shell\AssembleJPG\command]
			@=""C:\Program Files\PowerShell\7\pwsh.exe" -ExecutionPolicy Bypass -File "C:\Users\Renaud\Scripts\AssembleJPG.ps1" "%1" "true" "true" "False"""
			
			[HKEY_CLASSES_ROOT\Folder\shell\AssembleJPG]
			@=""
			"MUIVerb"="Assemble les images JPG verticalement et transitions"
            "Icon"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
            00,25,00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,41,00,\
            73,00,73,00,65,00,6d,00,62,00,6c,00,65,00,4a,00,50,00,47,00,2e,00,69,00,63,\
            00,6f,00,00,00
			"Position"="1"

			[HKEY_CLASSES_ROOT\Folder\shell\AssembleJPG\command]
			@=""C:\Program Files\PowerShell\7\pwsh.exe" -ExecutionPolicy Bypass -File "C:\Users\Renaud\Scripts\AssembleJPG.ps1" "%1" "true" "true" "true"""
			

            (fin du .reg il faut garder les 2 lignes vides à la fin du fichier l'enregistrer et clique droit pour le fusionner au registre)
            (copier l'icon Assemble.jpg dans le répertoire C:\System32\system32\)

        Pré-requis pour le bon fonctionnement du script :
    3.a Le script nécessite d'avoir PowerShell 7 ou supérieur d'installé sur votre machine.
        Vous pouvez le télécharger ici : https://learn.microsoft.com/fr-fr/powershell/scripting/install/installing-powershell-on-windows
        Après l'installation de PowerShell 7 il faudra peut être modifier la ligne de commande dans le registre pour pointer vers le bon exécutable 
        (exemple : C:\Program Files\PowerShell\7\pwsh.exe -File C:\Users\'votre nom de compte'\Scripts\AssembleJPG.ps1 "%1" "true" "true" "false")

    3.b Pour la conversion d'image le script utilise imagemagick.
        vous devez ouvrir une fenêtre PowerShell en tant qu'administrateur et exécuter la commande suivante :
		    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.WebClient]::New().DownloadString('https://chocolatey.org/install.ps1') | Invoke-Expression
		et après :
                choco install imagemagick --acceptlicence --yes		
		Note:  l'installation échouera si une précédente installation est dans "C:\ProgramData\chocolatey" est présente il faudra supprimer ou renommer ce 
        répertoire manuellement.            

        Problème possible lors du lancement du script :
	4.a En cas d'interdiction de lancement des scripts:
			S'il y a une interdiction c'est que la politique de sécurité actuelle doit être "Restricted" qui est la valeur par défaut sous Windows.
            Pour la modifier, vous devez ouvrir une fenêtre PowerShell en tant qu'administrateur .
			Cliquez sur "Démarrer" puis saisissez "powershell", faites clic droit sur "Windows PowerShell" et cliquez sur "Exécuter en tant qu'Administrateur"
			Utilisez la commande suivante : "Set-ExecutionPolicy Unrestricted"
			Lorsqu'on vous demande de confirmer la modification, indiquez "O" pour Oui et appuyez sur Entrée et relancer le script ".\ConvertArchive.ps1"
