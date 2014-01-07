#!/usr/bin/env bash

echo "Nombre del fichero 'markdown' a procesar (sin extensión)"
echo ""
echo "posibles ficheros disponibles"
echo "--------------------------------------------------------------------------------"
ls *.md 
echo "--------------------------------------------------------------------------------"
echo ""

echo "> " 
read fichero

clear
echo "        MENU"
echo "===================="
echo "   1. PDF"
echo "   2. HTML"

echo "Elige una opción"
read opcion

case $opcion in

# PDF
1)
pandoc $fichero.tex -s -V title=$fichero -f latex -t context -o $fichero.context
context $fichero.context
open $fichero.pdf
;;

# HTML
2)
pandoc $fichero.md -s --section-divs -f markdown -t html5 -o $fichero.html
open $fichero.html
;;

*) echo "$opcion ERROR. opción no válida";;
esac

echo "Presiona una tecla para continuar...";

