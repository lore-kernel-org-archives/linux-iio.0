Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA364734FB
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279493; cv=none; b=cX9vCjLndf/a+bnPlJFk0zYuii62FeW9ds1LpcWmOydSvh8I9MKfg9okPqZ/sBuO72PPedTPcz9i4mZl2IiRFcrT4Jw1s7C58GR7F5j7AycvXcCKpOBBWOA2GEy2kIn7yY9naiyAntoZUfrc8dPaFnUls1DTEEgp3/lvMc9LJY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279493; c=relaxed/simple;
	bh=iVZJNB04oDHT2zNskcmykZJnD8+AbswTFYVqhRvzFZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/hhwOUGXj7aQR4RQPIZZw8uAKx0n6Ohv1PTor9mnAG67TlccAXXvQyZhY5mNPLdQmQeqGlVYpWpIH8DVad3y0jZ4jD1ms3bXjDqWv6PdqI+yBxol0NXByYrhkUIQ/95LYpxefg3ywC9lQ93yXh+kTQdP29xiEmEfT3kTE5pCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbGw72hp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbGw72hp"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aaf3f54dbfso203138eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279490; x=1785884290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XShOrLFzvWfhWAFZxzJPaTav7R3nACVwlCtKsEqOgAg=;
        b=gbGw72hpJcT4nXHmJf/L+qxSfQMm1YDzMcVsJozQDM8HaaXFJ9YOFC9ddYTPYBxMRZ
         UydoVFumhCa6I4Wj7NqxM7Tigk53E1HwBR1LvWYzJAFDEiUE2UPwm3b9XDv2aC1VdjBj
         nVUDWxO/N5l8a8wADkjx0eUkkzwNNDrZ26eZO30s8sZRkSuypVIYyQLV0skrkNxdTp4F
         PM3jkYd3VBKbwGajrqiBe92wUzM3s0LP+5fkH8iCupvCqrxr/xPB4Pir4Wf7eRSabgT+
         5FpbLeasJapSv6+6xTOIuE1k76WbSQ71BjVxa4o3BR6I/1DEefLVu2eVLDYEMfY9ljaP
         hEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279490; x=1785884290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XShOrLFzvWfhWAFZxzJPaTav7R3nACVwlCtKsEqOgAg=;
        b=Qq19dSA1osefnFMVOXmi6KqsXz4u7zkUEz9mQeEThOYToyaKmBBYjhvKeBtk148Gjc
         WcKyqDQurhFE7Gef1tvjb0+O8rwWelp+Hkj353dvH8+AtgzTMItgI7pc1PhdL8NCVmgc
         jNsnB5p5cSWTexAxEr2QyobOoprh4rZx/HzZwWSVYMQu3tFWkrT73UoVFj667Cr0mdt5
         6DNQ8gxgpqJSZiR6j1uQxk85NOi78IveHDQIVqtSmL2wdgMXF/FuFqaqW/WxLudQfT/A
         pKolV2/ajA79ii3DxoBRrqI3V9pLvrknWWPGnSTVA9WhcpG8fwT88IFjjGMAjQSvACdn
         iB+w==
X-Gm-Message-State: AOJu0YxjQD628QmdyJS8YW6G0ml6cUmFdogP0rnGzdu+M9YhomGATJgE
	xvvA285EdLD17pqScBVkN7ZdqRKNMwnPdylL+jK0Wqvgw77ndAxwaqc+FPNLWw==
X-Gm-Gg: AR+sD12bi1+1sZI0+TjVXU07yNrkYuwEKktyPaiuzczuSB6sHrE5JG1bl6VhfQEmWl8
	f28WG6OxPWtbYnDQ7VFBFtaQlh94gBf0oT0svD+cKExFLmfyBj3pGd15cH2ZGJNeLn+a180YDEH
	xjIM7e7djiJ0uPfXa7y9aX7WDFsDYst5NK6HLaMkUQpg2JJUnZLB6Dv13JzZFOfW4HThGNWzgur
	LpE43Jj7JsWfEEIOiepkAPKOVz31zl1a76qequHTk0gZoHSaeBdcB5QhZJr8eHbzOW5In9qJnL7
	f8fp2ZnL/5PTp0ko3VvdjSAG/dGuH762m0yuYBGU1D16ez91wJgh1ZgR52A2HmtnwrqDCmdjnrh
	YMbF3PhrO6P7+XtnmFesBr3uuG0T0FZhesDfGluqMhO/E2/1FCQOC18EENCsE3HqQG4CLmwnaEk
	7QTawazztyJ3eMvAq1M1a6Hw==
X-Received: by 2002:a05:6820:4dec:b0:6a1:18a3:48f5 with SMTP id 006d021491bc7-6ac96cfdce7mr2156328eaf.37.1785279490424;
        Tue, 28 Jul 2026 15:58:10 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9162:e42b:cb94:2d55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4588646ade0sm990277fac.5.2026.07.28.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:58:09 -0700 (PDT)
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
Subject: [PATCH V21 5/9] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Tue, 28 Jul 2026 17:55:36 -0500
Message-ID: <20260728225542.174825-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728225542.174825-1-macroalpha82@gmail.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 187 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
 4 files changed, 203 insertions(+)

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
index 6ec1d730017e..af301bde3f17 100644
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
@@ -100,6 +104,92 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
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
+	 * If a state change occurs from off to on, sleep for the startup time
+	 * of the sensor. Since more than one sensor can be transitioned from
+	 * off to on, select the maximum time from each of the sensors changing
+	 * from off to on. The startup time for the temp sensor is considerably
+	 * smaller than the startup time for the other sensors and one or more
+	 * are required to be on for the temp sensor to function, so any start
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
+	 * Only sleep if sleepval_us is greater than 0 in case some platforms
+	 * have issues with a 0 delay. The 0 delay can happen if one or both
+	 * sensors is shut down.
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
@@ -212,20 +302,47 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
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
 
+static void inv_icm42607_sensors_off(void *_data)
+{
+	struct inv_icm42607_state *st = _data;
+	const struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	st->conf.gyro.mode = INV_ICM42607_SENSOR_MODE_OFF;
+	st->conf.accel.mode = INV_ICM42607_SENSOR_MODE_OFF;
+
+	ret = inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
+					 st->conf.accel.mode);
+	if (ret)
+		dev_err(dev, "Unable to turn off sensors\n");
+}
+
 static void inv_icm42607_disable_vddio_reg(void *_data)
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
@@ -240,6 +357,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (!st)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, st);
+
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
@@ -275,10 +394,78 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (ret)
 		return ret;
 
+	/*
+	 * Ensure if sensors get turned on at some point, they're turned off
+	 * as part of teardown.
+	 */
+	ret = devm_add_action_or_reset(dev, inv_icm42607_sensors_off, st);
+	if (ret)
+		return ret;
+
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
+	/*
+	 * Set sensors state to off. Since we only support one-shot
+	 * today we can use runtime PM to turn sensors off when not
+	 * in use, and then when needed the reads/writes will
+	 * re-enable the sensors as needed. This reduces complexity,
+	 * however the tradeoff is that an unused sensor won't be
+	 * turned off until the entire chip is no longer in use.
+	 */
+	inv_icm42607_sensors_off(st);
+	return 0;
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
index f2b9067815b0..e903106af84a 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -84,6 +84,7 @@ static struct i2c_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-i2c",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_id,
 	.probe = inv_icm42607_probe,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
index eb04036a6712..cd739375f6b2 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -94,6 +94,7 @@ static struct spi_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-spi",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_spi_id_table,
 	.probe = inv_icm42607_probe,
-- 
2.43.0

