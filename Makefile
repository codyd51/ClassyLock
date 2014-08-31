ARCHS = armv7
GO_EASY_ON_ME=1
include theos/makefiles/common.mk

TWEAK_NAME = ClassyLock
ClassyLock_FILES = Tweak.xm
ClassyLock_FRAMEWORKS = UIKit CoreText CoreGraphics CoreData
ClassyLock_PRIVATE_FRAMEWORKS = Preferences Weather CoreText
ClassyLock_CFLAGS = -fobjc-arc
ClassyLock_ICON = ClassyLock.png

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += classylock
include $(THEOS_MAKE_PATH)/aggregate.mk
