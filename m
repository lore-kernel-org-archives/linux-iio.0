Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972944192EC
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544495; cv=none; b=goM/ZKCIs/89P6i1L+Vf+1om8qFR70WuPhxXt8vKUZ4zd6+wvZ9HRgZcqlWsqFdB5wDBH5e71OzAJfWUreTzkvUvG9HRVejERTEdVjR36bNGyghOql6HIkLeYTuBpjoRN/TZ6QvjWxCbQOt3RJhiMHx7X/d2iGXDpxo7/4bC/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544495; c=relaxed/simple;
	bh=qZNMh6ongCfme017BYAJhfA7y6vz94oFefvFFMDsGgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7g5qkJ1rv0I3wBoJqiyMb//7Dm1c23WL2icJ5bdqYU4aG8mypkGeT/n7Pp3AJs7SgLC+kQcBbIoaq7XEwgl5t6hi7jEZq0hMf03CeCu9VpNGSjAH1cOGBCm+mYYcWGPCDT0gkm8kQeX3JowYQDbAXqa29zajfD8prb/5UJWAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VESkfSpq; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VESkfSpq"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6db226e1fso2621439a34.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544492; x=1782149292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SEAlN8WVNDMLKN6vmEcW+cJZpdDwJlORUdjJHdKhL0=;
        b=VESkfSpqCWM9mA5ipQA7Ze/JhtE1nowdGgkLaYPkO1nYLXLUOmDVpaWc4er2hA0GxV
         SHnLv9FLDITeOrFkyuO4lM7w4oTzIR94ZXWFiyXT+szHpk9gJlHoKVnysAMBBH+zQPld
         6pHEsPLynvNXztea9a0aSowyULi5TJcDY3Kc3YB6OfkNQ+bMmk4ceviccl0Ww8RaWX57
         6N1tHkdXfFZQIuHBVRUhGSMLInYLDToFBujb4fy34oS3KV6SqpryPfTGhbbq5UftKAWg
         Zk+UHUbNqlL9kRPcJoCjAMw2FIQl/CuWSt9jAJhX0U1llUHRDFivdvgs6P/V6WFToZMO
         CAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544492; x=1782149292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SEAlN8WVNDMLKN6vmEcW+cJZpdDwJlORUdjJHdKhL0=;
        b=pSpswq6h6RvZpRNcO6UwBq2Rs5z3Ml4iJvzfNwz15OciISk0ha34bm27hMTiqncBLZ
         6w/RKCEEWjLxze2olxPY8eCcw0/JfXC3ItjhhypXBivLuDWA6YwxK/193IWDn+xHCDHn
         ksqyG1SkRy0nNBIgnWDODmaYhLI/Mnuc3XFWs5W1+HeEF0ODCUbVEpxDX9lOg0TBzJlN
         XjMfm+tu1oDRdU2aXoubqhnyWuB/eMApIZQV/89Wfay3Snj75xZeFwFixLK4FUbNVsHP
         su+Fm+vO6z8dTH38FoEq7Q5rGBv0hvn71K4tMJ/VDFxUsDG7ev2WcPfSZS63rqDW4XfO
         7vCw==
X-Gm-Message-State: AOJu0YwC6le/J+iJW46v3OtRMIyK12AWg4NLnL0nZS9U1E5c2wDJXmn0
	nwlGOdfnUjX/l11xdHAScWQuTqld873PbwFxJa3ChmsboS26LHhGDl31LrmUkhtr
X-Gm-Gg: Acq92OH6ehjdWBoqUpWbqg87yHDJwHl4V/wfHksOEUUfmz3uEhSlpT89zCrKo0bJ3eO
	VL2HpuEfbUKMzRgKGldAWCiX2I3uFtJlGgjdqfJD/VZfHnivJnVaKsn2+39UqBUm1wW3Qvc9sAd
	jwmokk+X3J7t3O7Sx6M1qDDxob+1j9tx9GWW2R327p9m7Nl1O+6Hf1mBsabPEjvdgvfnG+N5mUu
	h3P8JYHDNaPP4Xm8LcgVBKRd0Jqr5u2qTLbR/CVEPGd+DZ7K94Yfd42YQgWKR1JvFn9RrOW8syl
	DxFQR2DripUsV9tp9wNrL/0Vn96s1o2n9dfPI5yf2+ypI1Kyt9Y0iLfJ5sKCW3sbU6wThYATjUS
	lenxKr55umf5lTBHKA/3DSr3KFS2KiZhRheMpA7Wi80auW9rn1dPiJBk8jrq0ewKVSRaxeqmVCX
	hHzKRBSSWA7TyaAUJhTLZKvw==
X-Received: by 2002:a05:6830:6389:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7e78e7b0c6bmr9839062a34.17.1781544492573;
        Mon, 15 Jun 2026 10:28:12 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f451fe7sm4480033a34.0.2026.06.15.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:28:11 -0700 (PDT)
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
Subject: [PATCH V13 5/9] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Mon, 15 Jun 2026 12:25:48 -0500
Message-ID: <20260615172554.160910-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615172554.160910-1-macroalpha82@gmail.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 139 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
 4 files changed, 159 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index a6a58571935f..4f4f541027dc 100644
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
@@ -105,12 +106,20 @@ struct inv_icm42607_hw {
 	u8 whoami;
 };
 
+struct inv_icm42607_suspended {
+	enum inv_icm42607_sensor_mode gyro;
+	enum inv_icm42607_sensor_mode accel;
+	bool temp;
+};
+
 /**
  *  struct inv_icm42607_state - driver state variables
  *  @hw:		Hardware specific data.
  *  @lock:		lock for serializing multiple registers access.
  *  @map:		regmap pointer.
  *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @vddio_en:		I/O voltage status for runtime PM.
+ *  @suspended:		suspended sensors configuration.
  *  @conf:		chip sensors configurations.
  *  @orientation:	sensor chip orientation relative to main hardware.
  */
@@ -119,6 +128,8 @@ struct inv_icm42607_state {
 	struct mutex lock;
 	struct regmap *map;
 	struct regulator *vddio_supply;
+	bool vddio_en;
+	struct inv_icm42607_suspended suspended;
 	struct inv_icm42607_conf conf;
 	struct iio_mount_matrix orientation;
 };
@@ -334,11 +345,18 @@ struct inv_icm42607_state {
 #define INV_ICM42607_GYRO_STOP_TIME_MS			45
 #define INV_ICM42607_TEMP_STARTUP_TIME_MS		77
 
+/*
+ * Suspend delay assumed from other icm42600 series device, not
+ * documented in datasheet.
+ */
+#define INV_ICM42607_SUSPEND_DELAY_MS			(2 * USEC_PER_MSEC)
+
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
+extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 4b8e19091786..64f5d263de4f 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
@@ -11,6 +12,7 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/time.h>
@@ -103,6 +105,63 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
+static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
+				      enum inv_icm42607_sensor_mode gyro,
+				      enum inv_icm42607_sensor_mode accel,
+				      bool temp, unsigned int *sleep_ms)
+{
+	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
+	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
+	bool oldtemp = st->conf.temp_en;
+	unsigned int sleepval_ms;
+	unsigned int val;
+	int ret;
+
+	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
+		return 0;
+
+	/*
+	 * Datasheet on page 14.26 says we need to ensure the gyro sensor is on
+	 * for a minimum of 45ms. So if we transition from an on state to an
+	 * off state wait 45ms to ensure a sufficient pause before power off.
+	 */
+	if (!gyro && oldgyro)
+		fsleep(INV_ICM42607_GYRO_STOP_TIME_MS * USEC_PER_MSEC);
+
+	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
+	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
+	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	st->conf.gyro.mode = gyro;
+	st->conf.accel.mode = accel;
+	st->conf.temp_en = temp;
+
+	/*
+	 * If a state change occurs from off to on, sleep for the startup
+	 * time of the sensor, unless a sleep_ms is specified. Since more
+	 * than one sensor can be transitioned from off to on, select the
+	 * maximum time from each of the sensors changing from off to on.
+	 */
+	sleepval_ms = 0;
+	if (temp && !oldtemp)
+		sleepval_ms = max(sleepval_ms, INV_ICM42607_TEMP_STARTUP_TIME_MS);
+
+	if (accel && !oldaccel)
+		sleepval_ms = max(sleepval_ms, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
+
+	if (gyro && !oldgyro)
+		sleepval_ms = max(sleepval_ms, INV_ICM42607_GYRO_STARTUP_TIME_MS);
+
+	if (sleep_ms)
+		*sleep_ms = sleepval_ms;
+	else if (sleepval_ms)
+		fsleep(sleepval_ms * USEC_PER_MSEC);
+
+	return 0;
+}
+
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
@@ -208,12 +267,17 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
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
 
@@ -221,7 +285,12 @@ static void inv_icm42607_disable_vddio_reg(void *_data)
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
@@ -236,6 +305,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (!st)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, st);
+
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
@@ -271,10 +342,78 @@ int inv_icm42607_core_probe(struct regmap *regmap,
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
+	return pm_runtime_force_resume(dev);
+}
+
+static int inv_icm42607_runtime_suspend(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+
+	guard(mutex)(&st->lock);
+
+	/* save sensors state */
+	st->suspended.gyro = st->conf.gyro.mode;
+	st->suspended.accel = st->conf.accel.mode;
+	st->suspended.temp = st->conf.temp_en;
+
+	return inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+					  INV_ICM42607_SENSOR_MODE_OFF, false,
+					  NULL);
+}
+
+static int inv_icm42607_runtime_resume(struct device *dev)
+{
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+
+	guard(mutex)(&st->lock);
+
+	/* restore sensors state */
+	return inv_icm42607_set_pwr_mgmt0(st, st->suspended.gyro,
+					  st->suspended.accel,
+					  st->suspended.temp, NULL);
+}
+
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42607_pm_ops, IIO_ICM42607) = {
+	SYSTEM_SLEEP_PM_OPS(inv_icm42607_suspend, inv_icm42607_resume)
+	RUNTIME_PM_OPS(inv_icm42607_runtime_suspend,
+		       inv_icm42607_runtime_resume,
+		       NULL)
+};
+
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-42607 device driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index bde931752eb8..aed04be28528 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -85,6 +85,7 @@ static struct i2c_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-i2c",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_id,
 	.probe = inv_icm42607_probe,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
index 6072ed7adc86..137cd34582d8 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -95,6 +95,7 @@ static struct spi_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-spi",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_spi_id_table,
 	.probe = inv_icm42607_probe,
-- 
2.43.0

