ARCHS = arm64
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomSiriBG
$(TWEAK_NAME)_FILES = $(wildcard *.xm *.m)
$(TWEAK_NAME)_LIBRARIES = imagepicker
$(TWEAK_NAME)_LDFLAGS += -lCSPreferencesProvider
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += customsiribg
include $(THEOS_MAKE_PATH)/aggregate.mk
