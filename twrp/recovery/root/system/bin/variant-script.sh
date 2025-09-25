#!/system/bin/sh
# Avalon variant detection: EU, Global, India
variant=$(getprop ro.boot.prjname)
odmname=$(getprop ro.product.odm.name)
sku=$(getprop ro.boot.product.hardware.sku)

echo "prjname: $variant"
echo "odmname: $odmname"
echo "sku: $sku"

set_props() {
    # $1 = model (e.g., CPH2663 or CPH2661)
    model="$1"
    resetprop ro.product.device "OP5E93L1"
    resetprop ro.product.vendor.device "OP5E93L1"
    resetprop ro.product.odm.device "OP5E93L1"
    resetprop ro.product.product.device "OP5E93L1"
    resetprop ro.product.system_ext.device "OP5E93L1"

    resetprop ro.product.product.model "$model"
    resetprop ro.product.model "$model"
    resetprop ro.product.system.model "$model"
    resetprop ro.product.system_ext.model "$model"
    resetprop ro.product.vendor.model "$model"
    resetprop ro.product.odm.model "$model"
}

case "$variant" in
    "24211")
        case "$odmname" in
            "CPH2663EEA")
                set_props "CPH2663"
                resetprop ro.product.odm.name "CPH2663EEA"
                resetprop ro.boot.hardware.revision "EU"
                ;;
            "CPH2663")
                set_props "CPH2663"
                resetprop ro.product.odm.name "CPH2663"
                resetprop ro.boot.hardware.revision "GLOBAL"
                ;;
            "CPH2661IN"|"CPH2661")
                set_props "CPH2661"
                resetprop ro.product.odm.name "CPH2661IN"
                resetprop ro.boot.hardware.revision "IN"
                ;;
            *)
                case "$sku" in
                    "6")
                        set_props "CPH2661"
                        resetprop ro.product.odm.name "CPH2661IN"
                        resetprop ro.boot.hardware.revision "IN"
                        ;;
                    *)
                        # default to Global
                        set_props "CPH2663"
                        resetprop ro.product.odm.name "CPH2663"
                        resetprop ro.boot.hardware.revision "GLOBAL"
                        ;;
                esac
                ;;
        esac
        ;;
    *)
        set_props "CPH2663"
        resetprop ro.product.odm.name "CPH2663"
        resetprop ro.boot.hardware.revision "GLOBAL"
        ;;
esac

exit 0
