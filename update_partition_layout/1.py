#!/usr/bin/python3

FLASH_SIZE=int("65536")
FLASH_UBOOT_OFFSET=int("0")
FLASH_KERNEL_OFFSET=int("2048")
FLASH_ROFS_OFFSET=int("10240")
FLASH_RWFS_OFFSET=int("57344")
FLASH_RWFS_SIZE=int("8192")

kernel_offset=FLASH_KERNEL_OFFSET * 1024
kernel_size=(FLASH_ROFS_OFFSET - FLASH_KERNEL_OFFSET) * 1024
rofs_offset=FLASH_ROFS_OFFSET * 1024
rofs_size=(FLASH_RWFS_OFFSET - FLASH_ROFS_OFFSET) * 1024
rwfs_offset=FLASH_RWFS_OFFSET * 1024
rwfs_size=(FLASH_RWFS_SIZE) * 1024

DTS_FILE="aspeed-ast2600-evb.dts"
import re
f1=open(DTS_FILE, 'r')
new_dts=str()
for line in f1:
    if 'kernel@' in line:
        new_dts+=re.sub('kernel@.*','kernel@{:x} {{'.format(kernel_offset),line)
        new_dts+=re.sub('reg =.*','reg = <0x{:x} 0x{:x}>;'.format(kernel_offset,kernel_size),f1.readline())
    elif 'rofs@' in line:
        new_dts+=re.sub('rofs@.*','rofs@{:x} {{'.format(rofs_offset),line)
        new_dts+=re.sub('reg =.*','reg = <0x{:x} 0x{:x}>;'.format(rofs_offset,rofs_size),f1.readline())
    elif 'rwfs@' in line:
        new_dts+=re.sub('rwfs@.*','rwfs@{:x} {{'.format(rwfs_offset),line)
        new_dts+=re.sub('reg =.*','reg = <0x{:x} 0x{:x}>;'.format(rwfs_offset,rwfs_size),f1.readline())
    else:
        new_dts+=line

f1.close()
f1=open(DTS_FILE, 'w')
f1.write(new_dts)
f1.close()
