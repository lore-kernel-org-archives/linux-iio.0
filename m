Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:50528 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaGGJt3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jul 2014 05:49:29 -0400
Received: by mail-wg0-f51.google.com with SMTP id x12so3978674wgg.10
        for <linux-iio@vger.kernel.org>; Mon, 07 Jul 2014 02:49:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [RESEND PATCH 3/3] iio: st_sensors: add devicetree probing support
Date: Mon,  7 Jul 2014 11:48:45 +0200
Message-Id: <1404726525-2649-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The I2C devices that make up the STMicroelectronics MEMS sensors
may be sneakily enabled by cleverly giving the device node the same
name as a string match from the platform device ID table. However
the right method is to use the compatible string.

On detection, the ST sensors use the ID string to probe and
instatiate the right sensor driver, so pass the kernel-internal ID
string in the .data field of the OF match table, and set the I2C
client name to this name when a compatible match is used.

This avoids having misc Linux-specific strings floating around in
the device tree.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_i2c.c               | 49 ++++++++++++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 29 +++++++++++++++
 drivers/iio/gyro/st_gyro_i2c.c                 | 37 +++++++++++++++++++
 drivers/iio/magnetometer/st_magn_i2c.c         | 21 +++++++++++
 drivers/iio/pressure/st_pressure_i2c.c         | 21 +++++++++++
 include/linux/iio/common/st_sensors_i2c.h      | 11 ++++++
 6 files changed, 168 insertions(+)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index d7bedbdfc81d..67000e507d83 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -18,6 +18,53 @@
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_accel.h"
 
+#ifdef CONFIG_OF
+static const struct of_device_id st_accel_of_match[] = {
+	{
+		.compatible = "st,lsm303dlh-accel",
+		.data = LSM303DLH_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm303dlhc-accel",
+		.data = LSM303DLHC_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis3dh-accel",
+		.data = LIS3DH_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330d-accel",
+		.data = LSM330D_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330dl-accel",
+		.data = LSM330DL_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330dlc-accel",
+		.data = LSM330DLC_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis331dlh-accel",
+		.data = LIS331DLH_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm303dl-accel",
+		.data = LSM303DL_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm303dlm-accel",
+		.data = LSM303DLM_ACCEL_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330-accel",
+		.data = LSM330_ACCEL_DEV_NAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_accel_of_match);
+#endif
+
 static int st_accel_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
 {
@@ -31,6 +78,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 
 	adata = iio_priv(indio_dev);
 	adata->dev = &client->dev;
+	st_sensors_of_i2c_probe(client, st_accel_of_match);
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
@@ -67,6 +115,7 @@ static struct i2c_driver st_accel_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-accel-i2c",
+		.of_match_table = of_match_ptr(st_accel_of_match),
 	},
 	.probe = st_accel_i2c_probe,
 	.remove = st_accel_i2c_remove,
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 38af9440c103..12246e9529ef 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/iio/iio.h>
+#include <linux/of_device.h>
 
 #include <linux/iio/common/st_sensors_i2c.h>
 
@@ -76,6 +77,34 @@ void st_sensors_i2c_configure(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL(st_sensors_i2c_configure);
 
+#ifdef CONFIG_OF
+/**
+ * st_sensors_of_i2c_probe() - device tree probe for ST I2C sensors
+ * @client: the I2C client device for the sensor
+ * @match: the OF match table for the device, containing compatible strings
+ *	but also a .data field with the corresponding internal kernel name
+ *	used by this sensor.
+ *
+ * In effect this function matches a compatible string to an internal kernel
+ * name for a certain sensor device, so that the rest of the autodetection can
+ * rely on that name from this point on. I2C client devices will be renamed
+ * to match the internal kernel convention.
+ */
+void st_sensors_of_i2c_probe(struct i2c_client *client,
+			     const struct of_device_id *match)
+{
+	const struct of_device_id *of_id;
+
+	of_id = of_match_device(match, &client->dev);
+	if (!of_id)
+		return;
+
+	/* The name from the OF match takes precedence if present */
+	strncpy(client->name, of_id->data, sizeof(client->name));
+	client->name[sizeof(client->name) - 1] = '\0';
+}
+#endif
+
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics ST-sensors i2c driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 23c12f361b05..a26516aea8cb 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -18,6 +18,41 @@
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_gyro.h"
 
+#ifdef CONFIG_OF
+static const struct of_device_id st_gyro_of_match[] = {
+	{
+		.compatible = "st,l3g4200d-gyro",
+		.data = L3G4200D_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330d-gyro",
+		.data = LSM330D_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330dl-gyro",
+		.data = LSM330DL_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330dlc-gyro",
+		.data = LSM330DLC_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,l3gd20-gyro",
+		.data = L3GD20_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,l3g4is-gyro",
+		.data = L3G4IS_GYRO_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm330-gyro",
+		.data = LSM330_GYRO_DEV_NAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_gyro_of_match);
+#endif
+
 static int st_gyro_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
 {
@@ -31,6 +66,7 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 
 	gdata = iio_priv(indio_dev);
 	gdata->dev = &client->dev;
+	st_sensors_of_i2c_probe(client, st_gyro_of_match);
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
 
@@ -65,6 +101,7 @@ static struct i2c_driver st_gyro_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-gyro-i2c",
+		.of_match_table = of_match_ptr(st_gyro_of_match),
 	},
 	.probe = st_gyro_i2c_probe,
 	.remove = st_gyro_i2c_remove,
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 892e0feeb5c1..486279d1f1e2 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -18,6 +18,25 @@
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_magn.h"
 
+#ifdef CONFIG_OF
+static const struct of_device_id st_magn_of_match[] = {
+	{
+		.compatible = "st,lsm303dlhc-magn",
+		.data = LSM303DLHC_MAGN_DEV_NAME,
+	},
+	{
+		.compatible = "st,lsm303dlm-magn",
+		.data = LSM303DLM_MAGN_DEV_NAME,
+	},
+	{
+		.compatible = "st,lis3mdl-magn",
+		.data = LIS3MDL_MAGN_DEV_NAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_magn_of_match);
+#endif
+
 static int st_magn_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
 {
@@ -31,6 +50,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 
 	mdata = iio_priv(indio_dev);
 	mdata->dev = &client->dev;
+	st_sensors_of_i2c_probe(client, st_magn_of_match);
 
 	st_sensors_i2c_configure(indio_dev, client, mdata);
 
@@ -61,6 +81,7 @@ static struct i2c_driver st_magn_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-magn-i2c",
+		.of_match_table = of_match_ptr(st_magn_of_match),
 	},
 	.probe = st_magn_i2c_probe,
 	.remove = st_magn_i2c_remove,
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 3cd73e39b840..0ab5a20d7760 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -18,6 +18,25 @@
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_pressure.h"
 
+#ifdef CONFIG_OF
+static const struct of_device_id st_press_of_match[] = {
+	{
+		.compatible = "st,lps001wp-press",
+		.data = LPS001WP_PRESS_DEV_NAME,
+	},
+	{
+		.compatible = "st,lps25h-press",
+		.data = LPS25H_PRESS_DEV_NAME,
+	},
+	{
+		.compatible = "st,lps331ap-press",
+		.data = LPS331AP_PRESS_DEV_NAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, st_press_of_match);
+#endif
+
 static int st_press_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
 {
@@ -31,6 +50,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
 
 	pdata = iio_priv(indio_dev);
 	pdata->dev = &client->dev;
+	st_sensors_of_i2c_probe(client, st_press_of_match);
 
 	st_sensors_i2c_configure(indio_dev, client, pdata);
 
@@ -60,6 +80,7 @@ static struct i2c_driver st_press_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-press-i2c",
+		.of_match_table = of_match_ptr(st_press_of_match),
 	},
 	.probe = st_press_i2c_probe,
 	.remove = st_press_i2c_remove,
diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
index 67d845385ae2..1796af093368 100644
--- a/include/linux/iio/common/st_sensors_i2c.h
+++ b/include/linux/iio/common/st_sensors_i2c.h
@@ -13,8 +13,19 @@
 
 #include <linux/i2c.h>
 #include <linux/iio/common/st_sensors.h>
+#include <linux/of.h>
 
 void st_sensors_i2c_configure(struct iio_dev *indio_dev,
 		struct i2c_client *client, struct st_sensor_data *sdata);
 
+#ifdef CONFIG_OF
+void st_sensors_of_i2c_probe(struct i2c_client *client,
+			     const struct of_device_id *match);
+#else
+static inline void st_sensors_of_i2c_probe(struct i2c_client *client,
+					   const struct of_device_id *match)
+{
+}
+#endif
+
 #endif /* ST_SENSORS_I2C_H */
-- 
1.9.3

