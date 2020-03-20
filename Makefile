MIRAGE = mirage

mem-unix: DIR = in_memory
mem-unix: TARGET = unix
mem-unix: build

mem-osx: DIR = in_memory
mem-osx: TARGET = macosx
mem-osx: build

build: config depend
	$(MAKE) -C $(DIR)

config:
	cd $(DIR) && mirage configure \
	  -t $(TARGET) \
	  --dhcp true \
	  --net=direct
depend:
	$(MAKE) -C $(DIR) depend

clean:
	$(MAKE) -C in_memory clean
