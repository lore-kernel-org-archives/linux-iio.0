Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CC3A8744
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209720; cv=none; b=c0fXkuz2ZR2QC09vVox3i0Vf6skEnGXRAFfG+SjYfLZv6RjhzvbWRcihCF8qmGtfgl/dezJGl6ZUnkYlbjCUf5DDMRA6kqNadegxqrRf0mKt/GZIquLZI1C//DPuYT8zwaY6RC/PVSxPtk6D89C3Pty7CMMc5cXSIQEHM1ekWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209720; c=relaxed/simple;
	bh=KPXz1zyCOhUKZ8PeK84SA5ljc2lrt5o3CsdLQy2hh5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9eZptj6KWVBfw3FmwiwRizwo3b2km3UQ877wX038hLac9WOFbiDSs8tedRzLfyNq7XzdpnVxCgUxa6md8MY945nG6W4RWcw6yTXGrB5yYkBEh2/vicvyWYPtzUffX/55ZraaKjarvLXXKjxJ6Kb9iZmYZpBUSjS3Oflc9hlR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2GKFtRn; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2GKFtRn"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43d3a0dabb0so223458fac.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209718; x=1781814518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjQPfh3hEXm7KLM7jh3jhYAf+nGLEyVqhn0xCk8m844=;
        b=U2GKFtRnrE0QKb5I3eUXuG088yMop23FVxVD5pDo+IBUzpyfgCJGXCJdNG9ag/dGst
         02JJuXpHBGLJTwlbtp9WIVlzhkBnZnYOa8kn+BTpR8+ozh1XNSbqi3jUA9xh3oxpn0RJ
         Hc1jWqtT5ivuqQq5hq90PY8k/gmKQEjPP+7pIzGUalAGcWSbAKJzWBDX/cvroP3rrh33
         Zzh0kAy7LPBoKnJqSa4DeZHnXFbZyzvIIvpF869apmKVaZvMwSgzt8clMS0iwD0IHPut
         vmmmhjW1kWaXOm/Zc+IhmStejjEYNM5Hz+v8AarCckBNHtEeMCrHgmQfjio00cR4yv2C
         ++ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209718; x=1781814518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fjQPfh3hEXm7KLM7jh3jhYAf+nGLEyVqhn0xCk8m844=;
        b=D0AQf68ijL4g47CMLyr3e9e/qtnJliBScRNenhBT+CUC2LLMTugkxYSSPlD2H88RV4
         +2EXp4iXcagAAUQUtAjLUcf46eoolUnYrp1bkQhHG9GR8zFonymU7uD6DXOC4XWHkzOu
         BQboLH3j10ia/Hrdsw05gDRChmJy+zn8N66WNnsgm8zMOo2xLVWBk0YZFbIAzeeID7Tq
         q2zO9xjYbxv2StBypJciFDI19dzDninwepW0yaXkoC5OLkWuo42Fah2qzbb5tHZ/PsIq
         jO2qnvOXZMqyXBKuORpNBcfjCerSzDP2/HhR+YHb97uNj5D2AlqIm/AT/CLfGxQcqYM1
         XH8A==
X-Gm-Message-State: AOJu0YzuQbpKSeG+3aiOZHn7lWbLo2a7j8CWvK7OJcPLh+AIlZa6Rn0T
	4GIAHGutlv+2QGH4Edi0gqh65yxyiCQwR//7Mbs7mbxPWcxWcULsWI18s/xp3Xaf
X-Gm-Gg: Acq92OE3JS/YfAHO0+3fYsBKdzcRCVu9Ci/I2cnyd1oYj8dS6CdWBWzNNaidPgDeriv
	kvaxGdysMPWUV6zeWxR2NJEZ+TROe9r7780T/YAGlTB54JrG0zro2jLlRljaEh6PuamVIb+CEJb
	Dm6La3KJ82gCZY1c3Af0C0V92zx8teiEkm7pKK7thqDvJMK4AgtIR/uYDzeyFavhC+8nfd/zcle
	5VeSXBgdUKF5rQ9EcrhULMReKbMvZhFU5yPKVAmkDem7oMLOrA7spkE53DUagOhpYutzd/uzJgK
	1CZ+fhh7Ic31U5hl7zTJ4lnzDL3TLGwS3enCF+d/cHcBrJFK09UH9YaNgGRIGqnqG1ldGENdLB2
	it/VdjGEWwxFF4wdGVmklKRA3ROc3/ZkERFEKj48TWLu7qi4IlwaceGS6n3tlAFcvhk4iXMU57T
	fT91Tf3D8vANztHwcuUuBEhQ==
X-Received: by 2002:a05:6870:b151:b0:43d:35ed:215c with SMTP id 586e51a60fabf-44241f6a0a8mr2534487fac.33.1781209717954;
        Thu, 11 Jun 2026 13:28:37 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44244cd05c9sm1796134fac.18.2026.06.11.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:28:37 -0700 (PDT)
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
Subject: [PATCH V12 5/9] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Thu, 11 Jun 2026 15:26:02 -0500
Message-ID: <20260611202607.85376-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611202607.85376-1-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 131 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
 4 files changed, 151 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index c85d3b74166f..28edc12d5373 100644
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
@@ -105,11 +106,19 @@ struct inv_icm42607_hw {
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
  *  @map:		regmap pointer.
  *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @suspended:		suspended sensors configuration.
+ *  @vddio_en:		I/O voltage status for runtime PM.
  *  @lock:		lock for serializing multiple registers access.
  *  @conf:		chip sensors configurations.
  *  @orientation:	sensor chip orientation relative to main hardware.
@@ -118,6 +127,8 @@ struct inv_icm42607_state {
 	const struct inv_icm42607_hw *hw;
 	struct regmap *map;
 	struct regulator *vddio_supply;
+	struct inv_icm42607_suspended suspended;
+	bool vddio_en;
 	struct mutex lock;
 	struct inv_icm42607_conf conf;
 	struct iio_mount_matrix orientation;
@@ -339,11 +350,18 @@ struct inv_icm42607_state {
 #define INV_ICM42607_GYRO_STARTUP_TIME_MS		30
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
index 5d40f1ee53d6..8073317088ec 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -11,6 +11,7 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/time.h>
@@ -102,6 +103,56 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
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
+	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, gyro);
+	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, accel);
+	/*
+	 * Note that temp being enabled here doesn't affect PM since
+	 * per 10.25 of the datasheet the clock will be off by default
+	 * if both the gyro and accel modes are off.
+	 */
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
+	sleepval_ms = 0;
+	if (temp && !oldtemp)
+		sleepval_ms = max(sleepval_ms, INV_ICM42607_TEMP_STARTUP_TIME_MS);
+
+	if (accel != oldaccel)
+		sleepval_ms = max(sleepval_ms, INV_ICM42607_ACCEL_STARTUP_TIME_MS);
+
+	if (gyro != oldgyro)
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
@@ -213,12 +264,17 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
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
 
@@ -226,7 +282,12 @@ static void inv_icm42607_disable_vddio_reg(void *_data)
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
@@ -241,6 +302,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (!st)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, st);
+
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
@@ -276,10 +339,78 @@ int inv_icm42607_core_probe(struct regmap *regmap,
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
index a1484f32c5d9..6e7310db5598 100644
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
index 0c8deb1f33e2..e361a692a32f 100644
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

