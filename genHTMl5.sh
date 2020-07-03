# genHTML5
#
# Auteur : Mathieu TOULON aka StrategeFirst
# Contact : mathieu.toulon[at]free.fr
# Date de création : 02/07/2020
# Dernière màj : 03/07/2020
#
# Objectif : créé une base HTML pur rapidement



#0 - Initialisation
CSS=false
JS=false
PHP=false

HelloWorld=false
name=''

HelpText='\033[93mAide de genHTML5

FONCTIONNEMENT:

Créé un fichier HTML ou PHP avec des éléments pour gagner du temps
Peut aussi génére du CSS et du JS

OPTION:
-css
> Ajoutera une base CSS (Lien HTML,repertoire CSS,un fichier CSS vide)
-js
> Ajoutera une base JS (Lien HTML,repertoire JS,un fichier JavaScript vide)
-name <nom>
> définie le nom de votre projet
-php
> si utiliser convertie votre fichier html en php
-hw
> inclu une vérification dans la page (utile pour vérifier qu il n y ai pas de problème
--help
> Affiche cet aide

EXEMPLE:
genHTML5
> Un seul fichier index.html
genHTML5 -php
> Un seul fichier index.php
genHTML5 -css -js
> rajoute un repertoire et un lien vers du css et js vide
genHTML5 -name test
> même que premier exemple mais nommé test.html
genHTML5 -name test.html
> idem que précédent

\e[0m';

#1 - Gestion paramètre
while [[ ! -z $1 ]]
do
	case $1 in
		-css)	CSS=true;;
		-js)	JS=true;;
		-php)	PHP=true;;
		-hw)	HelloWorld=true;;
		-name)	name="$2"; shift;;
		--aide) echo -e "$HelpText"; exit;;
		--help) echo -e "$HelpText"; exit;;
		*)
			echo -e -n "\033[91m"
			echo 'Option ou valeur :'
			echo "$1"
			echo 'refuser'
			echo -e -n "\e[0m"
			exit;;
	esac
	shift
done

#2 - Par défaut donner le nom de index
if [[ -z $name ]]
then
	if [[ $PHP == 'true' ]]
	then
		file='index.php'
	else
		file='index.html'
	fi
else
	if [[ $PHP == 'true' ]]
	then
		if [[ ${name:$((${#name}-4))} == '.php' ]]
		then
			file=$name
			name=${name:0:-4}
		else
			file=$(echo $name".php")
		fi
	else
		if [[ ${name:$((${#name}-5))} == '.html' ]]
		then
			file=$name
			name=${name:0:-5}
		else
			file=$(echo $name".html")
		fi
	fi
fi

#3 - Création
#3.1 CSS
if [[ $CSS == 'true' ]]
then
	mkdir CSS
	touch CSS/main.css
	CSS='\n\t\t<link href="CSS/main.css" rel="stylesheet" type="text/css"/>'
else
	CSS=''
fi

#3.2 JS
if [[ $JS == 'true' ]]
then
	mkdir JS
	touch JS/scipt.js
	JS='\n\t\t<script src="JS/script.js"></script>';
else
	JS=''
fi

#3.3 Hello World
if [[ $HelloWorld == 'true' ]]
then
	if [[ $PHP == 'true' ]]
	then
		hw='<?php echo "<h1> Hello World </h1>"; phpinfo(); ?>';
	else
		hw='<h1> Hello World </h1>';
	fi
else
	hw=''
fi

#3.4 HTML/PHP
touch "$file"
echo -e '<!DOCTYPE html>
<html lang="fr-FR" dir="ltr">
	<head>
		<meta charset="utf-8"/>
		<title> '$name' </title>'$CSS$JS'
	</head>
	<body>
		'$hw'
	</body>
</html>' >> "$file";

