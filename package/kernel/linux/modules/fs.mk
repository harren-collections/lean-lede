#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

FS_MENU:=Filesystems

define KernelPackage/fs-9p
  SUBMENU:=$(FS_MENU)
  TITLE:=Plan 9 Resource Sharing Support
  DEPENDS:=+kmod-9pnet +(LINUX_6_1||LINUX_6_6||LINUX_6_12):kmod-fs-netfs
  KCONFIG:=\
	CONFIG_9P_FS \
	CONFIG_9P_FS_POSIX_ACL=n \
	CONFIG_9P_FS_SECURITY=n \
	CONFIG_9P_FSCACHE=n
  FILES:=$(LINUX_DIR)/fs/9p/9p.ko
  AUTOLOAD:=$(call AutoLoad,30,9p)
endef

define KernelPackage/fs-9p/description
  Kernel module for Plan 9 Resource Sharing Support support
endef

$(eval $(call KernelPackage,fs-9p))


define KernelPackage/fs-afs
  SUBMENU:=$(FS_MENU)
  TITLE:=Andrew FileSystem client
  DEFAULT:=n
  DEPENDS:=+kmod-rxrpc +kmod-dnsresolver +kmod-fs-fscache
  KCONFIG:=\
	CONFIG_AFS_FS=m \
	CONFIG_AFS_DEBUG=n \
	CONFIG_AFS_FSCACHE=y
  FILES:=$(LINUX_DIR)/fs/afs/kafs.ko
  AUTOLOAD:=$(call AutoLoad,30,kafs)
endef

define KernelPackage/fs-afs/description
  Kernel module for Andrew FileSystem client support
endef

$(eval $(call KernelPackage,fs-afs))

define KernelPackage/fs-autofs4
  SUBMENU:=$(FS_MENU)
  TITLE:=AUTOFS4 filesystem support
  KCONFIG:= \
	CONFIG_AUTOFS4_FS \
	CONFIG_AUTOFS_FS
  FILES:= \
	$(LINUX_DIR)/fs/autofs/autofs4.ko
  AUTOLOAD:=$(call AutoLoad,30,autofs4)
endef

define KernelPackage/fs-autofs4/description
 Kernel module for AutoFS4 support
endef

$(eval $(call KernelPackage,fs-autofs4))


define KernelPackage/fs-btrfs
  SUBMENU:=$(FS_MENU)
  TITLE:=BTRFS filesystem support
  DEPENDS:=+kmod-lib-crc32c +kmod-lib-lzo +kmod-lib-zlib-inflate +kmod-lib-zlib-deflate +kmod-lib-raid6 +kmod-lib-xor +kmod-lib-zstd
  KCONFIG:=\
	CONFIG_BTRFS_FS \
	CONFIG_BTRFS_FS_CHECK_INTEGRITY=n
  FILES:=\
	$(LINUX_DIR)/fs/btrfs/btrfs.ko
  AUTOLOAD:=$(call AutoLoad,30,btrfs,1)
endef

define KernelPackage/fs-btrfs/description
 Kernel module for BTRFS support
endef

$(eval $(call KernelPackage,fs-btrfs))


define KernelPackage/fs-smbfs-common
  SUBMENU:=$(FS_MENU)
  TITLE:=SMBFS common dependencies support
  HIDDEN:=1
  KCONFIG:=\
	CONFIG_SMBFS_COMMON@lt6.1 \
	CONFIG_SMBFS@ge6.1
  DEPENDS:= \
	+(LINUX_5_4||LINUX_5_10):kmod-crypto-arc4 \
	+(LINUX_5_4||LINUX_5_10):kmod-crypto-md4 \
	+(LINUX_6_6||LINUX_6_12):kmod-fs-netfs \
	+(LINUX_6_6||LINUX_6_12):kmod-nls-ucs2-utils
  FILES:= \
	$(LINUX_DIR)/fs/smbfs_common/cifs_arc4.ko@lt6.1 \
	$(LINUX_DIR)/fs/smbfs_common/cifs_md4.ko@lt6.1 \
	$(LINUX_DIR)/fs/smb/common/cifs_arc4.ko@ge6.1 \
	$(LINUX_DIR)/fs/smb/common/cifs_md4.ko@ge6.1
endef

define KernelPackage/fs-smbfs-common/description
 Kernel module dependency for CIFS or SMB_SERVER support
endef

$(eval $(call KernelPackage,fs-smbfs-common))


define KernelPackage/fs-cifs
  SUBMENU:=$(FS_MENU)
  TITLE:=CIFS support
  KCONFIG:= \
	CONFIG_CIFS \
	CONFIG_CIFS_DFS_UPCALL=n \
	CONFIG_CIFS_UPCALL=n
  FILES:= \
	$(LINUX_DIR)/fs/cifs/cifs.ko@lt6.1 \
	$(LINUX_DIR)/fs/smb/client/cifs.ko@ge6.1
  AUTOLOAD:=$(call AutoLoad,30,cifs)
  $(call AddDepends/nls)
  DEPENDS+= \
    +kmod-fs-smbfs-common \
    +kmod-crypto-md5 \
    +kmod-crypto-sha256 \
    +kmod-crypto-sha512 \
    +kmod-crypto-cmac \
    +kmod-crypto-hmac \
    +kmod-crypto-aead \
    +kmod-crypto-ccm \
    +kmod-crypto-ecb \
    +kmod-crypto-des \
    +!(LINUX_5_4||LINUX_5_10):kmod-asn1-decoder \
    +!(LINUX_5_4||LINUX_5_10):kmod-oid-registry \
    +!(LINUX_5_4||LINUX_5_10):kmod-dnsresolver
endef

define KernelPackage/fs-cifs/description
 Kernel module for CIFS support
endef

$(eval $(call KernelPackage,fs-cifs))


define KernelPackage/fs-configfs
  SUBMENU:=$(FS_MENU)
  TITLE:=Configuration filesystem support
  KCONFIG:= \
	CONFIG_CONFIGFS_FS
  FILES:=$(LINUX_DIR)/fs/configfs/configfs.ko
  AUTOLOAD:=$(call AutoLoad,30,configfs)
endef

define KernelPackage/fs-configfs/description
 Kernel module for configfs support
endef

$(eval $(call KernelPackage,fs-configfs))


define KernelPackage/fs-cramfs
  SUBMENU:=$(FS_MENU)
  TITLE:=Compressed RAM/ROM filesystem support
  DEPENDS:=+kmod-lib-zlib-inflate
  KCONFIG:= \
	CONFIG_CRAMFS
  FILES:=$(LINUX_DIR)/fs/cramfs/cramfs.ko
  AUTOLOAD:=$(call AutoLoad,30,cramfs)
endef

define KernelPackage/fs-cramfs/description
 Kernel module for cramfs support
endef

$(eval $(call KernelPackage,fs-cramfs))


define KernelPackage/fs-efivarfs
  SUBMENU:=$(FS_MENU)
  TITLE:=efivar filesystem support
  KCONFIG:=CONFIG_EFIVAR_FS
  FILES:=$(LINUX_DIR)/fs/efivarfs/efivarfs.ko
  DEPENDS:=@(x86_64||x86)
  AUTOLOAD:=$(call Autoload,90,efivarfs)
endef

define KernelPackage/fs-efivarfs/description
  Kernel module to support efivarfs file system mountpoint.
endef

$(eval $(call KernelPackage,fs-efivarfs))


define KernelPackage/fs-exfat
  SUBMENU:=$(FS_MENU)
  TITLE:=exFAT filesystem support
  KCONFIG:= \
	CONFIG_EXFAT_FS \
	CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
  FILES:= \
	$(LINUX_DIR)/drivers/staging/exfat/exfat.ko@lt5.7 \
	$(LINUX_DIR)/fs/exfat/exfat.ko@ge5.7
  AUTOLOAD:=$(call AutoLoad,30,exfat,1)
  DEPENDS:=+kmod-nls-base
endef

define KernelPackage/fs-exfat/description
 Kernel module for exFAT filesystem support
endef

$(eval $(call KernelPackage,fs-exfat))


define KernelPackage/fs-exportfs
  SUBMENU:=$(FS_MENU)
  TITLE:=exportfs kernel server support
  KCONFIG:=CONFIG_EXPORTFS
  FILES=$(LINUX_DIR)/fs/exportfs/exportfs.ko
  AUTOLOAD:=$(call AutoLoad,20,exportfs,1)
endef

define KernelPackage/fs-exportfs/description
 Kernel module for exportfs. Needed for some other modules.
endef

$(eval $(call KernelPackage,fs-exportfs))


define KernelPackage/fs-ext4
  SUBMENU:=$(FS_MENU)
  TITLE:=EXT4 filesystem support
  DEPENDS := \
    +kmod-lib-crc16 \
    +kmod-crypto-hash \
    +kmod-crypto-crc32c
  KCONFIG:= \
	CONFIG_EXT4_FS \
	CONFIG_EXT4_ENCRYPTION=n \
	CONFIG_JBD2
  FILES:= \
	$(LINUX_DIR)/fs/ext4/ext4.ko \
	$(LINUX_DIR)/fs/jbd2/jbd2.ko \
	$(LINUX_DIR)/fs/mbcache.ko
  AUTOLOAD:=$(call AutoLoad,30,mbcache jbd2 ext4,1)
endef

define KernelPackage/fs-ext4/description
 Kernel module for EXT4 filesystem support
endef

$(eval $(call KernelPackage,fs-ext4))


define KernelPackage/fs-f2fs
  SUBMENU:=$(FS_MENU)
  TITLE:=F2FS filesystem support
  DEPENDS:= +kmod-crypto-hash +kmod-crypto-crc32 +kmod-nls-base
  KCONFIG:=CONFIG_F2FS_FS
  FILES:=$(LINUX_DIR)/fs/f2fs/f2fs.ko
  AUTOLOAD:=$(call AutoLoad,30,f2fs,1)
endef

define KernelPackage/fs-f2fs/description
 Kernel module for F2FS filesystem support
endef

$(eval $(call KernelPackage,fs-f2fs))


define KernelPackage/fs-fscache
  SUBMENU:=$(FS_MENU)
  TITLE:=General filesystem local cache manager
  DEPENDS:=+kmod-fs-netfs
  KCONFIG:=\
	CONFIG_FSCACHE \
	CONFIG_FSCACHE_STATS=y \
	CONFIG_FSCACHE_HISTOGRAM=n \
	CONFIG_FSCACHE_DEBUG=n \
	CONFIG_FSCACHE_OBJECT_LIST=n \
	CONFIG_CACHEFILES \
	CONFIG_CACHEFILES_DEBUG=n \
	CONFIG_CACHEFILES_HISTOGRAM=n \
	CONFIG_CACHEFILES_ERROR_INJECTION=n@ge5.17 \
	CONFIG_CACHEFILES_ONDEMAND=n@ge5.19
  FILES:= \
	$(LINUX_DIR)/fs/fscache/fscache.ko \
	$(LINUX_DIR)/fs/cachefiles/cachefiles.ko
  AUTOLOAD:=$(call AutoLoad,29,fscache cachefiles)
endef

$(eval $(call KernelPackage,fs-fscache))


define KernelPackage/fs-hfs
  SUBMENU:=$(FS_MENU)
  TITLE:=HFS filesystem support
  DEPENDS:=+kmod-cdrom
  KCONFIG:=CONFIG_HFS_FS
  FILES:=$(LINUX_DIR)/fs/hfs/hfs.ko
  AUTOLOAD:=$(call AutoLoad,30,hfs)
  $(call AddDepends/nls)
endef

define KernelPackage/fs-hfs/description
 Kernel module for HFS filesystem support
endef

$(eval $(call KernelPackage,fs-hfs))


define KernelPackage/fs-hfsplus
  SUBMENU:=$(FS_MENU)
  TITLE:=HFS+ filesystem support
  DEPENDS:=+kmod-cdrom
  KCONFIG:=CONFIG_HFSPLUS_FS
  FILES:=$(LINUX_DIR)/fs/hfsplus/hfsplus.ko
  AUTOLOAD:=$(call AutoLoad,30,hfsplus)
  $(call AddDepends/nls,utf8)
endef

define KernelPackage/fs-hfsplus/description
 Kernel module for HFS+ filesystem support
endef

$(eval $(call KernelPackage,fs-hfsplus))


define KernelPackage/fs-isofs
  SUBMENU:=$(FS_MENU)
  TITLE:=ISO9660 filesystem support
  DEPENDS:=+kmod-lib-zlib-inflate +kmod-cdrom
  KCONFIG:=CONFIG_ISO9660_FS CONFIG_JOLIET=y CONFIG_ZISOFS=n
  FILES:=$(LINUX_DIR)/fs/isofs/isofs.ko
  AUTOLOAD:=$(call AutoLoad,30,isofs)
  $(call AddDepends/nls)
endef

define KernelPackage/fs-isofs/description
 Kernel module for ISO9660 filesystem support
endef

$(eval $(call KernelPackage,fs-isofs))


define KernelPackage/fs-jfs
  SUBMENU:=$(FS_MENU)
  TITLE:=JFS filesystem support
  KCONFIG:=CONFIG_JFS_FS
  FILES:=$(LINUX_DIR)/fs/jfs/jfs.ko
  AUTOLOAD:=$(call AutoLoad,30,jfs,1)
  DEPENDS:=+(LINUX_6_6||LINUX_6_12):kmod-nls-ucs2-utils
  $(call AddDepends/nls)
endef

define KernelPackage/fs-jfs/description
 Kernel module for JFS support
endef

$(eval $(call KernelPackage,fs-jfs))

define KernelPackage/fs-minix
  SUBMENU:=$(FS_MENU)
  TITLE:=Minix filesystem support
  KCONFIG:=CONFIG_MINIX_FS
  FILES:=$(LINUX_DIR)/fs/minix/minix.ko
  AUTOLOAD:=$(call AutoLoad,30,minix)
endef

define KernelPackage/fs-minix/description
 Kernel module for Minix filesystem support
endef

$(eval $(call KernelPackage,fs-minix))


define KernelPackage/fs-msdos
  SUBMENU:=$(FS_MENU)
  TITLE:=MSDOS filesystem support
  DEPENDS:=+kmod-fs-vfat
  KCONFIG:=CONFIG_MSDOS_FS
  FILES:=$(LINUX_DIR)/fs/fat/msdos.ko
  AUTOLOAD:=$(call AutoLoad,40,msdos)
  $(call AddDepends/nls)
endef

define KernelPackage/fs-msdos/description
 Kernel module for MSDOS filesystem support
endef

$(eval $(call KernelPackage,fs-msdos))


define KernelPackage/fs-netfs
  SUBMENU:=$(FS_MENU)
  TITLE:=Network Filesystems support
  DEPENDS:=@!(LINUX_5_4||LINUX_5_10)
  KCONFIG:= CONFIG_NETFS_SUPPORT
  FILES:=$(LINUX_DIR)/fs/netfs/netfs.ko
  AUTOLOAD:=$(call AutoLoad,28,netfs)
endef

$(eval $(call KernelPackage,fs-netfs))


define KernelPackage/fs-nfs
  SUBMENU:=$(FS_MENU)
  TITLE:=NFS filesystem client support
  DEPENDS:=+kmod-fs-nfs-common +kmod-dnsresolver
  KCONFIG:= \
	CONFIG_NFS_FS \
	CONFIG_NFS_USE_LEGACY_DNS=n \
	CONFIG_NFS_USE_NEW_IDMAPPER=n
  FILES:= \
	$(LINUX_DIR)/fs/nfs/nfs.ko
  AUTOLOAD:=$(call AutoLoad,40,nfs)
endef

define KernelPackage/fs-nfs/description
 Kernel module for NFS client support
endef

$(eval $(call KernelPackage,fs-nfs))


define KernelPackage/fs-nfs-common
  SUBMENU:=$(FS_MENU)
  TITLE:=Common NFS filesystem modules
  DEPENDS:=+kmod-oid-registry
  KCONFIG:= \
	CONFIG_LOCKD \
	CONFIG_SUNRPC \
	CONFIG_GRACE_PERIOD \
	CONFIG_NFS_V4=y \
	CONFIG_NFS_V4_1=y \
	CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org" \
	CONFIG_NFS_V4_1_MIGRATION=n \
	CONFIG_NFS_V4_2=y \
	CONFIG_NFS_V4_2_READ_PLUS=n
  FILES:= \
	$(LINUX_DIR)/fs/lockd/lockd.ko \
	$(LINUX_DIR)/net/sunrpc/sunrpc.ko \
	$(LINUX_DIR)/fs/nfs_common/grace.ko
  AUTOLOAD:=$(call AutoLoad,30,grace sunrpc lockd)
endef

$(eval $(call KernelPackage,fs-nfs-common))


define KernelPackage/fs-nfs-common-rpcsec
  SUBMENU:=$(FS_MENU)
  TITLE:=NFS Secure RPC
  DEPENDS:= \
	+kmod-fs-nfs-common \
	+kmod-crypto-des \
	+kmod-crypto-cbc \
	+kmod-crypto-cts \
	+kmod-crypto-md5 \
	+kmod-crypto-sha1 \
	+kmod-crypto-hmac \
	+kmod-crypto-ecb \
	+kmod-crypto-arc4 \
	+kmod-oid-registry
  KCONFIG:= \
	CONFIG_SUNRPC_GSS \
	CONFIG_RPCSEC_GSS_KRB5
  FILES:= \
	$(LINUX_DIR)/net/sunrpc/auth_gss/auth_rpcgss.ko \
	$(LINUX_DIR)/net/sunrpc/auth_gss/rpcsec_gss_krb5.ko
  AUTOLOAD:=$(call AutoLoad,31,auth_rpcgss rpcsec_gss_krb5)
endef

define KernelPackage/fs-nfs-common-rpcsec/description
 Kernel modules for NFS Secure RPC
endef

$(eval $(call KernelPackage,fs-nfs-common-rpcsec))


define KernelPackage/fs-nfs-v3
  SUBMENU:=$(FS_MENU)
  TITLE:=NFS3 filesystem client support
  DEPENDS:=+kmod-fs-nfs
  FILES:= \
	$(LINUX_DIR)/fs/nfs/nfsv3.ko
  AUTOLOAD:=$(call AutoLoad,41,nfsv3)
endef

define KernelPackage/fs-nfs-v3/description
 Kernel module for NFS v3 client support
endef

$(eval $(call KernelPackage,fs-nfs-v3))


define KernelPackage/fs-nfs-v4
  SUBMENU:=$(FS_MENU)
  TITLE:=NFS4 filesystem client support
  DEPENDS:=+kmod-fs-nfs
  KCONFIG:= \
	CONFIG_NFS_V4=y
  FILES:= \
	$(LINUX_DIR)/fs/nfs/nfsv4.ko
  AUTOLOAD:=$(call AutoLoad,41,nfsv4)
endef

define KernelPackage/fs-nfs-v4/description
 Kernel module for NFS v4 client support
endef

$(eval $(call KernelPackage,fs-nfs-v4))


define KernelPackage/fs-nfsd
  SUBMENU:=$(FS_MENU)
  TITLE:=NFS kernel server support
  DEPENDS:=+kmod-fs-nfs-common +kmod-fs-exportfs +kmod-fs-nfs-common-rpcsec
  KCONFIG:= \
	CONFIG_NFSD \
	CONFIG_NFSD_V4=y \
	CONFIG_NFSD_V4_SECURITY_LABEL=n \
	CONFIG_NFSD_BLOCKLAYOUT=n \
	CONFIG_NFSD_SCSILAYOUT=n \
	CONFIG_NFSD_FLEXFILELAYOUT=n \
	CONFIG_NFSD_FAULT_INJECTION=n \
	CONFIG_NFSD_V4_2_INTER_SSC=n
  FILES:=$(LINUX_DIR)/fs/nfsd/nfsd.ko
  AUTOLOAD:=$(call AutoLoad,40,nfsd)
endef

define KernelPackage/fs-nfsd/description
 Kernel module for NFS kernel server support
endef

$(eval $(call KernelPackage,fs-nfsd))


define KernelPackage/fs-ntfs
  SUBMENU:=$(FS_MENU)
  TITLE:=NTFS filesystem read-only (old driver) support
  KCONFIG:=CONFIG_NTFS_FS
  FILES:=$(LINUX_DIR)/fs/ntfs/ntfs.ko
  AUTOLOAD:=$(call AutoLoad,30,ntfs)
  DEPENDS+=@!LINUX_6_12
  $(call AddDepends/nls)
endef

define KernelPackage/fs-ntfs/description
 Kernel module for limited NTFS filesystem support. Support for writing
 is extremely limited and disabled as a result.
endef

$(eval $(call KernelPackage,fs-ntfs))


define KernelPackage/fs-ntfs3
  SUBMENU:=$(FS_MENU)
  TITLE:=NTFS filesystem read & write (new driver) support
  KCONFIG:= CONFIG_NTFS3_FS CONFIG_NTFS3_FS_POSIX_ACL=y
  FILES:=$(LINUX_DIR)/fs/ntfs3/ntfs3.ko
  $(call AddDepends/nls)
  AUTOLOAD:=$(call AutoLoad,80,ntfs3)
endef

define KernelPackage/fs-ntfs3/description
 Kernel module for fully functional NTFS filesystem support. It allows
 reading as well as writing.

 It supports NTFS versions up to 3.1.
endef

$(eval $(call KernelPackage,fs-ntfs3))


define KernelPackage/fs-reiserfs
  SUBMENU:=$(FS_MENU)
  TITLE:=ReiserFS filesystem support
  KCONFIG:=CONFIG_REISERFS_FS
  FILES:=$(LINUX_DIR)/fs/reiserfs/reiserfs.ko
  AUTOLOAD:=$(call AutoLoad,30,reiserfs,1)
endef

define KernelPackage/fs-reiserfs/description
 Kernel module for ReiserFS support
endef

$(eval $(call KernelPackage,fs-reiserfs))


define KernelPackage/fs-squashfs
  SUBMENU:=$(FS_MENU)
  TITLE:=SquashFS 4.0 filesystem support
  KCONFIG:=CONFIG_SQUASHFS \
	CONFIG_SQUASHFS_XZ=y
  FILES:=$(LINUX_DIR)/fs/squashfs/squashfs.ko
  AUTOLOAD:=$(call AutoLoad,30,squashfs,1)
endef

define KernelPackage/fs-squashfs/description
 Kernel module for SquashFS 4.0 support
endef

$(eval $(call KernelPackage,fs-squashfs))


define KernelPackage/fs-udf
  SUBMENU:=$(FS_MENU)
  TITLE:=UDF filesystem support
  KCONFIG:=CONFIG_UDF_FS
  FILES:=$(LINUX_DIR)/fs/udf/udf.ko
  AUTOLOAD:=$(call AutoLoad,30,udf)
  DEPENDS:=+kmod-lib-crc-itu-t +kmod-cdrom
  $(call AddDepends/nls)
endef

define KernelPackage/fs-udf/description
 Kernel module for UDF filesystem support
endef

$(eval $(call KernelPackage,fs-udf))


define KernelPackage/fs-vfat
  SUBMENU:=$(FS_MENU)
  TITLE:=VFAT filesystem support
  KCONFIG:= \
	CONFIG_FAT_FS \
	CONFIG_VFAT_FS
  FILES:= \
	$(LINUX_DIR)/fs/fat/fat.ko \
	$(LINUX_DIR)/fs/fat/vfat.ko
  AUTOLOAD:=$(call AutoLoad,30,fat vfat,1)
  $(call AddDepends/nls,cp437 iso8859-1 utf8)
endef

define KernelPackage/fs-vfat/description
 Kernel module for VFAT filesystem support
endef

$(eval $(call KernelPackage,fs-vfat))

define KernelPackage/fs-xfs
  SUBMENU:=$(FS_MENU)
  TITLE:=XFS filesystem support
  KCONFIG:=CONFIG_XFS_FS
  DEPENDS:= +kmod-fs-exportfs +kmod-lib-crc32c
  FILES:=$(LINUX_DIR)/fs/xfs/xfs.ko
  AUTOLOAD:=$(call AutoLoad,30,xfs,1)
endef

define KernelPackage/fs-xfs/description
 Kernel module for XFS support
endef

$(eval $(call KernelPackage,fs-xfs))


define KernelPackage/fuse
  SUBMENU:=$(FS_MENU)
  TITLE:=FUSE (Filesystem in Userspace) support
  KCONFIG:= CONFIG_FUSE_FS
  FILES:=$(LINUX_DIR)/fs/fuse/fuse.ko
  AUTOLOAD:=$(call AutoLoad,80,fuse)
endef

define KernelPackage/fuse/description
 Kernel module for userspace filesystem support
endef

$(eval $(call KernelPackage,fuse))


define KernelPackage/pstore
  SUBMENU:=$(FS_MENU)
  TITLE:=Pstore file system
  DEFAULT:=m if ALL_KMODS
  KCONFIG:= \
	CONFIG_PSTORE \
	CONFIG_PSTORE_COMPRESS=y \
	CONFIG_PSTORE_COMPRESS_DEFAULT="deflate" \
	CONFIG_PSTORE_DEFLATE_COMPRESS=y \
	CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
  FILES:= $(LINUX_DIR)/fs/pstore/pstore.ko
  AUTOLOAD:=$(call AutoLoad,30,pstore,1)
  DEPENDS:=+(LINUX_6_6||LINUX_6_12):kmod-lib-zlib-deflate \
	   +(LINUX_6_6||LINUX_6_12):kmod-lib-zlib-inflate
endef

define KernelPackage/pstore/description
 Kernel module for pstore filesystem support
endef

$(eval $(call KernelPackage,pstore))
