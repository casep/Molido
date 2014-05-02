#!/bin/bash
#Script para actualizacion de ambientes
#Casep, 20101109, casep@intersys.com, version inicial
#Casep, 20110705, cambio en las paths, validar cantidad de parámetros, invocacion rutina COS
#Casep, 20110706, compatible para bld tst y trn

#Path ejemplo BLD-TST /trak/devel/BUILD/sdvp/bld/db
#Path ejemplo TRN /trak/sdcl/trn/db

#Valido recibir 2 los paremetros
if [ $# -lt 2 ]; then
 echo "uso /usr/bin/actualiza.sh proyecto ambiente"
 echo "proyecto = sdar,sdcl,sdcn,sdcq,sdor,sdsr,sdtl,sdvn,sdvp"
 echo "ambiente = bld,tst,trn" 
 exit
fi

proyecto=$1
ambiente=$2

archivoWebsys=/routines/websys.ConfigurationD\_$proyecto\_$ambiente.xml
if [ ! -e $archivoWebsys ]; then
 echo "No existe archivo de respaldo de websys.Configuration"
 echo "generarlo en $archivoWebsys"
 exit
fi

archivoGlobales=/tmp/GlobalesLive\_$proyecto.xml
if [ ! -e $archivoGlobales ]; then
 echo "No existe archivo de globales exportadas desde Live"
 echo "copiarlo en $archivoGlobales"
 exit
fi
 
if [ $ambiente == 'bld' ]; then
 instancia="BLD"
 pathDB=/trak/devel/BUILD/$proyecto/$ambiente/db
elif [ $ambiente == 'tst' ]; then
 instancia="TST"
 pathDB=/trak/devel/BUILD/$proyecto/$ambiente/db
elif [ $ambiente == 'trn' ]; then
 instancia=""
 pathDB=/trak/$proyecto/$ambiente/db
else
 echo "Ambiente no encontrado (tst,bld,trn)"
 exit
fi

if [ $proyecto == 'sdar' ]; then
 instancia="SDAR"$instancia
elif [ $proyecto == 'sdcl' ]; then
  instancia="SDCL"$instancia
elif [ $proyecto == 'sdcn' ]; then
  instancia="SDCN"$instancia
elif [ $proyecto == 'sdcq' ]; then
  instancia="SDCQ"$instancia
elif [ $proyecto == 'sdor' ]; then
  instancia="SDOR"$instancia
elif [ $proyecto == 'sdsr' ]; then
  instancia="SDSR"$instancia
elif [ $proyecto == 'sdtl' ]; then
  instancia="SDTL"$instancia
elif [ $proyecto == 'sdvn' ]; then
  instancia="SDVN"$instancia
elif [ $proyecto == 'sdvp' ]; then
  instancia="SDVP"$instancia
else
 echo "Proyecto no encontrado (sdar,sdcl,sdcn,sdcq,sdor,sdsr,sdtl,sdvn,sdvp)"
 exit
fi

echo "Deteniendo Cache"
ccontrol stop $instancia quietly
echo "Eliminando versiones anteriores"
rm -rf $pathDB/{app,sys,codes}
echo "Copiando versiones actualizadas"
cp -r /RESTORED/trak/$proyecto/PRD/db/{app,sys,codes} $pathDB/
echo "Cambiando permisos"
chown -R cacheusr.cacheusr $pathDB/{app,sys,codes}
echo "Elimiando locks"
find $pathDB/ -name cache.lck | xargs rm -f
echo "Iniciando instancia"
ccontrol start $instancia quietly
echo "Toques finales"
su - casep -c "csession $instancia -UUSER \"actualizaAmbiente\""

