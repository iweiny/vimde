# simple makefile for all this stuff.

SCRIPTS = install.sh \
          mktags.sh \
			 vimde

SOURCES = realpath.c

DOCS = README

SUPPORT_FILES = s.gvimrc.raw

package: distclean
	tar czf vimde.tgz $(SCRIPTS) $(SOURCES) $(DOCS) $(SUPPORT_FILES)

realpath:
	$(CC) realpath.c -o realpath

distclean:
	$(RM) -rf realpath
