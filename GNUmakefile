all::
RSYNC_DEST := yhbt.net:/srv/yhbt/mall
mall_c := ext/mall/mall.c
pkg_extra += $(mall_c)
$(mall_c): $(mall_c).erb
	erb < $< > $@+
	mv $@+ $@
rfpackage := mall
doc:: $(mall_c)
include pkg.mk
$(ext_pfx)/$(ext)/mall.c: $(mall_c)
$(ext_pfx)/$(ext)/Makefile: $(ext_pfx)/$(ext)/mall.c
