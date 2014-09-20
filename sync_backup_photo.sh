#!/bin/sh
#
# File: sync_backup_photo.sh
#
# Created: Saturday, September 20 2014 by Hua Liang[Stupid ET] <et@everet.org>
#

echo "================================="
echo "Syncing folder structure\n"

echo "================================="
echo "New start to backup 收藏\n"
rsync --size-only --ignore-existing -rvhH --progress --delete /Volumes/Photos2/收藏 /Volumes/Photos/

echo "================================="
echo "New start to backup 照片\n"
rsync --size-only --ignore-existing -rvhH --progress --delete /Volumes/Photos2/照片 /Volumes/Photos/

echo "================================="
echo "Now updating xmp file\n"
rsync -rv --include '*/' --include '*.xmp' --exclude '*' --prune-empty-dirs /Volumes/Photos2/收藏 /Volumes/Photos/
rsync -rv --include '*/' --include '*.xmp' --exclude '*' --prune-empty-dirs /Volumes/Photos2/照片 /Volumes/Photos/
