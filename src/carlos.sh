#!/bin/bash

set -e

if [ $# -lt 1 ]; then
    echo "Uso: $0 <arquivo.carlos> [saida.cpp]"
    exit 1
fi       

ENTRADA="$1"
SAIDA="{2:-{ENTRADA%.carlos}.cpp}"

if [ ! -f "$ENTRADA" ]; then
    echo "❌ Arquivo não encontrado: $ENTRADA"
    exit 1
fi

awk '
BEGIN {
    print "#include <iostream>"
    print "#include <string>"
    print "#include <vector>"
    print "#include <map    print "#include <set>"
    print "using namespace std;"
    print ""
    topo = 0
    linha_num = 0
}

function erro(msg) {
    printf "Erro de sintaxe na linha %d: %s\n", linha_num, msg > "/dev/stderr"
    exit 1
}

function fecha_blocos(nivel) {
    while (topo > 0 && nivel < pilha[topo]) {
        topo--
        printf "%*s}\n", pilha[topo], ""
    }
}

function converte_for(linha) {
    # for (a, b, c) -> for (a; b; c)
    sub(/^for *\(/, "", linha)
    sub(/\)[^)]*$/, "", linha)
    n = split(linha, partes, ",")
    if (n != 3) erro("for deve ter 3 partes: for (init, condicao, incremento)")
    resultado = "for ("
    for (i = 1; i <= n; i++) {
        gsub(/^ +| +$/, "", partes[i])
        resultado = resultado partes[i]
        if (i < n) resultado = resultado "; "
    }
    return resultado ")"
}

function envolve_condicao(conteudo, palavra) {
    # "if idade >= 18:" -> "if (idade >= 18):"
    sub("^" palavra " +", "", conteudo)
    sub(/:$/, "", conteudo)
    return palavra " (" conteudo "):"
}

{
    linha_num++
    linha = $0

    if (linha ~ /^[ \t]*$/) { print ""; next }

    match(linha, /^ */)
    nivel = RLENGTH
    conteudo = substr(linha, nivel + 1)

    # #include <carlinho.h> -> remove (header já está embutido)
    if (conteudo ~ /^#include *<carlinho.h>/) next
    if (conteudo ~ /^#include/) { printf "%s\n", conteudo; next }
    if (conteudo ~ /^using namespace/) next

    # Comentários: preserva
    if (conteudo ~ /^\/\//) {
        printf "%*s%s\n", nivel, "", conteudo
        next
    }

    fecha_blocos(nivel)

    # if / elif / while sem parênteses -> adiciona parênteses
    if (conteudo ~ /^if [^()]*:$/)  conteudo = envolve_condicao(conteudo, "if")
    if (conteudo ~ /^elif [^()]*:$/) conteudo = envolve_condicao(conteudo, "elif")
    if (conteudo ~ /^while [^()]*:$/) conteudo = envolve_condicao(conteudo, "while")

    # elif -> else if
    if (conteudo ~ /^else if/) sub(/^else if/, "else if", conteudo)
    if (conteudo ~ /^elif/) sub(/^elif/, "else if", conteudo)

    # else:
    if (conteudo ~ /^else:/)sub(/else:/) sub(/^else:/)sub(/else:/, "else:", conteudo)

    # match -> switch (mantém parênteses)
    if (conteudo ~ /^match *\(/) sub(/^match/, "switch", conteudo)

    # case _ -> default
    if (conteudo ~ /^case *_:$/) sub(/^case *_:/, "default:", conteudo)

    # for
    if (conteudo ~ /^for *\(/) conteudo = converte_for(conteudo)

    # Abre bloco: termina com ":"
    if (conteudo ~ /:$/) {
        sub(/:$/, " {", conteudo)
        pilha[++topo] = nivel
        printf "%*s%s\n", nivel, "", conteudo
        next
    }

    # Linha de comando simples -> ";"
    if (conteudo !~ /[{}]$/ && conteudo !~ /^}/) {
        conteudo = conteudo ";"
    }

    printf "%*s%s\n", nivel, "", conteudo
}

END {
    while (topo > 0) {
        topo--
        printf "%*s}\n", pilha[topo], ""
    }
}
' "ENTRADA">"ENTRADA" > "ENTRADA">"SAIDA"

echo "Gerado: $SAIDA"
