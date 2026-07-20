Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3373C063A
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579174; cv=none; b=nCWg8kDch9JgNPmISrpZZwqhD94llrp619RNRakg3eadWBruhPMZYzyNoIhOSWiMGDJGDuekReDhdNlZSxfoPqD1EdDkJ6Go1iyxogm21fjkQrDd30VhDpRLmY+0TL9ISAnIv1+JP9GC4rzlnKu8wIYQwv9i7xszu0TaaB0yKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579174; c=relaxed/simple;
	bh=58SSPwVokzGMNSPjXglFhlMr4VDkPJ2Nr2OAwT9oU9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loPmwkLjsOy204YlHvkapn7x8FbWXeCdBJTf450H20vJPRLtMIdRNBYBJhEb0gMnOUjlRndxcIjvoZY2agKXNmzws5BR4AUvujFvLNl+TD2iEuq6FxlymXnE+PCc0AnhftcKXOSu8uXoj+zQTTNIB9DGFJK6eTOzJaG4IjBLTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoOB6sER; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoOB6sER"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-497d6c2d000so6656379b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579171; x=1785183971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zI37Rqr4EJavtvk5G+daqMxkOHQaBT+PYW9+VsCOf8s=;
        b=PoOB6sERAPsuiCWCcrnape+TpJbQtpWG5ILCkJAhxA9VrRmk5xsD4bbrgHb3YjZ0yh
         /863rvZCxQ0IeANjeZPixU8TrKrBVQXPjZyeYsz5TUSduFRYQX8zrYHXgJnX9oiMBSNh
         T1lV8Y/rh8swkUB2WG52vRmH+56Reu4i1a6yZm7h2EPe6WtikCcECwvzf1rUylMimH5m
         uU8d+Tn+LBbrSxcpRYwNBitGDB0VCg7EjXklKnXLlqa0PQLjbOvb22CODiZh9SlSTnDL
         wtcWF/KltIAXolNiX0Gl66LZuG+Jd1h3n1bezAQN+49bAyGTKtbpq/gL9RVgwXKLBn1o
         4HPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579171; x=1785183971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zI37Rqr4EJavtvk5G+daqMxkOHQaBT+PYW9+VsCOf8s=;
        b=D60Ne6T+/vkaK9EkK6Ldl1i3caRhr9HFTsAJXO9T/EQlY0X08jemJPKuZJkoYRieoy
         ykmkALStilVS8eZnSfJ0bHUEDdRlUcfv1/mB+tvEhxggN6HZ6mWobfAkMU4ugKW6yacs
         QaHjczKFiyUN7pUlXv67jEKKIZyfmOXgkTdfR9gol2X7l6A+yUAjkaqbBlEcL+zCbor2
         putTU8so3kgqlnMSQGQMTfcWx2FuC2ho77rH+wu6PzGWPPTsB1z4CssroNZuoeoBcsND
         x91WK9/xYXI6GKVDMHHa1ahdZJ+f3G8wGdOnOWBpCVN8zruk9DkqKeBf0SYsQS+eC1Jr
         Q5cg==
X-Gm-Message-State: AOJu0YzQ2xKLIF7T75WpCGmMKG/ePfeyVmAYdartDj+5XyrXrkjko4SQ
	GCDBwdyWxU6TYWgVpLfUEHzfcQ5JLNlShvY//8c/3MI7H0OSh+cxlvcUf5MZFA==
X-Gm-Gg: AfdE7ckqrEivaNGgk7W1WYSy+M9VxtRyiQA20IPLPsW42l/dteqzPsrDJbO3XF1cxXG
	n1NbLhfoHqgRaoSxKtsWEvMLtrhQaXAMLZYqac+GlJVB+FTYMbANJBn6hcUx4kjzj3A9OPER/Lh
	ZkYl3bk2aC4wEp0hvCQOm9YkskDl03pBezsMrwNvzfZVNPDfKYR/VOONCelP96yokXakGn6GIIG
	O5RG8Pwl2tBDR6kvRUhX2HvDwFYfY4o7O0SqehJgB2TXZM8MbLqOtYpdohw1dUWloyKNz2ibPR5
	PEwYx4Pz0zYMxMj767rkjBgqL8RQsacP3439ATNUzXUxf/xQPBC9HwJEyq+OeqXsfYKgc6/MIAt
	seP7iYv3t3c5Y51pw3RmGPnCfAp7kWrGNbABrsbZCkqgAnmKch+qJHdaqdkIvFfZ1SMicWSbKsB
	djdP01o/YwCdFb/91iMX+2o6KVjkIMd737
X-Received: by 2002:a05:6808:11c7:b0:495:f85b:d08f with SMTP id 5614622812f47-4a4d036cddemr7999142b6e.18.1784579171250;
        Mon, 20 Jul 2026 13:26:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9988:5abf:3c51:d168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3e5a0cdsm8029550b6e.18.2026.07.20.13.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:26:09 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V18 5/9] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Mon, 20 Jul 2026 15:23:37 -0500
Message-ID: <20260720202343.70138-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720202343.70138-1-macroalpha82@gmail.com>
References: <20260720202343.70138-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add power management support for the ICM42607 device driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  14 ++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 168 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   8 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   8 +
 4 files changed, 198 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 169e848caf2e..61927a6c2663 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -9,6 +9,7 @@
 #include <linux/bits.h>
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/time.h>
@@ -125,6 +126,7 @@ struct inv_icm42607_hw {
  *  @lock:		lock for serializing multiple registers access.
  *  @map:		regmap pointer.
  *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @vddio_en:		I/O voltage status for runtime PM.
  *  @conf:		chip sensors configurations.
  *  @orientation:	sensor chip orientation relative to main hardware.
  */
@@ -133,6 +135,7 @@ struct inv_icm42607_state {
 	struct mutex lock;
 	struct regmap *map;
 	struct regulator *vddio_supply;
+	bool vddio_en;
 	struct inv_icm42607_conf conf;
 	struct iio_mount_matrix orientation;
 };
@@ -352,11 +355,22 @@ struct inv_icm42607_state {
 #define INV_ICM42607_GYRO_STOP_TIME_US			(45 * USEC_PER_MSEC)
 #define INV_ICM42607_TEMP_STARTUP_TIME_US		77
 
+/*
+ * Suspend delay assumed from other icm42600 series device, not
+ * documented in datasheet.
+ */
+#define INV_ICM42607_SUSPEND_DELAY_MS			(2 * MSEC_PER_SEC)
+
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
+extern const struct dev_pm_ops inv_icm42607_pm_ops;
+
+int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,
+			       enum inv_icm42607_sensor_mode *gyro,
+			       enum inv_icm42607_sensor_mode *accel);
 
 int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 6ec1d730017e..c127ea0a94c4 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -4,15 +4,19 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/iio/iio.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/time.h>
+#include <linux/timekeeping.h>
 #include <linux/types.h>
 
 #include "inv_icm42607.h"
@@ -100,6 +104,93 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
+int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,
+			       enum inv_icm42607_sensor_mode *gyro,
+			       enum inv_icm42607_sensor_mode *accel)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->map, INV_ICM42607_REG_PWR_MGMT0, &val);
+	if (ret)
+		return ret;
+
+	*gyro = FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
+	*accel = FIELD_GET(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, val);
+
+	return 0;
+}
+
+static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
+				      enum inv_icm42607_sensor_mode gyro,
+				      enum inv_icm42607_sensor_mode accel)
+{
+	enum inv_icm42607_sensor_mode oldaccel, oldgyro;
+	unsigned int sleepval_us;
+	unsigned int val;
+	s64 disable_wait;
+	int ret;
+
+	ret = inv_icm42607_get_pwr_mgmt0(st, &oldgyro, &oldaccel);
+	if (ret)
+		return ret;
+
+	if (gyro == oldgyro && accel == oldaccel)
+		return 0;
+
+	/*
+	 * Datasheet on page 14.26 says we need to ensure the gyro sensor is on
+	 * for a minimum of 45ms. So if we transition from an on state to an
+	 * off state make sure at least 45ms have passed before power off and
+	 * wait if it hasn't. In case some platforms don't respond well to a
+	 * sleep of 0, make sure the fsleep duration is > 0.
+	 */
+	if (!gyro && oldgyro) {
+		disable_wait = clamp(ktime_us_delta(st->conf.gyro_stop, ktime_get()),
+				     0, INV_ICM42607_GYRO_STOP_TIME_US);
+
+		if (disable_wait > 0)
+			fsleep(disable_wait);
+	}
+
+	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro) |
+	      FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
+	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	/*
+	 * If a state change occurs from off to on, sleep for the startup
+	 * time of the sensor, unless a sleep_ms is specified. Since more
+	 * than one sensor can be transitioned from off to on, select the
+	 * maximum time from each of the sensors changing from off to on.
+	 * The startup time for the temp sensor is considerably smaller
+	 * than the startup time for the other sensors and one or more are
+	 * required to be on for the temp sensor to function, so any start
+	 * delay should be enough.
+	 */
+	sleepval_us = 0;
+	if (accel && !oldaccel)
+		sleepval_us = max(sleepval_us, INV_ICM42607_ACCEL_STARTUP_TIME_US);
+
+	if (gyro && !oldgyro) {
+		sleepval_us = max(sleepval_us, INV_ICM42607_GYRO_STARTUP_TIME_US);
+		/* Track the earliest we can turn off the gyroscope. */
+		st->conf.gyro_stop = ktime_add_us(ktime_get(),
+						  INV_ICM42607_GYRO_STOP_TIME_US);
+	}
+
+	/*
+	 * Only sleep if sleepval_us is greater than 0 in case some
+	 * platforms have issues with a 0 delay. The 0 delay can happen
+	 * if one or both sensors is shut down.
+	 */
+	if (sleepval_us > 0)
+		fsleep(sleepval_us);
+
+	return 0;
+}
+
 static int inv_icm42607_set_init_conf(struct inv_icm42607_state *st,
 				      const struct inv_icm42607_conf *conf)
 {
@@ -212,12 +303,17 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
 {
 	int ret;
 
+	if (st->vddio_en)
+		return 0;
+
 	ret = regulator_enable(st->vddio_supply);
 	if (ret)
 		return ret;
 
 	fsleep(INV_ICM42607_POWER_UP_TIME_US);
 
+	st->vddio_en = true;
+
 	return 0;
 }
 
@@ -225,7 +321,12 @@ static void inv_icm42607_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42607_state *st = _data;
 
+	if (!st->vddio_en)
+		return;
+
 	regulator_disable(st->vddio_supply);
+
+	st->vddio_en = false;
 }
 
 int inv_icm42607_core_probe(struct regmap *regmap,
@@ -240,6 +341,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (!st)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, st);
+
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
@@ -275,10 +378,75 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (ret)
 		return ret;
 
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
 
+static int inv_icm42607_suspend(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	inv_icm42607_disable_vddio_reg(st);
+
+	return 0;
+}
+
+static int inv_icm42607_resume(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	ret = inv_icm42607_enable_vddio_reg(st);
+	if (ret)
+		return ret;
+
+	/* Sync the regcache again after regulator shutdown. */
+	regcache_mark_dirty(st->map);
+	ret = regcache_sync(st->map);
+	if (ret)
+		return ret;
+
+	return pm_runtime_force_resume(dev);
+}
+
+static int inv_icm42607_runtime_suspend(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+
+	guard(mutex)(&st->lock);
+
+	/*
+	 * Set sensors state to off. Since we only support one-shot
+	 * today we can use runtime PM to turn sensors off when not
+	 * in use, and then when needed the reads/writes will
+	 * re-enable the sensors as needed. This reduces complexity,
+	 * however the tradeoff is that an unused sensor won't be
+	 * turned off until the entire chip is no longer in use.
+	 */
+	st->conf.gyro.mode = INV_ICM42607_SENSOR_MODE_OFF;
+	st->conf.accel.mode = INV_ICM42607_SENSOR_MODE_OFF;
+
+	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
+					  st->conf.accel.mode);
+}
+
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {
+	SYSTEM_SLEEP_PM_OPS(inv_icm42607_suspend, inv_icm42607_resume)
+	RUNTIME_PM_OPS(inv_icm42607_runtime_suspend, NULL, NULL)
+};
+
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-42607 device driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index f2b9067815b0..04ad37291783 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include "inv_icm42607.h"
@@ -56,6 +57,11 @@ static int inv_icm42607_probe(struct i2c_client *client)
 	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_i2c_bus_setup);
 }
 
+static void inv_icm42607_i2c_remove(struct i2c_client *client)
+{
+	pm_runtime_force_suspend(&client->dev);
+}
+
 static const struct i2c_device_id inv_icm42607_id[] = {
 	{
 		.name = "icm42607",
@@ -84,9 +90,11 @@ static struct i2c_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-i2c",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_id,
 	.probe = inv_icm42607_probe,
+	.remove = inv_icm42607_i2c_remove,
 };
 module_i2c_driver(inv_icm42607_driver);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
index eb04036a6712..995393dce942 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -7,6 +7,7 @@
 #include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
@@ -65,6 +66,11 @@ static int inv_icm42607_probe(struct spi_device *spi)
 	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_spi_bus_setup);
 }
 
+static void inv_icm42607_spi_remove(struct spi_device *spi)
+{
+	pm_runtime_force_suspend(&spi->dev);
+}
+
 static const struct spi_device_id inv_icm42607_spi_id_table[] = {
 	{
 		.name = "icm42607",
@@ -94,9 +100,11 @@ static struct spi_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-spi",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_spi_id_table,
 	.probe = inv_icm42607_probe,
+	.remove = inv_icm42607_spi_remove,
 };
 module_spi_driver(inv_icm42607_driver);
 
-- 
2.43.0

