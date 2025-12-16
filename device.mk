#
# OnePlus Nord 4 (avalon)
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# Shipping API levels
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# OTA certs
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/local_OTA \
    $(DEVICE_PATH)/security/special_OTA

# Virtual A/B
AB_OTA_UPDATER := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# fastbootd
PRODUCT_PACKAGES += fastbootd

# Decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Soong
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# Recovery overlays
TARGET_RECOVERY_DEVICE_DIRS += \
    $(DEVICE_PATH)/twrp \
    $(DEVICE_PATH)/recovery/root

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS := boot vendor_boot recovery vendor_dlkm dtbo vbmeta super init_boot system_dlkm abl aop aop_config bluetooth cpucp cpucp_dtb devcfg dsp engineering_cdt featenabler hyp imagefv keymaster modem oplus_sec oplusstanvbk qupfw shrm splash tz uefi uefisecapp xbl xbl_config xbl_ramdump
