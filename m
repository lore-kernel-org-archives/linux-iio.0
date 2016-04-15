Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5999 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbcDOOLD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Apr 2016 10:11:03 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, irina.tirdea@intel.com
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, geert@linux-m68k.org,
	vlad.dogaru@intel.com, octavian.purdila@intel.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: magn: Split bmc150 driver in common/i2c parts
Date: Fri, 15 Apr 2016 17:13:09 +0300
Message-Id: <1460729590-18886-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1460729590-18886-1-git-send-email-daniel.baluta@intel.com>
References: <1460729590-18886-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is useful for easily adding SPI support in later patches.

Now bmc150_magn exports core functions to be used by I2C/SPI drivers
instances. For the moment only I2C driver is supported.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/Kconfig           |  17 ++--
 drivers/iio/magnetometer/Makefile          |   2 +
 drivers/iio/magnetometer/bmc150_magn.c     | 155 ++++++++++++-----------------
 drivers/iio/magnetometer/bmc150_magn.h     |  11 ++
 drivers/iio/magnetometer/bmc150_magn_i2c.c |  77 ++++++++++++++
 5 files changed, 163 insertions(+), 99 deletions(-)
 create mode 100644 drivers/iio/magnetometer/bmc150_magn.h
 create mode 100644 drivers/iio/magnetometer/bmc150_magn_i2c.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 021dc53..e916005 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -25,22 +25,25 @@ config AK09911
 	  Deprecated: AK09911 is now supported by AK8975 driver.
 
 config BMC150_MAGN
-	tristate "Bosch BMC150 Magnetometer Driver"
-	depends on I2C
-	select REGMAP_I2C
+	tristate
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for the BMC150 magnetometer.
 
-	  Currently this only supports the device via an i2c interface.
+config BMC150_MAGN_I2C
+	tristate "Bosch BMC150 I2C Magnetometer Driver"
+	depends on I2C
+	select BMC150_MAGN
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for the BMC150 magnetometer with
+	  I2C interface.
 
 	  This is a combo module with both accelerometer and magnetometer.
 	  This driver is only implementing magnetometer part, which has
 	  its own address and register map.
 
 	  To compile this driver as a module, choose M here: the module will be
-	  called bmc150_magn.
+	  called bmc150_magn_i2c.
 
 config MAG3110
 	tristate "Freescale MAG3110 3-Axis Magnetometer"
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index dd03fe5..5647773 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -5,6 +5,8 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AK8975)	+= ak8975.o
 obj-$(CONFIG_BMC150_MAGN) += bmc150_magn.o
+obj-$(CONFIG_BMC150_MAGN_I2C) += bmc150_magn_i2c.o
+
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 0e9da18..d104fb8 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -34,6 +34,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/regmap.h>
 
+#include "bmc150_magn.h"
+
 #define BMC150_MAGN_DRV_NAME			"bmc150_magn"
 #define BMC150_MAGN_IRQ_NAME			"bmc150_magn_event"
 
@@ -134,7 +136,7 @@ struct bmc150_magn_trim_regs {
 } __packed;
 
 struct bmc150_magn_data {
-	struct i2c_client *client;
+	struct device *dev;
 	/*
 	 * 1. Protect this structure.
 	 * 2. Serialize sequences that power on/off the device and access HW.
@@ -146,6 +148,7 @@ struct bmc150_magn_data {
 	struct iio_trigger *dready_trig;
 	bool dready_trigger_on;
 	int max_odr;
+	int irq;
 };
 
 static const struct {
@@ -215,7 +218,7 @@ static bool bmc150_magn_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static const struct regmap_config bmc150_magn_regmap_config = {
+const struct regmap_config bmc150_magn_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -225,6 +228,7 @@ static const struct regmap_config bmc150_magn_regmap_config = {
 	.writeable_reg = bmc150_magn_is_writeable_reg,
 	.volatile_reg = bmc150_magn_is_volatile_reg,
 };
+EXPORT_SYMBOL(bmc150_magn_regmap_config);
 
 static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
 				      enum bmc150_magn_power_modes mode,
@@ -263,17 +267,17 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 	int ret;
 
 	if (on) {
-		ret = pm_runtime_get_sync(&data->client->dev);
+		ret = pm_runtime_get_sync(data->dev);
 	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
+		pm_runtime_mark_last_busy(data->dev);
+		ret = pm_runtime_put_autosuspend(data->dev);
 	}
 
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"failed to change power state to %d\n", on);
 		if (on)
-			pm_runtime_put_noidle(&data->client->dev);
+			pm_runtime_put_noidle(data->dev);
 
 		return ret;
 	}
@@ -350,7 +354,7 @@ static int bmc150_magn_set_max_odr(struct bmc150_magn_data *data, int rep_xy,
 	/* the maximum selectable read-out frequency from datasheet */
 	max_odr = 1000000 / (145 * rep_xy + 500 * rep_z + 980);
 	if (odr > max_odr) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"Can't set oversampling with sampling freq %d\n",
 			odr);
 		return -EINVAL;
@@ -684,27 +688,27 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
 					 false);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
+		dev_err(data->dev,
 			"Failed to bring up device from suspend mode\n");
 		return ret;
 	}
 
 	ret = regmap_read(data->regmap, BMC150_MAGN_REG_CHIP_ID, &chip_id);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Failed reading chip id\n");
+		dev_err(data->dev, "Failed reading chip id\n");
 		goto err_poweroff;
 	}
 	if (chip_id != BMC150_MAGN_CHIP_ID_VAL) {
-		dev_err(&data->client->dev, "Invalid chip id 0x%x\n", chip_id);
+		dev_err(data->dev, "Invalid chip id 0x%x\n", chip_id);
 		ret = -ENODEV;
 		goto err_poweroff;
 	}
-	dev_dbg(&data->client->dev, "Chip id %x\n", chip_id);
+	dev_dbg(data->dev, "Chip id %x\n", chip_id);
 
 	preset = bmc150_magn_presets_table[BMC150_MAGN_DEFAULT_PRESET];
 	ret = bmc150_magn_set_odr(data, preset.odr);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Failed to set ODR to %d\n",
+		dev_err(data->dev, "Failed to set ODR to %d\n",
 			preset.odr);
 		goto err_poweroff;
 	}
@@ -712,7 +716,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	ret = regmap_write(data->regmap, BMC150_MAGN_REG_REP_XY,
 			   BMC150_MAGN_REPXY_TO_REGVAL(preset.rep_xy));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Failed to set REP XY to %d\n",
+		dev_err(data->dev, "Failed to set REP XY to %d\n",
 			preset.rep_xy);
 		goto err_poweroff;
 	}
@@ -720,7 +724,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	ret = regmap_write(data->regmap, BMC150_MAGN_REG_REP_Z,
 			   BMC150_MAGN_REPZ_TO_REGVAL(preset.rep_z));
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Failed to set REP Z to %d\n",
+		dev_err(data->dev, "Failed to set REP Z to %d\n",
 			preset.rep_z);
 		goto err_poweroff;
 	}
@@ -733,7 +737,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
 					 true);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Failed to power on device\n");
+		dev_err(data->dev, "Failed to power on device\n");
 		goto err_poweroff;
 	}
 
@@ -842,41 +846,33 @@ static const char *bmc150_magn_match_acpi_device(struct device *dev)
 	return dev_name(dev);
 }
 
-static int bmc150_magn_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
+		      int irq, const char *name)
 {
 	struct bmc150_magn_data *data;
 	struct iio_dev *indio_dev;
-	const char *name = NULL;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+	dev_set_drvdata(dev, indio_dev);
+	data->regmap = regmap;
+	data->irq = irq;
+	data->dev = dev;
 
-	if (id)
-		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = bmc150_magn_match_acpi_device(&client->dev);
-	else
-		return -ENOSYS;
+	if (!name && ACPI_HANDLE(dev))
+		name = bmc150_magn_match_acpi_device(dev);
 
 	mutex_init(&data->mutex);
-	data->regmap = devm_regmap_init_i2c(client, &bmc150_magn_regmap_config);
-	if (IS_ERR(data->regmap)) {
-		dev_err(&client->dev, "Failed to allocate register map\n");
-		return PTR_ERR(data->regmap);
-	}
 
 	ret = bmc150_magn_init(data);
 	if (ret < 0)
 		return ret;
 
-	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.parent = dev;
 	indio_dev->channels = bmc150_magn_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmc150_magn_channels);
 	indio_dev->available_scan_masks = bmc150_magn_scan_masks;
@@ -884,35 +880,34 @@ static int bmc150_magn_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_magn_info;
 
-	if (client->irq > 0) {
-		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
+	if (irq > 0) {
+		data->dready_trig = devm_iio_trigger_alloc(dev,
 							   "%s-dev%d",
 							   indio_dev->name,
 							   indio_dev->id);
 		if (!data->dready_trig) {
 			ret = -ENOMEM;
-			dev_err(&client->dev, "iio trigger alloc failed\n");
+			dev_err(dev, "iio trigger alloc failed\n");
 			goto err_poweroff;
 		}
 
-		data->dready_trig->dev.parent = &client->dev;
+		data->dready_trig->dev.parent = dev;
 		data->dready_trig->ops = &bmc150_magn_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		ret = iio_trigger_register(data->dready_trig);
 		if (ret) {
-			dev_err(&client->dev, "iio trigger register failed\n");
+			dev_err(dev, "iio trigger register failed\n");
 			goto err_poweroff;
 		}
 
-		ret = request_threaded_irq(client->irq,
+		ret = request_threaded_irq(irq,
 					   iio_trigger_generic_data_rdy_poll,
 					   NULL,
 					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					   BMC150_MAGN_IRQ_NAME,
 					   data->dready_trig);
 		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+			dev_err(dev, "request irq %d failed\n", irq);
 			goto err_trigger_unregister;
 		}
 	}
@@ -922,34 +917,33 @@ static int bmc150_magn_probe(struct i2c_client *client,
 					 bmc150_magn_trigger_handler,
 					 &bmc150_magn_buffer_setup_ops);
 	if (ret < 0) {
-		dev_err(&client->dev,
-			"iio triggered buffer setup failed\n");
+		dev_err(dev, "iio triggered buffer setup failed\n");
 		goto err_free_irq;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		goto err_buffer_cleanup;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev,
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev,
 					 BMC150_MAGN_AUTO_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
+		dev_err(dev, "unable to register iio device\n");
 		goto err_buffer_cleanup;
 	}
 
-	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
+	dev_dbg(dev, "Registered device %s\n", name);
 	return 0;
 
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_free_irq:
-	if (client->irq > 0)
-		free_irq(client->irq, data->dready_trig);
+	if (irq > 0)
+		free_irq(irq, data->dready_trig);
 err_trigger_unregister:
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
@@ -957,22 +951,23 @@ err_poweroff:
 	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
 	return ret;
 }
+EXPORT_SYMBOL(bmc150_magn_probe);
 
-static int bmc150_magn_remove(struct i2c_client *client)
+int bmc150_magn_remove(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
 
-	if (client->irq > 0)
-		free_irq(data->client->irq, data->dready_trig);
+	if (data->irq > 0)
+		free_irq(data->irq, data->dready_trig);
 
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
@@ -983,11 +978,12 @@ static int bmc150_magn_remove(struct i2c_client *client)
 
 	return 0;
 }
+EXPORT_SYMBOL(bmc150_magn_remove);
 
 #ifdef CONFIG_PM
 static int bmc150_magn_runtime_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
@@ -996,7 +992,7 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
 					 true);
 	mutex_unlock(&data->mutex);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "powering off device failed\n");
+		dev_err(dev, "powering off device failed\n");
 		return ret;
 	}
 	return 0;
@@ -1007,7 +1003,7 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
  */
 static int bmc150_magn_runtime_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 
 	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
@@ -1018,7 +1014,7 @@ static int bmc150_magn_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int bmc150_magn_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
@@ -1032,7 +1028,7 @@ static int bmc150_magn_suspend(struct device *dev)
 
 static int bmc150_magn_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
@@ -1045,38 +1041,13 @@ static int bmc150_magn_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops bmc150_magn_pm_ops = {
+const struct dev_pm_ops bmc150_magn_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(bmc150_magn_suspend, bmc150_magn_resume)
 	SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
 			   bmc150_magn_runtime_resume, NULL)
 };
-
-static const struct acpi_device_id bmc150_magn_acpi_match[] = {
-	{"BMC150B", 0},
-	{"BMC156B", 0},
-	{},
-};
-MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
-
-static const struct i2c_device_id bmc150_magn_id[] = {
-	{"bmc150_magn", 0},
-	{"bmc156_magn", 0},
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, bmc150_magn_id);
-
-static struct i2c_driver bmc150_magn_driver = {
-	.driver = {
-		   .name = BMC150_MAGN_DRV_NAME,
-		   .acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
-		   .pm = &bmc150_magn_pm_ops,
-		   },
-	.probe = bmc150_magn_probe,
-	.remove = bmc150_magn_remove,
-	.id_table = bmc150_magn_id,
-};
-module_i2c_driver(bmc150_magn_driver);
+EXPORT_SYMBOL(bmc150_magn_pm_ops);
 
 MODULE_AUTHOR("Irina Tirdea <irina.tirdea@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("BMC150 magnetometer driver");
+MODULE_DESCRIPTION("BMC150 magnetometer core driver");
diff --git a/drivers/iio/magnetometer/bmc150_magn.h b/drivers/iio/magnetometer/bmc150_magn.h
new file mode 100644
index 0000000..9a8e268
--- /dev/null
+++ b/drivers/iio/magnetometer/bmc150_magn.h
@@ -0,0 +1,11 @@
+#ifndef _BMC150_MAGN_H_
+#define _BMC150_MAGN_H_
+
+extern const struct regmap_config bmc150_magn_regmap_config;
+extern const struct dev_pm_ops bmc150_magn_pm_ops;
+
+int bmc150_magn_probe(struct device *dev, struct regmap *regmap, int irq,
+		      const char *name);
+int bmc150_magn_remove(struct device *dev);
+
+#endif /* _BMC150_MAGN_H_ */
diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
new file mode 100644
index 0000000..eddc7f0
--- /dev/null
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -0,0 +1,77 @@
+/*
+ * 3-axis magnetometer driver supporting following I2C Bosch-Sensortec chips:
+ *  - BMC150
+ *  - BMC156
+ *
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/regmap.h>
+
+#include "bmc150_magn.h"
+
+static int bmc150_magn_i2c_probe(struct i2c_client *client,
+				 const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	const char *name = NULL;
+
+	regmap = devm_regmap_init_i2c(client, &bmc150_magn_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	if (id)
+		name = id->name;
+
+	return bmc150_magn_probe(&client->dev, regmap, client->irq, name);
+}
+
+static int bmc150_magn_i2c_remove(struct i2c_client *client)
+{
+	return bmc150_magn_remove(&client->dev);
+}
+
+static const struct acpi_device_id bmc150_magn_acpi_match[] = {
+	{"BMC150B", 0},
+	{"BMC156B", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
+
+static const struct i2c_device_id bmc150_magn_i2c_id[] = {
+	{"bmc150_magn",	0},
+	{"bmc156_magn", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
+
+static struct i2c_driver bmc150_magn_driver = {
+	.driver = {
+		.name	= "bmc150_magn_i2c",
+		.acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
+		.pm	= &bmc150_magn_pm_ops,
+	},
+	.probe		= bmc150_magn_i2c_probe,
+	.remove		= bmc150_magn_i2c_remove,
+	.id_table	= bmc150_magn_i2c_id,
+};
+module_i2c_driver(bmc150_magn_driver);
+
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BMC150 I2C magnetometer driver");
-- 
2.5.0

