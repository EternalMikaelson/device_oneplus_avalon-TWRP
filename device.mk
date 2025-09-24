# Device makefile for OnePlus Nord 4 (avalon) TWRP

# Inherit base AOSP configs
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# GSI keys in ramdisk (verified boot)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Platform
QCOM_BOARD_PLATFORMS += $(PRODUCT_PLATFORM)
TARGET_BOARD_PLATFORM := $(PRODUCT_PLATFORM)
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_BOARD_PLATFORM)

# Build relaxations
BUILD_BROKEN_DUP_RULES := true
RELAX_USES_LIBRARY_CHECK := true

# A/B + Virtual A/B
AB_OTA_UPDATER := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd + HAL
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.1-impl-mock

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 31

# A/B updater packages
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_verifier \
    update_engine_sideload \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

# f2fs utils
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Userdata checkpoint
PRODUCT_PACKAGES += checkpoint_gc

# Postinstall (vendor) — optional
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Shipping / API levels
BOARD_SHIPPING_API_LEVEL := 31
BOARD_API_LEVEL := 31
SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31

# Build without msm headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

# Decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# UFS bsg framework selection
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# OEM otacerts for recovery
PRODUCT_EXTRA_RECOVERY_KEYS += $(DEVICE_PATH)/security/otacert

# System AVB chain (vbmeta_system)
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

# Fuse passthrough
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# TWRP device dir
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)/twrp

# Payload consumer (update_engine)
PRODUCT_PACKAGES += libpayload_consumer

# Ensure full dynamic A/B partition coverage for payload flashing
# Keep in sync with recovery.fstab and super metadata
AB_OTA_PARTITIONS := \
    boot \
    vendor_boot \
    init_boot \
    dtbo \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    super \
    system \
    system_ext \
    product \
    vendor \
    odm \
    system_dlkm \
    vendor_dlkm \
    odm_dlkm

# Guard: avoid pulling keystore/keymint into recovery
PRODUCT_PACKAGES -= \
    keystore2 \
    android.system.keystore2 \
    android.hardware.security.keymint \
    android.hardware.security.sharedsecret
