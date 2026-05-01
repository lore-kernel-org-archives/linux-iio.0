Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45B372EF0
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673667; cv=none; b=A4G1f1W4k/4czKMcnwi4y7AymiJJOvrh0PSBpo2Jb+NW93miC5QBAZuaCT4adE+/XcZMjC2OAPzgvY5XspW9FKLha7kryETjTkCWQ3ox0CcDAlG78I7ZIST2RwUlFgLobUdIJ/AigHmV1G28vD3CwapQhDzV5jhKVSsq54eaf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673667; c=relaxed/simple;
	bh=o+2syCqqbr7UGs1NdiqP33xqRgvYvckjNznNNBpUSuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO9GQw3PMXMdBY97/ORILspXXiVImBr1i0EwQnzYnUBw97TNEhofp0w1sFQuGv8OXN1cmHaBPGKKe+5TFqoq4/77/4JGxd4lqMXd1H/32nCfDmSPPljqdRC7Wk+jkFItcxOpUnGLHB8qaGi9i+GaYfjqiU3d1ae75F+nEXM6MNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6ck7VLe; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6ck7VLe"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-47bdee5bfc4so1718063b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777673664; x=1778278464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKFlzqqR7i9M4h/gUS3RyPKE+MqjlN+AWOAgNuHiyzc=;
        b=q6ck7VLeb/DI/pxa6xrxEjOeGdmAqsxZK1iiv/3Uh12CvcKwquUphtgOgo0WN/In5J
         X73uDtGMUb8/kxfRlljU6Z165g7joJ7k4yoggcPTzrUhC1OrYYaHlOx0GapPeVra5VkW
         6hktQ/HImQBlbPUmq2kcm0kX4gpP17osvTfDQXLeY3SvZ6FCl3Boktgm4xvIET/xL4Tu
         6LZe1GiaWSpcbruIym7YaWcFj/3qKsRFBbBuaOyKFWFLXkxcVGZB9CIaBJ0lYHcmWwXo
         Jc1Or5Tdh255NVHw8DHn4w9AX17Ow2khwI7lp8nae5gReloZuvR9yrya6ro3m8vrQVIx
         ugDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673664; x=1778278464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKFlzqqR7i9M4h/gUS3RyPKE+MqjlN+AWOAgNuHiyzc=;
        b=fLF9LL090AVo3t0yKs6NWmrfKit17TZc41wivteSs3vwJN3MoQTlEQ7VDJ5XkgDxdP
         Jg8zsusTvRQXvxVuy9H/UJE/XA86Hx85cLFddpHqy9gJL1UDcMngrkh9QY2tmxWPAA+9
         xCcjd7EHksz2UPMDEqsbypUxaQm62G4t1QxDxbqcUr5IqntIqfAEIr6xZjShujwec36i
         ckSzRXtEnCLVSni3LaWEfCJASpmZjyAdnqqJ9/itZAc/3j0nXiN7OsW2M4Kk09GJfAu+
         mK/43DnpPVJR/UINkimR2TJY9j3+LyO5UsGEUmRX7j2/BIgqAEQgNOxO9enY9OfqGuJ2
         kfnw==
X-Gm-Message-State: AOJu0Yx84ZILl7KEoi/HTe9K6eph99ciWevvbAzjqI5R4RjSb8tNkda9
	tuZyRCx/OSPcAIuTGZawScjNQzRp7fhc0ebQQnt9y2LWZEjYTlVprKOelHWdAQ==
X-Gm-Gg: AeBDievBIAkhTUY/4FEKuq8YldP0oSwU2JQhAc52ATY7Yy9NPM7z9+IpMliYOExRM75
	CshAykSyB/I/sThDrwISSy7Wrndzc+xoMXiXeADhS0dwtttMh9UQ2Rzwcym0QZGxfznsBuKbGcq
	yxeTL61L79mcLmvxc5fQKIvtxN4rsFV2bKWHaWs4IIL++0R3q4Lr2svQQcazK4WnSLjjd7sfhXj
	tFlVPlUXSCSGYNNNFFJ2RZMhH7kaidNIKBcv4V++hR3zpgheblh99gM6R8o2RwElN5rXIqEXahw
	HNmuCt+3Ov9PqnaPJ1Whuu+QToSlXzfw9mTYaAwxzfL+IWIkeqNjbDr82lYUg2tVKgITFDMVwqK
	QP+Tbh1nP/ZEn8aawoUZbVROsJ0qEWbCTHdO85qmBW2/ap5FCLuXJ4j70InSIwWcIPKQbA9hfZl
	WGfl7Kul9cKU4OnLWsUwP8l4yMHZul34s=
X-Received: by 2002:a05:6808:ecb:b0:47b:be30:5b36 with SMTP id 5614622812f47-47c61f6b480mr3568963b6e.3.1777673664594;
        Fri, 01 May 2026 15:14:24 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm1827337a34.26.2026.05.01.15.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:14:24 -0700 (PDT)
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
Subject: [PATCH V4 04/10] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Fri,  1 May 2026 17:11:43 -0500
Message-ID: <20260501221152.194251-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501221152.194251-1-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |   2 +
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 177 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
 4 files changed, 181 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 763d731ccc60..7facc114adc5 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -11,6 +11,7 @@
 #include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -390,6 +391,7 @@ struct inv_icm42607_sensor_state {
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
+extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 1ac3a573863c..af3784040b7a 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -106,6 +107,62 @@ u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
 	return odr_periods[odr];
 }
 
+static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
+				      enum inv_icm42607_sensor_mode gyro,
+				      enum inv_icm42607_sensor_mode accel,
+				      bool temp, unsigned int *sleep_ms)
+{
+	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
+	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
+	bool oldtemp = st->conf.temp_en;
+	unsigned int sleepval;
+	unsigned int val;
+	int ret;
+
+	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
+		return 0;
+
+	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
+	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
+	if (!temp)
+		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
+	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	st->conf.gyro.mode = gyro;
+	st->conf.accel.mode = accel;
+	st->conf.temp_en = temp;
+
+	sleepval = 0;
+	if (temp && !oldtemp) {
+		if (sleepval < INV_ICM42607_TEMP_STARTUP_TIME_MS)
+			sleepval = INV_ICM42607_TEMP_STARTUP_TIME_MS;
+	}
+	if (accel != oldaccel && oldaccel == INV_ICM42607_SENSOR_MODE_OFF) {
+		usleep_range(200, 300);
+		if (sleepval < INV_ICM42607_ACCEL_STARTUP_TIME_MS)
+			sleepval = INV_ICM42607_ACCEL_STARTUP_TIME_MS;
+	}
+	if (gyro != oldgyro) {
+		if (oldgyro == INV_ICM42607_SENSOR_MODE_OFF) {
+			usleep_range(200, 300);
+			if (sleepval < INV_ICM42607_GYRO_STARTUP_TIME_MS)
+				sleepval = INV_ICM42607_GYRO_STARTUP_TIME_MS;
+		} else if (gyro == INV_ICM42607_SENSOR_MODE_OFF) {
+			if (sleepval < INV_ICM42607_GYRO_STOP_TIME_MS)
+				sleepval = INV_ICM42607_GYRO_STOP_TIME_MS;
+		}
+	}
+
+	if (sleep_ms)
+		*sleep_ms = sleepval;
+	else if (sleepval)
+		msleep(sleepval);
+
+	return 0;
+}
+
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
@@ -313,10 +370,130 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
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
 
+/*
+ * Suspend saves sensors state and turns everything off.
+ * Check first if runtime suspend has not already done the job.
+ */
+static int inv_icm42607_suspend(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	struct device *accel_dev;
+	bool wakeup;
+	int accel_conf;
+	int ret = 0;
+
+	guard(mutex)(&st->lock);
+
+	st->suspended.gyro = st->conf.gyro.mode;
+	st->suspended.accel = st->conf.accel.mode;
+	st->suspended.temp = st->conf.temp_en;
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	/* keep chip on and wake-up capable if APEX and wakeup on */
+	accel_dev = &st->indio_accel->dev;
+	wakeup = st->apex.on && device_may_wakeup(accel_dev);
+	if (wakeup) {
+		/* keep accel on and setup irq for wakeup */
+		accel_conf = st->conf.accel.mode;
+		enable_irq_wake(st->irq);
+		disable_irq(st->irq);
+	} else {
+		accel_conf = INV_ICM42607_SENSOR_MODE_OFF;
+	}
+
+	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+					 INV_ICM42607_SENSOR_MODE_OFF, false,
+					 NULL);
+	if (ret)
+		return ret;
+
+	if (!wakeup)
+		regulator_disable(st->vddio_supply);
+
+	return 0;
+}
+
+/*
+ * System resume gets the system back on and restores the sensors state.
+ * Manually put runtime power management in system active state.
+ */
+static int inv_icm42607_resume(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	struct device *accel_dev;
+	bool wakeup;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	/* check wakeup capability */
+	accel_dev = &st->indio_accel->dev;
+	wakeup = st->apex.on && device_may_wakeup(accel_dev);
+	/* restore irq state */
+	if (wakeup) {
+		enable_irq(st->irq);
+		disable_irq_wake(st->irq);
+	} else {
+		ret = inv_icm42607_enable_vddio_reg(st);
+		if (ret)
+			return ret;
+	}
+
+	/* restore sensors state */
+	ret = inv_icm42607_set_pwr_mgmt0(st, st->suspended.gyro,
+					 st->suspended.accel,
+					 st->suspended.temp, NULL);
+	return ret;
+}
+
+static int inv_icm42607_runtime_suspend(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	int ret = 0;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+					 INV_ICM42607_SENSOR_MODE_OFF, false,
+					 NULL);
+	if (ret)
+		return ret;
+
+	regulator_disable(st->vddio_supply);
+
+	return 0;
+}
+
+static int inv_icm42607_runtime_resume(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+
+	guard(mutex)(&st->lock);
+
+	return inv_icm42607_enable_vddio_reg(st);
+}
+
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {
+	SYSTEM_SLEEP_PM_OPS(inv_icm42607_suspend, inv_icm42607_resume)
+	RUNTIME_PM_OPS(inv_icm42607_runtime_suspend,
+		       inv_icm42607_runtime_resume, NULL)
+};
+
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-42607x device driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index 83cdb9c87167..24cf39d52592 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -78,6 +78,7 @@ static struct i2c_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-i2c",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_id,
 	.probe = inv_icm42607_probe,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
index 7a02bbab3a63..9ee3b39b1b08 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -84,6 +84,7 @@ static struct spi_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-spi",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = &inv_icm42607_pm_ops,
 	},
 	.id_table = inv_icm42607_spi_id_table,
 	.probe = inv_icm42607_probe,
-- 
2.43.0

