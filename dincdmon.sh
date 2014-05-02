#!/bin/bash

# Comando para ejecutar el CRON:
# sh cdmon.sh &

# si cdmon.sh es el nombre del script
# Con dicho comando quedará corriendo la aplicación de fondo.
# IMPORTANTE: Debes tener el paquete "links2" instalado

############################ Créditos
# Versión de www.EstebanWeb.cl (1ra Actualización el 16 de enero del 2008)
# blog: www.estebanweb.cl/linux
# Idea original por Enrique Garcia Alvarez <kike>
# kike arroba eldemonionegro punto com
# http://www.eldemonionegro.com/wordpress/archivos/2006/01/15/script-para-cdmon/
# Modificado por primera vez por Javier xavy en ghalician punto es
# Modificado por segunda vez en diciembre del 2007 por Esteban estebanweb.cl
# www.estebanweb.cl
# Comentado por estebanweb.cl
# contacto a esteban iglesias manriquez (todo junto) arroba gmail (.) com
# puedes tener más info en www.estebanweb.cl/linux
# Y más sobre este script en --->
# http://www.estebanweb.cl/linux/index.php/12/2007/%c2%a1el-problema-de-la-ip-dinamica-solucionado-script-para-actualizar-ip-en-cdmon/
# Software libre (licencia GNU)para la administracion de dominios en cdmon 
# Copyright (C) 2005-2006 
#
# estebanweb.cl dice: 
# Me gustaría que me avisaras de cualquier cambio que se le realiza al script
# Y que si lo publicas en tu web pongas los créditos de arriba
# contacto a esteban iglesias manriquez (todo junto) arroba gmail (.) com
#
# Puedes leer la licencia en en español en http://www.viti.es/gnu/licenses/gpl.html
############################# Licencia
#    Este programa es software libre. Puede redistribuirlo y/o modificarlo
#    bajo los teminos de la Licencia Publica General de GNU segun es publicada
#    por la Free Software Foundation, bien de la version 2 de dicha Licencia
#    o bien (segun su eleccion) de cualquier version posterior.
#
#    Este programa se distribuye con la esperanza de que sea util, 
#    pero SIN NINGUNA GARANTIA, incluso sin la garantia MERCANTIL implicita o
#    sin garantizar la CONVENIENCIA PARA UN PROPOSITO PARTICULAR. 
#    Vease la Licencia Publica General de GNU para mas detalles.
#    Deberia haber recibido una copia de la Licencia Publica General junto
#    con este programa. Si no ha sido asi, escriba a la 
#    Free Software Foundation, Inc., en 675 Mass Ave, Cambridge, MA 02139, EEUU.
#    MIRA AQUI PARA SABER MAS ==>>  http://www.gnu.org/copyleft/gpl.html
#
############################# License
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#    SEE HERE FOR MORE ==>>  http://www.gnu.org/copyleft/gpl.html
###########################################################################
############################ PROTOCOLO
###########################################################################
# Para poder actualizar su IP tiene que hacer una llamada a la siguiente URL:
#    https://dinamico.cdmon.org/onlineService.php
# con los argumentos via GET siguientes:
#    enctype=MD5 
#    n=nombre_de_usuario 
#    p=contrasea_codificada_con_md5
# si la IP que quiere actualizar es diferente a la IP que le asigna el sistema
# puede definir una IP propia con el argumento "cip"
#    cip=x.x.x.x
# de modo que tendremos:
#    https://dinamico.cdmon.org/onlineService.php?enctype=MD5&n=usuario&p=1bc29b36f623ba82aaf6724fd3b16718&cip=x.x.x.x
# donde cip es opcional ya que al hacer la peticin via URL el servidor devuelve
# un resultado.
#
#    RESULTADOS:
# la peticion https nos devuelve una variable con el formato siguiente:
#    &resultat=resultado de la peticin del servidor&
# donde tenemos las siguientes opciones:
#
# Cuando se hace una peticin sin la variable cip y la autentificacin ha sido
# correcta nos devuelve la IP actual que detecta el servidor.
#    &resultat=guardatok&newip=x.x.x.x&
#
# Cuando hemos mandado nuestra IP mediante la variable cip y la autentificacin
# ha sido satisfactoria.
#    &resultat=customok&
#
# Nos devuelve este resultado cuando la autentificacin ha sido
# pero la IP es erronea.
#    &resultat=badip&
#
# Nos devuelve este resultado cuando la autentificacin no ha sido satisfactoria.
#    &resultat=errorlogin&
#
# Nos devuelve este resultado en raras ocasiones, solo cuando modificamos el
# archivo que procesa todas las peticiones para obligar a todos los usuarios a
# actualizar a una nueva version de la aplicacion. En su caso solo tendra
# que ponerse en contacto con nosotros para obtener la nueva URL para hacer la peticion.
#    &resultat=novaversio&
#  
######################################################################################
#											AQUI COMIENZA
######################################################################################
## Comenzamos con los datos de usuario de CDMON.COM
# Le debes dar valores a las variables..
# USUARIO = es el nombre de usuario para entrar en CDMON.COM
# PASSWORDMD5 = Es la contraseña para entrar en CDMON.COM encriptada con
#		el algoritmo MD5.
# Puedes encriptar tu contraseña con MD5 en https://www.cdmon.com/md5.php
# EMAIL = es donde queremos q lleguen los mensajes del CRON.
# HOST = el dominio/subdominio que se desea actualizar


USUARIO=
PASSMD5=
EMAIL=
HOST=

# Aquí un ejemplo de como debería quedar
# con un usuario "usuario" y con su password "contraseña"
# con un computador llamado pcdeusuario y con un usuario (esto es en linux) (dentro del pc)
# llamado "dueño"
###################################
# USUARIO=usuario
# PASSMD5=484ac397cb407ab7aad776f0663f8c85
# EMAIL=dueño@pcdeusuario
# HOST=mi.sub.dominio.com
###################################

#lo que primero hace es comenzar un loop
while [ 1  ]                                           
do 
#luego pregunta por la ip de la página web
#aquí tendremos que substituir HOST.TLD por el dominio
IP_DNS_ONLINE=$(host $HOST dinamic1.cdmon.net | grep -m1 $HOST | awk {'print $4'})
#luego pregunta por la ip del pc a traves de whatismyip.com
GET_IP="https://dinamico.cdmon.org/onlineService.php?enctype=MD5&n=$USUARIO&p=$PASSMD5"
IP_ACTUAL=`wget --no-check-certificate $GET_IP -o /dev/null -q -O /dev/stdout | cut -f2 -d\& | cut -f2 -d=`
#y compara si son iguales

if [ "$IP_DNS_ONLINE" != "$IP_ACTUAL" ]; then

# y si es que no son iguales, hace lo siguiente
#establece una variable con el GET que tiene que hacer, con todos los datos
    CHANGE_IP="https://dinamico.cdmon.org/onlineService.php?enctype=MD5&n=$USUARIO&p=$PASSMD5&cip=$IP_ACTUAL"
    # luego al establecer la variable RESULTADO, hace el GET y la variable se queda con la respuesta que le da
    # si es satisfactorio, la respuesta debería ser &resultat=customok&
    RESULTADO=`wget $CHANGE_IP -o /dev/null -O /dev/stdout --no-check-certificate`
    #Ponemos que es lo que queremos que salga en el email
    MENSAJE="Ha habido un cambio en la IP de los nombres de dominio.\n"
    MENSAJE=$MENSAJE"Se han actualizado los servidores DNS dinamicos de CDMON.\n"
    MENSAJE=$MENSAJE"El resultado devuelto ha sido el siguiente:\n"
    
    #Finalmente envia un email con los resultados

    echo -e $MENSAJE $RESULTADO IP DEL SITIO era: $IP_DNS_ONLINE por lo tanto fue modificada por la IP ACTUAL:$IP_ACTUAL | mail $EMAIL -s "cambio de IP"
    
fi
# Aquí debes introducir la cantidad de segundos que quieres que espere para que vuelva al principio
sleep 180
done

############################ FIN
##########################################################################

