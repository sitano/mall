all::
RSYNC_DEST := bogomips.org:/srv/bogomips/mall
pkg_extra += ext/mall/mall.c
ext/mall/mall.c: ext/mall/mall.c.erb
	erb < $< > $@+
	mv $@+ $@
rfproject := qrp
rfpackage := mall
include pkg.mk
