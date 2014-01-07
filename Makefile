export TARGET = iphone:clang:7.0:7.0
export ARCHS = armv7 armv7s arm64
include theos/makefiles/common.mk

TWEAK_NAME = DarkBoard
DarkBoard_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
