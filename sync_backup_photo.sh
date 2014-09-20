#!/bin/sh
#
# File: sync_backup_photo.sh
#
# Created: Saturday, September 20 2014 by Hua Liang[Stupid ET] <et@everet.org>
#

echo "New start to backup 收藏"
rsync --size-only --ignore-existing -rvhH --progress --delete /Volumes/Photos2/收藏 /Volumes/Photos/

echo "New start to backup 照片"
rsync --size-only --ignore-existing -rvhH --progress --delete /Volumes/Photos2/照片 /Volumes/Photos/
