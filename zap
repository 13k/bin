#!/bin/sh
# $Id: zap,v 1.6 1997/08/19 20:44:55 gustavo Exp $

# I got this idea when skimming the Kernigham's book `UNIX Programming
# Environment'.  I don't have the source, hence the different
# implementation.  This is handy for sysadmins who do a lot of `ps'
# followed by `kill'.  Instead of `kill PID', use `zap REGEXP', where
# REGEXP is an egrep-like regular expression that will be matched
# against the ps's output.  Every matching line is presented to the
# user asking him to tell if the process in question must be killed or
# not.  zap can take an option telling which signal to use in the
# killing.

#PATH=/usr/bin:/bin:/sbin; export PATH
PROGNAME=$0
OS=`uname -s`_`uname -r`

case $OS in
    SunOS_4*)
	PS='ps auxww'
	ECHON='echo -n'
	;;
    SunOS_5*)
	PS='ps -ef'
	ECHON='/usr/ucb/echo -n'
	;;
    OSF*|HP-UX*|AIX*|Linux*)
	PS='ps -ef'
	ECHON='echo -n'
	;;
    *)
	echo "Unknown system: $OS"
	exit 2
esac

usage() {
    echo "usage: `basename $PROGNAME` [-SIG] [--] regexp"
    exit 1
}

case "$1" in
    -*) SIG=$1; shift ;;
    *)  SIG=-15 ;;
esac

if [ "$1" = "--" ]; then
    shift
fi

if [ $# -eq 1 ]; then
    REGEXP=$1
else
    usage
fi

TTY=`tty`
TMP=/tmp/zap.$$

$PS >$TMP

egrep -- "$1" $TMP |
    while read uid PID REST; do
	if [ "$PID" -ne $$ ]; then
	    $ECHON "$uid $PID $REST [y/N]?"
	    read ANSWER <$TTY
	    case "$ANSWER" in
		y|Y) kill $SIG $PID;;
	    esac
	fi
    done

rm -f $TMP
