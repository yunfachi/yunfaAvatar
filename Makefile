PREFIX = /usr
MANDIR = $(PREFIX)/share/man

all:
	@echo Run \'make install\' to install yunfaAvatar.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(MANDIR)/man1
	@cp -p yunfaavatar $(DESTDIR)$(PREFIX)/bin/yunfaavatar
	@cp -p -r services $(DESTDIR)$(PREFIX)/bin/services
	@cp -p -r utils $(DESTDIR)$(PREFIX)/bin/utils
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/yunfaavatar

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/yunfaavatar
	@rm -rf $(DESTDIR)$(PREFIX)/bin/services
	@rm -rf $(DESTDIR)$(PREFIX)/bin/utils