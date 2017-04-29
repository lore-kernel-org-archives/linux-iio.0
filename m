Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36393 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992735AbdD2Htg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Apr 2017 03:49:36 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2 2/4] iio: accel: adxl345_core: Introduce set_mode and data_ready functions
Date: Sat, 29 Apr 2017 15:48:59 +0800
Message-Id: <96d20633a6ff9792f7be642a590669fc07d9ad63.1493450577.git.eraretuya@gmail.com>
In-Reply-To: <cover.1493450577.git.eraretuya@gmail.com>
References: <cover.1493450577.git.eraretuya@gmail.com>
In-Reply-To: <cover.1493450577.git.eraretuya@gmail.com>
References: <cover.1493450577.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move code that enables measurement/standby mode into its own function
and call that function when appropriate. Previously, we set the sensor
to measurement in probe and back to standby during remove. Change it
here to only enter measurement mode when request for data is initiated.

The DATA_READY bit is always set if the corresponding event occurs.
Introduce the data_ready function that monitors the INT_SOURCE register
of this bit. This is done to ensure consistent readings.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
Changes in v2:
* Make function naming more clear: drdy -> data_ready
  * Switch from while to do..while
  * Rename regval to val
  * Switch to usleep_range() for shorter delay
  * Add comment to justify delay
  * Change error code -EIO to -EAGAIN
* Endianness issue: scrap the get_triple function entirely, make no
  changes in terms of reading registers in read_raw
* Introduce mutex here rather than in succeeding patch
* Probe:
  * Fix random whitespace omission
  * Remove configuring to standby mode, the device powers on in standby
    mode so this is not needed

 drivers/iio/accel/adxl345_core.c | 84 +++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 9ccb582..b8a212c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -8,6 +8,7 @@
  * directory of this archive for more details.
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -17,6 +18,7 @@
 
 #define ADXL345_REG_DEVID		0x00
 #define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_INT_SOURCE		0x30
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_DATAX0		0x32
 #define ADXL345_REG_DATAY0		0x34
@@ -25,6 +27,10 @@
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
 
+/* INT_ENABLE/INT_MAP/INT_SOURCE bits */
+#define ADXL345_INT_DATA_READY		BIT(7)
+#define ADXL345_INT_OVERRUN		0
+
 #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
 #define ADXL345_DATA_FORMAT_2G		0
 #define ADXL345_DATA_FORMAT_4G		1
@@ -44,9 +50,49 @@ static const int adxl345_uscale = 38300;
 
 struct adxl345_data {
 	struct regmap *regmap;
+	struct mutex lock; /* protect this data structure */
 	u8 data_range;
 };
 
+static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL, mode);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set power mode, %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adxl345_data_ready(struct adxl345_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int tries = 5;
+	u32 val;
+	int ret;
+
+	do {
+		/*
+		 * 1/ODR + 1.1ms; 11.1ms at ODR of 0.10 Hz
+		 * Sensor currently operates at default ODR of 100 Hz
+		 */
+		usleep_range(1100, 11100);
+
+		ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &val);
+		if (ret < 0)
+			return ret;
+		if ((val & ADXL345_INT_DATA_READY) == ADXL345_INT_DATA_READY)
+			return 0;
+	} while (--tries);
+	dev_err(dev, "Data is not yet ready, try again.\n");
+
+	return -EAGAIN;
+}
+
 #define ADXL345_CHANNEL(reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -72,6 +118,19 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		ret = adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		ret = adxl345_data_ready(data);
+		if (ret < 0) {
+			adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
+			mutex_unlock(&data->lock);
+			return ret;
+		}
 		/*
 		 * Data is stored in adjacent registers:
 		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
@@ -79,10 +138,15 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		 */
 		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
 				       sizeof(regval));
-		if (ret < 0)
+		mutex_unlock(&data->lock);
+		if (ret < 0) {
+			adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
 			return ret;
+		}
 
 		*val = sign_extend32(le16_to_cpu(regval), 12);
+		adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
@@ -136,6 +200,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	mutex_init(&data->lock);
+
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
 	indio_dev->info = &adxl345_info;
@@ -143,20 +209,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
-	/* Enable measurement mode */
-	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
-			   ADXL345_POWER_CTL_MEASURE);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable measurement mode: %d\n", ret);
-		return ret;
-	}
-
 	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev, "iio_device_register failed: %d\n", ret);
-		regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
-			     ADXL345_POWER_CTL_STANDBY);
-	}
 
 	return ret;
 }
@@ -169,8 +224,7 @@ int adxl345_core_remove(struct device *dev)
 
 	iio_device_unregister(indio_dev);
 
-	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
-			    ADXL345_POWER_CTL_STANDBY);
+	return adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
 }
 EXPORT_SYMBOL_GPL(adxl345_core_remove);
 
-- 
2.7.4

