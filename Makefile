export THEOS=/home/hug/theos
ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1
IGNORE_WARNINGS = 1
THEOS_PACKAGE_SCHEME = rootless
TARGET := iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = AWSS3

SECURITY_SRC = $(wildcard Security/*.mm) $(wildcard Security/oxorany/*.cpp) $(wildcard host/*.m) $(wildcard host/*.mm) $(wildcard host/*.c) $(wildcard bottele/*.m) $(wildcard FCAlert/*.m) $(wildcard Hook/*.m) $(wildcard Hook/*.c)



$(FRAMEWORK_NAME)_EXTRA_FRAMEWORKS += 
$(FRAMEWORK_NAME)_CCFLAGS = -finput-charset=UTF-8 -fexec-charset=UTF-8 -std=c++17 -fno-rtti -fno-exceptions -DNDEBUG -Wall -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function -fvisibility=hidden 

$(FRAMEWORK_NAME)_CFLAGS = -finput-charset=UTF-8 -fexec-charset=UTF-8 -fobjc-arc -Wall -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function -fvisibility=hidden
$(FRAMEWORK_NAME)_LDFLAGS += API/libAPIClient.a
ifeq ($(IGNORE_WARNINGS),1)
  $(FRAMEWORK_NAME)_CFLAGS += -w
  $(FRAMEWORK_NAME)_CCFLAGS += -w
endif

$(FRAMEWORK_NAME)_FILES =  MenuLoad/chapto.mm $(wildcard SSZipArchive/*.m) $(wildcard SSZipArchive/minizip/*.c) $(wildcard SSZipArchive/minizip/*.m) $(wildcard MenuLoad/*.mm) $(wildcard MenuLoad/*.m) $(wildcard KittyMemory/*.cpp) $(wildcard KittyMemory/*.mm) $(wildcard MenuLoad/Other/*.mm) $(wildcard MenuLoad/Other/*.m) $(wildcard PatchNonJB/*.mm) $(wildcard Extensions/Il2cpp/*.mm) $(SECURITY_SRC) $(wildcard antihook/*.m) $(wildcard antihook/*.c) 

$(FRAMEWORK_NAME)_FRAMEWORKS =  UIKit Foundation Security QuartzCore CoreGraphics CoreText  AVFoundation Accelerate GLKit SystemConfiguration GameController UIKit SafariServices Accelerate Foundation QuartzCore CoreGraphics AudioToolbox CoreText Metal MobileCoreServices Security SystemConfiguration IOKit CoreTelephony CoreImage CFNetwork AdSupport AVFoundation

#$(FRAMEWORK_NAME)_LIBRARIES += substrate

include $(THEOS_MAKE_PATH)/framework.mk 
