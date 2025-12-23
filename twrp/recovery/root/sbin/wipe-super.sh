#!/sbin/sh
SUPER_BLOCK="/dev/block/by-name/super"
CANDIDATES="/sbin/super_empty.img /tmp/super_empty.img /sdcard/super_empty.img /data/media/0/super_empty.img"
LOG="/tmp/wipe-super.log"

echo "wipe-super: starting" > "$LOG"

if [ ! -b "$SUPER_BLOCK" ]; then
  echo "wipe-super: super block not found" >> "$LOG"
  exit 1
fi

for path in $CANDIDATES; do
  if [ -f "$path" ]; then
    echo "wipe-super: using $path" >> "$LOG"
    dd if="$path" of="$SUPER_BLOCK" bs=4M >> "$LOG" 2>&1
    if [ $? -ne 0 ]; then
      echo "wipe-super: dd failed" >> "$LOG"
      exit 2
    fi
    sync
    echo "wipe-super: success" >> "$LOG"
    exit 0
  fi
done

echo "wipe-super: super_empty.img not found" >> "$LOG"
exit 3
