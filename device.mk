# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2019 The OmniRom Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#


# Inherit AOSP/product defaults
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Platform
QCOM_BOARD_PLATFORMS += $(PRODUCT_PLATFORM)
TARGET_BOARD_PLATFORM := $(PRODUCT_PLATFORM)
TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_BOARD_PLATFORM)

BUILD_BROKEN_DUP_RULES := true
RELAX_USES_LIBRARY_CHECK := true

# VNDK/API
PRODUCT_TARGET_VNDK_VERSION := 31
BOARD_SHIPPING_API_LEVEL := 31
BOARD_API_LEVEL := 31
SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31

# A/B support
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS ?= \
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

# A/B related packages
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_engine_sideload \
    update_verifier \
    libupdate_engine \
    libpayload_consumer \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

# f2fs utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Userdata checkpoint
PRODUCT_PACKAGES += checkpoint_gc
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Support to compile recovery without msm headers
TARGET_HAS_GENERIC_KERNEL_HEADERS := true

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.1-impl-mock

# qcom decryption (kept)
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Fuse passthrough (kept)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.fuse.passthrough.enable=true

# Recovery extras
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)/twrp

# OEM otacerts
PRODUCT_EXTRA_RECOVERY_KEYS += $(DEVICE_PATH)/security/otacert
