PREFIX ?= /usr/local

.PHONY: install test exemplos clean

install:
	install -m 755 bin/carlosc $(PREFIX)/bin/carlosc
	install -m 755 src/carlos.sh $(PREFIX)/bin/carlos-transpilador
	install -m 644 lib/carlinho.h $(PREFIX)/include/carlinho.h
	@echo "Carlos instalado! Use: carlosc programa.carlos"

test:
	bash testes/rodar_testes.sh

exemplos:
	@for ex in exemplos/*.carlos; do \
		echo "Compilando exemplo"; bashbin/carlosc"ex..."; \
		bash bin/carlosc "exemplo"; bashbin/carlosc"ex" || exit 1; \
	done
	@echo "Todos os exemplos compilaram!"

clean:
	rm -f exemplos/*.cpp exemplos/adivinhacao exemplos/ola exemplos/lacos exemplos/condicionais
	rm -f /tmp/teste_*.cpp /tmp/teste_*
