# Combination of 3 Build scripts to match my wish
# Credit for Ronfante
# Credit for Kunal Kene "kunalkene1797"
# Credit for Nimit Mehta (CheckYourScreen)

# Edit by Farchan Rifai


#For Time Calculation
BUILD_START=$(date +"%s")
echo "enter version name for zip name (only number) :" 
read VER
# Housekeeping
KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/arch/arm/boot/zImage
KERN_DTB=$KERNEL_DIR/arch/arm/boot/dt.img
OUT_DIR=$KERNEL_DIR/anykernel/

# Color Code Script
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
nocol='\033[0m'         # Default

make clean && make mrproper
export ARCH=arm
export SUBARCH=arm
export KBUILD_BUILD_USER="Farchan"
export KBUILD_BUILD_HOST="FoxCT"
export CROSS_COMPILE=~/arm-eabi-5.3/bin/arm-eabi-

compile_kernel ()
{
echo -e "$Blue*****************************************************"
echo    "*                     Compiling                     *"
echo    "*                     -- zdx --                     *"
echo    "*          brought to you by @farchanrifai          *"
echo -e "*****************************************************$nocol"

DEFCONFIG=cyanogen_cancro_defconfig
make ARCH=arm CROSS_COMPILE=~/arm-eabi-5.3/bin/arm-eabi- $DEFCONFIG
make CONFIG_NO_ERROR_ON_MISMATCH=y -j12 ARCH=arm CROSS_COMPILE=~/arm-eabi-5.3/bin/arm-eabi-
if ! [ -a $KERN_IMG ];
then
echo -e "$red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
dtb
zipping
}

dtb() {
tools_sk/dtbtool -o $KERN_DTB -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/

}


zipping() {
rm -rf $OUT_DIR/BlackFox*.zip
rm -rf $OUT_DIR/zImage
#rm -rf $OUT_DIR/dtb
for i in `find -name *.ko`; do cp $i ~/xero/AnyKernel2/modules/; done
cp $KERN_IMG $OUT_DIR/zImage
#cp $KERN_DTB $OUT_DIR/dtb
cd $OUT_DIR
echo "is it a test build ..? (y/n) :"
read buildtype
if [ $buildtype == 'y' ]
then
echo "test build number?:"
read BN
zip -r BlackFox.kernel-cancro.R$VER-test-$BN.zip *
else
zip -r BlackFox.kernel-cancro.R$VER-$(date +"%Y%m%d").zip *
fi
}

compile_kernel
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
