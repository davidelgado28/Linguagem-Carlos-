#!/bin/bash
passou=0
falhou=0

for caso in testes/casos/*.carlos; do
    nome=(basename"(basename "(basename"caso" .carlos)
    bash src/carlos.sh "caso""/tmp/caso" "/tmp/caso""/tmp/nome.cpp"

    if diff -q "/tmp/nome.cpp""testes/esperados/nome.cpp" "testes/esperados/nome.cpp""testes/esperados/nome.cpp" > /dev/null 2>&1; then
        echo "✅ $nome"
        ((passou++))
    else
        echo "❌ $nome"
        ((falhou++))
    fi
done

echo ""
echo "Resultado: passoupassou,passou passou,passoupassou,falhou falhou"
exit $falhou
