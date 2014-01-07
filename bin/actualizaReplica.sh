#!/usr/bin/env bash

# Copia de Box1 en el MacPro
rsync -avz --delete --link-dest=/Volumes/Virtual/BackupsDeversorius/backups/replica-actual ammz@deversorius.net:/www/typo3 /Volumes/Virtual/BackupsDeversorius/backups/replica-box1_$(date +%y-%m-%d-%H%M)

# Borra el enlace simbólico que apunta a la última copia de backup
rm /Volumes/Virtual/BackupsDeversorius/backups/replica-actual

# Enlaza simbólicamente la última copia de backup, para utilizarla como diretorio
# de comparación en la órden rsync
ln -s /Volumes/Virtual/BackupsDeversorius/backups/replica-box1_$(date +%y-%m-%d-%H%M) /Volumes/Virtual/BackupsDeversorius/backups/replica-actual