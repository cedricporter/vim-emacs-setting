#!/bin/sh
#
# File: sync_backup_photo.sh
#
# Created: Saturday, September 20 2014 by Hua Liang[Stupid ET] <et@everet.org>
#

echo "================================="
echo "Syncing folder structure\n"

echo "================================="
echo "Now start to backup 收藏\n"
rsync --size-only --ignore-existing -rvhH --progress --delete /Volumes/Photos2/收藏 /Volumes/Photos/

echo "================================="
echo "Now start to backup 照片\n"
rsync --size-only --ignore-existing -rvhH --progress --delete /Volumes/Photos2/照片 /Volumes/Photos/

echo "================================="
echo "Now updating xmp file\n"
rsync -rv --include '*/' --include '*.xmp' --exclude '*' --prune-empty-dirs /Volumes/Photos2/收藏 /Volumes/Photos/
rsync -rv --include '*/' --include '*.xmp' --exclude '*' --prune-empty-dirs /Volumes/Photos2/照片 /Volumes/Photos/


echo "================================="
echo "Now compress lightroom backup folder\n"
(cd ~/Lightroom/ET/ET/Backups ; find . -mindepth 1 -maxdepth 1 -type d -exec tar zcvf {}.tgz {} \;)


echo "================================="
echo "Now compress lightroom backup folder\n"
rsync --size-only --ignore-existing -rvh --include '*/' --include '*.tgz' --exclude '*' --prune-empty-dirs --progress ~/Lightroom/ET/ET/Backups /Volumes/Photos2/Lightroom_Backups


echo "================================="
echo "Deleting backup folder after compress\n"
(cd ~/Lightroom/ET/ET/Backups ; find . -mindepth 1 -maxdepth 1 -type d | tr "\n" "\000" | xargs -0 rm -rf ;)
