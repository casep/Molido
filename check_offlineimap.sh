#!/usr/bin/env bash
#Dumb script to check offlineimap and logging it

echo "Inicio"   >  /tmp/offlineimap.log
echo `date`     >> /tmp/offlineimap.log
echo ""         >> /tmp/offlineimap.log
offlineimap     >> /tmp/offlineimap.log
echo ""         >> /tmp/offlineimap.log
echo "Fin"      >> /tmp/offlineimap.log
echo `date`     >> /tmp/offlineimap.log
echo ""         >> /tmp/offlineimap.log

