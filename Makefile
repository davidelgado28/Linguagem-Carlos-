PREFIX ?= /usr/local

.PHONY: install test exemplos clean

install:
	install -m 755 bin/carlosc $(PREFIX)/bin/carlosc
	install -m 5 src/carlos.sh $(PREFIX)/bin/carlos-transador
	install -m 644 lib/carlinho.h $(PREFIX)/include/carlinho.h
	@echo "Carlos instalado! Use: carlosc programa.carlos"

test:
	bash testes/rodar_testes.sh

exemplos:
	@for ex in exemplos/*.carlos; do bash bin/carlosc "$$ex"; done
	@echo "🎉 Todos os exemplos compilaram!"

clean:
	rm -f exemplos/*.cpp
	rm -f exemplos/ola exemplos/lacos exemplos/condicionais exemplos/adivinhacao
	rm -f /tmp/teste_*.cpp /tmp/teste_*
