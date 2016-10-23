ROOT_DIR="$(dirname "$(pwd)")"
ANYKERNEL_DIR=$ROOT_DIR/AnyKernel2_Pack
BINARY_DIR=$ROOT_DIR/android_kernel_wingtech_msm8916/arch/arm/boot
ZIMAGE=$BINARY_DIR/zImage
DTB=$BINARY_DIR/dt.img
TEMP_DIR=$ROOT_DIR/temp
KERNEL_NAME=LateAutumn
OUTPUT_DIR=$ROOT_DIR/$KERNEL_NAME-Builds

echo "Creating anykernel zip.."
echo "Creating temporary directory.."
mkdir $TEMP_DIR
echo "Copying binaries.."
cp $ZIMAGE $TEMP_DIR/zImage
cp $DTB $TEMP_DIR/dtb
echo "Copying anykernel files.."
cp -r $ANYKERNEL_DIR/* $TEMP_DIR
cd $TEMP_DIR
read -p "Kernel version : " ver
echo "Creating zip.."
mkdir $OUTPUT_DIR
ZIP_LOC=$OUTPUT_DIR/$KERNEL_NAME-$ver.zip
zip -r9 $ZIP_LOC .
echo "Deleting temporary directory.."
rm -r $TEMP_DIR
echo "Flashable zip file created.."
