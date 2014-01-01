#!/bin/sh
#
# File: sock5.sh
#
# Created: Monday, March 25 2013 by Hua Liang[Stupid ET] <et@everet.org>
#

ssh -qnfNT -D 127.0.0.1:3389 -l root -p 1990 ipv6.everet.org
