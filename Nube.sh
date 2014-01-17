#!/bin/bash
#Nube.sh
#---
# Versión 1.7
# Autor: Fco. J. Becerra
# email: fjbecerr2@gmail.com
# fecha: 08/May/2013
# update: 21/10/2013
#--
#Copia el contenido de Nube en un usb
#
#¡¡¡¡¡TODOS LOS ECHO o comentarios TRAS LAS ORDENES SON 
#PARA EVITAR ERRORES CON EL SALTO DE LINEA!!!!
#
# ..........................................................
# Variables
ORIGEN=`pwd` # Directorio Origen
AYUDA=`pwd`/help_nube.txt # Archivo de ayuda
declare -i ERROR=0 # Control de errores, declarado como entero
ORIGEN_COPIA_TEMP=/cygdrive/[RUTA]/nube/[CARPETA] # 
DESTINO_COPIA_TEMP=/cygdrive/[RUTA]/nube #
ORIGEN_COPIA=/cygdrive/$1/nube/$3 # 
DESTINO_COPIA=/cygdrive/$2/nube/$3 #
DESTINO=/cygdrive/$2/nube #
RUTAS=0 # Introducir los parámetros de las rutas 0 -> 1 Utilizar rutas completa
NORIGEN=0 # Nº de Archivos
FECHA=`date`+%D;echo #Fecha abreviada
# ********************** #
func_Mensaje () {		#
	echo " "
	echo "________________________" #
	echo "|                      | " # 
	echo "|      NUBE->USB       | " # 
	echo "|      VERSION: 1.8.1    | " #
	echo "________________________" #
	#Información de ayuda
	echo "------------------------------------------------------------------" #
	echo "<<< (Para obtener ayuda de funcionamiento nube -help) >>>" #
	echo "------------------------------------------------------------------" #
} #
# ********************** #
func_VerRutas () {		#
	echo " Rutas predefinicas"
	echo "-> ORIGEN ACTUAL" #
	echo ORIGEN #
	echo "-> ORIGEN DE DATOS" #
	echo "/cygdrive/$1/nube/$3" #
	echo /cygdrive/$1/nube/$3 #
	echo "-> DESTINO " # 
	echo "/cygdrive/$2/nube" #
	echo /cygdrive/$2/nube #	
} #
# ********************** #
#-Controlar si existe la ayuda
func_ExisteAyuda () { #	
	echo " " #
	echo "--> Chequeando el fichero de ayuda: " $AYUDA	#	
	if [[ -e "$AYUDA" ]] #
	then #
		echo "--> Fichero de ayuda	... OK"
		ERROR=0 #
	else	#
		ERROR=1 #
		echo "--> Fichero de ayuda	... ERROR"
	fi #
	echo " " #
} #
# ********************** #
func_Cambiar_Rutas () { #
	RUTA=0 # Rutas por defecto
	echo "Sustitución de rutas predefinidas " #
	echo "Ruta de origen : " $ORIGEN_COPIA_TEMP #
	echo "Ruta de destino : " $DESTINO_COPIA_TEMP #
	echo "Nueva rutas: " #
	echo "Ruta de origen: ... " #
	read ORIGEN_COPIA_TEMP #
	echo "Ruta de destino : " #
	read DESTINO_COPIA_TEMP #	
	echo "Nuevas de rutas predefinidas " #
	echo "Ruta de origen : " $ORIGEN_COPIA_TEMP #
	echo "Ruta de destino : " $DESTINO_COPIA_TEMP #
	# Testear la nueva ruta
	test -d $ORIGEN_COPIA_TEMP #
	if [[ $? = 0 ]] #
	then #
		test -d $ORIGEN_COPIA_TEMP #	
		if [[ $? = 0 ]] #
		then #
			RUTA=1 #
		else #
			echo "No existe la ruta DESTINO" #			
		fi #	
	else #
		echo "No existe la ruta ORIGEN" #
	fi #			
	} #
# Función para Testear los directorios
func_ExisteOrigen () { #
	test -d $ORIGEN_COPIA #
	if [[ $? = 0 ]] #
	then #
		ERROR=0 #
	else # 
		ERROR=1 #
	fi	#		
} #
# ***********************
func_ExisteDestino () { #
	test -d $DESTINO_COPIA #
	if [[ $? = 0 ]] #
	then #
		ERROR=0 #
	else # 
		ERROR=1 #
	fi	#	
} #
# *************************
func_EliminarDestino() { #
	echo " " #
	echo "--- Se eliminaran los ficheros previos en destino "$DESTINO_COPIA/$3; sleep 2 #Pausa
	rm -fr $DESTINO_COPIA/$3||echo "FALLO EN EL BORRADO PREVIO" #
	if [[ $? = 0 ]] #
	then #
		ERROR=0 #
	else # 
		ERROR=1 #
	fi	#
} #
# *************************
func_Copiar() { #
	echo " " #
	echo "--- Se copian los archivos de "$ORIGEN_COPIA/$3; sleep 2 #Pausa
	echo "--- A "$DESTINO_COPIA/$3; sleep 2 #Pausa
	cp -r $ORIGEN_COPIA $DESTINO_COPIA #
	if [[ $? = 0 ]] #
	then #
		ERROR=0 #
	else # 
		ERROR=1 #
	fi	#
} #
# *************************
func_Infor() { #
	# Añadir la información de actualización	
	echo -e "- \r" >>$DESTINO/FActualizado.txt; echo #	
	echo -e " - ACTUALIZADO: \r" >>$DESTINO/FActualizado.txt; echo #	
	echo ${FECHA} >>$DESTINO/FActualizado.txt; echo #
	echo -e " \r" >>$DESTINO/FActualizado.txt; echo #	
	echo $ORIGEN_COPIA>>$DESTINO/FActualizado.txt;echo -e >>$DESTINO/FActualizado.txt;echo #
	echo -e " \r" >>$DESTINO/FActualizado.txt; echo #	
	echo $DESTINO_COPIA>>$DESTINO/FActualizado.txt;echo -e >>$DESTINO/FActualizado.txt;echo #
	echo -n "--- Elementos copiados: ";ls $ORIGEN_COPIA| wc -l;echo #
	echo "--- Contenido destino";ls $DESTINO_COPIA # Fin de la copia
	# Mostrar la información de actualización
	cat $DESTINO/FActualizado.txt;echo #prueba
} #
# ------------------- COMIENZA EL SCRIPT ------------------
#
func_Mensaje #
# ***********
if test "$1" = "-help" #Lanzar la ayuda
then #
	func_ExisteAyuda #	
	if (($ERROR==0)) # if para expresión aritmética (( ...))	
	then #		
		cat $AYUDA;echo #			
	fi	#
	exit 1 #Salir	
fi	#
#
# ¿Imprimir el fichero de ayuda?
# -------------------------------------------
if test "$1" = "-help_prn" #Lanzar imprimir la ayuda
then #
	func_ExisteAyuda #	
	if (($ERROR==0)) # if para expresión aritmética (( ...))	
	then #
		echo "--> Imprimiendo Ayuda	... OK"
		lpr $AYUDA;echo #
	fi	#
	exit 1 #Salir	
fi #
# ****************
#** Ver las rutas
if test "$1" = "-vway" #Lanzar la ayuda
then #
	func_VerRutas #
	exit 1 #Salir
fi #
#**Cambiar las rutas
if test "$1" = "-way" #Lanzar la ayuda
then #
	func_Cambiar_Rutas #
	exit 1 #Salir
fi #	
# OPERACIONES DE COPIA DE ARCHIVOS
# Operacion que no hacen controles
if test "$4" = "-err" #
then #
	func_EliminarDestino #
	func_Copiar #
	echo "Compruebe la copia" #
	exit 1 #Salir
fi #	
# ---------- Comprobar ubicación de origen
func_ExisteOrigen # 
if [[ $ERROR = 0 ]] #
then #
	echo "--> Fichero en origen ... OK" $ORIGEN_COPIA #
else #	
	echo "--> Fichero en origen ... ERROR" $ORIGEN_COPIA #
	exit 1 #Salir	
fi	#
# ---------- Comprobar ubicación de destino
func_ExisteDestino # 
if [[ $ERROR = 0 ]] #
then #
	echo "--> Ubicacion en destino ... OK" $DESTINO_COPIA #
else #	
	echo "--> Ubicacion en destino ... ERROR" $DESTINO_COPIA #
	exit 1 #Salir	
fi	#
# ------ Mensajes
echo " "
echo " ---------------------------------------- "
echo " Preparando copia desde: "${ORIGEN_COPIA}
echo " a Memoria USB: "$DESTINO_COPIA
echo " ---------------------------------------- ";sleep 2 #Pausa
#echo "--- Contenido de: "${ORIGEN};ls -m -R -1 $ORIGEN||echo "No existe el directorio"
NORIGEN=`ls -m -R -1 $ORIGEN_COPIA| wc -l` #Nº de archivos
echo 
echo " ------------------------------------------"
echo " Información de destino"$DESTINO_COPIA
echo " ------------------------------------------"
df -h --total $DESTINO_COPIA; sleep 3 #Pausa e informacion de disco destiono
# COMIENZA LA OPERACION
#
func_EliminarDestino #
if [[ $ERROR = 0 ]] #
then #
	echo "--> Eliminar ficheros en destino ... OK" $DESTINO_COPIA #
else #	
	echo "--> Eliminar ficheros en destino ... ERROR" $DESTINO_COPIA #
	exit 1 #Salir	
fi	#
func_Copiar #
if [[ $ERROR = 0 ]] #
then #
	echo "--> Copia de archivos ... OK" 
	echo $ORIGEN_COPIA #
	echo $DESTINO_COPIA #
else #	
	echo "--> Copia de archivos ... ERROR" $DESTINO_COPIA #
	echo $ORIGEN_COPIA #
	echo $DESTINO_COPIA #
	exit 1 #Salir	
fi	#
func_Infor #