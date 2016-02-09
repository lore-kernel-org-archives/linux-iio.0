Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47057 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785AbcBIPjn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 9 Feb 2016 10:39:43 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, daniel.baluta@intel.com, mwelling@ieee.org,
	lucas.de.marchi@gmail.com, adi.reus@gmail.com,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v3 3/4] iio: imu: inv_mpu6050: Separate driver into core and i2c functionality.
Date: Tue,  9 Feb 2016 17:38:19 +0200
Message-Id: <1455032300-12466-4-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1455032300-12466-1-git-send-email-adriana.reus@intel.com>
References: <1455032300-12466-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Separate this driver into core and i2c functionality.
This is in preparation for adding spi support.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 Changes since v2:
 * Fix the compilation error that occurs if CONFIG_ACPI is not defined

 drivers/iio/imu/inv_mpu6050/Kconfig           |  15 +-
 drivers/iio/imu/inv_mpu6050/Makefile          |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  18 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 208 ++++----------------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 207 +++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  12 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   4 +-
 8 files changed, 271 insertions(+), 203 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index f301f3a..4e8ea9e 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -4,11 +4,9 @@
 
 config INV_MPU6050_IIO
 	tristate "Invensense MPU6050 devices"
-	depends on I2C && SYSFS
+	depends on SYSFS
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-	select I2C_MUX
-	select REGMAP_I2C
 	help
 	  This driver supports the Invensense MPU6050 devices.
 	  This driver can also support MPU6500 in MPU6050 compatibility mode
@@ -16,3 +14,14 @@ config INV_MPU6050_IIO
 	  It is a gyroscope/accelerometer combo device.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050.
+
+config INV_MPU6050_I2C
+	tristate "Invensense MPU6050 devices (I2C)"
+	depends on I2C
+	select INV_MPU6050_IIO
+	select I2C_MUX
+	select REGMAP_I2C
+	help
+	  This driver can be built as a module. The module will be called
+	  inv-mpu6050-i2c.
+
diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
index f566f6a..ca4941d 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -3,4 +3,7 @@
 #
 
 obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
-inv-mpu6050-objs := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o inv_mpu_acpi.o
+inv-mpu6050-objs := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
+
+obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
+inv-mpu6050-i2c-objs := inv_mpu_i2c.o inv_mpu_acpi.o
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 1c982a5..0bcfa8d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -139,22 +139,23 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
 	return 0;
 }
 
-int inv_mpu_acpi_create_mux_client(struct inv_mpu6050_state *st)
+int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 {
+	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(&client->dev));
 
 	st->mux_client = NULL;
-	if (ACPI_HANDLE(&st->client->dev)) {
+	if (ACPI_HANDLE(&client->dev)) {
 		struct i2c_board_info info;
 		struct acpi_device *adev;
 		int ret = -1;
 
-		adev = ACPI_COMPANION(&st->client->dev);
+		adev = ACPI_COMPANION(&client->dev);
 		memset(&info, 0, sizeof(info));
 
 		dmi_check_system(inv_mpu_dev_list);
 		switch (matched_product_name) {
 		case INV_MPU_ASUS_T100TA:
-			ret = asus_acpi_get_sensor_info(adev, st->client,
+			ret = asus_acpi_get_sensor_info(adev, client,
 							&info);
 			break;
 		/* Add more matched product processing here */
@@ -166,7 +167,7 @@ int inv_mpu_acpi_create_mux_client(struct inv_mpu6050_state *st)
 			/* No matching DMI, so create device on INV6XX type */
 			unsigned short primary, secondary;
 
-			ret = inv_mpu_process_acpi_config(st->client, &primary,
+			ret = inv_mpu_process_acpi_config(client, &primary,
 							  &secondary);
 			if (!ret && secondary) {
 				char *name;
@@ -191,8 +192,9 @@ int inv_mpu_acpi_create_mux_client(struct inv_mpu6050_state *st)
 	return 0;
 }
 
-void inv_mpu_acpi_delete_mux_client(struct inv_mpu6050_state *st)
+void inv_mpu_acpi_delete_mux_client(struct i2c_client *client)
 {
+	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(&client->dev));
 	if (st->mux_client)
 		i2c_unregister_device(st->mux_client);
 }
@@ -200,12 +202,12 @@ void inv_mpu_acpi_delete_mux_client(struct inv_mpu6050_state *st)
 
 #include "inv_mpu_iio.h"
 
-int inv_mpu_acpi_create_mux_client(struct inv_mpu6050_state *st)
+int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 {
 	return 0;
 }
 
-void inv_mpu_acpi_delete_mux_client(struct inv_mpu6050_state *st)
+void inv_mpu_acpi_delete_mux_client(struct i2c_client *client)
 {
 }
 #endif
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 151a378..7b46db5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -27,11 +27,6 @@
 #include <linux/acpi.h>
 #include "inv_mpu_iio.h"
 
-static const struct regmap_config inv_mpu_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 /*
  * this is the gyro scale translated from dynamic range plus/minus
  * {250, 500, 1000, 2000} to rad/s
@@ -80,83 +75,6 @@ static const struct inv_mpu6050_hw hw_info[INV_NUM_PARTS] = {
 	},
 };
 
-/*
- * The i2c read/write needs to happen in unlocked mode. As the parent
- * adapter is common. If we use locked versions, it will fail as
- * the mux adapter will lock the parent i2c adapter, while calling
- * select/deselect functions.
- */
-static int inv_mpu6050_write_reg_unlocked(struct inv_mpu6050_state *st,
-					  u8 reg, u8 d)
-{
-	int ret;
-	u8 buf[2];
-	struct i2c_msg msg[1] = {
-		{
-			.addr = st->client->addr,
-			.flags = 0,
-			.len = sizeof(buf),
-			.buf = buf,
-		}
-	};
-
-	buf[0] = reg;
-	buf[1] = d;
-	ret = __i2c_transfer(st->client->adapter, msg, 1);
-	if (ret != 1)
-		return ret;
-
-	return 0;
-}
-
-static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void *mux_priv,
-				     u32 chan_id)
-{
-	struct iio_dev *indio_dev = mux_priv;
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	int ret = 0;
-
-	/* Use the same mutex which was used everywhere to protect power-op */
-	mutex_lock(&indio_dev->mlock);
-	if (!st->powerup_count) {
-		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
-						     0);
-		if (ret)
-			goto write_error;
-
-		msleep(INV_MPU6050_REG_UP_TIME);
-	}
-	if (!ret) {
-		st->powerup_count++;
-		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
-						     INV_MPU6050_INT_PIN_CFG |
-						     INV_MPU6050_BIT_BYPASS_EN);
-	}
-write_error:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
-				       void *mux_priv, u32 chan_id)
-{
-	struct iio_dev *indio_dev = mux_priv;
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&indio_dev->mlock);
-	/* It doesn't really mattter, if any of the calls fails */
-	inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
-				       INV_MPU6050_INT_PIN_CFG);
-	st->powerup_count--;
-	if (!st->powerup_count)
-		inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
-					       INV_MPU6050_BIT_SLEEP);
-	mutex_unlock(&indio_dev->mlock);
-
-	return 0;
-}
-
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 {
 	unsigned int d, mgmt_1;
@@ -758,42 +676,23 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	return 0;
 }
 
-/**
- *  inv_mpu_probe() - probe function.
- *  @client:          i2c client.
- *  @id:              i2c device id.
- *
- *  Returns 0 on success, a negative error code otherwise.
- */
-static int inv_mpu_probe(struct i2c_client *client,
-	const struct i2c_device_id *id)
+int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name)
 {
 	struct inv_mpu6050_state *st;
 	struct iio_dev *indio_dev;
 	struct inv_mpu6050_platform_data *pdata;
+	struct device *dev = regmap_get_device(regmap);
 	int result;
-	struct regmap *regmap;
 
-	if (!i2c_check_functionality(client->adapter,
-		I2C_FUNC_SMBUS_I2C_BLOCK))
-		return -ENOSYS;
-
-	regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
-			(int)PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
-
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->client = client;
 	st->powerup_count = 0;
+	st->irq = irq;
 	st->map = regmap;
-	pdata = dev_get_platdata(&client->dev);
+	pdata = dev_get_platdata(dev);
 	if (pdata)
 		st->plat_data = *pdata;
 	/* power is turned on inside check chip type*/
@@ -803,18 +702,17 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	result = inv_mpu6050_init_config(indio_dev);
 	if (result) {
-		dev_err(&client->dev,
-			"Could not initialize device.\n");
+		dev_err(dev, "Could not initialize device.\n");
 		return result;
 	}
 
-	i2c_set_clientdata(client, indio_dev);
-	indio_dev->dev.parent = &client->dev;
-	/* id will be NULL when enumerated via ACPI */
-	if (id)
-		indio_dev->name = (char *)id->name;
+	dev_set_drvdata(dev, indio_dev);
+	indio_dev->dev.parent = dev;
+	/* name will be NULL when enumerated via ACPI */
+	if (name)
+		indio_dev->name = name;
 	else
-		indio_dev->name = (char *)dev_name(&client->dev);
+		indio_dev->name = dev_name(dev);
 	indio_dev->channels = inv_mpu_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
 
@@ -826,13 +724,12 @@ static int inv_mpu_probe(struct i2c_client *client,
 					    inv_mpu6050_read_fifo,
 					    NULL);
 	if (result) {
-		dev_err(&st->client->dev, "configure buffer fail %d\n",
-				result);
+		dev_err(dev, "configure buffer fail %d\n", result);
 		return result;
 	}
 	result = inv_mpu6050_probe_trigger(indio_dev);
 	if (result) {
-		dev_err(&st->client->dev, "trigger probe fail %d\n", result);
+		dev_err(dev, "trigger probe fail %d\n", result);
 		goto out_unreg_ring;
 	}
 
@@ -840,102 +737,47 @@ static int inv_mpu_probe(struct i2c_client *client,
 	spin_lock_init(&st->time_stamp_lock);
 	result = iio_device_register(indio_dev);
 	if (result) {
-		dev_err(&st->client->dev, "IIO register fail %d\n", result);
+		dev_err(dev, "IIO register fail %d\n", result);
 		goto out_remove_trigger;
 	}
 
-	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
-					      &client->dev,
-					      indio_dev,
-					      0, 0, 0,
-					      inv_mpu6050_select_bypass,
-					      inv_mpu6050_deselect_bypass);
-	if (!st->mux_adapter) {
-		result = -ENODEV;
-		goto out_unreg_device;
-	}
-
-	result = inv_mpu_acpi_create_mux_client(st);
-	if (result)
-		goto out_del_mux;
-
 	return 0;
 
-out_del_mux:
-	i2c_del_mux_adapter(st->mux_adapter);
-out_unreg_device:
-	iio_device_unregister(indio_dev);
 out_remove_trigger:
 	inv_mpu6050_remove_trigger(st);
 out_unreg_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
 	return result;
 }
+EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
 
-static int inv_mpu_remove(struct i2c_client *client)
+int inv_mpu_core_remove(struct device  *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
-	inv_mpu_acpi_delete_mux_client(st);
-	i2c_del_mux_adapter(st->mux_adapter);
 	iio_device_unregister(indio_dev);
-	inv_mpu6050_remove_trigger(st);
+	inv_mpu6050_remove_trigger(iio_priv(indio_dev));
 	iio_triggered_buffer_cleanup(indio_dev);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(inv_mpu_core_remove);
+
 #ifdef CONFIG_PM_SLEEP
 
 static int inv_mpu_resume(struct device *dev)
 {
-	return inv_mpu6050_set_power_itg(
-		iio_priv(i2c_get_clientdata(to_i2c_client(dev))), true);
+	return inv_mpu6050_set_power_itg(iio_priv(dev_get_drvdata(dev)), true);
 }
 
 static int inv_mpu_suspend(struct device *dev)
 {
-	return inv_mpu6050_set_power_itg(
-		iio_priv(i2c_get_clientdata(to_i2c_client(dev))), false);
+	return inv_mpu6050_set_power_itg(iio_priv(dev_get_drvdata(dev)), false);
 }
-static SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
-
-#define INV_MPU6050_PMOPS (&inv_mpu_pmops)
-#else
-#define INV_MPU6050_PMOPS NULL
 #endif /* CONFIG_PM_SLEEP */
 
-/*
- * device id table is used to identify what device can be
- * supported by this driver
- */
-static const struct i2c_device_id inv_mpu_id[] = {
-	{"mpu6050", INV_MPU6050},
-	{"mpu6500", INV_MPU6500},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
-
-static const struct acpi_device_id inv_acpi_match[] = {
-	{"INVN6500", 0},
-	{ },
-};
-
-MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
-
-static struct i2c_driver inv_mpu_driver = {
-	.probe		=	inv_mpu_probe,
-	.remove		=	inv_mpu_remove,
-	.id_table	=	inv_mpu_id,
-	.driver = {
-		.name	=	"inv-mpu6050",
-		.pm     =       INV_MPU6050_PMOPS,
-		.acpi_match_table = ACPI_PTR(inv_acpi_match),
-	},
-};
-
-module_i2c_driver(inv_mpu_driver);
+SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
+EXPORT_SYMBOL_GPL(inv_mpu_pmops);
 
 MODULE_AUTHOR("Invensense Corporation");
 MODULE_DESCRIPTION("Invensense device MPU6050 driver");
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
new file mode 100644
index 0000000..6c225a0
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -0,0 +1,207 @@
+/*
+* Copyright (C) 2012 Invensense, Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*/
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include "inv_mpu_iio.h"
+
+static const struct regmap_config inv_mpu_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+/*
+ * The i2c read/write needs to happen in unlocked mode. As the parent
+ * adapter is common. If we use locked versions, it will fail as
+ * the mux adapter will lock the parent i2c adapter, while calling
+ * select/deselect functions.
+ */
+static int inv_mpu6050_write_reg_unlocked(struct i2c_client *client,
+					  u8 reg, u8 d)
+{
+	int ret;
+	u8 buf[2] = {reg, d};
+	struct i2c_msg msg[1] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = sizeof(buf),
+			.buf = buf,
+		}
+	};
+
+	ret = __i2c_transfer(client->adapter, msg, 1);
+	if (ret != 1)
+		return ret;
+
+	return 0;
+}
+
+static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void *mux_priv,
+				     u32 chan_id)
+{
+	struct i2c_client *client = mux_priv;
+	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	/* Use the same mutex which was used everywhere to protect power-op */
+	mutex_lock(&indio_dev->mlock);
+	if (!st->powerup_count) {
+		ret = inv_mpu6050_write_reg_unlocked(client,
+						     st->reg->pwr_mgmt_1, 0);
+		if (ret)
+			goto write_error;
+
+		msleep(INV_MPU6050_REG_UP_TIME);
+	}
+	if (!ret) {
+		st->powerup_count++;
+		ret = inv_mpu6050_write_reg_unlocked(client,
+						     st->reg->int_pin_cfg,
+						     INV_MPU6050_INT_PIN_CFG |
+						     INV_MPU6050_BIT_BYPASS_EN);
+	}
+write_error:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
+				       void *mux_priv, u32 chan_id)
+{
+	struct i2c_client *client = mux_priv;
+	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	mutex_lock(&indio_dev->mlock);
+	/* It doesn't really mattter, if any of the calls fails */
+	inv_mpu6050_write_reg_unlocked(client, st->reg->int_pin_cfg,
+				       INV_MPU6050_INT_PIN_CFG);
+	st->powerup_count--;
+	if (!st->powerup_count)
+		inv_mpu6050_write_reg_unlocked(client, st->reg->pwr_mgmt_1,
+					       INV_MPU6050_BIT_SLEEP);
+	mutex_unlock(&indio_dev->mlock);
+
+	return 0;
+}
+
+/**
+ *  inv_mpu_probe() - probe function.
+ *  @client:          i2c client.
+ *  @id:              i2c device id.
+ *
+ *  Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_mpu_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct inv_mpu6050_state *st;
+	int result;
+	const char *name = id ? id->name : NULL;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENOSYS;
+
+	regmap = devm_regmap_init_i2c(client, &inv_mpu_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	result = inv_mpu_core_probe(regmap, client->irq, name);
+	if (result < 0)
+		return result;
+
+	st = iio_priv(dev_get_drvdata(&client->dev));
+	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
+					      &client->dev,
+					      client,
+					      0, 0, 0,
+					      inv_mpu6050_select_bypass,
+					      inv_mpu6050_deselect_bypass);
+	if (!st->mux_adapter) {
+		result = -ENODEV;
+		goto out_unreg_device;
+	}
+
+	result = inv_mpu_acpi_create_mux_client(client);
+	if (result)
+		goto out_del_mux;
+
+	return 0;
+
+out_del_mux:
+	i2c_del_mux_adapter(st->mux_adapter);
+out_unreg_device:
+	inv_mpu_core_remove(&client->dev);
+	return result;
+}
+
+static int inv_mpu_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	inv_mpu_acpi_delete_mux_client(client);
+	i2c_del_mux_adapter(st->mux_adapter);
+
+	return inv_mpu_core_remove(&client->dev);
+}
+
+/*
+ * device id table is used to identify what device can be
+ * supported by this driver
+ */
+static const struct i2c_device_id inv_mpu_id[] = {
+	{"mpu6050", INV_MPU6050},
+	{"mpu6500", INV_MPU6500},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
+
+static const struct acpi_device_id inv_acpi_match[] = {
+	{"INVN6500", 0},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
+
+static struct i2c_driver inv_mpu_driver = {
+	.probe		=	inv_mpu_probe,
+	.remove		=	inv_mpu_remove,
+	.id_table	=	inv_mpu_id,
+	.driver = {
+		.owner	=	THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(inv_acpi_match),
+		.name	=	"inv-mpu6050 i2c driver",
+		.pm     =       &inv_mpu_pmops,
+	},
+};
+
+module_i2c_driver(inv_mpu_driver);
+
+MODULE_AUTHOR("Invensense Corporation");
+MODULE_DESCRIPTION("Invensense device MPU6050 driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 469cd1f..1bf65a0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -108,9 +108,10 @@ struct inv_mpu6050_hw {
  *  @hw:		Other hardware-specific information.
  *  @chip_type:		chip type.
  *  @time_stamp_lock:	spin lock to time stamp.
- *  @client:		i2c client handle.
  *  @plat_data:		platform data.
  *  @timestamps:        kfifo queue to store time stamp.
+ *  @map		regmap pointer.
+ *  @irq		interrupt number.
  */
 struct inv_mpu6050_state {
 #define TIMESTAMP_FIFO_SIZE 16
@@ -120,13 +121,13 @@ struct inv_mpu6050_state {
 	const struct inv_mpu6050_hw *hw;
 	enum   inv_devices chip_type;
 	spinlock_t time_stamp_lock;
-	struct i2c_client *client;
 	struct i2c_adapter *mux_adapter;
 	struct i2c_client *mux_client;
 	unsigned int powerup_count;
 	struct inv_mpu6050_platform_data plat_data;
 	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
 	struct regmap *map;
+	int irq;
 };
 
 /*register and associated bit definition*/
@@ -255,5 +256,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask);
 int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
 int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
-int inv_mpu_acpi_create_mux_client(struct inv_mpu6050_state *st);
-void inv_mpu_acpi_delete_mux_client(struct inv_mpu6050_state *st);
+int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
+void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
+int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name);
+int inv_mpu_core_remove(struct device *dev);
+extern const struct dev_pm_ops inv_mpu_pmops;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index eb19dae..1fc5fd9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -42,7 +42,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	/* disable interrupt */
 	result = regmap_write(st->map, st->reg->int_enable, 0);
 	if (result) {
-		dev_err(&st->client->dev, "int_enable failed %d\n", result);
+		dev_err(regmap_get_device(st->map), "int_enable failed %d\n",
+			result);
 		return result;
 	}
 	/* disable the sensor output to FIFO */
@@ -89,7 +90,7 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	return 0;
 
 reset_fifo_fail:
-	dev_err(&st->client->dev, "reset fifo failed %d\n", result);
+	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
 	result = regmap_write(st->map, st->reg->int_enable,
 					INV_MPU6050_BIT_DATA_RDY_EN);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index ee9e66d..72d6aae 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -123,7 +123,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	if (!st->trig)
 		return -ENOMEM;
 
-	ret = devm_request_irq(&indio_dev->dev, st->client->irq,
+	ret = devm_request_irq(&indio_dev->dev, st->irq,
 			       &iio_trigger_generic_data_rdy_poll,
 			       IRQF_TRIGGER_RISING,
 			       "inv_mpu",
@@ -131,7 +131,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	st->trig->dev.parent = &st->client->dev;
+	st->trig->dev.parent = regmap_get_device(st->map);
 	st->trig->ops = &inv_mpu_trigger_ops;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 
-- 
1.9.1

