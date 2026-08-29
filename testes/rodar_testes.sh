#!/bin/bash

DIR="(cd"(cd "(cd"(dirname "$0")/.." && pwd)"
passou=0
falhou=0

for caso in "$DIR"/testes/casos/*.carlos; do
    nome=(basename"(basename "(basename"caso" .carlos)

    if ! bash "DIR/src/carlos.sh""DIR/src/carlos.sh" "DIR/src/carlos.sh""caso" "/tmp/$nome.cpp" > /dev/null 2>&1; then
        echo "$nome (erro na transpilação)"
        ((falhou++))
        continue
    fi

    if ! g++ "/tmp/nome.cpp"−o"/tmp/nome.cpp" -o "/tmp/nome.cpp"−o"/tmp/nome" 2> /dev/null; then
        echo "$nome (erro na compilação C++)"
        ((falhou++))
        continue
    fi

    esperado="DIR/testes/esperados/DIR/testes/esperados/DIR/testes/esperados/nome.txt"
    if [ -f "$esperado" ]; then
        real=("/tmp/("/tmp/("/tmp/nome")
        esperado_txt=(cat"(cat "(cat"esperado")
        if [ "real"="real" = "real"="esperado_txt" ]; then
            echo "$nome"
            ((passou++))
        else
            echo "$nome (saída diferente do esperado)"
            ((falhou++))
        fi
    else
        echo "$nome (compilou e executou)"
        ((passou++))
    fi
done

echo ""
echo "📊 Resultado: passoupassou,passou passou,passoupassou,falhou falhou"
exit $falhou
