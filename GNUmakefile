
all: ext/mall/mall.so

ext/mall/Makefile: ext/mall/mall.c ext/mall/extconf.rb
	cd ext/mall && ruby extconf.rb

ext/mall/mall.so: ext/mall/Makefile
	$(MAKE) -C ext/mall

ext/mall/mall.c: ext/mall/mall.c.erb
	erb < $< > $@+
	mv $@+ $@
clean:
	-$(MAKE) -C ext/mall clean

test: ext/mall/mall.so
	ruby -Iext/mall -rmall test/test_mall.rb

# using rdoc 2.4.1
doc: .document
	rdoc -Na -m README.txt -t "$(shell sed -ne '1s/^= //p' README.txt)"
.PHONY: test doc
