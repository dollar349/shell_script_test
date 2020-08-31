#!/usr/bin/python3

FLASH_SIZE=int("65536")
FLASH_UBOOT_OFFSET=int("0")
FLASH_KERNEL_OFFSET=int("2048")
FLASH_ROFS_OFFSET=int("10240")
FLASH_RWFS_OFFSET=int("57344")
FLASH_RWFS_SIZE=int("8192")

kernel_start=FLASH_KERNEL_OFFSET * 1024
kernel_size=(FLASH_ROFS_OFFSET - FLASH_KERNEL_OFFSET) * 1024
rootfs_start=FLASH_ROFS_OFFSET * 1024
rootfs_size=(FLASH_RWFS_OFFSET - FLASH_ROFS_OFFSET) * 1024
rwfs_start=FLASH_RWFS_OFFSET * 1024
rwfs_size=(FLASH_RWFS_SIZE) * 1024

f="aspeed-common.h"
import re
f1=open(f, 'r')
new_f=str()
for line in f1:
    if '"kernel_start=' in line:
        new_f+=re.sub('=0x.*','=0x{:x}\\\\0" \\\\'.format(kernel_start),line)
    elif '"kernel_size=' in line:
        new_f+=re.sub('=0x.*','=0x{:x}\\\\0" \\\\'.format(kernel_size),line)
    elif '"rootfs_start=' in line:
        new_f+=re.sub('=0x.*','=0x{:x}\\\\0" \\\\'.format(rootfs_start),line)
    elif '"rootfs_start=' in line:
        new_f+=re.sub('=0x.*','=0x{:x}\\\\0" \\\\'.format(rootfs_start),line)
    elif '"rootfs_size=' in line:
        new_f+=re.sub('=0x.*','=0x{:x}\\\\0" \\\\'.format(rootfs_size),line)
    elif '"rwfs_start=' in line:
        new_f+=re.sub('=0x.*','=0x{:x}\\\\0" \\\\'.format(rwfs_start),line)
    elif '"rwfs_size=' in line:
        new_f+=re.sub('=0x.*','=0x{:x}\\\\0" \\\\'.format(rwfs_size),line)
    else:
        new_f+=line

f1.close()
f1=open(f, 'w')
f1.write(new_f)
f1.close()
