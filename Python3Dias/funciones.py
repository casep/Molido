#!/usr/bin/python
def computepay(h, r) :
    if h > 40:
     ex=h-40
     total=40.0*r+ex*1.5*r
    else :
     total=h*r
    return total
#Fin de la funcion ahora viene el codigo que normalmente se ejecuta

inp = raw_input("Enter Hours:")
ho=float(inp)
inp = raw_input("Enter Rate:")
ra=float(inp)
pago = computepay(ho,ra)  # Llamado a la funcion
print "Pay:",pago
