#! /bin/sh 
mo_name=$1

# Put whatever loops etc, but this is just straight call
# Date,       Time   ,  Glorefs, RemGrefs, GRratio,  PhyRds, Rdratio, Gloupds, RemGupds, Rourefs, RemRrefs,  RouLaS, RemRLaS,  PhyWrs,   WDQsz,  WDtmpq, WDphase,  WIJwri,  RouCMs, Jrnwrts,  ActECP,  Addblk, PrgBufL, PrgSrvR,  BytSnt,  BytRcd,  WDpass,  IJUcnt, IJULock


gnu_mgs.sh $1 3 Glorefs
gnu_mgs.sh $1 4 RemGrefs
gnu_mgs.sh $1 6 PhyRds
gnu_mgs.sh $1 7 Rdratio
gnu_mgs.sh $1 8 Gloupds
gnu_mgs.sh $1 12 RouLaS
gnu_mgs.sh $1 14 PhyWrs
gnu_mgs.sh $1 18 WIJwri
gnu_mgs.sh $1 20 Jrnwrts

