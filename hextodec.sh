#!/usr/bin/env bash
#
# APP NAME: hextodex.sh - Hex to Dec 
# DESCRIPTION: Criado para facilitar a conversão de bytes escritos em hexadecimal em números decimais. A entrada é non-sensitive. Utiliza a calculadora BC para a conversão.
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
# VERSÃO 1.1: Incorpora supressão de saída hexadecimal
# VERSÃO 1.11: Tratamento de entrada. Evita hexadecimais impossíveis e sintaxe de comando.
# VERSÃO 1.12: Melhorias de código
#
# TODO: 
#
#
#


banner() {
    echo "hextodec.sh"
    echo "-----------" 
    echo ""
    echo "Converte números hexadecimais em decimais."
    echo ""
    echo ""
    echo "USO:"
    echo "----"
    echo ""
    echo "Digite um valor hexadecimal ou:"
    echo ""
    echo "- Use -b para leitura de bytes separados por espaços. Ex. FF FF FF"
    echo "- Use -n para exibir somente o resultado decimal."
    echo ""
}


erro_generico() {
    echo "Valor inválido."
    echo "Confira o número hexadecimal ou a sintaxe do programa."
    echo ""
}


hextodec(){
    NORMALIZE=$(echo $@ | tr '[:lower:]' '[:upper:]' | sed "s/ //g")

    if [[ $NOHEX != 1 ]]
    then
        echo -en "\033[1;4;31m$NORMALIZE \033[0m"
    fi

    DEC=$(bc <<< "ibase=16;$NORMALIZE")
    printf '\033[4;41m%3d\033[0m' $DEC
}


# Sem argumento, exibe o banner
if [[ $# -eq 0 ]] 
then
    banner
    exit 0
fi

# Inicia loop de argumentos
while test -n "$1"
do
    case "$1" in

        -n ) export NOHEX=1   ;;
        -b ) export ONEBITE=1 ;; 
         * ) if ! [[ "$@" =~ [^a-fA-F0-9\ ] ]]
             then
                 export HEX=$@
                 break 
             else
                 # avisa se digitou hex ou argumento incorreto
                 erro_generico
                 exit 1
             fi
             ;;
    esac

    shift
done

# loop hex separados por espaço
if [[ $ONEBITE == 1 ]]
then
    for i in $HEX                    
    do
       hextodec $i
       echo -n " "
    done
else
    # calculo total de hex, sem espaços
    hextodec $HEX 
fi
