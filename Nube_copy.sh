#!/bin/bash
# Nube_copy.sh
# Variables
#FECHA=`date`
#ORIGEN=/cygdrive/D/Nube/BDropBox
#DESTINO=/cygdrive/G
#$ls
#hostname
#echo ------------------------------------------
#echo Preparando copia desde $ORIGEN 
#echo a Memoria USB $DESTINO
#echo ------------------------------------------
#sleep 6 #Pausa
#echo Usuarios en el sistema | who | wc -l
#sleep 6
#echo Eliminando elementos anteriores ...
#echo Numero de archivos a eliminar | ls | wc -l
#sleep 6
#echo Eliminando $DESTINO/BDropbox...
#$FECHA>>error_nube.txt
#rm $DESTINO/BDropbox 2 >>error_nube.txt
#echo Copiando todos los archivos de Dropbox a la unidad...
#$FECHA>>error_nube.txt
#cp {$ORIGEN[0]}/BDropbox/* $DESTINO 2>>error_nube.txt
#echo
#echo Estado de errores...
#cat error_nube.txt
#ORIGEN[0]=/cygdrive/D/Nube/BDropBox
#ORIGEN[1]=/cygdrive/D/Nube/DropBox
#ORIGEN[2]=/cygdrive/D/Nube/Google* #Parche para evita el espacio
#readonly ORIGEN #Solo lectura
#echo Posibles valores de origen ${ORIGEN[*]}
# echo $? Saber que una operacion fallo porque vale 1
#if [ "$?" -eq "1"]; then
#	echo Error en la operacion de borrado
#else
#	echo "el usuario $usuario, no existe en /etc/passwd"
#fi
#cp -r $ORIGEN $DESTINO
#cd $ORIGEN
#echo " Eliminando elementos anteriores de: "$DESTINO
#mkdir $DESTINO
#
#if test -f mensaje.txt
#then
#	echo Existe
#else
#	echo No existe
#fi
#test $DESTINO
#mkdir $DESTINO
#
#logname