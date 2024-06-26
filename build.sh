#!/bin/bash
DL="https://github.com/openipc/firmware/releases/download/latest"

if [[ "$1" == *"-star6b0" ]]; then
	CC=cortex_a7_thumb2_hf-gcc13-musl-4_9
elif [[ "$1" == *"-star6e" ]]; then
	CC=cortex_a7_thumb2_hf-gcc13-glibc-4_9
else
	CC=cortex_a7_thumb2-gcc13-musl-4_9
fi

GCC=$PWD/toolchain/$CC/bin/arm-linux-gcc

if [ ! -e toolchain/$CC ]; then
	wget -c -q --show-progress $DL/$CC.tgz -P $PWD
	mkdir -p toolchain/$CC
	tar -xf $CC.tgz -C toolchain/$CC --strip-components=1 || exit 1
	rm -f $CC.tgz
fi

if [ ! -e firmware ]; then
	git clone https://github.com/openipc/firmware --depth=1
fi

if [ "$1" = "osd-goke" ]; then
	DRV=$PWD/firmware/general/package/goke-osdrv-gk7205v200/files/lib
	make -C osd -B CC=$GCC DRV=$DRV $1
elif [ "$1" = "osd-hisi" ]; then
	DRV=$PWD/firmware/general/package/hisilicon-osdrv-hi3516ev200/files/lib
	make -C osd -B CC=$GCC DRV=$DRV $1
elif [ "$1" = "osd-star6b0" ]; then
	DRV=$PWD/firmware/general/package/sigmastar-osdrv-infinity6b0/files/lib
	make -C osd -B CC=$GCC DRV=$DRV $1
elif [ "$1" = "osd-star6e" ]; then
	DRV=$PWD/firmware/general/package/sigmastar-osdrv-infinity6e/files/lib
	make -C osd -B CC=$GCC DRV=$DRV $1
else
	echo "Usage: $0 [osd-goke|osd-hisi|osd-star6b0|osd-star6e]"
	exit 1
fi
