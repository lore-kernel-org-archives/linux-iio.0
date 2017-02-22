Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34527 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbdBVKYS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2017 05:24:18 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v3 3/4] iio: accel: adxl345: Split driver into core and I2C
Date: Wed, 22 Feb 2017 18:23:00 +0800
Message-Id: <68ce56410416b439bd59a8e2f4fe294a48cb5fad.1487757223.git.eraretuya@gmail.com>
In-Reply-To: <cover.1487757223.git.eraretuya@gmail.com>
References: <cover.1487757223.git.eraretuya@gmail.com>
In-Reply-To: <cover.1487757223.git.eraretuya@gmail.com>
References: <cover.1487757223.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move I2C-specific code into its own file and rely on regmap to access
registers. The core code provides access to x, y, z and scale readings.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
Change from v2:
* Add OF match table on both I2C and SPI files and document them

Changes from v1:
* Update Kconfig to Jonathan's preferred style
* Improve similarity index from 78% to 100% (rename detection)

 drivers/iio/accel/Kconfig                       | 13 ++--
 drivers/iio/accel/Makefile                      |  3 +-
 drivers/iio/accel/{adxl345.c => adxl345_core.c} |  0
 drivers/iio/accel/adxl345_i2c.c                 | 81 +++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 5 deletions(-)
 rename drivers/iio/accel/{adxl345.c => adxl345_core.c} (100%)
 create mode 100644 drivers/iio/accel/adxl345_i2c.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 26b8614..ffb0a63 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -8,14 +8,19 @@ menu "Accelerometers"
 config ADXL345
 	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer Driver"
 	depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
-	depends on I2C
-	select REGMAP_I2C
+	select REGMAP
+	select ADXL345_I2C if I2C
 	help
 	  Say Y here if you want to build support for the Analog Devices
 	  ADXL345 3-axis digital accelerometer.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called adxl345.
+	  To compile this driver as a module, choose M here: the core
+	  module will be called adxl345_core and you will also get
+	  adxl345_i2c for I2C.
+
+config ADXL345_I2C
+	tristate
+	select REGMAP_I2C
 
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
diff --git a/drivers/iio/accel/adxl345.c b/drivers/iio/accel/adxl345_core.c
similarity index 100%
rename from drivers/iio/accel/adxl345.c
rename to drivers/iio/accel/adxl345_core.c
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
new file mode 100644
index 0000000..df01bd1
--- /dev/null
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -0,0 +1,81 @@
+/*
+ * ADXL345 3-Axis Digital Accelerometer
+ *
+ * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License. See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * I2C driver for ADXL345
+ * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
+ * 0x53 (ALT ADDRESS pin grounded)
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
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
+	const char *name = NULL;
+
+	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Error initializing i2c regmap: %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	if (id)
+		name = id->name;
+
+	return adxl345_common_probe(&client->dev, regmap, name);
+}
+
+static int adxl345_i2c_remove(struct i2c_client *client)
+{
+	return adxl345_common_remove(&client->dev);
+}
+
+static const struct i2c_device_id adxl345_i2c_id[] = {
+	{ "adxl345", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id adxl345_of_match[] = {
+	{ .compatible = "adi,adxl345" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, adxl345_of_match);
+#endif
+
+static struct i2c_driver adxl345_i2c_driver = {
+	.driver = {
+		.name	= "adxl345_i2c",
+		.of_match_table = of_match_ptr(adxl345_of_match),
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

