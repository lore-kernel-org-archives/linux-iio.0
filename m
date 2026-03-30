Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AD37F8D9
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900871; cv=none; b=lDJiiU5h8dI0Nmkw9vToLpjT4bTlkUerbA9iNHnEsK1F74l5JstuRpss0dUxuXwLkrxC1uAoMZLFGa9KFLNiSB5b1G6sDvsJATmpD6NWjlgFoONaa8BzLK9qC3oM8p5dZXdYEYNSIoCJesoc2pC3DKvMuqgZqwcWn8wig003Yk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900871; c=relaxed/simple;
	bh=SJSoL8SuGui7zmpK21MM5YhT767/Pm3qXKDFTqmP3fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P26lWriVtVimlwKYKdb0UOPWFCBSDWH2dPYjKR/rrsSQ/5I3v8qg2XPRvo1lEHzsmzLvVUCYmDq9uMngFcD7BFF4DjC9LXUrDPxCgb5211SlFhTm0gDMZdwqiTjr30pZTMt15fBwPhJS9d4ugdV7rABOy5aupQGhIh9o6jqHC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GADxMTZE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GADxMTZE"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d9d929e27aso4017783a34.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900868; x=1775505668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yko/h61fBPslNTUCZF5TCyRVjM5IiSB0CAcx1A/qslI=;
        b=GADxMTZEdVegt/xmGyqBN8Fjtbjf2ZUrgRzYDHDzApJ0yXsg3x9996BUTwxpX8LeqX
         7aoEYBPvJgeQl33Wx8Vn0CnFHzmASnJlES6IJUHdkVOM9K8bbK4sOboBLsu16Gnxh9i3
         nQViwNlqHh2zUMN8UZ4ikLg6naw8n72FVwXFPzFXIbLJa5SYQGQy86FzO+NTm69Zbgs+
         UucD7EW5uYSWYVg8koCib1921/rp+ViB0/nR1d6sI251m5SmdDS5TNv37dlwptnbrt8C
         qjtvaKxr3ptLWw7FiLW6fswQfAJjC1E7UaLyv0jSlJAKb9ZmlQ8Ivj9M7S1HkAleHsmx
         +jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900868; x=1775505668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yko/h61fBPslNTUCZF5TCyRVjM5IiSB0CAcx1A/qslI=;
        b=mvkT1Xr/nX4G4JcxNCbgprKs97A8LNGRnOfleicNhL26oHULcpQ0WRIlZpF1wNwrUu
         jWPUYTDKITDuYLBWEqZVljwhaaERtu/ZzqxmaeLnP510ACqAKB1WrdiXnH82s6HxN/Qb
         JhG9TbhXHmUQyqb5x0IotN2agRDY/erA7+h/Y0BJZo/sGbZoVBRorkw6Uno4tUVq3Sih
         4XtGY2OWN6l0xt+enBqsUzTRocUfWbhD2VNAtuxU7UNlNG4ntkMp7po3U9SXpvmbgrP9
         lV10HE6QoUNpd0sUVDWy0bZGb6qqRySRDdOa4cIMVHJfcm3MvP2QGJW7I/dOezhdYsZS
         58ig==
X-Gm-Message-State: AOJu0YwMhSwfJd/zsb/QLcVd5idaYigcb+rEnv/OLDdt1YH+TauPMqtg
	Yqxwg+5dJB59KfI4zfbj52h/QpwGwIu0wCiTcoLyHnbQGmFzcRhcNMZkajk8DU+6
X-Gm-Gg: ATEYQzyaz1ZbHHu6LkAmrKfxamDlrnqUqIg610eIPHn/Adbrrj+teKo0eowNYZu9FA7
	Ed7eGq1ZWJGmrXbz5Kp4kaWK5N4s/9xSa7fTjnw5wlscS0l0yncJDJJJoCOJ2HHibVKOEKzUsc6
	4Z+Pugq3pj32TIAz728As3oaIHrZk+LWxNyBA36hK9ayz7LXPR0qC4ZkEUU3JVJlTuH5kim4kCK
	prRMVtwgyT8x3gtQvgnRLxjG8oXu/BviF7yQr9Rjd3o5J/pb+Fzfq5UeiXsifoSKgbKHeG14ljE
	CkprT6SP/z+vEESeI56JX9szNFGtfZchFUDGFdstLZl02q2Eb3j2qw5y2oPZpKLr6BtaymESSO0
	bc5U+gWxoobF4rf9WvI4aX1fsRugeLF+M58dQSM09vUdP8OU39HYH3FNGF+A9oUdI3LkQmEaMFQ
	6cKck81PehVdfKN2LhG6Rk
X-Received: by 2002:a05:6830:3691:b0:7d9:c772:4d78 with SMTP id 46e09a7af769-7d9fafaaa3fmr8331502a34.30.1774900868315;
        Mon, 30 Mar 2026 13:01:08 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336353sm6601068a34.2.2026.03.30.13.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:01:07 -0700 (PDT)
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
Subject: [PATCH V3 3/9] iio: imu: inv_icm42607: Add I2C and SPI For icm42607
Date: Mon, 30 Mar 2026 14:58:47 -0500
Message-ID: <20260330195853.392877-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330195853.392877-1-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add I2C and SPI driver support for InvenSense ICM-42607 devices.
Include runtime power management on each device.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  14 ++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 204 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  93 ++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 100 +++++++++
 4 files changed, 411 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 609188c40ffc..7d13091aa8df 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -11,6 +11,7 @@
 #include <linux/regmap.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/common/inv_sensors_timestamp.h>
 
@@ -21,6 +22,16 @@ enum inv_icm42607_chip {
 	INV_CHIP_NB,
 };
 
+/* serial bus slew rates */
+enum inv_icm42607_slew_rate {
+	INV_ICM42607_SLEW_RATE_20_60NS,
+	INV_ICM42607_SLEW_RATE_12_36NS,
+	INV_ICM42607_SLEW_RATE_6_18NS,
+	INV_ICM42607_SLEW_RATE_4_12NS,
+	INV_ICM42607_SLEW_RATE_2_6NS,
+	INV_ICM42607_SLEW_RATE_INF_2NS,
+};
+
 enum inv_icm42607_sensor_mode {
 	INV_ICM42607_SENSOR_MODE_OFF,
 	INV_ICM42607_SENSOR_MODE_STANDBY,
@@ -413,6 +424,9 @@ struct inv_icm42607_sensor_state {
 
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
+extern const struct regmap_config inv_icm42607_regmap_config;
+extern const struct dev_pm_ops inv_icm42607_pm_ops;
+
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
 
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 6b7078387568..da04c820dab2 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -12,12 +12,33 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 
 #include "inv_icm42607.h"
 
+static const struct regmap_range_cfg inv_icm42607_regmap_ranges[] = {
+	{
+		.name = "user bank",
+		.range_min = 0x0000,
+		.range_max = 0x00FF,
+		.window_start = 0,
+		.window_len = 0x0100,
+	},
+};
+
+const struct regmap_config inv_icm42607_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x00FF,
+	.ranges = inv_icm42607_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42607_regmap_ranges),
+	.cache_type = REGCACHE_NONE,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
+
 struct inv_icm42607_hw {
 	uint8_t whoami;
 	const char *name;
@@ -86,6 +107,62 @@ u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
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
+	val = INV_ICM42607_PWR_MGMT0_GYRO(gyro) |
+	INV_ICM42607_PWR_MGMT0_ACCEL(accel);
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
@@ -219,6 +296,10 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
 static void inv_icm42607_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42607_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
+
+	if (pm_runtime_status_suspended(dev))
+		return;
 
 	regulator_disable(st->vddio_supply);
 }
@@ -289,11 +370,134 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
 
 	/* Setup chip registers (includes WHOAMI check, reset check, bus setup) */
 	ret = inv_icm42607_setup(st, bus_setup);
+	if (ret)
+		return ret; /* Return error from setup (e.g., WHOAMI fail) */
+
+	/* Setup runtime power management */
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
 
 	return ret;
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
+	/* restore irq state or vddio if cut off */
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
new file mode 100644
index 000000000000..eb72973debc5
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#include "inv_icm42607.h"
+
+static int inv_icm42607_i2c_bus_setup(struct inv_icm42607_state *st)
+{
+	unsigned int mask, val;
+	int ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
+				 INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
+				 INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN, 0);
+	if (ret)
+		return ret;
+
+	mask = INV_ICM42607_DRIVE_CONFIG2_I2C_MASK;
+	val = INV_ICM42607_DRIVE_CONFIG2_I2C(INV_ICM42607_SLEW_RATE_12_36NS);
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG2,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS);
+}
+
+static int inv_icm42607_probe(struct i2c_client *client)
+{
+	const void *match;
+	enum inv_icm42607_chip chip;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -EOPNOTSUPP;
+
+	match = device_get_match_data(&client->dev);
+	if (!match)
+		return -EINVAL;
+	chip = (uintptr_t)match;
+
+	regmap = devm_regmap_init_i2c(client, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm42607_core_probe(regmap, chip, inv_icm42607_i2c_bus_setup);
+}
+
+static const struct i2c_device_id inv_icm42607_id[] = {
+	{ "icm42607", INV_CHIP_ICM42607 },
+	{ "icm42607p", INV_CHIP_ICM42607P },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
+
+static const struct of_device_id inv_icm42607_of_matches[] = {
+	{
+		.compatible = "invensense,icm42607",
+		.data = (void *)INV_CHIP_ICM42607,
+	}, {
+		.compatible = "invensense,icm42607p",
+		.data = (void *)INV_CHIP_ICM42607P,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
+
+static struct i2c_driver inv_icm42607_driver = {
+	.driver = {
+		.name = "inv-icm42607-i2c",
+		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
+	},
+	.id_table = inv_icm42607_id,
+	.probe = inv_icm42607_probe,
+};
+module_i2c_driver(inv_icm42607_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-42607x I2C driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM42607");
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
new file mode 100644
index 000000000000..51ce3deeb706
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#include "inv_icm42607.h"
+
+static int inv_icm42607_spi_bus_setup(struct inv_icm42607_state *st)
+{
+	unsigned int mask, val;
+	int ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DEVICE_CONFIG,
+				 INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE,
+				 INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
+				 INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
+				 INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN, 0);
+	if (ret)
+		return ret;
+
+	mask = INV_ICM42607_DRIVE_CONFIG3_SPI_MASK;
+	val = INV_ICM42607_DRIVE_CONFIG3_SPI(INV_ICM42607_SLEW_RATE_INF_2NS);
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG3,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS);
+}
+
+static int inv_icm42607_probe(struct spi_device *spi)
+{
+	const void *match;
+	enum inv_icm42607_chip chip;
+	struct regmap *regmap;
+
+	match = device_get_match_data(&spi->dev);
+	if (!match)
+		return -EINVAL;
+	chip = (uintptr_t)match;
+
+	regmap = devm_regmap_init_spi(spi, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap %ld\n",
+				     PTR_ERR(regmap));
+
+	return inv_icm42607_core_probe(regmap, chip,
+				       inv_icm42607_spi_bus_setup);
+}
+
+static const struct of_device_id inv_icm42607_of_matches[] = {
+	{
+		.compatible = "invensense,icm42607",
+		.data = (void *)INV_CHIP_ICM42607,
+	},
+	{
+		.compatible = "invensense,icm42607p",
+		.data = (void *)INV_CHIP_ICM42607P,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
+
+static const struct spi_device_id inv_icm42607_spi_id_table[] = {
+	{ "icm42607", INV_CHIP_ICM42607 },
+	{ "icm42607p", INV_CHIP_ICM42607P },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, inv_icm42607_spi_id_table);
+
+static struct spi_driver inv_icm42607_driver = {
+	.driver = {
+		.name = "inv-icm42607-spi",
+		.of_match_table = inv_icm42607_of_matches,
+		.pm = &inv_icm42607_pm_ops,
+	},
+	.id_table = inv_icm42607_spi_id_table,
+	.probe = inv_icm42607_probe,
+};
+module_spi_driver(inv_icm42607_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-42607x SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM42607");
-- 
2.43.0

