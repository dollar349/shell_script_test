#!/bin/bash

FLASH_SIZE="65536"
FLASH_UBOOT_OFFSET="0"
FLASH_KERNEL_OFFSET="2048"
FLASH_ROFS_OFFSET="10240"
FLASH_RWFS_OFFSET="57344"
FLASH_RWFS_SIZE="8192"

START_OFFSET="0x200000"

DTS_FILE="aspeed-ast2600-evb.dts"

kernel_offset=$((${FLASH_KERNEL_OFFSET} * 1024))
kernel_size=$(( (${FLASH_ROFS_OFFSET} - ${FLASH_KERNEL_OFFSET}) * 1024 ))
kernel_offset_16=`printf '%x' ${kernel_offset}`
kernel_size_16=`printf '%x' ${kernel_size}`

rofs_offset=$((${FLASH_ROFS_OFFSET} * 1024))
rofs_size=$(( (${FLASH_RWFS_OFFSET} - ${FLASH_ROFS_OFFSET}) * 1024 ))
rofs_offset_16=`printf '%x' ${rofs_offset}`
rofs_size_16=`printf '%x' ${rofs_size}`

rwfs_offset=$((${FLASH_RWFS_OFFSET} * 1024))
rwfs_size=$(( (${FLASH_SIZE} - ${FLASH_RWFS_OFFSET}) * 1024 ))
rwfs_offset_16=`printf '%x' ${rwfs_offset}`
rwfs_size_16=`printf '%x' ${rwfs_size}`

line=`grep -n 'kernel@' ${DTS_FILE} | cut -d: -f1 | tail -1`
sed -i "${line}s/kernel@.*/kernel@${kernel_offset_16} {/" ${DTS_FILE}
regline=$((line+1))
sed -i "${regline}s/reg = .*/reg = <0x$kernel_offset_16 0x$kernel_size_16>;/" ${DTS_FILE}

line=`grep -n 'rofs@' ${DTS_FILE} | cut -d: -f1 | tail -1`
sed -i "${line}s/rofs@.*/rofs@${rofs_offset_16} {/" ${DTS_FILE}
regline=$((line+1))
sed -i "${regline}s/reg = .*/reg = <0x$rofs_offset_16 0x$rofs_size_16>;/" ${DTS_FILE}

line=`grep -n 'rwfs@' ${DTS_FILE} | cut -d: -f1 | tail -1`
sed -i "${line}s/rwfs@.*/rwfs@${rwfs_offset_16} {/" ${DTS_FILE}
regline=$((line+1))
sed -i "${regline}s/reg = .*/reg = <0x$rwfs_offset_16 0x$rwfs_size_16>;/" ${DTS_FILE}

