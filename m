Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:55243 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbaDMTJ3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Apr 2014 15:09:29 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so7366592wes.12
        for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2014 12:09:27 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/6] iio: st_sensors: move regulator retrieveal to core
Date: Sun, 13 Apr 2014 21:08:59 +0200
Message-Id: <1397416143-4396-3-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the pressure sensor has code to retrieve and enable two
regulators for Vdd and Vdd IO, but actually these voltage inputs
are found on all of these ST sensors, so move the regulator
handling to the core and make sure all the ST sensors call these
functions on probe() and remove() to enable/disable power.

Here also mover over to obtaining the regulator from the *parent*
device of the IIO device, as the IIO device is created on-the-fly
in this very subsystem it very unlikely evert have any regulators
attached to it whatsoever. It is much more likely that the parent
is a platform device, possibly instantiated from a device tree,
which in turn have Vdd and Vdd IO supplied assigned to it.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_core.c               |  4 +++
 drivers/iio/common/st_sensors/st_sensors_core.c | 37 +++++++++++++++++++++++
 drivers/iio/gyro/st_gyro_core.c                 |  4 +++
 drivers/iio/magnetometer/st_magn_core.c         |  4 +++
 drivers/iio/pressure/st_pressure_core.c         | 39 ++-----------------------
 include/linux/iio/common/st_sensors.h           |  4 +++
 6 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 4e06fcf5b891..a2abf7c2ce3b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -459,6 +459,8 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &accel_info;
 
+	st_sensors_power_enable(indio_dev);
+
 	err = st_sensors_check_device_support(indio_dev,
 				ARRAY_SIZE(st_accel_sensors), st_accel_sensors);
 	if (err < 0)
@@ -515,6 +517,8 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	iio_device_unregister(indio_dev);
 	if (adata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 7ba1ef270213..e8b932fed70e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
 
 #include <linux/iio/common/st_sensors.h>
@@ -198,6 +199,42 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 }
 EXPORT_SYMBOL(st_sensors_set_axis_enable);
 
+void st_sensors_power_enable(struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *pdata = iio_priv(indio_dev);
+	int err;
+
+	/* Regulators not mandatory, but if requested we should enable them. */
+	pdata->vdd = devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
+	if (!IS_ERR(pdata->vdd)) {
+		err = regulator_enable(pdata->vdd);
+		if (err != 0)
+			dev_warn(&indio_dev->dev,
+				 "Failed to enable specified Vdd supply\n");
+	}
+
+	pdata->vdd_io = devm_regulator_get_optional(indio_dev->dev.parent, "vddio");
+	if (!IS_ERR(pdata->vdd_io)) {
+		err = regulator_enable(pdata->vdd_io);
+		if (err != 0)
+			dev_warn(&indio_dev->dev,
+				 "Failed to enable specified Vdd_IO supply\n");
+	}
+}
+EXPORT_SYMBOL(st_sensors_power_enable);
+
+void st_sensors_power_disable(struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *pdata = iio_priv(indio_dev);
+
+	if (!IS_ERR(pdata->vdd))
+		regulator_disable(pdata->vdd);
+
+	if (!IS_ERR(pdata->vdd_io))
+		regulator_disable(pdata->vdd_io);
+}
+EXPORT_SYMBOL(st_sensors_power_disable);
+
 static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 				       struct st_sensors_platform_data *pdata)
 {
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index bc71f4d1e2ce..ed74a9069989 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -311,6 +311,8 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &gyro_info;
 
+	st_sensors_power_enable(indio_dev);
+
 	err = st_sensors_check_device_support(indio_dev,
 				ARRAY_SIZE(st_gyro_sensors), st_gyro_sensors);
 	if (err < 0)
@@ -363,6 +365,8 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	iio_device_unregister(indio_dev);
 	if (gdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 8e33a7682d33..240a21dd0c61 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -355,6 +355,8 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &magn_info;
 
+	st_sensors_power_enable(indio_dev);
+
 	err = st_sensors_check_device_support(indio_dev,
 				ARRAY_SIZE(st_magn_sensors), st_magn_sensors);
 	if (err < 0)
@@ -406,6 +408,8 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
+	st_sensors_power_disable(indio_dev);
+
 	iio_device_unregister(indio_dev);
 	if (mdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 013becbe8f47..cd7e01f3a93b 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -23,7 +23,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/buffer.h>
-#include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
 
 #include <linux/iio/common/st_sensors.h>
@@ -387,40 +386,6 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
 #define ST_PRESS_TRIGGER_OPS NULL
 #endif
 
-static void st_press_power_enable(struct iio_dev *indio_dev)
-{
-	struct st_sensor_data *pdata = iio_priv(indio_dev);
-	int err;
-
-	/* Regulators not mandatory, but if requested we should enable them. */
-	pdata->vdd = devm_regulator_get_optional(&indio_dev->dev, "vdd");
-	if (!IS_ERR(pdata->vdd)) {
-		err = regulator_enable(pdata->vdd);
-		if (err != 0)
-			dev_warn(&indio_dev->dev,
-				 "Failed to enable specified Vdd supply\n");
-	}
-
-	pdata->vdd_io = devm_regulator_get_optional(&indio_dev->dev, "vddio");
-	if (!IS_ERR(pdata->vdd_io)) {
-		err = regulator_enable(pdata->vdd_io);
-		if (err != 0)
-			dev_warn(&indio_dev->dev,
-				 "Failed to enable specified Vdd_IO supply\n");
-	}
-}
-
-static void st_press_power_disable(struct iio_dev *indio_dev)
-{
-	struct st_sensor_data *pdata = iio_priv(indio_dev);
-
-	if (!IS_ERR(pdata->vdd))
-		regulator_disable(pdata->vdd);
-
-	if (!IS_ERR(pdata->vdd_io))
-		regulator_disable(pdata->vdd_io);
-}
-
 int st_press_common_probe(struct iio_dev *indio_dev,
 				struct st_sensors_platform_data *plat_data)
 {
@@ -431,7 +396,7 @@ int st_press_common_probe(struct iio_dev *indio_dev,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &press_info;
 
-	st_press_power_enable(indio_dev);
+	st_sensors_power_enable(indio_dev);
 
 	err = st_sensors_check_device_support(indio_dev,
 					      ARRAY_SIZE(st_press_sensors),
@@ -493,7 +458,7 @@ void st_press_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
 
-	st_press_power_disable(indio_dev);
+	st_sensors_power_disable(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	if (pdata->get_irq_data_ready(indio_dev) > 0)
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 3c005eb3a0a4..96f51f0e0096 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -269,6 +269,10 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable);
 
 int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable);
 
+void st_sensors_power_enable(struct iio_dev *indio_dev);
+
+void st_sensors_power_disable(struct iio_dev *indio_dev);
+
 int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr);
 
 int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
-- 
1.9.0

