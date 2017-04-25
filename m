Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:45674 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171471AbdDYIGl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Apr 2017 04:06:41 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, jbrenner@taosinc.com
Subject: [PATCH] iio: tsl2583: add runtime power management support
Date: Tue, 25 Apr 2017 04:06:33 -0400
Message-Id: <20170425080633.27464-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds runtime power management support to the tsl2583 driver.
The device is powered off after two seconds of inactivity. Verified that
the driver still functions correctly using a TSL2581 hooked up to a
Raspberry Pi 2.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/tsl2583.c | 106 +++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index a78b602..1679181 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -3,7 +3,7 @@
  * within the TAOS tsl258x family of devices (tsl2580, tsl2581, tsl2583).
  *
  * Copyright (c) 2011, TAOS Corporation.
- * Copyright (c) 2016 Brian Masney <masneyb@onstation.org>
+ * Copyright (c) 2016-2017 Brian Masney <masneyb@onstation.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/pm_runtime.h>
 
 /* Device Registers and Masks */
 #define TSL2583_CNTRL			0x00
@@ -64,6 +65,8 @@
 #define TSL2583_CHIP_ID			0x90
 #define TSL2583_CHIP_ID_MASK		0xf0
 
+#define TSL2583_POWER_OFF_DELAY_MS	2000
+
 /* Per-device data */
 struct tsl2583_als_info {
 	u16 als_ch0;
@@ -108,7 +111,6 @@ struct tsl2583_chip {
 	struct tsl2583_settings als_settings;
 	int als_time_scale;
 	int als_saturation;
-	bool suspended;
 };
 
 struct gainadj {
@@ -460,8 +462,6 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	chip->suspended = false;
-
 	return ret;
 }
 
@@ -513,11 +513,6 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
 
 	mutex_lock(&chip->als_mutex);
 
-	if (chip->suspended) {
-		ret = -EBUSY;
-		goto done;
-	}
-
 	ret = tsl2583_als_calibrate(indio_dev);
 	if (ret < 0)
 		goto done;
@@ -645,20 +640,36 @@ static const struct iio_chan_spec tsl2583_channels[] = {
 	},
 };
 
+static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
+{
+	int ret;
+
+	if (on) {
+		ret = pm_runtime_get_sync(&chip->client->dev);
+		if (ret < 0)
+			pm_runtime_put_noidle(&chip->client->dev);
+	} else {
+		pm_runtime_mark_last_busy(&chip->client->dev);
+		ret = pm_runtime_put_autosuspend(&chip->client->dev);
+	}
+
+	return ret;
+}
+
 static int tsl2583_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret, pm_ret;
 
-	mutex_lock(&chip->als_mutex);
+	ret = tsl2583_set_pm_runtime_busy(chip, true);
+	if (ret < 0)
+		return ret;
 
-	if (chip->suspended) {
-		ret = -EBUSY;
-		goto read_done;
-	}
+	mutex_lock(&chip->als_mutex);
 
+	ret = -EINVAL;
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (chan->type == IIO_LIGHT) {
@@ -719,6 +730,18 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 read_done:
 	mutex_unlock(&chip->als_mutex);
 
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Preserve the ret variable if the call to
+	 * tsl2583_set_pm_runtime_busy() is successful so the reading
+	 * (if applicable) is returned to user space.
+	 */
+	pm_ret = tsl2583_set_pm_runtime_busy(chip, false);
+	if (pm_ret < 0)
+		return pm_ret;
+
 	return ret;
 }
 
@@ -727,15 +750,15 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 
-	mutex_lock(&chip->als_mutex);
+	ret = tsl2583_set_pm_runtime_busy(chip, true);
+	if (ret < 0)
+		return ret;
 
-	if (chip->suspended) {
-		ret = -EBUSY;
-		goto write_done;
-	}
+	mutex_lock(&chip->als_mutex);
 
+	ret = -EINVAL;
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		if (chan->type == IIO_LIGHT) {
@@ -767,9 +790,15 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-write_done:
 	mutex_unlock(&chip->als_mutex);
 
+	if (ret < 0)
+		return ret;
+
+	ret = tsl2583_set_pm_runtime_busy(chip, false);
+	if (ret < 0)
+		return ret;
+
 	return ret;
 }
 
@@ -803,7 +832,6 @@ static int tsl2583_probe(struct i2c_client *clientp,
 	i2c_set_clientdata(clientp, indio_dev);
 
 	mutex_init(&chip->als_mutex);
-	chip->suspended = true;
 
 	ret = i2c_smbus_read_byte_data(clientp,
 				       TSL2583_CMD_REG | TSL2583_CHIPID);
@@ -826,6 +854,11 @@ static int tsl2583_probe(struct i2c_client *clientp,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->client->name;
 
+	pm_runtime_enable(&clientp->dev);
+	pm_runtime_set_autosuspend_delay(&clientp->dev,
+					 TSL2583_POWER_OFF_DELAY_MS);
+	pm_runtime_use_autosuspend(&clientp->dev);
+
 	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev, "%s: iio registration failed\n",
@@ -836,16 +869,25 @@ static int tsl2583_probe(struct i2c_client *clientp,
 	/* Load up the V2 defaults (these are hard coded defaults for now) */
 	tsl2583_defaults(chip);
 
-	/* Make sure the chip is on */
-	ret = tsl2583_chip_init_and_power_on(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	dev_info(&clientp->dev, "Light sensor found.\n");
 
 	return 0;
 }
 
+static int tsl2583_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+
+	return tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_OFF);
+}
+
 static int __maybe_unused tsl2583_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -855,7 +897,6 @@ static int __maybe_unused tsl2583_suspend(struct device *dev)
 	mutex_lock(&chip->als_mutex);
 
 	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_OFF);
-	chip->suspended = true;
 
 	mutex_unlock(&chip->als_mutex);
 
@@ -877,7 +918,11 @@ static int __maybe_unused tsl2583_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(tsl2583_pm_ops, tsl2583_suspend, tsl2583_resume);
+static const struct dev_pm_ops tsl2583_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(tsl2583_suspend, tsl2583_resume, NULL)
+};
 
 static struct i2c_device_id tsl2583_idtable[] = {
 	{ "tsl2580", 0 },
@@ -904,6 +949,7 @@ static struct i2c_driver tsl2583_driver = {
 	},
 	.id_table = tsl2583_idtable,
 	.probe = tsl2583_probe,
+	.remove = tsl2583_remove,
 };
 module_i2c_driver(tsl2583_driver);
 
-- 
2.9.3

