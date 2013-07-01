#!/bin/bash
#Nube.sh
#---
# Versión 1.7
# Autor: Fco. J. Becerra
# email: fjbecerr2@gmail.com
# fecha: 08/May/2013
# update: 01/07/2013
#--
#Copia el contenido de Nube en un usb
#
#¡¡¡¡¡TODOS LOS ECHO o comentarios TRAS LAS ORDENES SON 
#PARA EVITAR ERRORES CON EL SALTO DE LINEA!!!!
#
# ..........................................................
# Función para Testear los directorios
func_ExisteOrigen () { #
		test -d $ORIGEN #
		existe_Origen=$?#
} #
#
func_ExisteDestino () { #
	test -d $DESTINO #
	existe_Destino=$?
} #
#
func_ExisteAyuda () { #	
	echo "Ayuda...." 
	test -r $1 # Parámetro de la función
	existe_Ayuda=$? #	
} #
#
func_Existe_FActualizado () { #
	test -w $DESTINO/FActualizado.txt #
	existe_Actualizado=$? #
} #
#
func_Asignar () { #
	ORIGEN=/cygdrive/$1/nube/$3 # 
	DESTINO=/cygdrive/$2/nube #
	AYUDA=`pwd`/help_nube.txt #
} #
#
#func_Recorrer_Elementos () {
	# Comprobar los elementos
	#for elemento in $My_Elementos #
	#do #
		#test -d $elemento #
		#if [[ !$?=0 ]] #
		#then #
			#echo "ERROR NO EXISTE...  "$elemento #
			#exit 1 #
		#fi	#
	#done #	
#}
#
#
# ------------------- COMIENZA EL SCRIPT ------------------
#
FECHA=`date` # 
# Elementos implicados en las operaciones
My_Elementos="/cygdrive/$1/nube/$3 /cygdrive/$2/nube"
My_Menu="BDropbox Dropbox"
ORIGEN=`pwd` # 
DESTINO=`pwd`#
AYUDA=`pwd`/help_nube.txt #
# Controles
existe_Origen=0 #
existe_Destino=0 #
existe_Ayuda=0 #
existe_Actualizado=0 #
NORIGEN=0 #
#
#
banner "Nube->USB" # Info...
#Información de ayuda
echo "Version 1.6 "
echo "------------------------------------------------------------------"
echo "<<< (Para obtener ayuda de funcionamiento nube -help) >>>"
echo "<<< (Para imprimit la ayuda nube -help_prn) >>>"
echo "------------------------------------------------------------------"
#
#¿Lanzar el fichero de ayuda?
if test "$1" = "-help" #Lanzar la ayuda
then #
	func_ExisteAyuda $AYUDA #
	if [[ $existe_Ayuda=0 ]] #	
	then #		
		cat $AYUDA;echo #		
	else #
		echo "ERROR PANTALLA- No se encontro el fichero de ayuda: "  #
		echo $AYUDA
		echo " ---------------------------------------- " #
		echo "  --------------------------------------- " #
		echo "    -----------------------------------    " #
	fi	#
	exit 1 #Salir	
fi	#
#
if test "$1" = "-help_prn" #Lanzar imprimir la ayuda
then #
	func_ExisteAyuda #
	if [[ !$existe_Ayuda=0 ]] #
	then #
		echo "ERROR IMPRESORA- No se encontro el fichero de ayuda: "  #
		echo $AYUDA #
		echo " ---------------------------------------- " #
		echo "  --------------------------------------- " #
		echo "    -----------------------------------    " #
	else #
		lpr $AYUDA;echo #
	fi	#
	exit 1 #Salir	
fi #
# 
#
echo " "
echo " ---------------------------------------- "
echo " Preparando copia desde: "${ORIGEN}
echo " a Memoria USB: "$DESTINO
echo " ---------------------------------------- ";sleep 2 #Pausa
#echo "--- Contenido de: "${ORIGEN};ls -m -R -1 $ORIGEN||echo "No existe el directorio"
NORIGEN=`ls -m -R -1 $ORIGEN| wc -l` #Nº de archivos
echo 
echo " ------------------------------------------"
echo " Información de "$DESTINO
echo " ------------------------------------------"
df --total $DESTINO; sleep 3 #Pausa
#
echo " "
echo "--- Se eliminaran los ficheros previos en destino "$DESTINO/$3; sleep 2 #Pausa
rm -fr $DESTINO/$3||echo "FALLO EN EL BORRADO PREVIO"
# 
echo "--- Copiando... [-Se indicará cuando finalice la copia-]"
cp -r $ORIGEN $DESTINO||echo "FALLO EN LA COPIA"
#
# Añadir la información de actualización
test -w $DESTINO/FActualizado.txt
if [[ $?=0 ]]
then
	echo -e "- ACTUALIZADO: ${FECHA}\r">>$DESTINO/FActualizado.txt;echo 
	echo "  Usuario / Terminal : "`whoami` " / " `hostname`>>$DESTINO/FActualizado.txt;echo #
	echo "  Elemento: "$DESTINO/$3>>$DESTINO/FActualizado.txt;echo -e "\r">>$DESTINO/FActualizado.txt;echo 
fi
#echo -n "--- Elementos copiados: ";ls -m -R -1 $ORIGEN| wc -l;echo 
#echo "--- Contenido destino";ls -R $DESTINO # Fin de la copia
echo " ------------"
echo -n " TOTALES "$ORIGEN;echo ": "$NORIGEN
# ls -m -R -1 $ORIGEN| wc -l #INFO...
# Comprobar si existe y guardar datos
test -w $DESTINO/FActualizado.txt
if [[ $?=0 ]]
then
	echo -n " TOTALES "$DESTINO/$3;echo -n ": ";ls -m -R -1 $DESTINO/$3| wc -l #info...
fi	
echo " ------------"
echo " "
# Mostrar la información de actualización de las últimas líneas de fichero
#df --total $DESTINO/$3;echo 
#cat $DESTINO/FActualizado.txt;echo #prueba
echo " Ultimas actualizaciones : "
echo " ------------------------- "
# Comprobar si existe y leer datos
test -r $DESTINO/FActualizado.txt
if [[ $?=0 ]]
then
	tail -8 $DESTINO/FActualizado.txt #prueba
fi	