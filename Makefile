PREFIX = /usr

all:
	@echo Run \'make install\' to install yunfaAvatar.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/opt
	@cp -p yunfaavatar $(DESTDIR)$(PREFIX)/opt/yunfaavatar
	@cp -p -r services $(DESTDIR)$(PREFIX)/opt/services
	@cp -p -r utils $(DESTDIR)$(PREFIX)/opt/utils
	@chmod 755 $(DESTDIR)$(PREFIX)/opt/yunfaavatar
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@ln -s $(DESTDIR)$(PREFIX)/opt/yunfaavatar $(DESTDIR)$(PREFIX)/bin/yunfaavatar

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/opt/yunfaavatar
	@rm -rf $(DESTDIR)$(PREFIX)/opt/services
	@rm -rf $(DESTDIR)$(PREFIX)/opt/utils
