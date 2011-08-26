Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 15/16] staging:iio:imu:adis16400 cleanups
Date: Fri, 26 Aug 2011 11:19:32 +0100
Message-Id: <1314353973-7662-16-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

a) remove irq is gpio requirement - No reason this needs to be true.
b) use actual part name in info message rather than adis16400 in all cases.
c) scrap use of IIO_CHAN to simplify move out of staging.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400_core.c    |  607 ++++++++++++++++++---------
 drivers/staging/iio/imu/adis16400_trigger.c |    2 +-
 2 files changed, 403 insertions(+), 206 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 02ba9be..c1ed832 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -16,7 +16,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -31,8 +30,6 @@
 #include "../ring_generic.h"
 #include "adis16400.h"
 
-#define DRIVER_NAME		"adis16400"
-
 enum adis16400_chip_variant {
 	ADIS16300,
 	ADIS16344,
@@ -44,19 +41,12 @@ enum adis16400_chip_variant {
 	ADIS16400,
 };
 
-static int adis16400_check_status(struct iio_dev *indio_dev);
-
-/* At the moment the spi framework doesn't allow global setting of cs_change.
- * It's in the likely to be added comment at the top of spi.h.
- * This means that use cannot be made of spi_write etc.
- */
-
 /**
  * adis16400_spi_write_reg_8() - write single byte to a register
  * @dev: device associated with child of actual device (iio_dev or iio_trig)
  * @reg_address: the address of the register to be written
  * @val: the value to write
- **/
+ */
 static int adis16400_spi_write_reg_8(struct iio_dev *indio_dev,
 				     u8 reg_address,
 				     u8 val)
@@ -80,7 +70,10 @@ static int adis16400_spi_write_reg_8(struct iio_dev *indio_dev,
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: value to be written
- **/
+ *
+ * At the moment the spi framework doesn't allow global setting of cs_change.
+ * This means that use cannot be made of spi_write.
+ */
 static int adis16400_spi_write_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
 		u16 value)
@@ -122,6 +115,9 @@ static int adis16400_spi_write_reg_16(struct iio_dev *indio_dev,
  * @reg_address: the address of the lower of the two registers. Second register
  *               is assumed to have address one greater.
  * @val: somewhere to pass back the value read
+ *
+ * At the moment the spi framework doesn't allow global setting of cs_change.
+ * This means that use cannot be made of spi_read.
  **/
 static int adis16400_spi_read_reg_16(struct iio_dev *indio_dev,
 		u8 lower_reg_address,
@@ -240,10 +236,11 @@ static ssize_t adis16400_write_reset(struct device *dev,
 	ret = strtobool(buf, &val);
 	if (ret < 0)
 		return ret;
-	if (val)
+	if (val) {
 		ret = adis16400_reset(dev_get_drvdata(dev));
-	if (ret < 0)
-		return ret;
+		if (ret < 0)
+			return ret;
+	}
 
 	return len;
 }
@@ -252,6 +249,7 @@ int adis16400_set_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int ret;
 	u16 msc;
+
 	ret = adis16400_spi_read_reg_16(indio_dev, ADIS16400_MSC_CTRL, &msc);
 	if (ret)
 		goto error_ret;
@@ -284,24 +282,6 @@ static int adis16400_stop_device(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int adis16400_self_test(struct iio_dev *indio_dev)
-{
-	int ret;
-	ret = adis16400_spi_write_reg_16(indio_dev,
-			ADIS16400_MSC_CTRL,
-			ADIS16400_MSC_CTRL_MEM_TEST);
-	if (ret) {
-		dev_err(&indio_dev->dev, "problem starting self test");
-		goto err_ret;
-	}
-
-	msleep(ADIS16400_MTEST_DELAY);
-	adis16400_check_status(indio_dev);
-
-err_ret:
-	return ret;
-}
-
 static int adis16400_check_status(struct iio_dev *indio_dev)
 {
 	u16 status;
@@ -351,11 +331,28 @@ error_ret:
 	return ret;
 }
 
+static int adis16400_self_test(struct iio_dev *indio_dev)
+{
+	int ret;
+	ret = adis16400_spi_write_reg_16(indio_dev,
+			ADIS16400_MSC_CTRL,
+			ADIS16400_MSC_CTRL_MEM_TEST);
+	if (ret) {
+		dev_err(&indio_dev->dev, "problem starting self test");
+		goto err_ret;
+	}
+
+	msleep(ADIS16400_MTEST_DELAY);
+	adis16400_check_status(indio_dev);
+
+err_ret:
+	return ret;
+}
+
 static int adis16400_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
 	u16 prod_id, smp_prd;
-	struct device *dev = &indio_dev->dev;
 	struct adis16400_state *st = iio_priv(indio_dev);
 
 	/* use low spi speed for init */
@@ -363,29 +360,26 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 	st->us->mode = SPI_MODE_3;
 	spi_setup(st->us);
 
-	/* Disable IRQ */
 	ret = adis16400_set_irq(indio_dev, false);
 	if (ret) {
-		dev_err(dev, "disable irq failed");
+		dev_err(&indio_dev->dev, "disable irq failed");
 		goto err_ret;
 	}
 
-	/* Do self test */
 	ret = adis16400_self_test(indio_dev);
 	if (ret) {
-		dev_err(dev, "self test failure");
+		dev_err(&indio_dev->dev, "self test failure");
 		goto err_ret;
 	}
 
-	/* Read status register to check the result */
 	ret = adis16400_check_status(indio_dev);
 	if (ret) {
 		adis16400_reset(indio_dev);
-		dev_err(dev, "device not playing ball -> reset");
+		dev_err(&indio_dev->dev, "device not playing ball -> reset");
 		msleep(ADIS16400_STARTUP_DELAY);
 		ret = adis16400_check_status(indio_dev);
 		if (ret) {
-			dev_err(dev, "giving up");
+			dev_err(&indio_dev->dev, "giving up");
 			goto err_ret;
 		}
 	}
@@ -396,10 +390,11 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 			goto err_ret;
 
 		if ((prod_id & 0xF000) != st->variant->product_id)
-			dev_warn(dev, "incorrect id");
+			dev_warn(&indio_dev->dev, "incorrect id");
 
-		printk(KERN_INFO DRIVER_NAME ": prod_id 0x%04x at CS%d (irq %d)\n",
-		       prod_id, st->us->chip_select, st->us->irq);
+		printk(KERN_INFO "%s: prod_id 0x%04x at CS%d (irq %d)\n",
+		       indio_dev->name, prod_id,
+		       st->us->chip_select, st->us->irq);
 	}
 	/* use high spi speed if possible */
 	ret = adis16400_spi_read_reg_16(indio_dev,
@@ -409,15 +404,13 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 		spi_setup(st->us);
 	}
 
-
 err_ret:
-
 	return ret;
 }
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		adis16400_read_frequency,
-		adis16400_write_frequency);
+			      adis16400_read_frequency,
+			      adis16400_write_frequency);
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16400_write_reset, 0);
 
@@ -442,23 +435,23 @@ enum adis16400_chan {
 };
 
 static u8 adis16400_addresses[17][2] = {
-	[in_supply] = { ADIS16400_SUPPLY_OUT, 0 },
+	[in_supply] = { ADIS16400_SUPPLY_OUT },
 	[gyro_x] = { ADIS16400_XGYRO_OUT, ADIS16400_XGYRO_OFF },
 	[gyro_y] = { ADIS16400_YGYRO_OUT, ADIS16400_YGYRO_OFF },
 	[gyro_z] = { ADIS16400_ZGYRO_OUT, ADIS16400_ZGYRO_OFF },
 	[accel_x] = { ADIS16400_XACCL_OUT, ADIS16400_XACCL_OFF },
 	[accel_y] = { ADIS16400_YACCL_OUT, ADIS16400_YACCL_OFF },
 	[accel_z] = { ADIS16400_ZACCL_OUT, ADIS16400_ZACCL_OFF },
-	[magn_x] = { ADIS16400_XMAGN_OUT, 0 },
-	[magn_y] = { ADIS16400_YMAGN_OUT, 0 },
-	[magn_z] = { ADIS16400_ZMAGN_OUT, 0 },
-	[temp] = { ADIS16400_TEMP_OUT, 0 },
+	[magn_x] = { ADIS16400_XMAGN_OUT },
+	[magn_y] = { ADIS16400_YMAGN_OUT },
+	[magn_z] = { ADIS16400_ZMAGN_OUT },
+	[temp] = { ADIS16400_TEMP_OUT },
 	[temp0] = { ADIS16350_XTEMP_OUT },
 	[temp1] = { ADIS16350_YTEMP_OUT },
 	[temp2] = { ADIS16350_ZTEMP_OUT },
-	[in1] = { ADIS16400_AUX_ADC, 0 },
-	[incli_x] = { ADIS16300_PITCH_OUT, 0 },
-	[incli_y] = { ADIS16300_ROLL_OUT, 0 }
+	[in1] = { ADIS16400_AUX_ADC },
+	[incli_x] = { ADIS16300_PITCH_OUT },
+	[incli_y] = { ADIS16300_ROLL_OUT }
 };
 
 static int adis16400_write_raw(struct iio_dev *indio_dev,
@@ -468,6 +461,7 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	int ret;
+
 	switch (mask) {
 	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
 		mutex_lock(&indio_dev->mlock);
@@ -488,9 +482,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct adis16400_state *st = iio_priv(indio_dev);
-	int ret;
+	int ret, shift;
 	s16 val16;
-	int shift;
 
 	switch (mask) {
 	case 0:
@@ -561,164 +554,368 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16400_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 in_supply, ADIS16400_SCAN_SUPPLY,
-		 IIO_ST('u', 14, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_x, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_x, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_y, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_z, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_MAGN, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 magn_x, ADIS16400_SCAN_MAGN_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_MAGN, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 magn_y, ADIS16400_SCAN_MAGN_Y, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_MAGN, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 magn_z, ADIS16400_SCAN_MAGN_Z, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 temp, ADIS16400_SCAN_TEMP, IIO_ST('s', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 in1, ADIS16400_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "supply",
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = in_supply,
+		.scan_index = ADIS16400_SCAN_SUPPLY,
+		.scan_type = IIO_ST('u', 14, 16, 0)
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_x,
+		.scan_index = ADIS16400_SCAN_GYRO_X,
+		.scan_type = IIO_ST('s', 14, 16, 0)
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_y,
+		.scan_index = ADIS16400_SCAN_GYRO_Y,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_z,
+		.scan_index = ADIS16400_SCAN_GYRO_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_x,
+		.scan_index = ADIS16400_SCAN_ACC_X,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_y,
+		.scan_index = ADIS16400_SCAN_ACC_Y,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_z,
+		.scan_index = ADIS16400_SCAN_ACC_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = magn_x,
+		.scan_index = ADIS16400_SCAN_MAGN_X,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = magn_y,
+		.scan_index = ADIS16400_SCAN_MAGN_Y,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = magn_z,
+		.scan_index = ADIS16400_SCAN_MAGN_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = temp,
+		.scan_index = ADIS16400_SCAN_TEMP,
+		.scan_type = IIO_ST('s', 12, 16, 0),
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = in1,
+		.scan_index = ADIS16400_SCAN_ADC_0,
+		.scan_type = IIO_ST('s', 12, 16, 0),
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(12)
 };
 
 static struct iio_chan_spec adis16350_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 in_supply, ADIS16400_SCAN_SUPPLY, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_x, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_x, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_y, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_z, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, "x", 0, 0,
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 temp0, ADIS16350_SCAN_TEMP_X, IIO_ST('s', 12, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, "y", 1, 0,
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 temp1, ADIS16350_SCAN_TEMP_Y, IIO_ST('s', 12, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, "z", 2, 0,
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 temp2, ADIS16350_SCAN_TEMP_Z, IIO_ST('s', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 in1, ADIS16350_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "supply",
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = in_supply,
+		.scan_index = ADIS16400_SCAN_SUPPLY,
+		.scan_type = IIO_ST('u', 12, 16, 0)
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_x,
+		.scan_index = ADIS16400_SCAN_GYRO_X,
+		.scan_type = IIO_ST('s', 14, 16, 0)
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_y,
+		.scan_index = ADIS16400_SCAN_GYRO_Y,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_z,
+		.scan_index = ADIS16400_SCAN_GYRO_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+	.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_x,
+		.scan_index = ADIS16400_SCAN_ACC_X,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_y,
+		.scan_index = ADIS16400_SCAN_ACC_Y,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_z,
+		.scan_index = ADIS16400_SCAN_ACC_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "x",
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = temp0,
+		.scan_index = ADIS16350_SCAN_TEMP_X,
+		.scan_type = IIO_ST('s', 12, 16, 0),
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 1,
+		.extend_name = "y",
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = temp1,
+		.scan_index = ADIS16350_SCAN_TEMP_Y,
+		.scan_type = IIO_ST('s', 12, 16, 0),
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 2,
+		.extend_name = "z",
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = temp2,
+		.scan_index = ADIS16350_SCAN_TEMP_Z,
+		.scan_type = IIO_ST('s', 12, 16, 0),
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = in1,
+		.scan_index = ADIS16350_SCAN_ADC_0,
+		.scan_type = IIO_ST('s', 12, 16, 0),
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(11)
 };
 
 static struct iio_chan_spec adis16300_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 in_supply, ADIS16400_SCAN_SUPPLY, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_x, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_x, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_y, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_z, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 temp, ADIS16400_SCAN_TEMP, IIO_ST('s', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 in1, ADIS16350_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
-	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 incli_x, ADIS16300_SCAN_INCLI_X, IIO_ST('s', 13, 16, 0), 0),
-	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 incli_y, ADIS16300_SCAN_INCLI_Y, IIO_ST('s', 13, 16, 0), 0),
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "supply",
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = in_supply,
+		.scan_index = ADIS16400_SCAN_SUPPLY,
+		.scan_type = IIO_ST('u', 12, 16, 0)
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_x,
+		.scan_index = ADIS16400_SCAN_GYRO_X,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_x,
+		.scan_index = ADIS16400_SCAN_ACC_X,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_y,
+		.scan_index = ADIS16400_SCAN_ACC_Y,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_z,
+		.scan_index = ADIS16400_SCAN_ACC_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = temp,
+		.scan_index = ADIS16400_SCAN_TEMP,
+		.scan_type = IIO_ST('s', 12, 16, 0),
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = in1,
+		.scan_index = ADIS16350_SCAN_ADC_0,
+		.scan_type = IIO_ST('s', 12, 16, 0),
+	}, {
+		.type = IIO_INCLI,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = incli_x,
+		.scan_index = ADIS16300_SCAN_INCLI_X,
+		.scan_type = IIO_ST('s', 13, 16, 0),
+	}, {
+		.type = IIO_INCLI,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = incli_y,
+		.scan_index = ADIS16300_SCAN_INCLI_Y,
+		.scan_type = IIO_ST('s', 13, 16, 0),
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(14)
 };
 
 static const struct iio_chan_spec adis16344_channels[] = {
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_x, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_x, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_y, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		 accel_z, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-		 temp0, ADIS16350_SCAN_TEMP_X, IIO_ST('s', 12, 16, 0), 0),
+	{
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_x,
+		.scan_index = ADIS16400_SCAN_GYRO_X,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_y,
+		.scan_index = ADIS16400_SCAN_GYRO_Y,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = gyro_z,
+		.scan_index = ADIS16400_SCAN_GYRO_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_x,
+		.scan_index = ADIS16400_SCAN_ACC_X,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_y,
+		.scan_index = ADIS16400_SCAN_ACC_Y,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_z,
+		.scan_index = ADIS16400_SCAN_ACC_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = accel_z,
+		.scan_index = ADIS16400_SCAN_ACC_Z,
+		.scan_type = IIO_ST('s', 14, 16, 0),
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(12)
 };
 
@@ -855,7 +1052,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	}
 
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
+	if (spi->irq) {
 		ret = adis16400_probe_trigger(indio_dev);
 		if (ret)
 			goto error_uninitialize_ring;
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index 3860d92..bf99153 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -29,7 +29,7 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 	struct adis16400_state *st = iio_priv(indio_dev);
 
 	st->trig = iio_allocate_trigger("%s-dev%d",
-					spi_get_device_id(st->us)->name,
+					indio_dev->name,
 					indio_dev->id);
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
-- 
1.7.3.4
