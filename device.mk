#
# OnePlus Nord 4 (avalon) TWRP device.mk
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

# A/B partitions (LATEST)
AB_OTA_PARTITIONS := \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    system_dlkm \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_dlkm \
    my_bigball \
    my_carrier \
    my_company \
    my_engineering \
    my_heytap \
    my_manifest \
    my_preload \
    my_product \
    my_region \
    my_stock
