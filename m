Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35219 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbdCDIjc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 03:39:32 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v6 3/4] iio: accel: adxl345: Split driver into core and I2C
Date: Sat,  4 Mar 2017 16:31:25 +0800
Message-Id: <0d31d963f4fe649ba52009f210edc2d0d31b7542.1488615230.git.eraretuya@gmail.com>
In-Reply-To: <cover.1488615230.git.eraretuya@gmail.com>
References: <cover.1488615230.git.eraretuya@gmail.com>
In-Reply-To: <cover.1488615230.git.eraretuya@gmail.com>
References: <cover.1488615230.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move I2C-specific code into its own file and rely on regmap to access
registers. The core code provides access to x, y, z and scale readings.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes from v5:
* Simplify configuration dependency to "depends on INPUT_ADXL34X=n"
* Rename functions from *_common_* to *_core_*
* Modify header comment: place indication at the beginning
* Remove explicit casting to int in handling devm_regmap_init_i2c() error,
  use %ld instead
* Remove temporary variable 'name'

 drivers/iio/accel/Kconfig                       | 13 +++--
 drivers/iio/accel/Makefile                      |  3 +-
 drivers/iio/accel/adxl345.h                     | 18 ++++++
 drivers/iio/accel/{adxl345.c => adxl345_core.c} | 57 ++++---------------
 drivers/iio/accel/adxl345_i2c.c                 | 73 +++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 51 deletions(-)
 create mode 100644 drivers/iio/accel/adxl345.h
 rename drivers/iio/accel/{adxl345.c => adxl345_core.c} (77%)
 create mode 100644 drivers/iio/accel/adxl345_i2c.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 26b8614..a725227 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -6,16 +6,21 @@
 menu "Accelerometers"
 
 config ADXL345
-	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer Driver"
-	depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
+	tristate
+
+config ADXL345_I2C
+	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"
+	depends on INPUT_ADXL34X=n
 	depends on I2C
+	select ADXL345
 	select REGMAP_I2C
 	help
 	  Say Y here if you want to build support for the Analog Devices
 	  ADXL345 3-axis digital accelerometer.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called adxl345.
+	  To compile this driver as a module, choose M here: the module
+	  will be called adxl345_i2c and you will also get adxl345_core
+	  for the core module.
 
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 618488d..3f4a6d6 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -3,7 +3,8 @@
 #
 
 # When adding new entries keep the list in alphabetical order
-obj-$(CONFIG_ADXL345) += adxl345.o
+obj-$(CONFIG_ADXL345) += adxl345_core.o
+obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
new file mode 100644
index 0000000..c1ddf39
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
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       const char *name);
+int adxl345_core_remove(struct device *dev);
+
+#endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345.c b/drivers/iio/accel/adxl345_core.c
similarity index 77%
rename from drivers/iio/accel/adxl345.c
rename to drivers/iio/accel/adxl345_core.c
index 87fdd9f..9ccb582 100644
--- a/drivers/iio/accel/adxl345.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -1,23 +1,20 @@
 /*
- * ADXL345 3-Axis Digital Accelerometer
+ * ADXL345 3-Axis Digital Accelerometer IIO core driver
  *
  * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
  *
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License. See the file COPYING in the main
  * directory of this archive for more details.
- *
- * IIO driver for ADXL345
- * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
- * 0x53 (ALT ADDRESS pin grounded)
  */
 
-#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
 
+#include "adxl345.h"
+
 #define ADXL345_REG_DEVID		0x00
 #define ADXL345_REG_POWER_CTL		0x2D
 #define ADXL345_REG_DATA_FORMAT		0x31
@@ -50,11 +47,6 @@ struct adxl345_data {
 	u8 data_range;
 };
 
-static const struct regmap_config adxl345_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 #define ADXL345_CHANNEL(reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -107,25 +99,14 @@ static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
 };
 
-static int adxl345_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       const char *name)
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
-	struct regmap *regmap;
-	struct device *dev;
 	u32 regval;
 	int ret;
 
-	regmap = devm_regmap_init_i2c(client, &adxl345_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
-
-	dev = regmap_get_device(regmap);
-
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0) {
 		dev_err(dev, "Error reading device ID: %d\n", ret);
@@ -156,7 +137,7 @@ static int adxl345_probe(struct i2c_client *client,
 	}
 
 	indio_dev->dev.parent = dev;
-	indio_dev->name = id->name;
+	indio_dev->name = name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
@@ -179,10 +160,11 @@ static int adxl345_probe(struct i2c_client *client,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(adxl345_core_probe);
 
-static int adxl345_remove(struct i2c_client *client)
+int adxl345_core_remove(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adxl345_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
@@ -190,25 +172,8 @@ static int adxl345_remove(struct i2c_client *client)
 	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
 			    ADXL345_POWER_CTL_STANDBY);
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
+EXPORT_SYMBOL_GPL(adxl345_core_remove);
 
 MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
-MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer driver");
+MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
new file mode 100644
index 0000000..05e1ec4
--- /dev/null
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -0,0 +1,73 @@
+/*
+ * ADXL345 3-Axis Digital Accelerometer I2C driver
+ *
+ * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License. See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
+ * 0x53 (ALT ADDRESS pin grounded)
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "adxl345.h"
+
+static const struct regmap_config adxl345_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int adxl345_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return adxl345_core_probe(&client->dev, regmap, id ? id->name : NULL);
+}
+
+static int adxl345_i2c_remove(struct i2c_client *client)
+{
+	return adxl345_core_remove(&client->dev);
+}
+
+static const struct i2c_device_id adxl345_i2c_id[] = {
+	{ "adxl345", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
+
+static const struct of_device_id adxl345_of_match[] = {
+	{ .compatible = "adi,adxl345" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, adxl345_of_match);
+
+static struct i2c_driver adxl345_i2c_driver = {
+	.driver = {
+		.name	= "adxl345_i2c",
+		.of_match_table = adxl345_of_match,
+	},
+	.probe		= adxl345_i2c_probe,
+	.remove		= adxl345_i2c_remove,
+	.id_table	= adxl345_i2c_id,
+};
+
+module_i2c_driver(adxl345_i2c_driver);
+
+MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
+MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer I2C driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

