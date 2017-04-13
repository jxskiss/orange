TO_INSTALL = orange
ORANGE_HOME ?= /usr/local/openresty
ORANGE_BIN ?= /usr/local/bin/orange

.PHONY: test install show
init-config:
	@ test -f conf/nginx.conf   || (cp conf/nginx.conf.example conf/nginx.conf && echo "copy nginx.conf")
	@ test -f conf/orange.conf  || (cp conf/orange.conf.example conf/orange.conf && echo "copy orange.conf")

test:
	@echo "to be continued..."

install:init-config
	@rm -rf $(ORANGE_BIN)
	@rm -rf $(ORANGE_HOME)
	@mkdir -p $(ORANGE_HOME)

	@for item in $(TO_INSTALL) ; do \
		cp -a $$item $(ORANGE_HOME)/; \
	done;

	@echo "#!/usr/bin/env resty" >> $(ORANGE_BIN)
	@echo "package.path=\"$(ORANGE_HOME)/?.lua;;\" .. package.path" >> $(ORANGE_BIN)
	@echo "require(\"orange.bin.main\")(arg)" >> $(ORANGE_BIN)
	@chmod +x $(ORANGE_BIN)
	@echo "Orange installed."
	@orange help

show:
	@orange help
