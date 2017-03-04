Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36484 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdCDIjJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 03:39:09 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v6 2/4] iio: accel: adxl345: Use I2C regmap instead of direct I2C access
Date: Sat,  4 Mar 2017 16:31:24 +0800
Message-Id: <5c19b374e20a749e0287ebdf2d9c41a08f7545a1.1488615230.git.eraretuya@gmail.com>
In-Reply-To: <cover.1488615230.git.eraretuya@gmail.com>
References: <cover.1488615230.git.eraretuya@gmail.com>
In-Reply-To: <cover.1488615230.git.eraretuya@gmail.com>
References: <cover.1488615230.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert the driver to use regmap instead of I2C-specific functions. This
is done in preparation for splitting this driver into core and
I2C-specific code as well as introduction of SPI driver.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes from v5:
* Re-order local variable declarations from longest to shortest line
* Remove explicit casting to int in handling devm_regmap_init_i2c() error,
  use %ld instead

 drivers/iio/accel/Kconfig   |  1 +
 drivers/iio/accel/adxl345.c | 66 +++++++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 23 deletions(-)

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
index c34991f..87fdd9f 100644
--- a/drivers/iio/accel/adxl345.c
+++ b/drivers/iio/accel/adxl345.c
@@ -14,6 +14,7 @@
 
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
 
@@ -45,10 +46,15 @@
 static const int adxl345_uscale = 38300;
 
 struct adxl345_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 	u8 data_range;
 };
 
+static const struct regmap_config adxl345_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 #define ADXL345_CHANNEL(reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -69,6 +75,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
+	__le16 regval;
 	int ret;
 
 	switch (mask) {
@@ -78,11 +85,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
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
@@ -104,37 +112,50 @@ static int adxl345_probe(struct i2c_client *client,
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	struct device *dev;
+	u32 regval;
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(client, ADXL345_REG_DEVID);
+	regmap = devm_regmap_init_i2c(client, &adxl345_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Error initializing regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	dev = regmap_get_device(regmap);
+
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
+	indio_dev->dev.parent = dev;
 	indio_dev->name = id->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -142,19 +163,18 @@ static int adxl345_probe(struct i2c_client *client,
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
@@ -167,8 +187,8 @@ static int adxl345_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	return i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
-					 ADXL345_POWER_CTL_STANDBY);
+	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
+			    ADXL345_POWER_CTL_STANDBY);
 }
 
 static const struct i2c_device_id adxl345_i2c_id[] = {
-- 
2.7.4

