Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr710042.outbound.protection.outlook.com ([40.107.71.42]:21224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729699AbeGMMUY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Jul 2018 08:20:24 -0400
From: Mircea Caprioru <mircea.caprioru@analog.com>
To: <eraretuya@gmail.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC: <devicetree@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] iio: adxl345: Add support for the ADXL375
Date: Fri, 13 Jul 2018 14:50:44 +0300
Message-ID: <20180713115044.32301-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

The ADXL375 is fully register map compatible to the ADXL345 (including the
device ID register returning the same value ...).

The only difference is the resolution of the acceleration sensor. The
ADXL375 can measure up to +-200g of acceleration.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL375.PDF

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 .../devicetree/bindings/iio/accel/adxl345.txt |  5 +++--
 drivers/iio/accel/Kconfig                     |  4 ++--
 drivers/iio/accel/adxl345.h                   |  7 ++++++-
 drivers/iio/accel/adxl345_core.c              | 19 +++++++++++++++++--
 drivers/iio/accel/adxl345_i2c.c               |  6 ++++--
 drivers/iio/accel/adxl345_spi.c               |  6 ++++--
 6 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl345.txt b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
index e7111b02c02c..ca5761b888ac 100644
--- a/Documentation/devicetree/bindings/iio/accel/adxl345.txt
+++ b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
@@ -1,9 +1,10 @@
-Analog Devices ADXL345 3-Axis, +/-(2g/4g/8g/16g) Digital Accelerometer
+Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
 
 http://www.analog.com/en/products/mems/accelerometers/adxl345.html
+http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
 
 Required properties:
- - compatible : should be "adi,adxl345"
+ - compatible : should be one of "adi,adxl345", "adi,adxl375"
  - reg : the I2C address or SPI chip select number of the sensor
 
 Required properties for SPI bus usage:
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 62ae7e5abcfa..829dc96c9dd6 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -40,7 +40,7 @@ config ADXL345_I2C
 	select REGMAP_I2C
 	help
 	  Say Y here if you want to build support for the Analog Devices
-	  ADXL345 3-axis digital accelerometer.
+	  ADXL345 or ADXL375 3-axis digital accelerometer.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called adxl345_i2c and you will also get adxl345_core
@@ -54,7 +54,7 @@ config ADXL345_SPI
 	select REGMAP_SPI
 	help
 	  Say Y here if you want to build support for the Analog Devices
-	  ADXL345 3-axis digital accelerometer.
+	  ADXL345 or ADXL375 3-axis digital accelerometer.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called adxl345_spi and you will also get adxl345_core
diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index c1ddf3927c47..ccd63de7a55a 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -11,8 +11,13 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+enum adxl345_device_type {
+	ADXL345,
+	ADXL375,
+};
+
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-		       const char *name);
+		       enum adxl345_device_type type, const char *name);
 int adxl345_core_remove(struct device *dev);
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7b29ae8375e9..03f5061ee317 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -50,9 +50,16 @@
  */
 static const int adxl345_uscale = 38300;
 
+/*
+ * The Datasheet lists a resolution of Resolution is ~49 mg per LSB. That's
+ * ~480mm/s**2 per LSB.
+ */
+static const int adxl375_uscale = 480000;
+
 struct adxl345_data {
 	struct regmap *regmap;
 	u8 data_range;
+	enum adxl345_device_type type;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -97,7 +104,14 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = adxl345_uscale;
+		switch (data->type) {
+		case ADXL345:
+			*val2 = adxl345_uscale;
+			break;
+		case ADXL375:
+			*val2 = adxl375_uscale;
+			break;
+		}
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -143,7 +157,7 @@ static const struct iio_info adxl345_info = {
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
-		       const char *name)
+		       enum adxl345_device_type type, const char *name)
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
@@ -169,6 +183,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
+	data->type = type;
 	/* Enable full-resolution mode */
 	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
 
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 05e1ec49700c..d24bf81adb95 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -34,7 +34,7 @@ static int adxl345_i2c_probe(struct i2c_client *client,
 		return PTR_ERR(regmap);
 	}
 
-	return adxl345_core_probe(&client->dev, regmap, id ? id->name : NULL);
+	return adxl345_core_probe(&client->dev, regmap, id->driver_data, id ? id->name : NULL);
 }
 
 static int adxl345_i2c_remove(struct i2c_client *client)
@@ -43,7 +43,8 @@ static int adxl345_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adxl345_i2c_id[] = {
-	{ "adxl345", 0 },
+	{ "adxl345", ADXL345 },
+	{ "adxl375", ADXL375 },
 	{ }
 };
 
@@ -51,6 +52,7 @@ MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
 static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl345" },
+	{ .compatible = "adi,adxl375" },
 	{ },
 };
 
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 6d658196f81c..67b7c66a8492 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -42,7 +42,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return adxl345_core_probe(&spi->dev, regmap, id->name);
+	return adxl345_core_probe(&spi->dev, regmap, id->driver_data, id->name);
 }
 
 static int adxl345_spi_remove(struct spi_device *spi)
@@ -51,7 +51,8 @@ static int adxl345_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id adxl345_spi_id[] = {
-	{ "adxl345", 0 },
+	{ "adxl345", ADXL345 },
+	{ "adxl375", ADXL375 },
 	{ }
 };
 
@@ -59,6 +60,7 @@ MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
 	{ .compatible = "adi,adxl345" },
+	{ .compatible = "adi,adxl375" },
 	{ },
 };
 
-- 
2.17.1

