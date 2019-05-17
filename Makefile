ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomSiriBG
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei
$(TWEAK_NAME)_LIBRARIES = imagepicker
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += customsiribg
include $(THEOS_MAKE_PATH)/aggregate.mk