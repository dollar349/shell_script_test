#!/bin/bash
FLASH_SIZE="65536"
FLASH_UBOOT_OFFSET="0"
FLASH_KERNEL_OFFSET="2048"
FLASH_ROFS_OFFSET="9216"
FLASH_RWFS_OFFSET="50176"
START_OFFSET="0x200000"

kernel_size=`expr \( ${FLASH_ROFS_OFFSET} - ${FLASH_KERNEL_OFFSET} \) \* 1024 `

rofs_start=$(( $START_OFFSET + ${kernel_size} ))
rofs_start_16="0x"`printf '%x' ${rofs_start}`



echo $rofs_start_16


