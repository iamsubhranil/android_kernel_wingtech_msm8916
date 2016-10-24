echo "Declaring directories.."
KERNEL_DIR=$(pwd)
cd ..
MAIN_DIR=$(pwd)
DTBTOOL_DIR=$MAIN_DIR/mkbootimg_tools
echo "Switching to kernel directory.."
cd $KERNEL_DIR
echo "Exporting arch, subarch and compiler directories.."
export USE_CCACHE=1
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=$MAIN_DIR/arm-eabi-4.8/bin/arm-eabi-
read -p "Do you want to rebuild all? " rebuild
case $rebuild in
	[Yy]* ) 
	echo "Cleaning previously compiled files..";
	make clean && make mrproper;
esac
read -p "Do you want to overwrite present configuration with the default one? " choice
case $choice in
	[Yy]* )
	echo "Creating default configuration..";
	make cyanogenmod_wt88047_defconfig;
esac
read -p "How many threads do you want to use for compiling the kernel? " threads
echo "Compiling kernel.."
make -j$threads
echo "Switching to dtbTool directory.."
cd $DTBTOOL_DIR
echo "Executing dtbToolCM.."
./dtbToolCM -2 -o $KERNEL_DIR/arch/arm/boot/dt.img -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/
echo "Kernel compilation complete!"
echo "Check above for any errors.."
read -p "Do you want to create a flashable zip? " zip
case $zip in
	[Yy]* )
	bash $KERNEL_DIR/zipping.sh
esac
echo "Process completed.."
