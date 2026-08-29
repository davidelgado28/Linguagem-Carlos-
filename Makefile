PREFIX ?= /usr/local

install:
	cp bin/carlosc $(PREFIX)/bin/
	cp src/carlos.sh $(PREFIX)/bin/carlos-transpilador
	cp lib/carlinho.h $(PREFIX)/include/

test	bash testes/rodar_testes.sh

clean:
	rm -f exemplos/*.cpp exemplos/*.o
