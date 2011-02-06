all::
RSYNC_DEST := bogomips.org:/srv/bogomips/mall
mall_c := ext/mall/mall.c
pkg_extra += $(mall_c)
$(mall_c): $(mall_c).erb
	erb < $< > $@+
	mv $@+ $@
rfproject := qrp
rfpackage := mall
include pkg.mk
$(ext_pfx)/$(ext)/mall.c: $(mall_c)
$(ext_pfx)/$(ext)/Makefile: $(ext_pfx)/$(ext)/mall.c
