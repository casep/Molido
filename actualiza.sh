#!/bin/bash
#Script para actualizacion de ambientes
#Casep, 20101109, casep@intersys.com, version inicial
#Casep, 20110705, cambio en las paths, validar cantidad de parámetros, invocacion rutina COS
#Casep, 20110706, compatible para bld tst y trn
#Casep, 20111027, compatible con Support
#Casep, 20111114, cambio ubicacion archivos credenciales
#Casep, 20111216, cambio en rutina de Toques finales por TRC 93844
#Casep, 20120222, cambio en path RESTORE
#Casep, 20120314, cambio path DBs ssmoc 2010
#Casep, 20120713, cambio * por nombres de BDs en support (sysconfig de 2011/ccr)
#Casep, 20120718, no mas Monitor
#Casep, 20121022, Paths 2011
#Casep, 20121031, DATA en Test
#Casep, 20121220, SDCQ 2011

#Path ejemplo BLD-TST /trak/devel/BUILD/sdvp/bld/db
#Path ejemplo TRN /trak/sdcl/trn/db
#Path ejemplo Support /trak/devel/BUILD/sdvp/db

#Valido recibir 2 los paremetros
if [ $# -lt 2 ]; then
 echo "uso /usr/bin/actualiza.sh proyecto ambiente"
 echo "proyecto = sdar,sdcl,sdcn,sdcq,sdor,sdsr,sdtl,sdvn,sdvp,smoc"
 echo "ambiente = support,tst,trn" 
 exit
fi

proyecto=$1
ambiente=$2
userCache="casep"

#Path RESTORE SSMOC es distinta
pathRestore=/RESTORED/trak/$proyecto/PRD
if [ $proyecto == 'smoc' ]; then
 pathRestore=/RESTORED/trak/ssmoc/PRD
fi

#Valido existencia RESTORE
archivoRestore=$pathRestore/db/_DATE.TSM
if [ ! -e $archivoRestore ]; then
 echo "No existe RESTORE"
 exit
fi

#Valido existencia archivo credenciales
archivoCredenciales=/refresh/credenciales\_$proyecto
if [ $ambiente == 'support' ]; then
 if [ ! -e $archivoCredenciales ]; then
  echo "No existe archivo de Credenciales"
  echo "generarlo en $archivoCredenciales"
  exit
 fi
fi

#Valido archivo rutinas
archivoRutinas=/routines/UActualizaAmbiente\_$proyecto\_$ambiente.xml
if [ ! -e $archivoWebsys ]; then
 echo "No existe archivo de respaldo de UActualizaAmbiente"
 echo "generarlo en $archivoRutinas"
 exit
fi

#Para refresco Tet se requieren globales
archivoGlobales=/tmp/GlobalesLive\_$proyecto.xml
if [ ! -e $archivoGlobales ] && [ $ambiente == 'trn' ]; then
 echo "No existe archivo de globales exportadas desde Live"
 echo "copiarlo en $archivoGlobales"
 exit
fi

#Path idiotas 
if [ $ambiente == 'support' ]; then
 instancia="SUPPORT"
 pathDB=/trak/devel/BUILD/$proyecto/db
 pathWEB=/trak/devel/BUILD/$proyecto/web
elif [ $ambiente == 'tst' ]; then
 instancia="TST"
 pathDB=/trak/devel/TEST/$proyecto/$ambiente/db
 pathWEB=/trak/devel/TEST/$proyecto/$ambiente/web
elif [ $ambiente == 'trn' ]; then
 instancia=""
 pathDB=/trak/$proyecto/$ambiente/db
 pathWEB=/trak/$proyecto/$ambiente/web
else
 echo "Ambiente no encontrado (tst,support,trn)"
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
elif [ $proyecto == 'smoc' ]; then
  instancia="SMOC"$instancia
else
 echo "Proyecto no encontrado (sdar,sdcl,sdcn,sdcq,sdor,sdsr,sdtl,sdvn,sdvp,smoc)"
 exit
fi

echo "Inicio Proceso " 
echo $(date)
echo " "
echo "Deteniendo Cache"
ccontrol stop $instancia quietly

echo " "
echo "Eliminando versiones anteriores"
rm -rf $pathDB/{app,sys,codes,data,2010,2011}
if [ $ambiente == 'support' ]; then
 rm -rf $pathDB/{audit,docs,hl7,log*}
fi
rm -rf $pathWEB/*

echo " "
echo "Copiando versiones actualizadas"
cp -r $pathRestore/db/{app,sys,codes,data,2010,2011} $pathDB/

if [ $ambiente == 'support' ]; then
 cp -r $pathRestore/db/{audit,docs,hl7,log*,_DATE.TSM} $pathDB/
fi
cp -r $pathRestore/web/* $pathWEB/

echo " "
echo "Cambiando permisos"
chown -R cacheusr.cacheusr $pathDB 
chown -R cacheusr.cacheusr $pathWEB

echo "Elimiando locks"
find $pathDB/ -name cache.lck | xargs rm -f

echo "Iniciando instancia"
cat $archivoCredenciales | ccontrol start $instancia quietly

echo " "
echo "Toques finales"
su - $userCache -c "csession $instancia -UUSER \"UCargaRutinas\""
cat $archivoCredenciales | xargs rm -f
rm -rf $archivoCredenciales
rm -rf $archivoGlobales
echo " "
echo "Fin proceso"
echo $(date)

