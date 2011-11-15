# makefile to create various emulator builds
# Note: -arch ppc requires /Developer/SDKs/MacOSX10.4u.sdk

REV=${shell hg id -n}

.PHONY:	broken em emp debug debugp trace tracep vfy vfyp fixed fixedp demo demop dongle lmserver magrst parts smad smag mtread mtwrite

em:     # production (Intel)

	cc -arch i686 -DREV=\"${REV}\" -DNOREGS -DNOTRACE -DFAST -DNOMEM -O -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/Universal/api;g++ -arch i686 -o em em.o dongle/mx/Universal/api/libmxmac260.a -framework IOKit -framework CoreFoundation
	strip em
	rm em.o


emp:    # production (PowerPC)

	cc -arch ppc -DREV=\"${REV}\" -DNOTRACE -DFAST -DNOMEM -O -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/ppc/api;g++ -arch ppc -o em em.o dongle/mx/ppc/api/libmxmac260.a -framework IOKit -framework CoreFoundation
	strip em
	rm em.o


debug:   # gdb (Intel)

	cc -arch i686 -DREV=\"${REV}\" -DNOREGS -g -O0 -DNOTRACE -DFAST -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/Universal/api;g++ -arch i686 -o em em.o dongle/mx/Universal/api/libmxmac260.a -framework IOKit -framework CoreFoundation
	rm em.o


debugp:  # gdb (PowerPC)

	cc -arch ppc -DREV=\"${REV}\" -DNOREGS -g -O0 -DNOTRACE -DFAST -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/ppc/api;g++ -arch ppc -o em em.o dongle/mx/ppc/api/libmxmac260.a -framework IOKit -framework CoreFoundation
	rm em.o


trace:   # tracing + gdb (Intel)

	cc -arch i686 -DREV=\"${REV}\" -DNOREGS -g -O0 -DFAST -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/Universal/api;g++ -arch i686 -o em em.o dongle/mx/Universal/api/libmxmac260.a -framework IOKit -framework CoreFoundation


tracep: # tracing + gdb (PowerPC)

	cc -arch ppc -DREV=\"${REV}\" -DNOREGS -g -O0 -DNOFAST -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/ppc/api;g++ -arch ppc -o em em.o dongle/mx/ppc/api/libmxmac260.a -framework IOKit -framework CoreFoundation


vfy:   # prod + tracing to verify em changes (Intel)

	cc -arch i686 -DREV=\"\" -O -DNOREGS -DFAST -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/Universal/api;g++ -arch i686 -o em em.o dongle/mx/Universal/api/libmxmac260.a -framework IOKit -framework CoreFoundation


vfyp: # prod + tracing to verify em changes (PowerPC)

	cc -arch ppc -DREV=\"\" -O -DFAST -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/ppc/api;g++ -arch ppc -o em em.o dongle/mx/ppc/api/libmxmac260.a -framework IOKit -framework CoreFoundation


fixed:  # fixed clock rate, gdb (Intel)

	cc -arch i686 -DREV=\"${REV}\" -DFIXEDCLOCK -DNOIDLE -DNOREGS -g -O0 -DFAST -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/Universal/api;g++ -arch i686 -o em em.o dongle/mx/Universal/api/libmxmac260.a -framework IOKit -framework CoreFoundation
	rm em.o


fixedp: # fixed clock rate, gdb (PowerPC)

	cc -arch ppc -DREV=\"${REV}\" -DFIXEDCLOCK -DNOIDLE -DNOREGS -g -O0 -DFAST -c em.c -fobey-inline -mdynamic-no-pic -Idongle/mx/ppc/api;g++ -arch ppc -o em em.o dongle/mx/ppc/api/libmxmac260.a -framework IOKit -framework CoreFoundation
	rm em.o


demo:  # demo (limited: 1-2 amlc, 1 disk drive up to 160MB, one PNC node) (Intel)

	cc -DREV=\"${REV}\" -DNOREGS -DDEMO -DNOTRACE -DFAST -O em.c -fobey-inline -mdynamic-no-pic -o em
	strip em


demop: # demo (PowerPC)

	cc -mmacosx-version-min=10.4 -fno-stack-protector -arch ppc -DREV=\"${REV}\" -DNOREGS -DDEMO -DNOTRACE -DFAST -O em.c -fobey-inline -mdynamic-no-pic -o em
	strip em


dongle: # utility to program a dongle

	cc -arch ppc -DREV=\"${REV}\" -c dongle.c -Idongle/mx/ppc/api;g++ -arch ppc -o dongle dongle.o dongle/mx/ppc/api/libmxmac260.a -framework IOKit -framework CoreFoundation
	rm dongle.o


lmserver: # license server

	cc -arch ppc -DREV=\"${REV}\" -c lmserver.c -Idongle/mx/ppc/api;g++ -arch ppc lmserver.o -o lmserver dongle/mx/ppc/api/libmxmac260.a -framework IOKit -framework CoreFoundation
	rm lmserver.o

mtread: # Dump a tape to a .tap disk file (Linux only)

	cc -o mtread mtread.c


mtwrite: # write a physical tape from a .tap file (Linux only)

	cc -o mtwrite mtwrite.c


magrst: # Unix version of Prime's magrst

	cc -arch ppc -DREV=\"${REV}\" -o magrst magrst.c istext.c


parts: # Unix utility to determine parttions in a drive file

	cc -arch ppc -DREV=\"${REV}\" -o parts parts.c


smad: # Unix utility to decode Prime pdev

	cc -arch ppc -DREV=\"${REV}\" -o smad smad.c

smag: # Unix create Prime pdev

	cc -arch ppc -DREV=\"${REV}\" -o smag smag.c

broken: # production (Intel)

	cc -arch i686 -O -c broken.c -fobey-inline -mdynamic-no-pic -Idongle/mx/Universal/api;g++ -arch i686 -o broken broken.o dongle/mx/Universal/api/libmxmac260.a -framework IOKit -framework CoreFoundation

brokenp: # production (Intel)

	cc -arch ppc -O -c broken.c -fobey-inline -mdynamic-no-pic -Idongle/mx/Universal/api;g++ -arch ppc -o brokenp broken.o dongle/mx/Universal/api/libmxmac260.a -framework IOKit -framework CoreFoundation

brokeno: # production (Intel)

	cc -arch ppc -O -c broken.c -fobey-inline -mdynamic-no-pic -Idongle/mx.orig/ppc/api;g++ -arch ppc -o brokeno broken.o dongle/mx.orig/ppc/api/libmxmac260.a -framework IOKit -framework CoreFoundation

brokenf: # production (Intel)

	cc -arch i686 -O -c broken.c -Idongle/mx.fix/Universal/api;g++ -arch i686 -o brokenf broken.o dongle/mx.fix/Universal/api/libmxmac260.a -framework IOKit -framework CoreFoundation


