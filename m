Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58057 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbG2NrD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 09:47:03 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 6/7] iio: bmg160: Separate i2c and core driver
Date: Wed, 29 Jul 2015 15:46:08 +0200
Message-Id: <1438177569-18772-7-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch separates the core driver using regmap and the i2c driver
which creates the i2c regmap. Also in the Kconfig file BMG160 and
BMG160_I2C are separate now.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/gyro/Kconfig                     | 18 +++++--
 drivers/iio/gyro/Makefile                    |  3 +-
 drivers/iio/gyro/bmg160.h                    | 10 ++++
 drivers/iio/gyro/{bmg160.c => bmg160_core.c} | 77 ++++------------------------
 drivers/iio/gyro/bmg160_i2c.c                | 73 ++++++++++++++++++++++++++
 5 files changed, 111 insertions(+), 70 deletions(-)
 create mode 100644 drivers/iio/gyro/bmg160.h
 rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (94%)
 create mode 100644 drivers/iio/gyro/bmg160_i2c.c

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 8d2439345673..1e6cfff5546f 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -51,16 +51,28 @@ config ADXRS450
 	  will be called adxrs450.
 
 config BMG160
-	tristate "BOSCH BMG160 Gyro Sensor"
-	depends on I2C
+	bool "BOSCH BMG160 Gyro Sensor"
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select REGMAP
 	help
 	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
 	  driver. This driver also supports BMI055 gyroscope.
 
+if BMG160
+
+config BMG160_I2C
+	tristate "Driver for connection via I2C"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
+	  driver connected via I2C. This driver also supports BMI055 gyroscope.
+
 	  This driver can also be built as a module.  If so, the module
-	  will be called bmg160.
+	  will be called bmg160_i2c.
+
+endif
 
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index f46341b39139..608401041550 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_ADIS16130) += adis16130.o
 obj-$(CONFIG_ADIS16136) += adis16136.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
-obj-$(CONFIG_BMG160) += bmg160.o
+obj-$(CONFIG_BMG160) += bmg160_core.o
+obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
 
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
 
diff --git a/drivers/iio/gyro/bmg160.h b/drivers/iio/gyro/bmg160.h
new file mode 100644
index 000000000000..72db723c8fb6
--- /dev/null
+++ b/drivers/iio/gyro/bmg160.h
@@ -0,0 +1,10 @@
+#ifndef BMG160_H_
+#define BMG160_H_
+
+extern const struct dev_pm_ops bmg160_pm_ops;
+
+int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
+		      const char *name);
+void bmg160_core_remove(struct device *dev);
+
+#endif  /* BMG160_H_ */
diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160_core.c
similarity index 94%
rename from drivers/iio/gyro/bmg160.c
rename to drivers/iio/gyro/bmg160_core.c
index 865ef4c1c43f..ba37db5d491a 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -30,7 +29,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/regmap.h>
 
-#define BMG160_DRV_NAME		"bmg160"
 #define BMG160_IRQ_NAME		"bmg160_event"
 #define BMG160_GPIO_NAME		"gpio_int"
 
@@ -137,14 +135,6 @@ static const struct {
 			   { 133, BMG160_RANGE_250DPS},
 			   { 66, BMG160_RANGE_125DPS} };
 
-struct regmap_config bmg160_regmap_i2c_conf = {
-	.reg_bits = 8,
-	.val_bits = 8,
-
-	.use_single_rw = true,
-	.cache_type = REGCACHE_NONE,
-};
-
 static int bmg160_set_mode(struct bmg160_data *data, u8 mode)
 {
 	int ret;
@@ -998,31 +988,22 @@ static const char *bmg160_match_acpi_device(struct device *dev)
 	return dev_name(dev);
 }
 
-static int bmg160_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
+		      const char *name)
 {
 	struct bmg160_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
-	const char *name = NULL;
-	struct regmap *regmap;
-	struct device *dev = &client->dev;
-
-	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
 	data->dev = dev;
-	data->irq = client->irq;
+	data->irq = irq;
+	data->regmap = regmap;
 
 	ret = bmg160_chip_init(data);
 	if (ret < 0)
@@ -1030,9 +1011,6 @@ static int bmg160_probe(struct i2c_client *client,
 
 	mutex_init(&data->mutex);
 
-	if (id)
-		name = id->name;
-
 	if (ACPI_HANDLE(dev))
 		name = bmg160_match_acpi_device(dev);
 
@@ -1128,14 +1106,14 @@ err_trigger_unregister:
 	return ret;
 }
 
-static int bmg160_remove(struct i2c_client *client)
+void bmg160_core_remove(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmg160_data *data = iio_priv(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
@@ -1148,8 +1126,6 @@ static int bmg160_remove(struct i2c_client *client)
 	mutex_lock(&data->mutex);
 	bmg160_set_mode(data, BMG160_MODE_DEEP_SUSPEND);
 	mutex_unlock(&data->mutex);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1212,40 +1188,9 @@ static int bmg160_runtime_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops bmg160_pm_ops = {
+const struct dev_pm_ops bmg160_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(bmg160_suspend, bmg160_resume)
 	SET_RUNTIME_PM_OPS(bmg160_runtime_suspend,
 			   bmg160_runtime_resume, NULL)
 };
 
-static const struct acpi_device_id bmg160_acpi_match[] = {
-	{"BMG0160", 0},
-	{"BMI055B", 0},
-	{},
-};
-
-MODULE_DEVICE_TABLE(acpi, bmg160_acpi_match);
-
-static const struct i2c_device_id bmg160_id[] = {
-	{"bmg160", 0},
-	{"bmi055_gyro", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, bmg160_id);
-
-static struct i2c_driver bmg160_driver = {
-	.driver = {
-		.name	= BMG160_DRV_NAME,
-		.acpi_match_table = ACPI_PTR(bmg160_acpi_match),
-		.pm	= &bmg160_pm_ops,
-	},
-	.probe		= bmg160_probe,
-	.remove		= bmg160_remove,
-	.id_table	= bmg160_id,
-};
-module_i2c_driver(bmg160_driver);
-
-MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("BMG160 Gyro driver");
diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
new file mode 100644
index 000000000000..9f3e82d0e30c
--- /dev/null
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -0,0 +1,73 @@
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+
+#include "bmg160.h"
+
+struct regmap_config bmg160_regmap_i2c_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.use_single_rw = true,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int bmg160_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	const char *name = NULL;
+
+	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	if (id)
+		name = id->name;
+
+	return bmg160_core_probe(&client->dev, regmap, client->irq, name);
+}
+
+static int bmg160_i2c_remove(struct i2c_client *client)
+{
+	bmg160_core_remove(&client->dev);
+
+	return 0;
+}
+
+static const struct acpi_device_id bmg160_acpi_match[] = {
+	{"BMG0160", 0},
+	{"BMI055B", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, bmg160_acpi_match);
+
+static const struct i2c_device_id bmg160_i2c_id[] = {
+	{"bmg160", 0},
+	{"bmi055_gyro", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
+
+static struct i2c_driver bmg160_i2c_driver = {
+	.driver = {
+		.name	= "bmg160_i2c",
+		.acpi_match_table = ACPI_PTR(bmg160_acpi_match),
+		.pm	= &bmg160_pm_ops,
+	},
+	.probe		= bmg160_i2c_probe,
+	.remove		= bmg160_i2c_remove,
+	.id_table	= bmg160_i2c_id,
+};
+module_i2c_driver(bmg160_i2c_driver);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BMG160 I2C Gyro driver");
-- 
2.1.4

