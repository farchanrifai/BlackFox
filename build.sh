DEFCONFIG=cyanogen_cancro_defconfig
make ARCH=arm CROSS_COMPILE=~/workspace/toolchain/bin/arm-eabi- $DEFCONFIG
make CONFIG_NO_ERROR_ON_MISMATCH=y -j32 ARCH=arm CROSS_COMPILE=~/workspace/toolchain/bin/arm-eabi-
#for i in `find -name *.ko`; do cp $i ~/workspace/anykernel/AnyKernel2/modules/; done
#dtbToolCM -s 2048 -d "qcom,msm-id = <" -2 -o arch/arm/boot/dt.img -p /usr/bin/ arch/arm/boot/
#./dtbTool -o ~/workspace/android_kernel_xiaomi_cancro/arch/arm/boot/dt.img -s 2048 -p ./scripts/dtc/ ./arch/arm/boot/
#cp arch/arm/boot/zImage ~/anykernel/AnyKernel2/
#cp arch/arm/boot/dt.img ~/anykernel/AnyKernel2/
#cd ~/workspace/anykernel/AnyKernel2
#DATE=$(date +"%m-%d-%y")
#rm *.zip
#zip -r9 GasL-$DATE.zip * -x README GasL-$DATE.zip
#sudo cp G* ~/workspace/relase/