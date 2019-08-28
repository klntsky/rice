#!/usr/bin/env bash

LIMIT=200
E_ARG_ERR=65
E_OUT_OF_RANGE=66

if [ -z "$1" ]
then
  echo "Usage: `basename $0` number-to-convert"
  exit $E_ARG_ERR
fi

num=$1
if [ "$num" -gt $LIMIT ]
then
    echo "Out of range!"
    exit $E_OUT_OF_RANGE
fi

to_roman ()
{
    number=$1
    factor=$2
    rchar=$3
    let "remainder = number - factor"
    while [ "$remainder" -ge 0 ]
    do
        echo -n $rchar
        let "number -= factor"
        let "remainder = number - factor"
    done
    return $number
}

to_roman $num 100 C
num=$?
to_roman $num 90 LXXXX
num=$?
to_roman $num 50 L
num=$?
to_roman $num 40 XL
num=$?
to_roman $num 10 X
num=$?
to_roman $num 9 IX
num=$?
to_roman $num 5 V
num=$?
to_roman $num 4 IV
num=$?
to_roman $num 1 I
echo
exit
