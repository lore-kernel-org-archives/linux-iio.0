Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C3392824
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134877; cv=none; b=Gtk43Df1RR3CobVndGXlMQI0c3grTiPAkaWmyqDSU3qC8PwfXjD7cXEYQjDCBOiuxNqZOBxOwij+daXZRBo0WfKiEYwiv3JXFFM5Z+tHYXNLBB+jsui4DkiJ+cYz23T3oO/dsx2YYh/HrPtoR/TZSFTuCM6NvqiNgazNgeIRc7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134877; c=relaxed/simple;
	bh=XBggy9mgRP12WpyAqMhe/K6lundvPh+NmfwNVbXyAcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BM5RhGUhW/aQ21oysrMnXhhxsyEbuoXpfLU+I0I2X2FdN6ygf7lk8pQwj1zRSoRTE3fH6wkQKCAYwyRg/SvvGQq7ubZDtlw0i0V7Y9j47+XaFmAKtefT+8Kdn7PKvLt7+VaZ8Wo7tNjXDJAjdw5LDpt7IJDDzS6MqskVUT7QGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH0MqApg; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH0MqApg"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69b4f7d66e2so646545eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134875; x=1779739675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xJ+xVgnZz6J8/ZOxTiHdKoDuz0ndhEP3E/chsRZjhM=;
        b=YH0MqApg53h7WOdfMt3819r0e9VYkuYJu2HBu82O+YweTdnufgxuBiwX5IMu00Zeir
         S3ObGo+lfDpHlvD/qMUG9hVOx2wUfdLTtmOwz91z6QZ2hKNPmADTRpbQgumCy+MICJJi
         UXE0CGpKXm/aqRQGsvpX3GPl8sBhPLrL2HRVwyqKOkv7WrK3+xQWkpAlopKDtmy9B3He
         YM4sxNUVz6reAspPkenLLsdbZLsFIpWLEvtK+Tnmr/+4HmNL7MfxAPzXa+PxiOcXnt+X
         nCMHiaZj4aPazictrUiZe3o9+Xo5AlIlAjmQw5voWb1f+jWs8JzanLs3Qp44uEF26nx8
         to6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134875; x=1779739675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xJ+xVgnZz6J8/ZOxTiHdKoDuz0ndhEP3E/chsRZjhM=;
        b=P3sQQODYK3WjjqIeiY4F8lE9xPauN7XWSUik230Svs/uYT6hRqJHnxASejrC6UpfzS
         cIk1JbuwAogfjOVk1/c/NfrC9/RbZTE9cVL9G7ZIyJjoSvPmMFb9pF1OOJK/+x860kRW
         LgFWFChexYXLw7hkqUcvjPgid1UxYHOtJMVjYvMVJlYAEcT9XqxZsCxDPp+98MTfiiey
         VXMUe8yi56RiwZaVB13IM9G17gusodxDHrnZmFfBu4PoaBEjQlTmQ2zS8UlgPVjbJJPB
         x7Hb4+pqi6iCFfYeSQJwcYS9AwgEvA2b65C5Evio0n9bZU5NzCANDAOKl62Cr9B4lYkz
         5Pmw==
X-Gm-Message-State: AOJu0Yy7aQoyibWUEb9oF9GfHOnhO54axArnHcefcCeiK8yc9P6dNbsM
	6VaXC6kI3UvZAzMQO0pXdpahXfTmxGMC4kN0UJQX4DFESdR4XiOydeMLJGfLYI6T
X-Gm-Gg: Acq92OEVMqa1jcV5I5kCzBjKBCmds3ts2pR50NZ5Jg8tXgV5YIndwzIdrSvqWOMPi4j
	iAAZ4XhrKWxwrnoR8wI1cR+kwVBTh6LpshydFXVNdVEU6CHWptaeJH4mMqSAZ11Csu9ic8D8wTm
	VhPKnU+/BQ4x0h9UR+hmG3UIlyqP3beCFyLfe3yS5tCn5J1vR4RampAhnrwKGRPzE8SooO3zrBd
	ss0ufI0SXxHycjpxraQjH3PH7G4a7g2U9UKIsy4C6PeFbIkJOfdbHSUIqWYFUxNU+H9eVNmVseG
	yPBir/KJepHoWG8+suvRaFABV4daK/XFcx6vS+UjaG9YqgMcofWBPzJn6FupPBVdOVE3Z2+X+Bx
	GiJQkBEWIC4tQXewbBKVHEUUh1K9EvIy3s7aiJYY+htViJFd4LX97UBjVpQR+TIJN8Lt5KFIcWU
	3rLxfSJcctpfCGlCvdz5Ai
X-Received: by 2002:a05:6820:2210:b0:696:17a3:4673 with SMTP id 006d021491bc7-69c9bfcf81dmr9991865eaf.50.1779134874819;
        Mon, 18 May 2026 13:07:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d0462e85esm6113360eaf.6.2026.05.18.13.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:07:54 -0700 (PDT)
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
Subject: [PATCH V8 05/10] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Mon, 18 May 2026 15:05:20 -0500
Message-ID: <20260518200526.458421-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518200526.458421-1-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  18 +++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 147 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
 4 files changed, 167 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 74d8d3d7c890..b05828415053 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -96,24 +97,34 @@ struct inv_icm42607_hw {
 	const struct inv_icm42607_conf *conf;
 };
 
+struct inv_icm42607_suspended {
+	enum inv_icm42607_sensor_mode gyro;
+	enum inv_icm42607_sensor_mode accel;
+	bool temp;
+};
+
 /**
  *  struct inv_icm42607_state - driver state variables
  *  @lock:		lock for serializing multiple registers access.
  *  @hw:		Hardware specific data.
  *  @map:		regmap pointer.
  *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @vddio_en:		I/O voltage status for runtime PM.
  *  @irq:		chip irq, required to enable/disable and set wakeup
  *  @orientation:	sensor chip orientation relative to main hardware.
  *  @conf:		chip sensors configurations.
+ *  @suspended:		suspended sensors configuration.
  */
 struct inv_icm42607_state {
 	struct mutex lock;
 	const struct inv_icm42607_hw *hw;
 	struct regmap *map;
 	struct regulator *vddio_supply;
+	bool vddio_en;
 	int irq;
 	struct iio_mount_matrix orientation;
 	struct inv_icm42607_conf conf;
+	struct inv_icm42607_suspended suspended;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -332,11 +343,18 @@ struct inv_icm42607_state {
 #define INV_ICM42607_GYRO_STARTUP_TIME_MS		30
 #define INV_ICM42607_TEMP_STARTUP_TIME_MS		77
 
+/*
+ * Suspend delay assumed from other icm42600 series device, not
+ * documented in datasheet.
+ */
+#define INV_ICM42607_SUSPEND_DELAY_MS			2000
+
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
+extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index e9c81b52f9ef..bc0cefa2fb77 100644
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
@@ -72,6 +73,62 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
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
+			if (sleepval < INV_ICM42607_GYRO_STARTUP_TIME_MS)
+				sleepval = INV_ICM42607_GYRO_STARTUP_TIME_MS;
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
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
@@ -179,12 +236,17 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
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
 
@@ -192,7 +254,12 @@ static void inv_icm42607_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42607_state *st = _data;
 
+	if (!st->vddio_en)
+		return;
+
 	regulator_disable(st->vddio_supply);
+
+	st->vddio_en = false;
 }
 
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
@@ -249,10 +316,90 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
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
+	guard(mutex)(&st->lock);
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+					 INV_ICM42607_SENSOR_MODE_OFF,
+					 false, NULL);
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
+	guard(mutex)(&st->lock);
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	ret = inv_icm42607_enable_vddio_reg(st);
+	if (ret)
+		return ret;
+
+	/* Nothing else to restore at this time. */
+
+	return 0;
+}
+
+static int inv_icm42607_runtime_suspend(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+					 INV_ICM42607_SENSOR_MODE_OFF, false,
+					 NULL);
+	if (ret)
+		return ret;
+
+	inv_icm42607_disable_vddio_reg(st);
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
index 8631579a609a..a51c764bf1dc 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -77,6 +77,7 @@ static struct i2c_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-i2c",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_id,
 	.probe = inv_icm42607_probe,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
index 960b5d3e9abc..9a37ad8d986a 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -89,6 +89,7 @@ static struct spi_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-spi",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_spi_id_table,
 	.probe = inv_icm42607_probe,
-- 
2.43.0

