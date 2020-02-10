rsync -avz ~/.config/evolution/ /var/run/media/casep/Backup/.config/evolution/
rsync -avz ~/.cache/evolution/ /var/run/media/casep/Backup/.cache/evolution/
rsync -avz --delete-before ~/Documents/ /var/run/media/casep/Backup/Documents/
rsync -avz ~/Games/ /var/run/media/casep/Backup/Games/
rsync -avz ~/mail/ /var/run/media/casep/Backup/mail/
rsync -avz ~/.local/share/evolution/ /var/run/media/casep/Backup/.local/share/evolution/
rsync -avz ~/Music/ /var/run/media/casep/Backup/Music/
rsync -avz ~/Photos/ /var/run/media/casep/Backup/Photos/
rsync -avz ~/Utils/ /var/run/media/casep/Backup/Utils/
rsync -avz --delete-before ~/VirtualBox\ VMs/ /var/run/media/casep/Backup/VirtualBox\ VMs/
