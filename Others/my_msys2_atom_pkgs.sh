#!/bin/sh

# package source
echo "##
## MSYS2 repository mirrorlist
##

## Primary
## msys2.org
Server = http://mirrors.ustc.edu.cn/msys2/REPOS/MSYS2/$arch
Server = http://mirror.bit.edu.cn/msys2/REPOS/MSYS2/$arch" > /etc/pacman.d/mirrorlist.msys ;

echo "##
##
## 32-bit Mingw-w64 repository mirrorlist
##

## Primary
## msys2.org
Server = http://mirrors.ustc.edu.cn/msys2/REPOS/MINGW/i686
Server = http://mirror.bit.edu.cn/msys2/REPOS/MINGW/i686" > /etc/pacman.d/mirrorlist.mingw32 ;

echo "##
## 64-bit Mingw-w64 repository mirrorlist
##

## Primary
## msys2.org
Server = http://mirrors.ustc.edu.cn/msys2/REPOS/MINGW/x86_64
Server = http://mirror.bit.edu.cn/msys2/REPOS/MINGW/x86_64" > /etc/pacman.d/mirrorlist.mingw64 ;

# utils
pacman -S curl wget tar vim zip unzip rsync openssh;

# utils optional
pacman -S p7zip texinfo lzip;

# dev
pacman -S cmake m4 autoconf automake python git make;

# gcc
pacman -S gcc gdb;

# mingw x86_64
pacman -S mingw-w64-x86_64-toolchain mingw-w64-x86_64-libtool;

# mingw i686
pacman -S mingw-w64-i686-toolchain  mingw-w64-i686-libtool;

# clang x86_64
pacman -S mingw64/mingw-w64-x86_64-compiler-rt mingw64/mingw-w64-x86_64-clang mingw64/mingw-w64-x86_64-clang-analyzer mingw64/mingw-w64-x86_64-clang-tools-extra;

# clang i686
pacman -S mingw32/mingw-w64-i686-clang mingw32/mingw-w64-i686-clang-analyzer mingw32/mingw-w64-i686-clang-tools-extra mingw32/mingw-w64-i686-compiler-rt;

# ruby
pacman -S ruby;

# atom = mingw + clang + dev + git-scm
# git can be found in https://git-scm.com, for example https://github.com/git-for-windows/git/releases/download/v2.7.4.windows.1/Git-2.7.4-64-bit.exe
# my atom config use these binaries:
## gcc,clang: msys2/mingw64, C:\msys64\mingw64\\bin\[gcc or clang].exe
## lua: C:\Program Files\Lua\luac5.1.exe
## pandoc: C:\Program Files (x86)\Pandoc\pandoc.exe

apm config set git "C:\Program Files\Git\bin\git.exe"
