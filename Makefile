CSNAME="iPhone Developer"

DEVELOPER=/Applications/Xcode.app/Contents/Developer
PLATFORM=$(DEVELOPER)/Platforms/iPhoneOS.platform/Developer
SDKVER = $(shell ls $(PLATFORM)/SDKs/ | tail -n 1)
SDK=$(PLATFORM)/SDKs/$(SDKVER)

CC=$(PLATFORM)/usr/bin/arm-apple-darwin10-llvm-gcc-4.2 
CFLAGS=-ggdb -Wall -isysroot $(SDK) -I../include

MACOSX=$(DEVELOPER)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk/System/Library/Frameworks

PROGS= removePIE

all: $(PROGS)

removePIE: removePIE.o 
	$(CC) $(CFLAGS) -o $@ $^
	codesign -f -s $(CSNAME) --entitlements removePIE.xcent $@

clean:
	rm -rf *.o *.dSYM $(PROGS)

