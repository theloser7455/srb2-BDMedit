#
# Mingw, if you don't know, that's Win32/Win64
#

EXENAME?=srb2winBDM.exe

# disable dynamicbase if under msys2
ifdef MSYSTEM
libs+=-Wl,--disable-dynamicbase
endif

sources+=win32/Srb2win.rc
opts+=-DSTDC_HEADERS
libs+=-ladvapi32 -lkernel32 -lmsvcrt -luser32

ifndef DEDICATED
ifndef DUMMY
SDL?=1
endif
endif

ifndef NOHW
opts+=-DUSE_WGL_SWAP
endif


libs+=-lws2_32

mingw:=x86_64-w64-mingw32

define _set =
$(1)_CFLAGS?=$($(1)_opts)
$(1)_LDFLAGS?=$($(1)_libs)
endef

lib:=../libs/gme
LIBGME_opts:=-I$(lib)/include
LIBGME_libs:=-L$(lib)/win64 -lgme
$(eval $(call _set,LIBGME))

lib:=../libs/libopenmpt
LIBOPENMPT_opts:=-I$(lib)/inc
LIBOPENMPT_libs:=-L$(lib)/lib/x86_64/mingw -lopenmpt
$(eval $(call _set,LIBOPENMPT))

ifndef NOMIXERX
HAVE_MIXERX=1
lib:=../libs/SDLMixerX/$(mingw)
else
lib:=../libs/SDL2_mixer/$(mingw)
endif

ifdef SDL
mixer_opts:=-I$(lib)/include/SDL2
mixer_libs:=-L$(lib)/lib

lib:=../libs/SDL2/$(mingw)
SDL_opts:=-I$(lib)/include/SDL2\
	$(mixer_opts) -Dmain=SDL_main
SDL_libs:=-L$(lib)/lib $(mixer_libs)\
	-lmingw32 -lSDL2main -lSDL2 -mwindows
$(eval $(call _set,SDL))
endif

lib:=../libs/zlib
ZLIB_opts:=-I$(lib)
ZLIB_libs:=-L$(lib)/win32 -lz64
$(eval $(call _set,ZLIB))

ifndef PNG_CONFIG
lib:=../libs/libpng-src
PNG_opts:=-I$(lib)
PNG_libs:=-L$(lib)/projects -lpng64
$(eval $(call _set,PNG))
endif

lib:=../libs/curl
CURL_opts:=-I$(lib)/include
CURL_libs:=-L$(lib)/lib64 -lcurl
$(eval $(call _set,CURL))

lib:=../libs/miniupnpc
MINIUPNPC_opts:=-I$(lib)/include -DMINIUPNP_STATICLIB
MINIUPNPC_libs:=-L$(lib)/mingw64 -lminiupnpc -lws2_32 -liphlpapi
$(eval $(call _set,MINIUPNPC))
