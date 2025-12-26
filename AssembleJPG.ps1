<#   
                                                    _⎞⎞⎞⎛⎛⎛_
                                                     ⁔    ⁔         
                                                 (⎛ ⚪ ⁔ ⚪ ⎞)
                    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄◯◯◯◯o▄▄▄(OO)▄▄▄o◯◯◯◯▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
                    █           _                           _     _          _ ____   ____         █
                    █          / \   ___ ___  ___ _ __ ___ | |__ | | ___    | |  _ \ / ___|        █
                    █         / _ \ / __/ __|/ _ \ '_ ` _ \| '_ \| |/ _ \_  | | |_) | |  _         █
                    █        / ___ \\__ \__ \  __/ | | | | | |_) | |  __/ |_| |  __/| |_| |        █
                    █       /_/   \_\___/___/\___|_| |_| |_|_.__/|_|\___|\___/|_|    \____|        █
                    █                                                                              █
                    ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀oOOO◯▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
                                                                   ◯ᲿᲿᲿo
                                              ⎝     ⎞
                                                                   ⎝      ⎞
                                                ⎞  ⎛                ╲  
                                                (▁▁)                 ╲   ⎛ 
                                                                      (▁▁)
	Script PowerShell pour l'assemblage d'un Webtoon :

        Il y a 6 fonctions principales dans ce script :

    1.a		Ce script va convertir toutes les images .webp .png .jpeg en .jpg et les remplacer dans le répertoire.
    1.b     Il va analyser les images jpg du répertoire pour vérifier si sont bien des images JPG valides.
    1.c     il va vérifier et unifier leurs largeurs et leurs résolutions DPI en recherchant quelle sont les plus utilisées.
    1.d     Il va vérifier si un assemblage d'images est déjà présent dans le répertoire et le supprimer !
        Attention si des fichiers avec $prefix="WebToon n°" sont présent dans le répertoire il les éffacera !
    1.e     Il va renommer les images s'il y a du padding dans les noms de fichiers.(1.jpg,2.jpg,..,10.jpg en 01.jpg,02.jpg,..,10.jpg)
    1.f     il recherchera les espaces horizontaux de couleurs unies de plus de 30 pixels pour uniformiser les espaces entre les scènes.
        Cette opération est assez longue et peut prendre plusieurs minutes en fonction du nombre d'images à traiter.
    1.g     Il assemblera toutes les images à la suite sur une hauteur max de 65000 pixels et recherchera des lignes horizontales complètes
            de couleur unie dans l'image afin de faire une coupure entre deux images.
    
    2.a il est possible de lancer le scripts directement en ligne de commande avec les paramètres suivants : 
            AssembJPG.ps1 "C:\Chemin\durépertoire\aassember" "true1" "true1" "true1"
                1er paramètre : Chemin du répertoire à assembler
                2ème paramètre : true pour uniformiser les largeurs des images
                3ème paramètre : true pour uniformiser les résolutions DPI des images
                4ème paramètre : true pour uniformiser les espaces entre les scènes

    2.b Il est possible de double cliquer directement sur le script pour le lancer la sélection du choix des paramètres se fera à l'exécution
	
    2.c il est possible de lancer le script depuis le menu contextuel de l'explorateur de fichier en ajoutant une clé dans le registre.
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
			@="powershell -File C:\\Users\\'votre nom de compte'\\Scripts\\AssembleJPG.ps1 \"%1\"\ "true"\ "true"\ "false""
			
			[HKEY_CLASSES_ROOT\Folder\shell\AssembleJPG]
			@=""
			"MUIVerb"="Assemble les images JPG verticalement et postprossessing transitions"
            "Icon"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
            00,25,00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,41,00,\
            73,00,73,00,65,00,6d,00,62,00,6c,00,65,00,4a,00,50,00,47,00,2e,00,69,00,63,\
            00,6f,00,00,00
			"Position"="1"

			[HKEY_CLASSES_ROOT\Folder\shell\AssembleJPG\command]
			@="powershell -File C:\\Users\\'votre nom de compte'\\Scripts\\AssembleJPG.ps1 \"%1\"\ "true"\ "true"\ "true""
			

            (fin du .reg il faut garder les 2 lignes vides à la fin du fichier l'enregistrer et clique droit pour le fusionner au registre)
            (copier l'icon Assemble.jpg dans le répertoire C:\System32\system32\)

    3.a Important : Pré-requis pour le bon fonctionnement du script :
	        Pour la conversion d'image le script utilise imagemagick.
            vous devez ouvrir une fenêtre PowerShell en tant qu'administrateur et exécuter la commande suivante :
			    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.WebClient]::New().DownloadString('https://chocolatey.org/install.ps1') | Invoke-Expression
			et après :
                choco install imagemagick --acceptlicence --yes		
			Note:  l'installation échouera si une précédente installation est dans "C:\ProgramData\chocolatey" est présente il faudra supprimer ou renommer ce 
                    répertoire manuellement.            

	3.b En cas d'interdiction de lancement des scripts:
			S'il y a une interdiction c'est que la politique de sécurité actuelle doit être "Restricted" qui est la valeur par défaut sous Windows.
            Pour la modifier, vous devez ouvrir une fenêtre PowerShell en tant qu'administrateur et exécuter la commande suivante :

			Cliquez sur "Démarrer" puis saisissez "powershell", faites clic droit sur "Windows PowerShell" et cliquez sur "Exécuter en tant qu'Administrateur"
			Utilisez la commande suivante : "Set-ExecutionPolicy Unrestricted"
			Lorsqu'on vous demande de confirmer la modification, indiquez "O" pour Oui et appuyez sur Entrée et relancer le script ".\ConvertArchive.ps1"

	                                           Par:	 _____   __  __    ____     ____     ____    _   __    ____           ____                                      __
 													/ ___/  / / / /   / __ )   / __ \   /  _/   / | / /   /  _/          / __ \  ___    ____   ____ _  __  __  ____/ /
  													\__ \  / / / /   / __  |  / /_/ /   / /    /  |/ /    / /           / /_/ / / _ \  / __ \ / __ `/ / / / / / __  / 
 												   ___/ / / /_/ /   / /_/ /  / _, _/  _/ /    / /|  /   _/ /           / _, _/ /  __/ / / / // /_/ / / /_/ / / /_/ /  
												  /____/  \____/   /_____/  /_/ |_|  /___/   /_/ |_/   /___/          /_/ |_|  \___/ /_/ /_/ \__,_/  \__,_/  \__,_/   
                             																					        (1er version le 28.12.2024) contact@infosub.fr

    Et vive l'ASCI Art et les Amstrad CPC ! ;)
#>
# Définir l'encodage en UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
# Variables modifiable par l'utilisateur :
$prefix = "WebToon"                 # Préfixe des fichiers à assembler
$maxHeight = 60000                  # Défini la hauteur max des assemblages (au delà de 65000 pixels plantage limite du format JPG)
$transihaut = 50                    # Hauteur de la zone de transition à conserver (en pixels) entre les images assemblées                       
$tauxvariahorizontal = 6            # Tolérance de variation des couleurs pour la détection d'une ligne de transition (en cas de mauvais qualité de l'image il faut l'augmenté ex: 36)
$pasrecherche = 5                   # Pas d'analyse si = 1 toutes les lignes si 2 une ligne sur 2 si 3 une ligne sur 3 etc...
$global:nbexclu = 5                 # Nombre de lignes verticales en pixels à exclure au début et a la fin pour la zone de détection d'une ligne de transition (Certaine image on des bordures noires ou blanches)
$global:nbexclu2 = 80               # Nombre de lignes verticales en pixels à exclure au début et a la fin pour la zone de détection d'une ligne de transition dans le module d'assemblage uniquement
# Variables internes du script (ne pas modifier)
$global:hautoritot = 0              # initialisation des variables pour le calcul de la hauteur totale de l'image en cours
$global:hautfintot = 0              # comptabilise la hauteur finale de toutes les images
$datestart = Get-Date               # Date de démarrage du script pour les stats à la fin
$checkMark = [char]0x2705           # Check Mark Unicode
$global:barnbimg = 1                # Variable interne global pour la barre de progression entre les différentes fonctions
$host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size(120, $host.UI.RawUI.WindowSize.Height)
Write-Host ""
Write-Host "                                _                           _     _          _ ____   ____ " -ForegroundColor cyan
Write-Host "                               / \   ___ ___  ___ _ __ ___ | |__ | | ___    | |  _ \ / ___|" -ForegroundColor cyan
Write-Host "                              / _ \ / __/ __|/ _ \ '_ `` _ \| '_ \| |/ _ \_  | | |_) | |  _ " -ForegroundColor cyan
Write-Host "                             / ___ \\__ \__ \  __/ | | | | | |_) | |  __/ |_| |  __/| |_| |" -ForegroundColor cyan
Write-Host "                            /_/   \_\___/___/\___|_| |_| |_|_.__/|_|\___|\___/|_|    \____|" -ForegroundColor cyan
Write-Host "                                                                "
Write-Host "              📄 Script de conversion des images .webp .png .jpeg en .jpg & Uniformisation des largeurs" -ForegroundColor cyan
Write-Host "           d'images, des dpi et de l'espace entre les scènes, renommages zéro padding et assemblage vertical" -ForegroundColor cyan
Write-Host "                            v7.2 du 26.12.2025 par SUBRINI Renaud 📧 contact@infosub.fr" -ForegroundColor yellow
Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray
# Charger les assembly
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms
# Affiche une progressbar personalisable
function BarProgress {param ([int]$barLength,[int]$barprog,[int]$bartotal,[string]$bartext1,[string]$bartext2,[string]$bartext3,[int]$barcolor,[int]$barlargmax)
    try{if ($barlargmax -eq "" -or $null -eq $barlargmax) { $barlargMax = 115 }
        if ($bartotal -ne "" -or $null -ne $bartotal) { if ($barcolor -ne "5") {$barlargmax = $barlargMax - $barLength}} else {$barlargmax = 10}       
        if ($barcolor -eq "5") {$textLength = (($bartext1.Length + $bartext2.Length + $bartext3.Length) + 5)
            $leftPadding = [math]::Floor(($barlargMax - $textLength))
            $emptyLength =(" " * $leftPadding )
        write-host "`r$bartext1" -ForegroundColor green -NoNewline 
        write-host " $bartext2" -ForegroundColor cyan -NoNewline
        write-host " $bartext3" -ForegroundColor green -NoNewline
        write-host " $emptyLength" -ForegroundColor white -NoNewline
        return }
    if ($bartotal -ne "0") {$percent = [math]::Round(($barprog / $bartotal) * 100)} else {$percent = 0}# Calculer le pourcentage de progression   
    $percentDisplay = if ($percent -lt 10) { "  $percent%" } elseif ($percent -lt 100) { " $percent%" } else { "$percent%" } # Ajuster l'affichage du pourcentage pour aligner la barre de progression
    if ($barprog -gt $bartotal) { $barprog = $bartotal }    # Vérifier que la progression ne dépasse pas la valeur totale
    if ($percent -eq 100 -and $barcolor -ne "4" -and $barcolor -ne "1") { $bartext1 = $bartext3 }
    if (($bartext1 -eq "" -or $null -eq $bartext1) -and $barcolor -ne "4") { $bartext1 = $percentDisplay }
    if ($barcolor -eq "4") { $bartext1 = $percentDisplay }
    $barLength = $barLength - 2 # Ajuste la longueur de la barre de progression en prennant en compte les crochets
    $textLength1 = $bartext1.Length # Calculer la position du texte centré
    if ($barLength -lt $textLength1) { $bartext1 = $bartext1.Substring(0, ($barLength-2)) 
        $textLength1 = $bartext1.Length } # Si le texte est plus court que la valeur totale, ajuster la position du texte
    $textLength2 = $bartext2.Length # Calculer la longeur de bartext2
    if ($barlargmax -lt $textLength2) { $bartext2 = $bartext2.Substring(0, ($BarLargmax-2)) 
        $textLength2 = $bartext2.Length } # Si le texte est plus court que la valeur totale, ajuster la position du texte
    $textLength3 = $bartext3.Length
    if (($barlargmax -lt $textLength3) -and $barcolor -eq "4") { $bartext3 = $bartext3.Substring(0, ($barlargMax-($textLength2-2))) 
        $textLength3 = $bartext3.Length } elseif ($barLength -lt $textLength3) { $bartext3 = $bartext1.Substring(0, ($barLength-2)) 
    $textLength3 = $bartext3.Length } # Si le texte est plus court que la valeur totale, ajuster la position du texte
    if ($bartext3 -eq "" -or $null -eq $bartext3) { $textLength3 = 0 } else { $textLength3 = $bartext3.Length }
    if ($barlargmax -eq "0") { $barlargmax = $barlargMax - $bartotal }
    $leftPadding1 = [math]::Floor(($barLength - $textLength1) / 2)
    if ($barlargmax -lt $textLenth2) {$leftPadding2 = [math]::Floor(1)} else {$leftPadding2 = [math]::Floor(($barlargMax-$textLength2))}
    $rightPadding = $barLength - $textLength1 - $leftPadding1
    $progressBar = "[" + (" " * $leftPadding1) + $bartext1 + (" " * $rightPadding) + "]" # Créer la chaîne complète de la barre de progression avec les crochets
    if ($bartotal -eq "0") { Return }
    $filledLength = [math]::Round(($barprog / $bartotal) * ($barLength + 2)) # Calculer la longueur de la partie remplie et vide +2 pour inclure les crochets
    $emptyLength = ($barLength + 2) - $filledLength
    if ($barcolor -eq "4") { if (($bartext3 -eq ""  -or $null -eq $bartext3)-and  $barcolor -eq "4") {$leftPadding2 = [math]::Floor(($barlargMax-($textLength1+$textLength2)+2))} 
    else {$leftPadding2 = [math]::Floor(($barlargMax-($textLength1+$textLength2+$textLength3+2)))}}
    $emptyLength2 =(" " * $leftPadding2)   
    if ($barcolor -ne "4") { $leftPadding2 = [math]::Floor(($barlargMax-($textLength2)+2))
        $emptyLength2 =(" " * $leftPadding2) }
    Write-Host "`r" -NoNewline    # Afficher la barre de progression sur la même ligne
    # Afficher la partie remplie de la barre
    if ($barcolor -eq "0") {if ($percent -eq 100) {Write-Host ($progressBar.Substring(0, $filledLength)) -ForegroundColor White -BackgroundColor Green -NoNewline}
    else {Write-Host ($progressBar.Substring(0, $filledLength)) -ForegroundColor Black -BackgroundColor White -NoNewline }}
    if ($barcolor -eq "1") { if ($percent -gt 74) {Write-Host ($progressBar.Substring(0, $filledLength)) -ForegroundColor White -BackgroundColor Green -NoNewline}
    elseif ($percent -lt 25) {Write-Host ($progressBar.Substring(0, $filledLength)) -ForegroundColor Black -BackgroundColor Red -NoNewline}
    elseif ($percent -lt 75) {Write-Host ($progressBar.Substring(0, $filledLength)) -ForegroundColor Black -BackgroundColor Yellow -NoNewline}}
    if ($barcolor -eq "2") {Write-Host ($progressBar.Substring(0, $filledLength)) -ForegroundColor White -BackgroundColor Green -NoNewline}
    if ($barcolor -eq "3") {Write-Host ($progressBar.Substring(0, $filledLength)) -ForegroundColor White -BackgroundColor Green -NoNewline}
    if ($barcolor -eq "4") {Write-Host ($progressBar.Substring(0, $filledLength)) -ForegroundColor White -BackgroundColor Green -NoNewline}
    # Afficher la partie vide de la barre
    Write-Host ($progressBar.Substring($filledLength, $emptyLength)) -ForegroundColor White -BackgroundColor Black -NoNewline
    # Afficher le pourcentage et le texte après la barre
    if ($barcolor -eq "0") { if ($percent -eq 100) {Write-Host " $bartext2$emptyLength2" -ForegroundColor Green -NoNewline} 
        else {Write-Host " $bartext2$emptyLength2" -ForegroundColor Cyan -NoNewline}}
    if ($barcolor -eq "1") {if ($percent -gt 74) {Write-Host " $bartext2$emptyLength2" -ForegroundColor Green -NoNewline}
        elseif ($percent -lt 25) {Write-Host " $bartext2$emptyLength2" -ForegroundColor Red -NoNewline}
        elseif ($percent -lt 75) {Write-Host " $bartext2$emptyLength2" -ForegroundColor Yellow -NoNewline}}
    if ($barcolor -eq "2") {Write-Host " $bartext2$emptyLength2" -ForegroundColor White -NoNewline} 
    if ($barcolor -eq "3") {Write-Host " $bartext2$emptyLength2" -ForegroundColor White -NoNewline}
    if ($barcolor -eq "4" -and ($bartext3 -ne "" -or $null -eq $bartext3)) { write-host " $bartext1" -ForegroundColor green -NoNewline 
        write-host " $bartext2" -ForegroundColor White -NoNewline
        write-host " $bartext3$emptyLength2" -ForegroundColor white -NoNewline}
    if ($barcolor -eq "4" -and ($bartext3 -eq "" -or $null -eq $bartext3)) { write-host " $bartext2" -ForegroundColor White -NoNewline
        write-host " $bartext3$emptyLength2 " -ForegroundColor white -NoNewline}
    } catch { $errorMessage = $_.Exception.Message.Split("`n")[0]
    $errorLine = $_.ScriptStackTrace.Split("`n")[0]
    [console]::beep(300,600)
    Write-Host ""
    Write-Host ""
    Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
    Write-Host " ⛔ Erreur dans le script : Fonction barre de progression ...."
    Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
    Write-Host "Ligne d'erreur : $errorLine" -ForegroundColor Red
    Write-Host "$errorMessage" -ForegroundColor Red
    Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
    Write-Host ""
    Write-Host "Etats des variables : " -ForegroundColor White
    Write-Host "barLength->$barLength barprog->$barprog bartotal->$bartotal barcolor->$barcolor percent->$percent barlargMax->$barlargMax"
    Write-Host "bartext1->$bartext1< bartext2->$bartext2< bartext3->$bartext3<"
    Write-Host "textLength1->$textLength1 textLength2->$textLength2 textLength3->$textLength3"
    Write-Host "emptyLength->$emptyLength< emptyLength2->$emptyLength2< emptyLength3->$emptyLength3< percentDisplay>$percentDisplay"
    Write-Host "leftPadding->$leftPadding1< rightPadding->$rightPadding<" -ForegroundColor White -BackgroundColor Green
    Write-Host "leftPadding2:$leftPadding2< leftPadding3->$leftPadding3<"-ForegroundColor White -BackgroundColor Green
    Write-Host "progressBar->$progressBar<" -ForegroundColor White -BackgroundColor Green
    Write-Host "filledLength->$filledLength<" -ForegroundColor White -BackgroundColor Green
    Write-Host "" -BackgroundColor black -ForegroundColor White
    Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
    Write-Host ""
    $Global:ilyaerreur = $true 
    Pause
    exit}}
# Fonction pour assembler les images
function Merge-Images { param ( [string]$directoryPath )
	Write-Host "Démarrage de l'assemblage des images du répertoire :📁 " -ForegroundColor White -NoNewline
    if ($directoryPath.Length -ge 61) {$dirNametemp = "... " + $directoryPath.Substring($directoryPath.Length - 57)} else {$dirNametemp = $directoryPath}
	Write-Host "$dirNametemp" -ForegroundColor green
	$listjpgFiles = Get-ChildItem -LiteralPath $directoryPath -Filter *.jpg -Recurse
	$listwebpFiles = Get-ChildItem -LiteralPath $directoryPath -Filter *.webp -Recurse
	$listpngFiles = Get-ChildItem -LiteralPath $directoryPath -Filter *.png -Recurse
	$listjpegFiles = Get-ChildItem -LiteralPath $directoryPath -Filter *.jpeg -Recurse
	$jpgCountl = $listjpgFiles.Count
	$webpCountl = $listwebpFiles.Count
	$pngCountl = $listpngFiles.Count
	$jpegCountl = $listjpegFiles.Count
	$totalimagefile = ($listjpgFiles.Count) + ($listwebpFiles.Count) + ($listpngFiles.Count) + ($listjpegFiles.Count)
	Write-Host "Analyse du nombre d'images présentes dans le répertoire .jpg:" -ForegroundColor White -NoNewline
	Write-Host "$jpgCountl" -ForegroundColor green -NoNewline
	Write-Host "  .webp:" -ForegroundColor White -NoNewline
	Write-Host "$webpCountl" -ForegroundColor cyan -NoNewline
	Write-Host "  .png:" -ForegroundColor White -NoNewline
	Write-Host "$pngCountl" -ForegroundColor cyan -NoNewline
	Write-Host "  .jpeg:" -ForegroundColor White -NoNewline
	Write-Host "$jpegCountl" -ForegroundColor cyan -NoNewline
	Write-Host "    donc au Total:" -ForegroundColor White -NoNewline
	Write-Host "$totalimagefile" -ForegroundColor green
    if ($totalimagefile -eq 0) { Write-Host "❌ Rien à assembler, aucun fichier d'image trouvé dans le répertoire." -ForegroundColor Gray
        Write-Host ""
        start-sleep -Seconds 5
        exit}
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fonction utilitaire : détecte le format réel via magic bytes
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
    function Get-ImageFormatFromFile {
        param([string]$path)
        if (-not (Test-Path $path)) { return $null }
        try {
            $fs = [System.IO.File]::Open($path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::Read)
            $bytes = New-Object byte[] 12
            $read = $fs.Read($bytes, 0, $bytes.Length)
            $fs.Close()
        } catch { return $null }
        if ($read -ge 3 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xD8 -and $bytes[2] -eq 0xFF) { return "jpeg" }
        if ($read -ge 12 -and ($bytes[0] -eq 0x52 -and $bytes[1] -eq 0x49 -and $bytes[2] -eq 0x46 -and $bytes[3] -eq 0x46 -and $bytes[8] -eq 0x57 -and $bytes[9] -eq 0x45 -and $bytes[10] -eq 0x42 -and $bytes[11] -eq 0x50)) { return "webp" }
        if ($read -ge 8 -and $bytes[0] -eq 0x89 -and $bytes[1] -eq 0x50 -and $bytes[2] -eq 0x4E -and $bytes[3] -eq 0x47) { return "png" }
        if ($read -ge 6) {
            $s = [System.Text.Encoding]::ASCII.GetString($bytes,0,6)
            if ($s -match '^GIF8[79]a') { return "gif" }
        }
        return "unknown"
    }
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fin de la fonction utilitaire
#
# Scan systématique de tous les .jpg/.jpeg : si le contenu réel n'est pas JPEG on renomme en .webp
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray 
Write-Host "✅ Analyse du format des images jpg pour vérifier leur format réel..." -ForegroundColor white -NoNewline
$jpgFiles = [System.IO.Directory]::EnumerateFiles($directoryPath, "*.jpg", [System.IO.SearchOption]::AllDirectories) + [System.IO.Directory]::EnumerateFiles($directoryPath, "*.jpeg", [System.IO.SearchOption]::AllDirectories)
    $renamedCount = 0
foreach ($jf in $jpgFiles) {
        $realFmt = Get-ImageFormatFromFile -path $jf
        if ($realFmt -eq "unknown" ) {Write-Host "   ⚠️ $oldName " -ForegroundColor Yellow -NoNewline
                Write-Host "n'est pas une image JPG mais un format inconnu "-ForegroundColor white 
                Pause
			    exit}
        if ($realFmt -and ($realFmt -ne "jpeg")) {
            try {
                if ($renamedCount -eq 0) { Write-host "" ; Write-host "" }
                $oldName = [System.IO.Path]::GetFileName($jf)
                if ($realFmt -eq "webp" ) {$newWebpPath = [System.IO.Path]::ChangeExtension($jf, ".webp")}
                if ($realFmt -eq "png" ) {$newWebpPath = [System.IO.Path]::ChangeExtension($jf, ".png")}
                if ($realFmt -eq "gif" ) {$newWebpPath = [System.IO.Path]::ChangeExtension($jf, ".gif")}
                if ($realFmt -eq "unknown" ) {Write-Host "   ⚠️ $oldName " -ForegroundColor Yellow -NoNewline
                Write-Host "n'est pas une image JPG mais un format inconnu "-ForegroundColor white 
                Pause
			    exit}
                $dir = [System.IO.Path]::GetDirectoryName($newWebpPath)
                $base = [System.IO.Path]::GetFileNameWithoutExtension($newWebpPath)
                $ext = [System.IO.Path]::GetExtension($newWebpPath)
                $candidate = $base
                $candidatePath = Join-Path $dir ($candidate + $ext)
                while (Test-Path -LiteralPath $candidatePath) {
                    $candidate += "a"
                    $candidatePath = Join-Path $dir ($candidate + $ext)
                }
                Move-Item -LiteralPath $jf -Destination $candidatePath -Force
                $renamedCount++
                #$jfName = [System.IO.Path]::GetFileName($candidatePath)
                Write-Host "   ⚠️ $oldName " -ForegroundColor Yellow -NoNewline
                Write-Host "n'est pas une image JPG mais bien une image au format "-ForegroundColor white -NoNewline
                Write-Host "$realFmt" -ForegroundColor Cyan -NoNewline
                Write-Host " elle sera donc convertie" -ForegroundColor white
            } catch {
                Write-Host "Impossible de renommer $jf : $($_.Exception.Message)" -ForegroundColor Red
            Pause
			exit
			}
        }
    }
	if ($renamedCount -gt 0) {
    Write-Host ""
    Write-Host "✅ $renamedCount fichiers .jpg/.jpeg  au total renommés pour conversion" -ForegroundColor Cyan
				#sleep 3
	} else {
			Write-Host "`r👍 La vérification du bon format des fichiers .jpg/.jpeg est terminé ... " -ForegroundColor Green
	}
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fin du scan systématique des jpg
#
# Début de la conversion des fichiers .webp .png .jpeg en .jpg
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
#Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray 
# Récupérer toutes les images dans le répertoire
	$images = Get-ChildItem -LiteralPath "$directoryPath" -Filter "*.jpg" -Recurse | Sort-Object DirectoryName, Name
# Rechercher tous les fichiers .webp et .png dans le répertoire et ses sous-répertoires
	$webpFiles1 = [System.IO.Directory]::EnumerateFiles($directoryPath, "*.webp", [System.IO.SearchOption]::AllDirectories) | Sort-Object
	$webpFiles2 = [System.IO.Directory]::EnumerateFiles($directoryPath, "*.png", [System.IO.SearchOption]::AllDirectories) | Sort-Object
	$webpFiles3 = [System.IO.Directory]::EnumerateFiles($directoryPath, "*.jpeg", [System.IO.SearchOption]::AllDirectories) | Sort-Object
	$imageFiles = @()
	$imageFiles += $webpFiles1 | ForEach-Object { Get-Item -LiteralPath $_ }
	$imageFiles += $webpFiles2 | ForEach-Object { Get-Item -LiteralPath $_ }
	$imageFiles += $webpFiles3 | ForEach-Object { Get-Item -LiteralPath $_ }
	$Nbdeficaconv = $imageFiles.Count
#Chemin vers ImageMagick
	$imageMagickPath = Get-ChildItem -Path "C:\Program Files\" -Filter "magick.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty DirectoryName -First 1
# Vérifier s'il y a des fichiers .webp ou .png
	$nbficconvtot = 1
# Conversion des fichiers .webp et .png en .jpg
if ($Nbdeficaconv -gt 0 ) {
    foreach ($file in $imageFiles) {
        try {   $fileNametemp = [System.IO.Path]::GetFileName($file)
            if ($fileNametemp.Length -ge 35) { $fileNametemp = $fileNametemp.Substring(0, 35)} 
                BarProgress -barprog $nbficconvtot -bartotal $Nbdeficaconv -barLength 59 -bartext1 "✨ Conversion en cours ..." -bartext2 "Traitement de $fileNametemp" -bartext3 "Conversion terminée" -barcolor 1
                $jpgPath = [System.IO.Path]::ChangeExtension($file.FullName, ".jpg")
			    & "$imageMagickPath\magick.exe" $file.FullName $jpgPath
		# Supprimer le fichier d'origine
		        $zipItem3 = Get-Item -LiteralPath $file.FullName
		        $zipItem3 | Remove-Item -Force
			    $nbficconvtot++
        } 
        catch { Write-Host ""
                Write-Host "Erreur lors de la conversion de $($file.FullName) : $_" -ForegroundColor red
			    pause
			    exit }}
    Write-Host "`r                                                                                                                        " -NoNewline
    Write-Host "`r──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray 
	Write-Host "$checkMark Toutes les images " -ForegroundColor White -NoNewline
	Write-Host ".webp .png" -ForegroundColor cyan -NoNewline
	Write-Host " et " -ForegroundColor White -NoNewline
	Write-Host ".jpeg" -ForegroundColor cyan -NoNewline
	Write-Host " converties en " -ForegroundColor White -NoNewline
	Write-Host ".jpg" -ForegroundColor cyan -NoNewline
	Write-Host " => " -ForegroundColor White -NoNewline
	write-Host "$($nbficconvtot-1)" -ForegroundColor cyan -NoNewline
	Write-Host " fichiers supprimés " -ForegroundColor red -NoNewline
	Write-Host "$Nbdeficaconv" -ForegroundColor cyan -NoNewline
	Write-Host " fichiers convertis " -ForegroundColor green} 
    else {  Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray 
            Write-Host "👍 Il n'y a pas de conversion de format de fichier webp,png ou jpeg nécessaire ..." -ForegroundColor Gray}
Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray 
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fin de conversion webp to jpeg
#
# Vérification si il existe déjà un assemblage de fichier
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
#$testwebtexit = ("$directoryPath\$prefix" + "001.jpg")
$testfilesper = Get-ChildItem -LiteralPath $directoryPath -Filter "$prefix*.jpg" -Recurse
$matchingFilesFi1 = $testfilesper | Where-Object { $_.Name -match "^$prefix\d{1,3}\.jpg$" }
$firstFileFi1 = $matchingFilesFi1 | Sort-Object Name | Select-Object -First 1
if ($firstFileFi1 -and (Test-Path -LiteralPath $firstFileFi1.FullName)) {
	Write-Host "⚠️ Attention, un assemblage est déjà présent avec le prefix " -ForegroundColor white -NoNewline
	Write-Host "$($prefix)XXX.jpg" -ForegroundColor yellow -NoNewline
	Write-Host " dans ce répertoire." -ForegroundColor white
    Write-Host ""
# Filtrer les fichiers qui correspondent au modèle "$prefixXXX.jpg"
foreach ($file in $testfilesper) {
    if ($file.Name -match "^$prefix\d{3}\.jpg$") { 
        $Remoldass = Get-Item -LiteralPath $file.FullName
		$Remoldass | Remove-Item -Force
        Write-Host  "`r❌ Suppression de " -ForegroundColor white -NoNewline
        $fileNametemp = $file.FullName
        if ($fileNametemp.Length -ge 91) {$fileNametemp = "..." + $fileNametemp.Substring($fileNametemp.Length - 87)} else {$fileNametemp = $file.FullName}
		Write-Host "$($fileNametemp)   " -ForegroundColor Red  -NoNewline}}
        Write-Host "" 
        Write-Host ""
        Write-Host "                                                                  ✅  Au total " -ForegroundColor white -NoNewline
        Write-Host "$($testfilesper.Count)" -ForegroundColor red -NoNewline
        Write-Host " fichiers supprimé du répertoire !" -ForegroundColor white -NoNewline
        Write-Host ""} 
    else {    Write-Host "👍 Il n'y a pas d'assemblage déjà présent dans le répertoire ..." -ForegroundColor gray	}
Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray 
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fin de vérification d'un précédent assemblage
#
# Trouver la largeur la plus fréquente
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
#$unitlarg = $false
if ($unitlarg) {    Write-Host "🔍 Démarrage de l'analyse de la largeurs des images dans le répertoire ..."-ForegroundColor white
                    Write-Host ""
$images = Get-ChildItem -LiteralPath "$directoryPath" -Filter "*.jpg" -Recurse | Sort-Object DirectoryName, Name
# Créer un dictionnaire pour stocker les largeurs et leurs fréquences
$widthFrequency = @{}
$tempcompt = 0
# Parcourir les images pour collecter les largeurs
foreach ($image in $images) { $img = [System.Drawing.Image]::FromFile($image.FullName)
    $width = $img.Width
    if ($widthFrequency.ContainsKey($width)) { $widthFrequency[$width]++
        $imageCountTemp = $images.Count
        $fileNametemp = [System.IO.Path]::GetFileName($image)
        if ($fileNametemp.Length -ge 19) { $fileNametemp = $fileNametemp.Substring(0, 19)} 
        $tempcompt++
        BarProgress -barprog $tempcompt -bartotal $imageCountTemp -barLength 59 -bartext1 "⏳ Analyse en cours $tempcompt/$imageCountTemp..." -bartext2 "Le fichier $fileNametemp a une largeur de $($width)p" -bartext3 "" -barcolor 1} 
    else { $widthFrequency[$width] = 1
        $imageCountTemp = $images.Count
        $fileNametemp = [System.IO.Path]::GetFileName($image)
        if ($tempcompt -eq "0") { BarProgress -barprog $tempcompt -bartotal $imageCountTemp -barLength 60 -bartext1 "Le 1er fichier est de $width Pixels de largeur" -bartext2 "Le fichier $fileNametemp est d'une largeur de $($width)p" -bartext3 "" -barcolor 3
        $tempcompt++}
        else { $tempcompt++
        BarProgress -barprog $tempcompt -bartotal $imageCountTemp -barLength 60 -bartext1 "Le fichier $tempcompt/$imageCountTemp lui est de $width Pixels" -bartext2 "Le fichier $fileNametemp est d'une largeur de $($width)p" -bartext3 "" -barcolor 0}
        Write-host ""} $img.Dispose() }
# Trouver la largeur la plus fréquente
BarProgress -barprog $tempcompt -bartotal $imageCountTemp -barLength 60 -bartext1 "Le dernier fichier est de $width Pixels de largeur" -bartext2 "Le fichier $fileNametemp est d'une largeur de $($width)p" -bartext3 "" -barcolor 1
$mostCommonWidth = $widthFrequency.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 1 | ForEach-Object { $_.Key }
$numberOfGroups = $widthFrequency.Keys.Count
Write-Host ""
Write-Host "" -NoNewline
            if ($numberOfGroups -eq 1) {Write-Host ""
                Write-Host "👍 L'analyse nous indique que toutes les images ont bien la même largeur en " -ForegroundColor green -NoNewline
                Write-Host "$mostCommonWidth" -ForegroundColor cyan -NoNewline
                Write-Host " pixels " -ForegroundColor green} 
            else {  write-host ""
                    Write-Host "Au total il y a donc " -ForegroundColor white -NoNewline
                    Write-Host "$numberOfGroups" -ForegroundColor cyan -NoNewline
                    Write-Host " groupes répartis de la manière suivante :" -ForegroundColor white
                    $totlargamod = 0
                    $totlargmax = 0
                        foreach ($width in $widthFrequency.Keys) { $Nobfictem3 = $($widthFrequency[$width])
                        Write-Host "                                                                $Nobfictem3" -ForegroundColor cyan -NoNewline
                        Write-Host " Fichiers avec une largeur de " -ForegroundColor White -NoNewline
                        Write-Host "$width" -ForegroundColor cyan -NoNewline
                        Write-Host " pixels" -ForegroundColor White
                # Définir le nombre de fichier a modifier ....
                        $totlargamod = $totlargamod + $Nobfictem3
                    if ($Nobfictem3 -gt $totlargmax) { $totlargmax = $widthFrequency[$width] }}
                    $totlargficmod = $($totlargamod-$totlargmax)
                    Write-host ""
                    Write-host "Il y a donc " -ForegroundColor green -NoNewline
                    Write-host "$($totlargamod-$totlargmax)" -ForegroundColor red -NoNewline
                    Write-host " fichiers qui ont une largeurs différente de " -ForegroundColor green -NoNewline
                    Write-Host "$mostCommonWidth" -ForegroundColor cyan -NoNewline
                    Write-Host " pixels $checkMark" -ForegroundColor green}
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fin de l'analyse des largeurs
#
# Redimensionner les images qui n'ont pas la largeur la plus commune ...
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
if ($totlargficmod -gt 0) { write-host ""
    $nbficrenom2 = 0
    $tempcompt = 1
    Write-Host "🔍 Démarrage du redimensionnement des images en cours ..." -ForegroundColor green -NoNewline
        if ($numberOfGroups -eq 1) { $bartotalt = $numberOfGroups} 
        else { $bartotalt = $numberOfGroups - 1 }
    foreach ($image in $images) { $img = [System.Drawing.Image]::FromFile($image.FullName)
        if ($img.Width -ne $mostCommonWidth) {
        $oldWidth = $img.Width
        $newHeight = [math]::Round($img.Height * ($mostCommonWidth / $img.Width))
        $newImage = New-Object System.Drawing.Bitmap($mostCommonWidth, $newHeight)
        $graphics = [System.Drawing.Graphics]::FromImage($newImage)
        $graphics.DrawImage($img, 0, 0, $mostCommonWidth, $newHeight)
        $fileNametemp = [System.IO.Path]::GetFileName($image)
        if ($fileNametemp.Length -ge 12) { $fileNametemp = $fileNametemp.Substring(0, 12)} 
        BarProgress -barprog $tempcompt -bartotal $($totlargamod-$totlargmax) -barLength 39 -bartext1 "" -bartext2 " ⏳ Conversion de l'image $fileNametemp de $($oldWidth)p vers $($mostCommonWidth)p" -bartext3 "" -barcolor 0
        $tempcompt++
    # Enregistrer l'image avec une extension temporaire
        $tempFileName = "$($image.FullName).tmp"
        $newImage.Save($tempFileName, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    # Décharger l'image originale
        $graphics.Dispose()
        $newImage.Dispose()
        $img.Dispose()
    # Supprimer l'image originale et renommer la nouvelle
        $image | Remove-Item -Force
        Rename-Item $tempFileName $image.FullName
        $nbficrenom2 = $nbficrenom2 +1} 
        else { $img.Dispose()}}
        if ($nbficrenom2 -eq 0) {write-host "Pas de redimensionnement nécessaire, les images ont déjà la largeur la plus commune." -ForegroundColor green
                Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray } 
        else {  BarProgress -barprog $($tempcompt-1) -bartotal $($totlargamod-$totlargmax) -barLength 40 -bartext1 "" -bartext2 " Fin de conversion des images vers $($mostCommonWidth) pixels" -bartext3 "" -barcolor 0
                write-host ""
                Write-Host ""
                Write-host "✅ le redimensionnement est terminé. Les images ont maintenant une largeur uniforme de "-ForegroundColor green -NoNewline
                Write-host "$($mostCommonWidth) pixels." -ForegroundColor yellow
                Write-Host ""
                Write-Host "                                                                          Au total " -ForegroundColor white -NoNewline
                Write-Host "$nbficrenom2" -ForegroundColor red -NoNewline
                Write-Host " fichiers redimensionnés !" -ForegroundColor white
                Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray }} 
else {  Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray }} 
else {  Write-Host "L'Analyse de la largeurs des images est déactiver" -ForegroundColor darkgray
	    Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray}
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# fin Trouver la largeur la plus fréquente
#
# Vérification de la cohérence DPI des images 
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
if ($dpifind) { $jpgFiles = Get-ChildItem -LiteralPath $directoryPath -Filter *.jpg -Recurse
Write-Host "🔍 Début de l'Analyse de la résolution DPI des images du répertoire ..." -ForegroundColor white
Write-Host ""
$Global:imageCountG = $jpgFiles.Count
# Dictionnaire pour stocker les résolutions DPI et leur fréquence
$dpiFrequencies = @{}
$tempcompt=0
$barimcount = 0
foreach ($file in $jpgFiles) {
    try {
    # Utiliser un flux de données pour charger l'image
        $stream = [System.IO.File]::OpenRead($file.FullName)
        $image = [System.Drawing.Image]::FromStream($stream)
        $tempcompt++
        $imageCountTemp = $jpgFiles.Count
        $fileNametemp = [System.IO.Path]::GetFileName($file.FullName)
        if ($fileNametemp.Length -ge 12) { $fileNametemp = $fileNametemp.Substring(0, 12)} 
    # Obtenir la résolution DPI de l'image
        $dpiX = $image.HorizontalResolution
        $dpiY = $image.VerticalResolution
        $dpiKey = "$dpiX x $dpiY"
        if ($dpiX -gt $dpimaxtemp ) { $dpimaxtemp = $dpiX }
    # Mettre à jour la fréquence de la résolution DPI
        if ($dpiFrequencies.ContainsKey($dpiKey)) { $dpiFrequencies[$dpiKey]++
        BarProgress -barprog $tempcompt -bartotal $imageCountTemp -barLength 60 -bartext1 "$fileNametemp ($dpiKey) DPI" -bartext2 "$tempcompt/$imageCountTemp ⏳ Analyse de la cohérences des DPI ..." -bartext3 "Dimensions DPI obtenu" -barcolor 1}
        else { $dpiFrequencies[$dpiKey] = 1 }
    # Libérer les ressources de l'image
        $image.Dispose()
        $stream.Dispose()
        } catch { $errorMessage = $_.Exception.Message.Split("`n")[0]
        $errorLine = $_.ScriptStackTrace.Split("`n")[0]
        [console]::beep(300,600)
        Write-Host ""
        Write-Host ""
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
		Write-Host " ⛔️ Erreur dans le script : Dictionnaire pour stocker les résolutions DPI et leur fréquence ...."
		Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
		Write-Host "Ligne d'erreur : $errorLine" -ForegroundColor Red
        Write-Host "$errorMessage" -ForegroundColor Red
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
        Write-Host "Image n°$tempcompt Image : $fileNametemp" -ForegroundColor Red
        Write-Host "DPI $dpiKey ($dpiX x $dpiY)" -ForegroundColor Red
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
        Write-host "Souvent la cause est un fichier corrompu ou une image non conforme" -ForegroundColor White
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta}}
    # Trouver la résolution DPI la plus fréquente
    $mostFrequentDpi = $dpiFrequencies.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 1
#$numberOfdpiGroups = $dpiFrequencies.Keys.Count
$referenceDpi = $mostFrequentDpi.Key
$referenceDpiX, $referenceDpiY = $referenceDpi -split ' x '
# arrondir les DPI à l'entier
$referenceDpiX = [math]::Round($referenceDpiX)
$referenceDpiY = [math]::Round($referenceDpiY)
BarProgress -barprog 100 -bartotal 100 -barLength 60 -bartext1 "L'analyse à déterminé que la résolution la plus fréquente est :" -bartext2 "$referenceDpi" -bartext3 "DPI" -barcolor 4
Write-Host ""
$tempcompt=0
foreach ($file in $jpgFiles) {
    try {# Utiliser un flux de données pour charger l'image
        $stream = [System.IO.File]::OpenRead($file.FullName)
        $image = [System.Drawing.Image]::FromStream($stream)
        # Obtenir la résolution DPI de l'image
        $dpiX = $image.HorizontalResolution
        $dpiY = $image.VerticalResolution
        $tempcompt++
        $imageCountTemp = $jpgFiles.Count
        # Vérifier si l'image a une résolution différente
        if ($dpiX -ne $referenceDpiX -or $dpiY -ne $referenceDpiY) { $barimcount++ }
        BarProgress -barprog $tempcompt -bartotal $imageCountTemp -barLength 60 -bartext1 "$tempcompt/$imageCountTemp " -bartext2 "Détermine combien de fichiers à convertir en $($referenceDpiX)DPI ..." -bartext3 "Fin de l'analyse" -barcolor 0
        # Libérer les ressources de l'image
        $image.Dispose()
        $stream.Dispose()
    } catch { Write-host "Erreur lors de la vérification de $($file.FullName) : $_" }}
if ($barimcount -gt "1") { Write-Host "                                                                                                                    "
        BarProgress -barprog 0 -bartotal 100 -barLength 60 -bartext1 "L'analyse à déterminé qu'il y a" -bartext2 "$barimcount" -bartext3 "fichiers à convertir ..." -barcolor 5
        Write-Host ""
        Write-Host ""
# Convertir les images qui n'ont pas la résolution DPI la plus fréquente
foreach ($file in $jpgFiles) {
    try {# Utiliser un flux de données pour charger l'image
    $stream = [System.IO.File]::OpenRead($file.FullName)
    $image = [System.Drawing.Image]::FromStream($stream)
    # Obtenir la résolution DPI de l'image
    $dpiX = $image.HorizontalResolution
    $dpiY = $image.VerticalResolution
    # Vérifier si l'image a une résolution différente
    if ($dpiX -ne $referenceDpiX -or $dpiY -ne $referenceDpiY) {
        # Créer une nouvelle image avec la résolution de référence
        $dpiconvefiles++
        $fileNametemp = [System.IO.Path]::GetFileName($file)
        if ($fileNametemp.Length -ge 12) { $fileNametemp = $fileNametemp.Substring(0, 12)} 
        $imageCountTemp = $jpgFiles.Count
        BarProgress -barprog $dpiconvefiles -bartotal $barimcount -barLength 59 -bartext1 "⏳ Conversion en cours" -bartext2 "$dpiconvefiles/$barimcount Conversion de $fileNametemp $referenceDpiX/$($referenceDpiY)DPI" -bartext3 "Fin de conversion   " -barcolor 3
        $newImage = New-Object System.Drawing.Bitmap $image.Width, $image.Height
        $newImage.SetResolution($referenceDpiX, $referenceDpiY)
        # Dessiner l'image originale sur la nouvelle image
        $graphics = [System.Drawing.Graphics]::FromImage($newImage)
        $graphics.DrawImage($image, 0, 0, $image.Width, $image.Height)
        # Fermer le flux de données avant de sauvegarder
        $stream.Dispose()
        # Sauvegarder la nouvelle image en .jpg dans un fichier temporaire
        $tempFile = [System.IO.Path]::GetTempFileName()
        $newImage.Save($tempFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        # Remplacer l'image originale par la nouvelle image
        [System.IO.File]::Delete($file.FullName)
        [System.IO.File]::Move($tempFile, $file.FullName)
        # Libérer les ressources
        $graphics.Dispose()
        $newImage.Dispose()
        } else {# Libérer les ressources de l'image originale
        $stream.Dispose()}
        # Libérer les ressources de l'image originale
        $image.Dispose() }
    catch { Write-Host "⛔️ Erreur lors de la conversion de $($file.FullName) : $_" -ForegroundColor red
		    pause
		    exit}}
    BarProgress -barprog 0 -bartotal 100 -barLength 60 -bartext1 "Fin de conversion DPI des fichiers en $($referenceDpiX)DPI" -bartext2 "" -bartext3 ""-barcolor 5
    if ($dpiconvefiles -eq 0) { Write-Host ""
        Write-Host "$checkMark Aucune conversion de résolution DPI nécessaire" -ForegroundColor green  
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray} 
    else {  Write-Host ""
        Write-Host "                                                                       Au total " -ForegroundColor white -NoNewline
        Write-Host "$dpiconvefiles" -ForegroundColor red -NoNewline
        Write-Host " conversion(s) de fichier(s) ..." -ForegroundColor white
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray }} 
    else {  Write-Host "`r                                                                                                                        "
            BarProgress -barprog 100 -bartotal 100 -barLength 60 -bartext1 "👍 L'analyse à déterminé qu'il y a n'y a pas de fichiers à convertir ..." -bartext2 "" -bartext3 "" -barcolor 5
            Write-Host ""
            Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray }} 
    else {  Write-Host "L'Analyse de la résolution DPI des images est déactiver" -ForegroundColor darkgray
	        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray }
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fin de vérification DPI
#
# Zero padding avec énumération continue optionnelle
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
$images = Get-ChildItem -LiteralPath "$directoryPath" -Filter "*.jpg" -Recurse | Sort-Object DirectoryName, Name
Write-Host "🔍 Démarrage de l'analyse des fichiers pour zero-padding ..." -ForegroundColor white ; Write-host ""
function ValidateFileNameA { param([string]$fileName,[int]$maxLength) if ($fileName -match '^\d+$') {$fileName.PadLeft($maxLength,'0')} else {$fileName} }
$enumfic = $false  # ← Activer ou désactiver l’énumération globale
$nbficrenom = 0; $counter = 1 ; $nbficmn = 0 ; $nbficdp = 0 ;$minPad = 4
$maxLength = if ($enumfic) { [math]::Max($minPad, [math]::Ceiling([math]::Log10([math]::Max(1, $images.Count + 1)))) } else {
    ($images | Where-Object { $_.BaseName -match '^\d+$' } | ForEach-Object { $_.BaseName.Length } | Measure-Object -Maximum).Maximum }
Write-Host "Nombre total de fichiers trouvés dans le répertoire racine : $($images.Count)" -ForegroundColor Cyan 
foreach ($file in $images) {try {if ($enumfic) { $newName = $counter.ToString("D$maxLength"); $counter++ } elseif ($file.BaseName -match '^\d+$' -and $file.BaseName.Length -lt $maxLength) {
            $newName = ValidateFileNameA -fileName $file.BaseName -maxLength $maxLength } else { continue }
        $newFile = Join-Path $file.DirectoryName "$newName$($file.Extension)"
        if ($file.FullName -eq $newFile) { Write-Host "`n[SKIP] le fichier est déjà nommé correctement : $($file.FullName)" -NoNewline -ForegroundColor Yellow; $nbficmn++ } 
        elseif (Test-Path $newFile) { Write-Host "`n[SKIP] Collision le fichier : $newFile existe déjà" -NoNewline -ForegroundColor Magenta ; $nbficdp++}
        if ($file.FullName -ne $newFile -and -not (Test-Path $newFile)) { Write-Host ("`rRenommage de {0} en {1}      " -f $file.FullName, (Split-Path $newFile -Leaf)) -NoNewline -ForegroundColor darkcyan
            [System.IO.File]::Move($file.FullName, $newFile) ; $nbficrenom++ }
    } catch { Write-Host "`nErreur lors du renommage de $($file.FullName) : $_" -ForegroundColor red ; pause; exit }}
if ($nbficrenom -eq 0) { Write-Host "`n👍 Aucun fichier n'a été renommé, le format est déjà correct." -ForegroundColor green } else {
    Write-Host "`n$checkMark $nbficrenom fichiers renommés avec succès " -NoNewline -ForegroundColor green }
    if ($nbficrenom -ne 0 -and $nbficmn -ne 0) { Write-Host "$nbficmn fichiers avec le bon nom renommage inutile  " -NoNewline -ForegroundColor yellow }
    if ($nbficrenom -ne 0 -and $nbficdp -ne 0) { Write-Host "$nbficdp fichiers en collision nom déjà existant" -ForegroundColor magenta }
    if ($nbficrenom -ne 0 -and ($nbficmn -ne 0 -or $nbficdp -ne 0)) { Write-Host ""}
    if ($nbficrenom -ne 0 -and ($nbficmn -eq 0 -or $nbficdp -eq 0)) { Write-Host ""}
Write-Host "─────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fin zero padding
#
# Début de l'analyse et de la reduction de l'espace entre les scènes
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
$Global:ficomp = 1
if ($reducespac -eq $true) { Write-Host "⏳ Démarrage de l'uniformisation des transitions sur une hauteur de " -ForegroundColor White -NoNewline
    Write-Host "$($transihaut)" -ForegroundColor Green -NoNewline
    Write-Host " lignes et tolérance de détection a " -ForegroundColor White -NoNewline
    Write-Host "$tauxvariahorizontal%" -ForegroundColor Green
    Write-Host ""
    Write-Host " Initialisation du moteur d'analyse des transitions..." -ForegroundColor White -NoNewline
    if ($global:nbexclu -eq 0) { $global:nbexclu = 1} # pour éviter la division par zéro
    Get-ChildItem -LiteralPath $directoryPath -Filter *.jpg  -Recurse | ForEach-Object {ProcImage -imagePath $_.FullName}
    if ($reducespac -eq $true -and ($global:hautoritot -gt 0) -and ($global:hautfintot -gt 0)) {
        $hautratio = (($global:hautoritot - $global:hautfintot) / $global:hautoritot) * 100
        $hautratio2 = $hautratio.ToString("F2")
    Write-Host ""
    Write-Host "La suppresion des espaces entre les scènes vous a permis une réduction de " -ForegroundColor green -NoNewline
    Write-Host "$hautratio2%" -ForegroundColor cyan -NoNewline
    Write-Host " de hauteur en moyenne" -ForegroundColor green
    Write-Host ""
	Write-Host "$checkMark Fin de l'uniformisation des transitions entre les scènes ! 😁👍" -ForegroundColor Green} else { Write-Host ""
    Write-Host " ⚠️ Désolé mais aucun gain en hauteur n'a était possible ! " -ForegroundColor red
    Write-Host ""
    Write-Host "ℹ️ Souvent la cause est trop de bruits dans les images ,la qualité ou une compression médiocre !" -ForegroundColor yellow}
    Write-Host ""
    Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray}
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Fin de l'analyse et de la reduction de l'espace entre les scènes
#
# Phase d'Assemblage
#⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤⏤
# Initialiser les variables pour l'assemblage
$images = Get-ChildItem -LiteralPath "$directoryPath" -Filter "*.jpg"  -Recurse | Sort-Object DirectoryName, Name
$currentHeight = 0
$maxRollback = 6
$global:countfilebar3 = ($images.Count)
$assemblageIndex = 1
$assemblageImages = @()
$maxHeightorig = $maxHeight
if ($global:hautfintot -gt $maxHeight) { 
    $NbSegments = [math]::Ceiling($global:hautfintot / $maxHeight)
    $maxHeightorig = $maxHeight
    $maxHeight =  [math]::Floor($global:hautfintot / $NbSegments)
Write-Host "ℹ️ Pondération de la Hauteur moyenne " -ForegroundColor White -NoNewline
Write-Host "$global:hautfintot" -ForegroundColor Cyan -NoNewline
Write-Host " pixels nombre d'images possible " -ForegroundColor white -NoNewline
Write-Host "$NbSegments" -ForegroundColor Cyan -NoNewline
Write-Host " nouvelle hauteur max " -ForegroundColor white -NoNewline
Write-Host "$maxHeight" -ForegroundColor Cyan -NoNewline
Write-Host " pixels" -ForegroundColor white
Write-Host ""
}
Write-Host "⏳ Début de l'assemblage verticale des images au format jpg avec un hauteur maximum de " -ForegroundColor White  -NoNewline
Write-Host "$maxHeight" -ForegroundColor green  -NoNewline
write-Host " pixels" -ForegroundColor white
Write-Host ""
Write-Host "           Taux de remplissage          " -ForegroundColor white -BackgroundColor green -NoNewline
Write-Host "  Num.                     Nom ori.  Nouv. Dim.     Nom :                   " -ForegroundColor white -BackgroundColor green -NoNewline
Write-Host "" -ForegroundColor White -BackgroundColor black
$lastFullName = $images[-1].FullName
foreach ($image in $images) {
    $img = [System.Drawing.Image]::FromFile($image.FullName)
    $limit = if ($image.FullName -eq $lastFullName) { $maxHeightorig  } else { $maxHeight }
    if ($currentHeight + $img.Height -le $limit) {
        # L'image rentre, on l'ajoute directement
        $assemblageImages += $img
        $currentHeight += $img.Height
    } else {
        # Il faut voir si on peut couper l'image à ajouter
        $availableSpace = $maxHeight - $currentHeight
        $cutInNew = Find-TransitionLine -image $img -currentHeight 0 -maxHeight $availableSpace
        if ($null -ne $cutInNew) {
            # Une transition est trouvée dans la nouvelle image
            $topPart = $img.Clone([System.Drawing.Rectangle]::new(0, 0, $img.Width, $cutInNew), $img.PixelFormat)
            $bottomPart = $img.Clone([System.Drawing.Rectangle]::new(0, $cutInNew, $img.Width, $img.Height - $cutInNew), $img.PixelFormat)
            $assemblageImages += $topPart
            $currentHeight += $topPart.Height
            # Sauvegarder et recommencer
            $assemblagePath = Join-Path -Path $directoryPath -ChildPath ("{0}{1:D3}.jpg" -f $prefix, $assemblageIndex)
            Save-Assemblage -images $assemblageImages -outputPath $assemblagePath
            $assemblageIndex++
            $assemblageImages = @($bottomPart)
            $currentHeight = $bottomPart.Height
        } else { # Aucune transition dans l'image à ajouter, on tente de revenir jusqu'à $maxRollback images précédentes
            $rollbackSuccess = $false
            for ($i = 1; $i -le [Math]::Min($maxRollback, $assemblageImages.Count); $i++) {
                $rollbackIndex = $assemblageImages.Count - $i
                $rollbackImage = $assemblageImages[$rollbackIndex]
                $cutInRollback = Find-TransitionLine -image $rollbackImage -currentHeight 0 -maxHeight $rollbackImage.Height
                if ($null -ne $cutInRollback) {
                    # Transition trouvée dans l’image précédente
                    $topRollback = $rollbackImage.Clone([System.Drawing.Rectangle]::new(0, 0, $rollbackImage.Width, $cutInRollback), $rollbackImage.PixelFormat)
                    $bottomRollback = $rollbackImage.Clone([System.Drawing.Rectangle]::new(0, $cutInRollback, $rollbackImage.Width, $rollbackImage.Height - $cutInRollback), $rollbackImage.PixelFormat)
                    # On garde toutes les images avant le rollback
                    $assemblageImages = $assemblageImages[0..($rollbackIndex - 1)]
                    $assemblageImages += $topRollback
                    # Sauvegarde de l’assemblage ajusté
                    $assemblagePath = Join-Path -Path $directoryPath -ChildPath ("{0}{1:D3}.jpg" -f $prefix, $assemblageIndex)
                    Save-Assemblage -images $assemblageImages -outputPath $assemblagePath
                    $assemblageIndex++
                    # Démarrage du nouveau avec bottomRollback + image actuelle
                    $assemblageImages = @($bottomRollback, $img)
                    $currentHeight = $bottomRollback.Height + $img.Height
                    $rollbackSuccess = $true
                    break}}
            if (-not $rollbackSuccess) { # Toujours pas de transition, on sauvegarde comme d’hab
                $assemblagePath = Join-Path -Path $directoryPath -ChildPath ("{0}{1:D3}.jpg" -f $prefix, $assemblageIndex)
                Save-Assemblage -images $assemblageImages -outputPath $assemblagePath
                $assemblageIndex++
                $assemblageImages = @($img)
                $currentHeight = $img.Height}}}}
# Sauvegarde finale après la boucle
if ($assemblageImages.Count -gt 0) {
    $assemblagePath = Join-Path -Path $directoryPath -ChildPath ("{0}{1:D3}.jpg" -f $prefix, $assemblageIndex)
    Save-Assemblage -images $assemblageImages -outputPath $assemblagePath}}
# fin de la fonction Merge-Images
# Fonction pour trouver la ligne de transition dans l'image
function Find-TransitionLine {
    param ([System.Drawing.Bitmap]$image, [int]$currentHeight, [int]$maxHeight, [string]$imageName)
    $startY = [Math]::Min($image.Height - 1, $maxHeight - $currentHeight)
    $Pdetect = 10 # tolérance de variation en couleur (ex: 10 ~ ±10 sur 0–255)
    $findstab = 15 # nombre de lignes stables à détecter d'affilée
    $margin = $global:nbexclu2
    $stableLines = 0
    for ($y = $startY; $y -ge 0; $y--) {
        $lineColor = $image.GetPixel($margin, $y)
        $isStable = $true
        for ($x = $margin; $x -lt ($image.Width - $margin); $x++) {
            $pixel = $image.GetPixel($x, $y)
            if ([Math]::Abs($pixel.R - $lineColor.R) -gt $Pdetect -or
                [Math]::Abs($pixel.G - $lineColor.G) -gt $Pdetect -or
                [Math]::Abs($pixel.B - $lineColor.B) -gt $Pdetect) {$isStable = $false
                break}}
        if ($isStable) { $stableLines++
            if ($stableLines -ge $findstab) { return [Math]::Max(0, $y + $findstab - 1) }} else {$stableLines = 0}}return $null}
# Fonction pour sauvegarder l'assemblage d'images
function Save-Assemblage {param ( [System.Drawing.Image[]]$images, [string]$outputPath)
    # Calculer la largeur et la hauteur totale de l'assemblage
    $width = $images[0].Width
    $totalHeight = $images | Measure-Object -Property Height -Sum | Select-Object -ExpandProperty Sum
    # Créer une nouvelle image pour l'assemblage
    $assemblage = New-Object System.Drawing.Bitmap($width, $totalHeight)
    $graphics = [System.Drawing.Graphics]::FromImage($assemblage)
    # Dessiner chaque image dans l'assemblage
    $currentY = 0
            foreach ($img in $images) { $graphics.DrawImage($img, 0, $currentY, $img.Width, $img.Height)
                $currentY += $img.Height }
                $maxHeightFormattedA = $totalHeight.ToString().PadLeft(5, '0')
                $maxwidthFormattedA = $width.ToString().PadLeft(3, '0')
                $maxassindexA = $assemblageIndex.ToString().PadLeft(3, '0')
                $fileNamecc = [System.IO.Path]::GetFileName($image)
                if ($fileNamecc.Length -ge 12) { $fileNamecc = $fileNamecc.Substring(0, 12)} 
                if ($global:barnbimg -lt 10) {BarProgress -barprog $totalHeight -bartotal $maxHeight -barLength 40 -bartext1 "" -bartext2 "   $global:barnbimg $checkMark Assemblage jusqu'à $fileNamecc ${maxwidthFormattedA}x${maxHeightFormattedA} dans $prefix$maxassindexA.jpg" -bartext3 "" -barcolor 3
    Write-host""} elseif ($global:barnbimg -lt 100) {BarProgress -barprog $totalHeight -bartotal $maxHeight -barLength 40 -bartext1 "" -bartext2 "  $global:barnbimg $checkMark Assemblage jusqu'à $fileNamecc ${maxwidthFormattedA}x${maxHeightFormattedA} dans $prefix$maxassindexA.jpg" -bartext3 "" -barcolor 3
    Write-host""} elseif ($global:barnbimg -lt 1000) {BarProgress -barprog $totalHeight -bartotal $maxHeight -barLength 40 -bartext1 "" -bartext2 "  $global:barnbimg $checkMark Assemblage jusqu'à $fileNamecc ${maxwidthFormattedA}x${maxHeightFormattedA} dans $prefix$maxassindexA.jpg" -bartext3 "" -barcolor 3
    Write-host""} elseif ($global:barnbimg -lt 10000) {BarProgress -barprog $totalHeight -bartotal $maxHeight -barLength 40 -bartext1 "" -bartext2 "$global:barnbimg $checkMark Assemblage jusqu'à $fileNamecc ${maxwidthFormattedA}x${maxHeightFormattedA} dans $prefix$maxassindexA.jpg" -bartext3 "" -barcolor 3
    Write-host""}
    $global:barnbimg++
    # Sauvegarder l'image assemblée
    $graphics.Dispose()
    $assemblage.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    # Libérer les ressources
    $assemblage.Dispose()
    foreach ($img in $images) {
    $img.Dispose() }}
# Fonction pour uniformiser la hauter des transitions entre les scènes
function ProcImage { param ( [string]$imagePath )
    # Charger l'image
    $image = [System.Drawing.Image]::FromFile($imagePath)
    $bitmap = New-Object System.Drawing.Bitmap $image
    $parentDir = Split-Path -Path $imagePath -Parent
    $parentName = Split-Path -Path $parentDir -Leaf
    $fileName = [System.IO.Path]::GetFileName($imagePath)
    $fileNametemp = "...$parentName/$fileName"
    $fileNametemp = $fileNametemp.Substring([Math]::Max(0, $fileNametemp.Length - 18)) #limite la longueur à 18 caractères
    $global:finlname2 = $fileNametemp
    # Fonction pour détecter les transitions
    function DetectTransitions {
        param ( [System.Drawing.Bitmap]$bitmap, [int]$startY )
        $transitions = @()
            for ($y = $startY; $y -lt $bitmap.Height; $y += $pasrecherche) {
            $lineColor = $bitmap.GetPixel($global:nbexclu, $y) # Commence à $global:nbexclu pixels à droite pour éviter les bords
            $isTransition = $true
            for ($x = ($global:nbexclu); $x -lt ($bitmap.Width - $global:nbexclu); $x++) {  # Finit $global:nbexclu pixels à gauche pour éviter les bords
                $pixelColor = $bitmap.GetPixel($x, $y)
                if (-not ($pixelColor.R -le ($lineColor.R + $tauxvariahorizontal * 2.55) -and $pixelColor.R -ge ($lineColor.R - $tauxvariahorizontal * 2.55) -and
                          $pixelColor.G -le ($lineColor.G + $tauxvariahorizontal * 2.55) -and $pixelColor.G -ge ($lineColor.G - $tauxvariahorizontal * 2.55) -and
                          $pixelColor.B -le ($lineColor.B + $tauxvariahorizontal * 2.55) -and $pixelColor.B -ge ($lineColor.B - $tauxvariahorizontal * 2.55))) {
                    $isTransition = $false
                    break }}
            if ($isTransition) {$transitionStart = $y
                $transitionHeight = 1
                $barbitmapt = ($bitmap.Height)
                while ($y + 1 -lt $bitmap.Height) { $nextLineColor = $bitmap.GetPixel($global:nbexclu, $y + 1)# Commence à $global:nbexclu pixels à droite pour éviter les bords
                    $isNextLineTransition = $true
                    for ($x = ($global:nbexclu); $x -lt ($bitmap.Width - $global:nbexclu); $x += $pasrecherche) { # Finit $global:nbexclu pixels à gauche pour éviter les bords
                        $pixelColor = $bitmap.GetPixel($x, $y + 1)
                        if (-not ($pixelColor.R -le ($nextLineColor.R + $tauxvariahorizontal * 2.55) -and $pixelColor.R -ge ($nextLineColor.R - $tauxvariahorizontal * 2.55) -and
                                  $pixelColor.G -le ($nextLineColor.G + $tauxvariahorizontal * 2.55) -and $pixelColor.G -ge ($nextLineColor.G - $tauxvariahorizontal * 2.55) -and
                                  $pixelColor.B -le ($nextLineColor.B + $tauxvariahorizontal * 2.55) -and $pixelColor.B -ge ($nextLineColor.B - $tauxvariahorizontal * 2.55))) {
                            $isNextLineTransition = $false
                            break }}
                    if ($isNextLineTransition) {$transitionHeight++
                        $y++ } else { break}}
                if ($transitionHeight -gt $transihaut) {
                    $transitions += [PSCustomObject]@{
                        Start = $transitionStart
                        Height = $transitionHeight }}
                BarProgress -barprog $y -bartotal $barbitmapt -barLength 40 -bartext1 "" -bartext2 "$Global:ficomp/$Global:imageCountG ⏳ Analyse des transitions dans le fichier $fileNametemp..." -bartext3 "" -barcolor 1
                $global:hautori = $barbitmapt }} return $transitions}
    $startY = 0
    $transitions = DetectTransitions -bitmap $bitmap -startY $startY
    while ($transitions.Count -gt 0) {
        $newHeight = $bitmap.Height - ($transitions | Measure-Object -Property Height -Sum).Sum + ($transitions.Count * $transihaut)
        $newBitmap = New-Object System.Drawing.Bitmap $bitmap.Width, $newHeight
        $graphics = [System.Drawing.Graphics]::FromImage($newBitmap)
        $currentY = 0
        $previousEnd = 0
        foreach ($transition in $transitions) {
            $graphics.DrawImage($bitmap, [System.Drawing.Rectangle]::FromLTRB(0, $currentY, $bitmap.Width, $currentY + ($transition.Start - $previousEnd)), [System.Drawing.Rectangle]::FromLTRB(0, $previousEnd, $bitmap.Width, $transition.Start), [System.Drawing.GraphicsUnit]::Pixel)
            $currentY += $transition.Start - $previousEnd
            $previousEnd = $transition.Start + $transition.Height
            $graphics.DrawImage($bitmap, [System.Drawing.Rectangle]::FromLTRB(0, $currentY, $bitmap.Width, $currentY + $transihaut), [System.Drawing.Rectangle]::FromLTRB(0, $transition.Start, $bitmap.Width, $transition.Start + $transihaut), [System.Drawing.GraphicsUnit]::Pixel)
            $currentY += $transihaut}
        $graphics.DrawImage($bitmap, [System.Drawing.Rectangle]::FromLTRB(0, $currentY, $bitmap.Width, $newHeight), [System.Drawing.Rectangle]::FromLTRB(0, $previousEnd, $bitmap.Width, $bitmap.Height), [System.Drawing.GraphicsUnit]::Pixel)
        $tempPath = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($imagePath), "temp_" + [System.IO.Path]::GetFileName($imagePath))
        $hautfin = $newBitmap.Height
        $graphics.Dispose()
        $newBitmap.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        $bitmap.Dispose()
        $image.Dispose()
        $newBitmap.Dispose()
    # Suppression et renomage avec literalPath
        $imagePath2 = Get-Item -LiteralPath $imagePath
        $tempPath2 = Get-Item -LiteralPath $tempPath
        $imagePath2 | Remove-Item
        Rename-Item $tempPath2 $imagePath2
        $hautratio = (($global:hautori - $hautfin) / $global:hautori) * 100
        $global:hautoritot = $global:hautoritot + $global:hautori
        $global:hautfintot = $global:hautfintot + $hautfin
        $hautratio2 = $hautratio.ToString("F2")
        $image = [System.Drawing.Image]::FromFile($imagePath)
        $bitmap = New-Object System.Drawing.Bitmap $image
        $startY = $previousEnd - $transitionHeight + $transihaut
        $transitions = DetectTransitions -bitmap $bitmap -startY $startY}
    $bitmap.Dispose()
    $image.Dispose()
    if ($hautratio -lt 5) { BarProgress -barprog 0 -bartotal 100 -barLength 40 -bartext1 "Pas de gain" -bartext2 "⚠️ Aucun gain n'est possible dans l'image $global:finlname2 " -bartext3 " " -barcolor 2
        write-host ""
        #Pondération si pas de gain sur l'image ajout de la hauteur originale dans $global:hautfintot 
        $global:hautfintot = $global:hautfintot + $global:hautori} else { Write-Host "`r                                                                                                                        " -NoNewline
        $hautratio2int = ([int]$hautratio2) / 100
        $hautratio2cal = 100 - $hautratio2int
        BarProgress -barprog $hautratio2cal -bartotal 100 -barLength 40 -bartext1 "Gain $hautratio2%" -bartext2 "$checkMark Le fichier $global:finlname2 hauteur:$($global:hautori)p reduction:$($hautfin)p Gain $hautratio2%" -bartext3 "" -barcolor 2
        write-host ""}
        $Global:ficomp++ }
# Récupérer le chemin du répertoire depuis les arguments
$directoryPath = $args[0]
$unitlarg = $args[1] # -eq "true"
$dpifind = $args[2] #-eq "true"
$reducespac = $args[3] #-eq "true"
# Question pour l'analyse de la largeur des images
# Obtenir la position actuelle du curseur
    $ycurcon = [System.Console]::CursorTop
if ([string]::IsNullOrWhiteSpace($unitlarg)) {[console]::beep(300,100)
    $ycurcon = [System.Console]::CursorTop
    $reponse = Read-Host "Recherche et uniformisation des largeurs des images ? (O)ui ou (N)on"
if ($reponse -eq 'O' -or $reponse -eq 'o' -or $reponse -eq 'Y' -or $reponse -eq 'y') {
    $unitlarg = $true} 
elseif ($reponse -eq 'N' -or $reponse -eq 'n') {$unitlarg = $false} 
else {  Write-Host "Réponse invalide. Veuillez entrer 'O' pour Oui ou 'N' pour Non."
        [console]::beep(300,600)
        Start-sleep 5
        exit}}
if ([string]::IsNullOrWhiteSpace($dpifind)) { [console]::beep(300,100)
    $reponse = Read-Host "Recherche et uniformisation DPI des images ? (O)ui ou (N)on"
if ($reponse -eq 'O' -or $reponse -eq 'o' -or $reponse -eq 'Y' -or $reponse -eq 'y') {
    $dpifind = $true } 
    elseif ($reponse -eq 'N' -or $reponse -eq 'n') {
            $dpifind = $false } 
    else {  Write-Host "Réponse invalide. Veuillez entrer 'O' pour Oui ou 'N' pour Non."
            [console]::beep(300,600)
            Start-sleep 5
            exit}}
if ([string]::IsNullOrWhiteSpace($reducespac)) { [console]::beep(300,100)
    $reponse2 = Read-Host "Voulez-vous Uniformiser l'espace entre les scènes ? (O)ui ou (N)on (opération longue)"
    if ($reponse2 -eq 'O' -or $reponse2 -eq 'o' -or $reponse2 -eq 'Y' -or $reponse2 -eq 'y') { $reducespac = $true } 
    elseif  ($reponse2 -eq 'N' -or $reponse2 -eq 'n') {
            $reducespac = $false } 
    else {  Write-Host "Réponse invalide. Veuillez entrer 'O' pour Oui ou 'N' pour Non."
            [console]::beep(300,600)
            Start-sleep 5
            exit }}
# Afficher les phrases
# Obtenir la nouvelle position du curseur après l'affichage des phrases
    $ycurcon2 = [System.Console]::CursorTop
# Boucle pour effacer les lignes
    for ($i = $ycurcon2; $i -ge $ycurcon; $i--) { [System.Console]::SetCursorPosition(0, $i)
    Write-Host "                                                                                                 "}
# Afficher les positions pour vérification
    [System.Console]::SetCursorPosition(0, $ycurcon)
    Write-Host "Paramètres: Uniformisation en largeurs " -ForegroundColor White -NoNewline
    if ($unitlarg -eq $true) { Write-Host "Oui" -ForegroundColor Green -NoNewline} else { Write-Host "Non" -ForegroundColor Red -NoNewline}
    Write-Host " des DPI " -ForegroundColor White -NoNewline
    if ($dpifind -eq $true) { Write-Host "Oui" -ForegroundColor Green -NoNewline} else { Write-Host "Non" -ForegroundColor Red -NoNewline}
    Write-Host " des transitions " -ForegroundColor White -NoNewline
    if ($reducespac -eq $true) { Write-Host "Oui" -ForegroundColor Green -NoNewline} else { Write-Host "Non" -ForegroundColor Red}
    if ($reducespac -eq $true) {  
        Write-Host " avec " -ForegroundColor White -NoNewline
        Write-Host "$($transihaut)" -ForegroundColor Green -NoNewline
        Write-Host " lignes entre et variation a " -ForegroundColor White -NoNewline
        Write-Host "$tauxvariahorizontal%" -ForegroundColor Green}
# Appeler la fonction pour assembler les images
    if ([string]::IsNullOrWhiteSpace($directoryPath) -or -not (Test-Path -LiteralPath $directoryPath)) {
    $folderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowserDialog.Description = "Sélectionnez un répertoire webtoon pour assemblage..."
    if ($folderBrowserDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $directoryPath = $folderBrowserDialog.SelectedPath } 
    else {    Write-host "Aucun répertoire sélectionné. Le script va s'arrêter."
                exit}}
$imageMagickPath = Get-ChildItem -Path "C:\Program Files\" -Filter "magick.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty DirectoryName -First 1
if (-Not $imageMagickPath) { Write-Host "Pré-requis : ImageMagick n'est pas installé ! "
    Write-Host ""
    pause 
    exit} 
    try { $ErrorActionPreference = "Stop"
		Merge-Images -directoryPath $directoryPath} catch { $err = $_
        $errorMessage = ($err.Exception.Message -split "`n")[0]
        $exceptionType = $err.Exception.GetType().FullName
        $scriptName = $err.InvocationInfo.ScriptName
        $scriptLine = $err.InvocationInfo.ScriptLineNumber
        $positionMessage = $err.InvocationInfo.PositionMessage
        $commandName = $err.InvocationInfo.MyCommand.Name
        $scriptStack = $err.ScriptStackTrace
        [console]::beep(300,600)
        Write-Host ""
        Write-Host ""
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
        Write-Host " ⛔ Oupps ! Erreur dans le script ...."
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
        Write-Host "Ligne d'erreur : n°$scriptLine" -ForegroundColor yellow
        Write-Host "$errorMessage" -ForegroundColor Red
        Write-Host "$exceptionType" -ForegroundColor Red
        Write-Host "$scriptName" -ForegroundColor Red
        Write-Host " $positionMessage" -ForegroundColor Red
        Write-Host "$commandName" -ForegroundColor Red
        Write-Host "$scriptStack" -ForegroundColor Red
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
        Write-Host "Fichier en cours : $fileNametemp"
        Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor magenta
        Write-Host ""
        $Global:ilyaerreur = $true }
if ($Global:ilyaerreur) {	
    Write-Host ""
	Write-Host "Attention il y a au moins une erreur !" -ForegroundColor magenta
	Write-Host ""
	pause
	exit}
	#$blablabla.Speak("Fin de l'assemblage des fichiers il n'y a pas d'erreurs !")
#Fin du script
$dateend = Get-Date
$duration = $dateend - $datestart
$formattedDuration = "{0:hh\:mm\:ss}" -f $duration
if ($reducespac -eq $true -and ($global:hautoritot -gt 0) -and ($global:hautfintot -gt 0)) {
$hautratio = (($global:hautoritot - $global:hautfintot) / $global:hautoritot) * 100
$hautratio2 = $hautratio.ToString("F2")}
Write-Host ""
Write-Host "──────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor darkgray
Write-Host ""
Write-Host "ℹ️ Fin de l'étape d'assemblage des images ! " -ForegroundColor green
Write-Host ""
Write-Host "👍 Fin des opérations sans erreurs !" -ForegroundColor Green
Write-Host ""
Write-Host "✅ Le traitement des images a pris au total :🕒 $($formattedDuration)s pour 📄 $global:countfilebar3 fichiers. " -ForegroundColor Cyan
Write-Host ""
Write-Host "✅ Création de $($global:barnbimg-1) fichiers assemblés avec succès ! ✌" -ForegroundColor Cyan
Write-Host ""
Write-Host ""
Write-Host "😍 Vivement la lecture de votre webtoon préféré ! 📚 😄 Longue vie aux webtoons ! 🚀 🌟"
Write-Host ""
Write-Host "😄 N'oublions pas l'ascii art ! 🎨 😍 et l'AMSTRAD CPC 464 😄"
Write-Host ""
Write-Host "🙏 Merci d'avoir utilisé ce script et merci PowerSHELL 😊"
Write-Host ""
if ($reducespac -eq $true -and ($global:hautoritot -gt 0) -and ($global:hautfintot -gt 0)) {Write-Host "Pour un ratio moyen $hautratio2% pour une rédutction de $($global:hautoritot)p a $($global:hautfintot)p"
Write-Host ""}
Write-Host "Le script va se fermer dans 3 secondes"
Write-Host ""
start-sleep -Seconds 3