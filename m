Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34485 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754607AbdBVKYK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2017 05:24:10 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v3 2/4] iio: accel: adxl345: Use I2C regmap instead of direct I2C access
Date: Wed, 22 Feb 2017 18:22:59 +0800
Message-Id: <b477e7142cb39b5bb86670191f41dcc031e80569.1487757223.git.eraretuya@gmail.com>
In-Reply-To: <cover.1487757223.git.eraretuya@gmail.com>
References: <cover.1487757223.git.eraretuya@gmail.com>
In-Reply-To: <cover.1487757223.git.eraretuya@gmail.com>
References: <cover.1487757223.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert the driver to use regmap instead of I2C-specific functions.
Also, introduce the header file "adxl345.h" and export the probe and
remove functions. This is done in preparation for splitting this driver
into core and I2C-specific code as well as introduction of SPI driver.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
Change from v2:
* None

Changes from v1:
* Move other deletions from patch 2 in here -- make it clear what got deleted
  and/or modified that is hard to see previously
* Introduce the driver header file "adxl345.h" here instead of doing it in the
  next patch
* Completely omit traces of i2c_client and let this file (adxl345.c) mirror the
  core file on the next patch.
* Improve debugging print about invalid device ID in probe.

 drivers/iio/accel/Kconfig   |  1 +
 drivers/iio/accel/adxl345.c | 88 ++++++++++++++++++++-------------------------
 drivers/iio/accel/adxl345.h | 18 ++++++++++
 3 files changed, 57 insertions(+), 50 deletions(-)
 create mode 100644 drivers/iio/accel/adxl345.h

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 2308bac..26b8614 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -9,6 +9,7 @@ config ADXL345
 	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer Driver"
 	depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y here if you want to build support for the Analog Devices
 	  ADXL345 3-axis digital accelerometer.
diff --git a/drivers/iio/accel/adxl345.c b/drivers/iio/accel/adxl345.c
index c34991f..a3bd711 100644
--- a/drivers/iio/accel/adxl345.c
+++ b/drivers/iio/accel/adxl345.c
@@ -7,16 +7,17 @@
  * the GNU General Public License. See the file COPYING in the main
  * directory of this archive for more details.
  *
- * IIO driver for ADXL345
- * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
- * 0x53 (ALT ADDRESS pin grounded)
+ * IIO core driver for ADXL345
  */
 
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
 
+#include "adxl345.h"
+
 #define ADXL345_REG_DEVID		0x00
 #define ADXL345_REG_POWER_CTL		0x2D
 #define ADXL345_REG_DATA_FORMAT		0x31
@@ -45,7 +46,7 @@
 static const int adxl345_uscale = 38300;
 
 struct adxl345_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 	u8 data_range;
 };
 
@@ -70,6 +71,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
 	int ret;
+	__le16 regval;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -78,11 +80,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
 		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
 		 */
-		ret = i2c_smbus_read_word_data(data->client, chan->address);
+		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
+				       sizeof(regval));
 		if (ret < 0)
 			return ret;
 
-		*val = sign_extend32(ret, 12);
+		*val = sign_extend32(le16_to_cpu(regval), 12);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
@@ -99,96 +102,81 @@ static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
 };
 
-static int adxl345_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+int adxl345_common_probe(struct device *dev, struct regmap *regmap,
+			 const char *name)
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
+	u32 regval;
 
-	ret = i2c_smbus_read_byte_data(client, ADXL345_REG_DEVID);
+	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0) {
-		dev_err(&client->dev, "Error reading device ID: %d\n", ret);
+		dev_err(dev, "Error reading device ID: %d\n", ret);
 		return ret;
 	}
 
-	if (ret != ADXL345_DEVID) {
-		dev_err(&client->dev, "Invalid device ID: %d\n", ret);
+	if (regval != ADXL345_DEVID) {
+		dev_err(dev, "Invalid device ID: %x, expected %x\n",
+			regval, ADXL345_DEVID);
 		return -ENODEV;
 	}
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+	dev_set_drvdata(dev, indio_dev);
+	data->regmap = regmap;
 	/* Enable full-resolution mode */
 	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
 
-	ret = i2c_smbus_write_byte_data(data->client, ADXL345_REG_DATA_FORMAT,
-					data->data_range);
+	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
+			   data->data_range);
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed to set data range: %d\n", ret);
+		dev_err(dev, "Failed to set data range: %d\n", ret);
 		return ret;
 	}
 
-	indio_dev->dev.parent = &client->dev;
-	indio_dev->name = id->name;
+	indio_dev->dev.parent = dev;
+	indio_dev->name = name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
 	/* Enable measurement mode */
-	ret = i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
-					ADXL345_POWER_CTL_MEASURE);
+	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
+			   ADXL345_POWER_CTL_MEASURE);
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed to enable measurement mode: %d\n",
-			ret);
+		dev_err(dev, "Failed to enable measurement mode: %d\n", ret);
 		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "iio_device_register failed: %d\n", ret);
-		i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
-					  ADXL345_POWER_CTL_STANDBY);
+		dev_err(dev, "iio_device_register failed: %d\n", ret);
+		regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
+			     ADXL345_POWER_CTL_STANDBY);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(adxl345_common_probe);
 
-static int adxl345_remove(struct i2c_client *client)
+int adxl345_common_remove(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adxl345_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
-	return i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
-					 ADXL345_POWER_CTL_STANDBY);
+	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
+			    ADXL345_POWER_CTL_STANDBY);
 }
-
-static const struct i2c_device_id adxl345_i2c_id[] = {
-	{ "adxl345", 0 },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
-
-static struct i2c_driver adxl345_driver = {
-	.driver = {
-		.name	= "adxl345",
-	},
-	.probe		= adxl345_probe,
-	.remove		= adxl345_remove,
-	.id_table	= adxl345_i2c_id,
-};
-
-module_i2c_driver(adxl345_driver);
+EXPORT_SYMBOL_GPL(adxl345_common_remove);
 
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
-MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer driver");
+MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
new file mode 100644
index 0000000..fca3e25
--- /dev/null
+++ b/drivers/iio/accel/adxl345.h
@@ -0,0 +1,18 @@
+/*
+ * ADXL345 3-Axis Digital Accelerometer
+ *
+ * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License. See the file COPYING in the main
+ * directory of this archive for more details.
+ */
+
+#ifndef _ADXL345_H_
+#define _ADXL345_H_
+
+int adxl345_common_probe(struct device *dev, struct regmap *regmap,
+			 const char *name);
+int adxl345_common_remove(struct device *dev);
+
+#endif /* _ADXL345_H_ */
-- 
2.7.4

