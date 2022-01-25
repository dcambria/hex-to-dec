#!/usr/bin/env bash
#
# APP NAME: hextodex.sh - Hex to Dec 
# DESCRIPTION: Criado para facilitar a conversão de bytes escritos em hexadecimal em números decimais. A entrada é non-sensitive.
#
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# AUTHOR NAME: Daniel Cambría
# AUTHOR EMAIL: daniel.cambria@bureau-it.com
# - - - - - - - - - - - - - - - - - - - - - - - - -
# COMPANY: Bureau de Tecnologia
# WEBSITE: bureau-it.com
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
# APP URL: -
#
#
# APP LOG
# -------
#
# VERSÃO 1.0: Leitura de vários blocos de 1 byte separados por espaços (-b) e números maiores longos sem espaços.
#
# TODO: 
#
#
#

hextodec(){
    HEXDEC=$(echo $@ | tr '[:lower:]' '[:upper:]' | sed "s/ //g")
    echo -en "\033[1;4;31m$HEXDEC \033[0m"
    DEC=$(bc <<< "ibase=16;$HEXDEC")
    printf '\033[4;41m%3d\033[0m' $DEC
}

echo ""

if [[ $# -eq 0 ]] 
then
    echo "Digite um valor hexadecimal ou"
    echo "Use -b para leitura de bytes separados por espaços. Ex. FF FF FF"
    exit 0
fi

if [ $1 == "-b" ]

then   
    shift
    HEX="$@"
    for i in $HEX                    
    do
       hextodec $i
       echo -n " "
    done  
else
    HEX="$@"
    hextodec $HEX

fi
