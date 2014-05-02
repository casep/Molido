#!/bin/bash
ADDRESS=`echo $1 | sed 's/mailto://'`
/opt/google/chrome/google-chrome "https://mail.google.com/mail?view=cm&tf=0&to=$ADDRESS"

