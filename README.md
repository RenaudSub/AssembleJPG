# AssembleJPG

**AssembleJPG** est un script PowerShell pour Windows permettant d’assembler automatiquement les images d’un webtoon en une ou plusieurs grandes images JPG verticales.

Le script vérifie les fichiers, convertit les formats compatibles, uniformise si nécessaire la largeur et la résolution des images, réduit les espaces entre les scènes et crée des fichiers `WebToon001.jpg`, `WebToon002.jpg`, etc.

[![Voir la démonstration](https://logisub.com/videos/previewassemble.jpg "Cliquez pour voir la vidéo")](https://logisub.com/videos/AssembleJPG.mp4)
Version actuelle : **7.6 — 20 août 2026**

## Fonctionnalités

Le traitement comprend les opérations suivantes :

1. recherche récursive des images présentes dans le dossier et ses sous-dossiers ;
2. vérification du format réel des fichiers `.jpg` et `.jpeg` à partir de leur signature ;
3. détection des images portant une mauvaise extension ;
4. conversion des fichiers WebP, PNG, JPEG et GIF en JPG avec ImageMagick ;
5. renommage avec ajout de zéros devant les noms numériques afin de conserver leur ordre ;
6. uniformisation facultative de la largeur des images ;
7. uniformisation facultative de leur résolution DPI ;
8. détection et réduction facultative des espaces horizontaux de couleur uniforme entre les scènes ;
9. répartition pondérée des images dans plusieurs assemblages ;
10. création des fichiers assemblés avec une hauteur maximale de **55 000 pixels**.

## Avertissement important

> Le script modifie directement le contenu du dossier traité.

- Les fichiers WebP, PNG, JPEG et GIF convertis en JPG sont supprimés après leur conversion.
- Les images peuvent être redimensionnées lorsque l’uniformisation des largeurs est activée.
- Les anciens assemblages nommés `WebToonXXX.jpg` sont supprimés avant la création des nouveaux fichiers.
- Il est fortement recommandé de travailler sur une copie de vos images originales.

## Prérequis

- Windows 10 ou Windows 11 ;
- [PowerShell 7 ou supérieur](https://learn.microsoft.com/fr-fr/powershell/scripting/install/installing-powershell-on-windows) ;
- [ImageMagick](https://imagemagick.org/) avec `magick.exe` installé dans `C:\Program Files`.

### Installation de PowerShell 7

Dans un terminal Windows, exécutez :

```powershell
winget install --id Microsoft.PowerShell --exact
```

### Installation d’ImageMagick

```powershell
winget install --id ImageMagick.ImageMagick --exact
```

Après l’installation d’ImageMagick, fermez puis rouvrez PowerShell afin que le programme soit correctement détecté.

## Téléchargement

Téléchargez les fichiers suivants depuis ce dépôt :

- `AssembleJPG.ps1` ;
- `AssembleJPG.ico` si vous souhaitez installer le raccourci dans le menu contextuel de l’Explorateur Windows.

Vous pouvez également utiliser l’archive proposée dans la section [Releases](https://github.com/RenaudSub/AssembleJPG/releases).

## Utilisation interactive

Ouvrez PowerShell 7 dans le dossier contenant le script puis exécutez :

```powershell
pwsh.exe -ExecutionPolicy Bypass -File ".\AssembleJPG.ps1"
```

Le script demande successivement si vous souhaitez :

- uniformiser la largeur des images ;
- uniformiser leur résolution DPI ;
- uniformiser les espaces entre les scènes.

Une fenêtre permet ensuite de sélectionner le dossier à traiter.

## Utilisation en ligne de commande

Le script accepte quatre arguments positionnels :

```powershell
pwsh.exe -ExecutionPolicy Bypass -File ".\AssembleJPG.ps1" `
    "C:\Chemin\du\Webtoon" `
    "true" `
    "true" `
    "true"
```

| Position | Valeur | Fonction |
| ---: | --- | --- |
| 1 | Chemin | Dossier contenant les images à assembler |
| 2 | `true` ou `false` | Uniformiser la largeur des images |
| 3 | `true` ou `false` | Uniformiser la résolution DPI |
| 4 | `true` ou `false` | Uniformiser les espaces entre les scènes |

Si les trois options ne sont pas fournies, le script les demande de manière interactive.

## Ajout au menu contextuel de l’Explorateur Windows

Le menu contextuel permet de lancer AssembleJPG directement en effectuant un clic droit sur un dossier.

### 1. Copier les fichiers

Créez le dossier suivant :

```text
C:\Scripts\AssembleJPG
```

Copiez-y :

```text
AssembleJPG.ps1
AssembleJPG.ico
```

### 2. Créer le fichier d’installation

Copiez le contenu suivant dans un fichier nommé `Installer-AssembleJPG.reg` :

```registry
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\Directory\shell\AssembleJPG]
"MUIVerb"="Assembler les images avec AssembleJPG"
"Icon"="C:\\Scripts\\AssembleJPG\\AssembleJPG.ico"

[HKEY_CURRENT_USER\Software\Classes\Directory\shell\AssembleJPG\command]
@="\"C:\\Program Files\\PowerShell\\7\\pwsh.exe\" -NoProfile -ExecutionPolicy Bypass -File \"C:\\Scripts\\AssembleJPG\\AssembleJPG.ps1\" \"%1\" \"true\" \"true\" \"true\""
```

Double-cliquez ensuite sur le fichier `.reg` et confirmez son importation.

Cette commande active les trois traitements facultatifs. Pour désactiver l’un d’eux, remplacez la valeur `true` correspondante par `false` dans la commande.

Le paramètre `-ExecutionPolicy Bypass` ne s’applique qu’à ce lancement du script. Il n’est donc pas nécessaire de modifier globalement la stratégie d’exécution de Windows avec `Set-ExecutionPolicy Unrestricted`.

### Désinstallation du menu contextuel

Créez un fichier nommé `Desinstaller-AssembleJPG.reg` contenant :

```registry
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\Software\Classes\Directory\shell\AssembleJPG]
```

Double-cliquez sur ce fichier et confirmez sa fusion pour retirer l’entrée du menu contextuel.

## Réglages avancés

Les principales valeurs modifiables se trouvent au début du script :

| Variable | Valeur par défaut | Description |
| --- | ---: | --- |
| `$prefix` | `WebToon` | Préfixe des fichiers créés |
| `$maxHeight` | `55000` | Hauteur maximale d’un assemblage |
| `$transihaut` | `70` | Hauteur conservée entre deux scènes |
| `$tauxvariahorizontal` | `6` | Tolérance de variation des couleurs |
| `$pasrecherche` | `5` | Intervalle entre les lignes analysées |
| `$global:nbexclu` | `5` | Marge latérale ignorée pendant l’analyse |
| `$global:nbexclu2` | `80` | Marge latérale ignorée pendant l’assemblage |
| `$ponderation` | `$true` | Active la répartition pondérée des images |

Une valeur plus faible pour `$pasrecherche` améliore la précision de la détection, mais augmente le temps de traitement.

## Formats pris en charge

| Format d’entrée | Traitement |
| --- | --- |
| JPG | Vérification puis assemblage |
| JPEG | Conversion en JPG |
| WebP | Conversion en JPG |
| PNG | Conversion en JPG |
| GIF | Conversion en JPG |

Pour les GIF animés, le résultat dépend du comportement d’ImageMagick lors de la conversion en JPG, un format qui ne prend pas en charge l’animation.

## Dépannage

### ImageMagick n’est pas détecté

Vérifiez que `magick.exe` est installé sous `C:\Program Files`, puis relancez PowerShell.

Vous pouvez rechercher son emplacement avec :

```powershell
Get-ChildItem "C:\Program Files" -Filter magick.exe -Recurse -ErrorAction SilentlyContinue
```

### Le lancement du script est bloqué

Utilisez un lancement ponctuel avec :

```powershell
pwsh.exe -ExecutionPolicy Bypass -File ".\AssembleJPG.ps1"
```

Si le fichier téléchargé est marqué comme provenant d’Internet, vous pouvez également le débloquer :

```powershell
Unblock-File ".\AssembleJPG.ps1"
```

### Une image est signalée comme corrompue

Le script s’arrête lorsqu’un fichier portant l’extension `.jpg` ou `.jpeg` possède un format inconnu. Ouvrez ou reconvertissez manuellement le fichier indiqué, puis relancez le traitement.

## Sécurité

Avant d’exécuter un script téléchargé sur Internet, vous pouvez consulter son contenu et calculer son empreinte SHA-256 :

```powershell
Get-FileHash ".\AssembleJPG.ps1" -Algorithm SHA256
```

Comparez cette valeur avec celle indiquée dans la Release correspondante.

## Auteur

Développé par **Renaud SUBRINI**.

- Site : [logisub.com](https://logisub.com/)
- Contact : `contact@infosub.fr`

Première version publiée le 28 décembre 2024.

Et vive l’ASCII art et les Amstrad CPC !

## Licence

Ce projet est distribué sous la licence **GNU General Public License v3.0**.

Vous pouvez l’utiliser, l’étudier, le modifier et le redistribuer selon les conditions décrites dans le fichier [`LICENSE`](LICENSE). Toute version modifiée redistribuée doit rester sous cette même licence et conserver son code source accessible.
