PREFIX = /usr

all:
	@echo Run \'make install\' to install yunfaAvatar.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/lib
	@cp -p yunfaavatar $(DESTDIR)$(PREFIX)/lib/yunfaavatar
	@cp -p -r services $(DESTDIR)$(PREFIX)/lib/services
	@cp -p -r utils $(DESTDIR)$(PREFIX)/lib/utils
	@chmod 755 $(DESTDIR)$(PREFIX)/lib/yunfaavatar
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@ln -s $(DESTDIR)$(PREFIX)/lib/yunfaavatar $(DESTDIR)$(PREFIX)/bin/yunfaavatar

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/lib/yunfaavatar
	@rm -rf $(DESTDIR)$(PREFIX)/lib/services
	@rm -rf $(DESTDIR)$(PREFIX)/lib/utils
