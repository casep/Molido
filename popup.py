#!/usr/bin/python

import gtk
import commands
import sys
import smtplib


d = gtk.Dialog()
d.add_buttons(gtk.STOCK_YES, 1)

comando='/usr/bin/sensors | grep RPM | cut -d" " -f9'
estado = commands.getoutput(comando)

if estado=='0':
 fromaddr = '"Automatic fan monitoring" <carlos.sepulveda+fan@gmail.com>'
 toaddrs = '"Carlos \"casep\" Sepulveda" <carlos.sepulveda@gmail.com>'
 subject = "Fan issue on T400"
 smtp_server = '127.0.0.1'
 msg = ' FAN issue on T400 \n' + commands.getoutput('date')
 m = 'From: %s\r\nTo: %s\r\nSubject: %s\r\nX-Mailer: My-Mail\r\n\r\n' % (fromaddr, toaddrs, subject)
 s = smtplib.SMTP(smtp_server)
 s.sendmail(fromaddr, toaddrs, m+msg)
 s.quit()

 d = gtk.Dialog()
 d.add_buttons(gtk.STOCK_YES, 1)
 label = gtk.Label(' El ventilador NO esta funcionando, \n Reinicia el equipo y debiera estar OK, \n MUACH, \n Casep!')
 label.show()
 d.vbox.pack_start(label)
 answer = d.run()
 sys.exit(2)
else:
 print 'Estado OK'
 sys.exit(0)

