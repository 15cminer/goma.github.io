#!/bin/bash
read -d '' GOMA_PATCH << "EOF"
24c24
< GOMA_LIBS = /home/goma/production/$(ARCH)
---
> GOMA_LIBS = /home/cminer/test/gomaLib
55c55
< SEACAS_TOP = $(GOMA_LIBS)/SEACAS-2013-12-03
---
> SEACAS_TOP = $(GOMA_LIBS)/Seacas-2013-12-03
64c64,68
< PREFIX = /home/goma/build
---
> PREFIX = /home/cminer/test/goma/build
> 
> FRONT_LIB =
> 
> UMFPACK_TOP = $(GOMA_LIBS)/UMFPACK-5.4/UMFPACK

EOF

read -d '' BRKFIX_PATCH << "EOF"
29c29
<            ACCESS = /projects/seacas/linux_rhel6/current
---
>            ACCESS = /home/cminer/test/gomaLib/Seacas-2013-12-03

EOF

git clone https://github.com/goma/goma.git
cd goma
mv settings.mk-example settings.mk
echo "$GOMA_PATCH" > goma.patch
patch settings.mk < goma.patch
make
make install
git clone https://github.com/goma/brkfix.git
cd brkfix
echo "$BRKFIX_PATCH" > brkfix.patch
patch Makefile < brkfix.patch
make
#./home/goma/guts/scripts/guts -m none -g /home/goma/goma/bin/goma
cd ../../
mkdir happy