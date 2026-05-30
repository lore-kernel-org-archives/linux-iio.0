Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D5346E70
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780111223; cv=none; b=sL2lF5hMn24vzo0ZyX/Nz8G1yB6oA7dIu4FTKghl6R8xQAzNJeXe0EsPQ2zgj1NhVDB6y1CVyjBTSjBe+gQPqeqcBpA1plagTCcnWnuPjb5ypOOMMhkzkQqv8NMkIWb1memyoFKbhhx+Xk0zVgUpmclEY14wjRjuHG812r6cOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780111223; c=relaxed/simple;
	bh=5bETJ6iI669F8s5LAmhygLMaNvqZjrkeDbmSAFHfn0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns+Qzb1knFpwkJ6SxO0c8pHTKSkaA6+Sbr2EWmQEH4KWDHMbohTgI3fDbxFBPL3QOWz7eoex/Qfowz+GrnJ4+WNPtl7Zp93XYk8WbXy0YK8O5622pjzJDfQLarhwAhkAeg0gmWPn/aNLRSEsl6xeieCMJXI2tnbi+Wx3TzhLmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvZgU8Zm; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvZgU8Zm"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-694891f8f62so7698645eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 20:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780111221; x=1780716021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYZ9Hm8Lf/HQhtQVgZ7/T9QD8Q+iGUVzRElNt4yyXx4=;
        b=SvZgU8ZmJleVSH2N9om88RESRwe0cE0ldvjiQJIGs0JEvpHse+3giItXK30IpJLeGg
         DgVSFm6LcbfDgdQ74eNukJJ1+4R7cDyfii3HY8lE6VxHti5B2DA6FoqCg2h2cawd4L81
         6kjlPwfux77Ok5ze5Ohce1/wbPAev9b9t+UB+3zSs7SwSnKJavEH4GJJFMXw2y/wmyKb
         AySEKiW1xv/Uy5JfLNsDUi/ITx6hk/iWua5k3MGbAJ5QfDPZVqtxwyUAQtQR8rMSJQpD
         0djbYLuNMRpZDWYPI2eE1l7JmJTiY15tbFGONK6m6Ku7vdmwyFVzRGaNeg3FKEZH3VgM
         iczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780111221; x=1780716021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYZ9Hm8Lf/HQhtQVgZ7/T9QD8Q+iGUVzRElNt4yyXx4=;
        b=B++vdFnGO3id2QyS/mC+asvu+gQmt9zR3nsA1u7bW20IC/NXg7t4yRgoWPWEtordHc
         4ITJAEW4y0WipFIU2IDPXoYq6SFGqEjBAI4R15XZAZy6KCVkhchwVHtDb2tZiQK13aDh
         AtxwhG2ldm+xvyMXc79NN4jDghT9ng+jFRMg2jQ1o93R3d4alm4Ge+MXVgmi11xvohpU
         tsvapm0+lh2F9xL5zEJRQ8EwzDEbfzM9wCkOnwSS5L8ersZ+alKoMmNHuwks5nL1CTDK
         Zx5pt9/R0ft/gqxgp2YFvcBgKmfYe5KR1Z2n3zTPqOB7jAmjSfhFPuE7e8IKynYQ8Kek
         Bheg==
X-Gm-Message-State: AOJu0YwDqmK0rroRyFUdtYOFLoIb1MVx6QNvOqOhq6FW87NL2UuupPzl
	rzGrzgf4aIijJD8FEqJudPt1PaLzKMxLGbnvJnhcx85Z3m4c323AgPR1BIhH72+M
X-Gm-Gg: Acq92OE2UIojNDVhZm506n2GAIgtIAKEJbCIBJcsXrPkJvlULtuGfrQrwn3SQ95Dg4Z
	3v0QlrnBwgq+jQkeY1N/+HUSOl7hWfUiojXL1UCszPh5amp2WYcf3DccpZL/83j24AODmFR8DmS
	rhQ7r4IN/ND3aE10aucID+epGUduADfdY+Q9oxjwB1Lxo7OyC2GhMLYsLGh8bPqI5heBDqvawLU
	1bIu4KF/FURMow5LofsfFNB4v+wcerXia2QLefMljAR7mHJ39iuWVvYUZgtUm30v8OwXnmLLoSv
	6GNw6txNsoTbF0aEbLRkYvl7TRiSRLP9q+Xhl3zs8Sn1H7iKkGZ0GuhsmsMzLw6CjdsfBTdsN5C
	GSjY+d2gQoSQflZvEK6lAW2x5KuZn3Us7MsR9l2Z/MqGmIuCT0ohXBVHVe4ZSD1bIvBuMr/iqy8
	ENUQVceZAfjJokut8vy5xgINXGNzDRO5Bfr92NNfXYLg==
X-Received: by 2002:a05:6820:1849:b0:69e:2fd:408e with SMTP id 006d021491bc7-69e103852d4mr1013272eaf.37.1780111220952;
        Fri, 29 May 2026 20:20:20 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm2130737eaf.5.2026.05.29.20.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 20:20:20 -0700 (PDT)
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
Subject: [PATCH V9 05/11] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Fri, 29 May 2026 22:17:32 -0500
Message-ID: <20260530031739.109063-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530031739.109063-1-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 144 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
 4 files changed, 156 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 7a73c917fe8a..00c8dfe20717 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -109,6 +110,7 @@ struct inv_icm42607_hw {
  *  @hw:		Hardware specific data.
  *  @map:		regmap pointer.
  *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @vddio_en:		I/O voltage status for runtime PM.
  *  @irq:		chip irq, required to enable/disable and set wakeup
  *  @orientation:	sensor chip orientation relative to main hardware.
  *  @conf:		chip sensors configurations.
@@ -118,6 +120,7 @@ struct inv_icm42607_state {
 	const struct inv_icm42607_hw *hw;
 	struct regmap *map;
 	struct regulator *vddio_supply;
+	bool vddio_en;
 	int irq;
 	struct iio_mount_matrix orientation;
 	struct inv_icm42607_conf conf;
@@ -339,11 +342,18 @@ struct inv_icm42607_state {
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
 
 int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 3dd4cc8c6b1d..cfdce70ce25d 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -10,6 +10,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -73,6 +74,51 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
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
+	if (temp && !oldtemp)
+		sleepval = max(sleepval, INV_ICM42607_TEMP_STARTUP_TIME_MS);
+
+	if (accel != oldaccel)
+		sleepval = max(sleepval, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
+
+	if (gyro != oldgyro)
+		sleepval = max(sleepval, INV_ICM42607_GYRO_STARTUP_TIME_MS);
+
+	if (sleep_ms)
+		*sleep_ms = sleepval;
+	else if (sleepval)
+		fsleep(sleepval * 1000);
+
+	return 0;
+}
+
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
@@ -182,12 +228,17 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
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
 
@@ -195,7 +246,12 @@ static void inv_icm42607_disable_vddio_reg(void *_data)
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
@@ -253,10 +309,98 @@ int inv_icm42607_core_probe(struct regmap *regmap,
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
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
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
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
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
index 22ac51108cd3..cd08bb9514f2 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -82,6 +82,7 @@ static struct i2c_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-i2c",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_id,
 	.probe = inv_icm42607_probe,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
index 421d3ec1cded..8a82e1610531 100644
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

