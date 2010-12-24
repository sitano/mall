RUBY = ruby
RSYNC = rsync
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
	$(RUBY) -Iext/mall -rmall test/test_mall.rb

pkg_extra := ChangeLog LATEST NEWS
doc: .document .wrongdoc.yml ext/mall/mall.c
	find ext -type f -name '*.rbc' -exec rm -f '{}' ';'
	$(RM) -r doc
	wrongdoc all
	install -m644 COPYING doc/
	install -m644 $(shell grep '^[A-Z]' .document) doc/

.manifest: ChangeLog
	(git ls-files && for i in $@ $(pkg_extra); do echo $$i; done) | \
	  LC_ALL=C sort > $@+
	mv $@+ $@

publish_doc:
	-git set-file-times
	$(MAKE) doc
	find doc/images -type f | \
		TZ=UTC xargs touch -d '1970-01-01 00:00:02' doc/rdoc.css
	chmod 644 $$(find doc -type f)
	$(RSYNC) -av doc/ bogomips.org:/srv/bogomips/mall/
	git ls-files | xargs touch

ifneq ($(VERSION),)
rfproject := qrp
rfpackage := mall
pkggem := pkg/$(rfpackage)-$(VERSION).gem
pkgtgz := pkg/$(rfpackage)-$(VERSION).tgz
release_notes := release_notes-$(VERSION)
release_changes := release_changes-$(VERSION)

release-notes: $(release_notes)
release-changes: $(release_changes)
$(release_changes):
	wrongdoc release_changes > $@+
	$(VISUAL) $@+ && test -s $@+ && mv $@+ $@
$(release_notes):
	wrongdoc release_notes > $@+
	$(VISUAL) $@+ && test -s $@+ && mv $@+ $@

# ensures we're actually on the tagged $(VERSION), only used for release
verify:
	test x"$(shell umask)" = x0022
	git rev-parse --verify refs/tags/v$(VERSION)^{}
	git diff-index --quiet HEAD^0
	test `git rev-parse --verify HEAD^0` = \
	     `git rev-parse --verify refs/tags/v$(VERSION)^{}`

fix-perms:
	-git ls-tree -r HEAD | awk '/^100644 / {print $$NF}' | xargs chmod 644
	-git ls-tree -r HEAD | awk '/^100755 / {print $$NF}' | xargs chmod 755

gem: $(pkggem)

install-gem: $(pkggem)
	gem install $(CURDIR)/$<

$(pkggem): manifest fix-perms
	gem build $(rfpackage).gemspec
	mkdir -p pkg
	mv $(@F) $@

$(pkgtgz): distdir = $(basename $@)
$(pkgtgz): HEAD = v$(VERSION)
$(pkgtgz): manifest fix-perms
	@test -n "$(distdir)"
	$(RM) -r $(distdir)
	mkdir -p $(distdir)
	tar cf - `cat .manifest` | (cd $(distdir) && tar xf -)
	cd pkg && tar cf - $(basename $(@F)) | gzip -9 > $(@F)+
	mv $@+ $@

package: $(pkgtgz) $(pkggem)

test-release: verify package $(release_notes) $(release_changes)
release: verify package $(release_notes) $(release_changes)
	# make tgz release on RubyForge
	rubyforge add_release -f -n $(release_notes) -a $(release_changes) \
	  $(rfproject) $(rfpackage) $(VERSION) $(pkgtgz)
	# push gem to RubyGems.org
	gem push $(pkggem)
	# in case of gem downloads from RubyForge releases page
	-rubyforge add_file \
	  $(rfproject) $(rfpackage) $(VERSION) $(pkggem)
else
gem install-gem: GIT-VERSION-FILE
	$(MAKE) $@ VERSION=$(GIT_VERSION)
endif

.PHONY: test doc
