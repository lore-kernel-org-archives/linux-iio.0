Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3803921D6
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778354505; cv=none; b=LAa2GmyAnHqr7TEECqlEcTfFgMFj9Nl/FXp/Kkogtdm+MIkMNh3udDjSXviTBbzTIhwv8g0XzZ9RYjOSYrvoYBu6FoQ7py9HXW+bhCKzpL7glqqGEZZQ2dynhK+JOg+TOrF4M7yFNKHyAtnIqG3wf1HsZtXnqQ4fY4KJUaAYAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778354505; c=relaxed/simple;
	bh=Iu3BKGNRAuY7A5QCbirM4LGyOF/bKTEu0kFmUspXwH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjHYAN6ZxMX+Wnj+DTHAgBq9Viz5Lv+AhOgERuqD6sCLAW7wiRQe5xzkrtATcVTM8EDOBOY1lcBPzJ2B1APBPAZS2m4WHE3I5cRQyS7jJukmmQYbrRigmnrdW5oO4ZYNd/nt6JFHzVNqb2n0NuApHyK/qcH/kPiDuvWCDIUe0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddt/NZMF; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddt/NZMF"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-435153d9b68so1894062fac.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778354502; x=1778959302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFq+S9593xwkcioFHPuyIdBmP704x4M7EgnuNwyV6PU=;
        b=ddt/NZMFmU89oGi1pdzXvE+mTq99eCWpt+rQ8POkcGfifrlv1FPu04uwk6QczDtSwJ
         HewyEjH4lTzaLMt0kWZrmkFWbPI2f4q4Q9VfO7x4x8xdBb43tUk2KEGG513JLs+UEiWM
         YrTkgtQD66kaMGuk1+YB930KicB0vVYldSHRy3dtZ1MXOQkzbL5LEK6OXBPBTX90Ii9y
         lZ69gPe+xyFAp9MmSbxnM3YDd+liGGJNIfv1qq7KJN3INcOROmWQGs9f6KDpMlXn8Dmd
         59bXex8MjxVu5iJ97sh9Ut5GERFKI2q3pvdi2xa4sR+ZbPINi+Vd7dPvremijWMbMMJs
         y2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778354502; x=1778959302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFq+S9593xwkcioFHPuyIdBmP704x4M7EgnuNwyV6PU=;
        b=oky2IFDWM2aJ+ThPIqRMdvRAdrMYKufYvBGZBpW0mInoPIA+1aS7uawxSZRSUuLfQc
         7SsPHk5J3xuTeKv74gutT02nq33Fhc22B+wgEos5al5Smbv6OzEFK4UXaBYVr55vQDpp
         FbIm9buxVOop+3BCH5RkeTF9mjr2VYpO3E2YKZYq05oXmz4jFXmBS+kuqxsNFITsTEgj
         NBSS1GhqYKvR3pCEWH5NSS+AMVbyFP/1vjDchNPNMfCdf6ZritUXIgwfL/ChOVk/6QKP
         E7OyfgReu+SLnQgbN1vxPfOVOYfz/syllXJ/SBoczzPmU42aHMC7sqKgLvax6yBndhsX
         7bww==
X-Gm-Message-State: AOJu0Yyb0XqXi9ijQ9e0txmKBTMwPQI/lysksQXLnev5ScgjnM80W1Vq
	mAlZY0DMwBAGTUHEEkjgAL0IBZhO+byJSalD4Nu3nW1v5bsrHtdl9lGRMaClBA==
X-Gm-Gg: Acq92OGPNh4fzg+ce36zEYCGMJYeikxP3ASTWBXHJfIBw/3RYIeXUEEsyaXnfsCLM7q
	6Q4iXiUUAnBtPLcJajnfnE1pQbSarJb/oN8Rv+mgg/48g6sPN5yuJDC0o3dvl5sXs1DKWtvkxyC
	Dwi7uLeYUBY0vPFEb7YFN2TDOL8aFsPUKq5t83HYHWt9zo8lT30joHKzkAT/V923aRZIRPe/E65
	Cnotlsu0uLoxiuU5qe//BHv1kH09frJ/xePmTyaCHSLRwEIEkk3tVffSywUemQf3U6YggTirZnp
	jK9FaQEM8UmEmlCgZIVv1c6URHhHPmovtamYhO4bmGR/47xp5BcUxVEnBIxHOA9qPE1KIUDj4vE
	jyY0zADtP4yYk1rSIwZ5Z3goBIKBa+o49kv09jNlaRDh1sZonmF8lEGUD49qYaFhOmERbMiT78/
	1Ajg6J6Ru3HUvixfTudh+/a4BeViQepZ0=
X-Received: by 2002:a05:6870:168f:b0:42f:eda7:42f8 with SMTP id 586e51a60fabf-434f56cc0ffmr11810030fac.8.1778354502171;
        Sat, 09 May 2026 12:21:42 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm5243896fac.12.2026.05.09.12.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:21:41 -0700 (PDT)
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
Subject: [PATCH V5 05/11] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Sat,  9 May 2026 14:18:59 -0500
Message-ID: <20260509191907.24734-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509191907.24734-1-macroalpha82@gmail.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  10 ++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 148 +++++++++++++++++-
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
 4 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 3ebc06025051..623ff3936b4b 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -96,6 +97,12 @@ struct inv_icm42607_hw {
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
@@ -105,6 +112,7 @@ struct inv_icm42607_hw {
  *  @irq:		chip irq, required to enable/disable and set wakeup
  *  @orientation:	sensor chip orientation relative to main hardware.
  *  @conf:		chip sensors configurations.
+ *  @suspended:		suspended sensors configuration.
  */
 struct inv_icm42607_state {
 	struct mutex lock;
@@ -114,6 +122,7 @@ struct inv_icm42607_state {
 	int irq;
 	struct iio_mount_matrix orientation;
 	struct inv_icm42607_conf conf;
+	struct inv_icm42607_suspended suspended;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -337,6 +346,7 @@ typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 extern const struct regmap_config inv_icm42607_regmap_config;
 extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
+extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 8ff51711ab1f..047de1b40550 100644
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
@@ -66,6 +67,62 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
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
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
@@ -192,8 +249,10 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
 static void inv_icm42607_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42607_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
 
-	regulator_disable(st->vddio_supply);
+	if (!pm_runtime_suspended(dev))
+		regulator_disable(st->vddio_supply);
 }
 
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
@@ -251,10 +310,97 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
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
+	regulator_disable(st->vddio_supply);
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
index 3859517f88c9..d4fab3d12753 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -72,6 +72,7 @@ static struct i2c_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-i2c",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_id,
 	.probe = inv_icm42607_probe,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
index 4a38a11f2bae..23204194eca5 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -79,6 +79,7 @@ static struct spi_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-spi",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_spi_id_table,
 	.probe = inv_icm42607_probe,
-- 
2.43.0

