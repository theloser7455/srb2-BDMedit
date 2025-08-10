# SRB2 - Which DLLs do I need to bundle?

Updated 12/6/2019 (v2.2)

Here are the required DLLs, per build. For each architecture, copy all the binaries from these folders:

* libs\dll-binaries\x86_64\exchndl.dll
* libs\dll-binaries\x86_64\libgme.dll
* libs\dll-binaries\x86_64\mgwhelp.dll (depend for exchndl.dll)
* libs\SDL2\x86_64-w64-mingw32\bin\SDL2.dll
* libs\SDLMixerX\x86_64-w64-mingw32\bin\*.dll (get everything)
* libs\libopenmpt\bin\x86_64\mingw\libopenmpt.dll
* libs\curl\lib64\libcurl-x64.dll

and don't forget to build r_opengl.dll for srb2dd.
