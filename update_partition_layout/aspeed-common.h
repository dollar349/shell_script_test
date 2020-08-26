/* SPDX-License-Identifier: GPL-2.0+ */
/*
 * Copyright (C) ASPEED Technology Inc.
 *
 * Copyright 2016 IBM Corporation
 * (C) Copyright 2016 Google, Inc
 */

#ifndef __ASPEED_COMMON_CONFIG_H
#define __ASPEED_COMMON_CONFIG_H

#include <asm/arch/platform.h>

#define CONFIG_BOOTFILE		"all.bin"

#define CONFIG_GATEWAYIP	192.168.0.1
#define CONFIG_NETMASK		255.255.255.0
#define CONFIG_IPADDR		192.168.0.45
#define CONFIG_SERVERIP		192.168.0.81

/* Misc CPU related */
#define CONFIG_CMDLINE_TAG
#define CONFIG_SETUP_MEMORY_TAGS
#define CONFIG_INITRD_TAG

#define CONFIG_SYS_SDRAM_BASE		ASPEED_DRAM_BASE

#ifdef CONFIG_PRE_CON_BUF_SZ
#define CONFIG_SYS_INIT_RAM_ADDR	(ASPEED_SRAM_BASE + CONFIG_PRE_CON_BUF_SZ)
#define CONFIG_SYS_INIT_RAM_SIZE	(ASPEED_SRAM_SIZE - CONFIG_PRE_CON_BUF_SZ)
#else
#define CONFIG_SYS_INIT_RAM_ADDR	(ASPEED_SRAM_BASE)
#define CONFIG_SYS_INIT_RAM_SIZE	(ASPEED_SRAM_SIZE)
#endif

#define SYS_INIT_RAM_END \
	(CONFIG_SYS_INIT_RAM_ADDR + CONFIG_SYS_INIT_RAM_SIZE)
#define CONFIG_SYS_INIT_SP_ADDR \
	(SYS_INIT_RAM_END - GENERATED_GBL_DATA_SIZE)

#define CONFIG_SYS_BOOTMAPSZ		(256 * 1024 * 1024)
#define CONFIG_SYS_MALLOC_LEN		(32 << 20)

/*
 * BOOTP options
 */
#define CONFIG_BOOTP_BOOTFILESIZE

/*
 * Miscellaneous configurable options
 */
#define CONFIG_BOOTCOMMAND		"bootm 20200000"
#define CONFIG_SYS_BOOTM_LEN 		(0x800000 * 2)

#define CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS   10

#define CONFIG_EXTRA_ENV_SETTINGS \
       "uboot_start=0x0\0" \
       "uboot_size=0x100000\0" \
       "env_start=0x100000\0" \
       "env_size=0x20000\0" \
       "kernel_start=0x200000\0" \
       "kernel_size=0x800000\0" \
       "rootfs_start=0xa00000\0" \
       "rootfs_size=0x2600000\0" \
       "rwfs_start=0x3000000\0" \
       "rwfs_size=0x800000\0" \
       "erase_env=sf probe 0;sf erase ${env_start} +${env_size}\0" \
       "erase_ps=sf probe 0;sf erase ${rwfs_start} +${rwfs_size}\0" \
       "au=setenv autostart no;if tftp 0x90000000 ${rootpath}image-bmc;" \
               "then sf probe 0; sf update 0x90000000 ${uboot_start} ${filesize};fi\0" \
       "bu=setenv autostart no;if tftp 0x90000000 ${rootpath}image-u-boot;" \
               "then sf probe 0; sf update 0x90000000 ${uboot_start} ${filesize};fi\0" \
       "ku=setenv autostart no;if tftp 0x90000000 ${rootpath}image-kernel;" \
               "then sf probe 0; sf update 0x90000000 ${kernel_start} ${filesize};fi\0" \
       "ru=setenv autostart no;if tftp 0x90000000 ${rootpath}image-rofs;" \
               "then sf probe 0; sf update 0x90000000 ${rootfs_start} ${filesize};fi\0" \
       "ram_init=setenv openbmcinitdownloadurl tftp://${serverip}:69/${rootpath}image-rofs; saveenv;\0" \
       "ram=setenv bootargs console=ttyS4,115200n8 root=/dev/ram rw openbmc-init-download-files ip=dhcp;" \
               "tftp 0x90000000 ${rootpath}image-kernel;" \
               "bootm 0x90000000;\0" \
	"verify=yes\0"	\
	""

/* Environment */
#ifdef CONFIG_ASPEED_PALLADIUM
#define CONFIG_ENV_IS_NOWHERE
#endif
#define CONFIG_ENV_SIZE			0x10000
#define CONFIG_ENV_OFFSET		0x100000
#define CONFIG_ENV_SECT_SIZE	(4 << 10)

/*
 * Ethernet related
 */
#define PHY_ANEG_TIMEOUT		800
#endif	/* __ASPEED_COMMON_CONFIG_H */
