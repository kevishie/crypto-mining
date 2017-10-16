
mkdir -p /tmp/intel
cd /tmp/intel
wget https://01.org/sites/default/files/downloads/intelr-graphics-linux/kblgucver914.tar.bz2
wget https://01.org/sites/default/files/downloads/intelr-graphics-linux/kbldmcver101.tar.bz2
wget https://01.org/sites/default/files/downloads/intelr-graphics-linux/bxtgucver87.tar.bz2

tar -xjvf kbldmcver101.tar.bz2
tar -xjvf bxtgucver87.tar.bz2
tar -xjvf kblgucver914.tar.bz2

cp -t /lib/firmware/i915/ bxt_guc_ver8_7/bxt_guc_ver8_7.bin kbl_dmc_ver1_01/kbl_dmc_ver1_01.bin kbl_guc_ver9_14/kbl_guc_ver9_14.bin

update-initramfs -u
