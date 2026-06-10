Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504AF352017
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114252; cv=none; b=lwAjRgTG4elqUgAsQTHbQ+efwcIf8yF35S2xrSILPtxSBDdTsNgGU43edBMkYv1Tf0lAhBnSHCdKQHrnh7Ss3oYf9ZJKQ7q3fk11KKAo7QUFkM5rRJQJJnaNNm8yqq494gp+dl5DFW3horhHRGAnqEiUQON/gp5FDmi+x+Z50JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114252; c=relaxed/simple;
	bh=NzH6hJ4P7+Odrab9SVY5sT6MsTS1bIWvbXq6dNHEYE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyD5nGDs4+ssmox54Ko2IVrQOglgeuECjUxpfCOmyUQNNBRbm2Jc8TcAAkrAFVfFd6I709LtVG+TFaqVlF1dwI5y/PP268rF1yB7Qttw3ojs+4KW3tgUNwVrfK2NYOE3LO3QzDXr4Dex06KwA2BBdLw3k9Kr0R1q1kQzWgEOhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHrK8FuS; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHrK8FuS"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43d3031a750so3900013fac.2
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114249; x=1781719049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW8Syt234OPRTlLmgS/3iLS5D5+Ulgv06ZIc/zfEuUM=;
        b=tHrK8FuSAxsRFMbab9Par8UdbSI5B+MeNOVzb85BPSloPEyzZhGj+1Blx9mzAWq6fT
         5vSrNqRZcI4eyXwgPL7a4v7K2IZ5b9X4S/F+2o9dsrCthEnIlSwmuDCZ1+Vcd3LTaRrC
         Fc5hhX4G6pJE4BmYOl0EIRpIDTk7yQfTg7XSdjkSxUpt/cR2ZbuY2iu8ONZNigafMPiw
         Za8o/5BFhVcjkM5ZlOpurHEFSTTmBUErB6h2M1YbizWHCZL9Uo3hpkHXuBhqVIRNSPfc
         1D8m2PZZ5wKvbUyPDkuiSiwft2qInrxzOjQHcIPSZSEyYGcbHmOz90MEBdWXate8x5+D
         2B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114249; x=1781719049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CW8Syt234OPRTlLmgS/3iLS5D5+Ulgv06ZIc/zfEuUM=;
        b=ot4wrpENlaVv34BFSiaDwJIRQkt81jzGkkyy5ZSaznFf+iuuJROnPRI49vCn0mjjXN
         Q73XX67Sfl4OTJH+Jbz7zc7/gndee2LkNICLhOmBaqXgTZMJo5AMNhfCPGuerPgtTqFU
         6Oz4MtJRA8iEvlpEEb1Yva/9UwMWAy8EGZ1DgcGLZVL81Ru3UEkLJCATN9H96HtHKHTb
         24/H3gL4PLJynyQ+aDf2jK5cx+jozXMia9MkEioKTrh6T3r+AwGSE5qXDGUGCiZUqI5F
         Ho0+UGH0jI2Wnwdwd7EpYynSTrZFrFMyE2W0hDC1CCCJT0dq9IHrB1GdyTBQMJf4LPbO
         Rtxw==
X-Gm-Message-State: AOJu0Yz0/8JYWdqZ3F2kUowc8W6K5DeiJobHDFhjSfwar28VEML85Gw4
	Uw4nKTU/2IsiJKzWUxsYGR0SnGsAe9j9eYhmCFLUNkx62EOgNZjJI2hsE8c0Yg==
X-Gm-Gg: Acq92OECESrWf7Se9TAMiNUOzcpdhRVtAgoJgRgcgvNrgqXLDUL81Ejo6ceVsHB9ISn
	ufPYwzAxdCrnmSNvwVabsgOnzNLtzMHsWcQAeQkLPy2PeIvXvhKMwY72b2GGVGn+9lwfGs7eWyo
	0LTpzZD2N8jBdUs6wz/QUEW+mvZr/tpEzi51nKcV2ASVUlpRrwRAVzpR+XJdp3FdP24tk/lPiou
	O3C6X4IzX2ozpP6QjyiPwQPOJd+jY795sg0wSR0XMbau3tmeuTcEenyxIB+cPA/fQjgpYto28DD
	S4MnISu+D+CegezY7LJ+87PDtNRSQCNBYndKwPfDPh/SGKgUWEXb0fEWDVXDOad0U6uF0ko4gEG
	Y+5/JAqFS8Z6xEKhkrhNAuzM0suvj421wdK89NHYohLUBPsS1BNadVT1m3X2rSTYlqJAVbY2Nuw
	T5ZcVHifWTOPyMNYq0JRkO7e7trkdRsGSdmCj9q913DFngUg1nMHoAwB3+oD0sHkji
X-Received: by 2002:a05:6870:b61f:b0:43d:1d30:7ea6 with SMTP id 586e51a60fabf-4413d32eb67mr15919489fac.2.1781114249085;
        Wed, 10 Jun 2026 10:57:29 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b86b:51ed:28ca:695f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d4f449sm21180794fac.8.2026.06.10.10.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:57:28 -0700 (PDT)
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
Subject: [PATCH V11 5/9] iio: imu: inv_icm42607: Add PM support for icm42607
Date: Wed, 10 Jun 2026 12:54:49 -0500
Message-ID: <20260610175455.19006-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610175455.19006-1-macroalpha82@gmail.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 125 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   1 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |   1 +
 4 files changed, 145 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 743a15fb1b89..1f1397eaa00e 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -9,6 +9,7 @@
 #include <linux/bits.h>
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
@@ -103,22 +104,32 @@ struct inv_icm42607_hw {
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
 	struct iio_mount_matrix orientation;
 	struct inv_icm42607_conf conf;
+	struct inv_icm42607_suspended suspended;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -337,11 +348,18 @@ struct inv_icm42607_state {
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
index 26dc09bbeaed..5e1f924a3e34 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -8,6 +8,7 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/time.h>
@@ -71,6 +72,51 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
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
+		fsleep(sleepval * USEC_PER_MSEC);
+
+	return 0;
+}
+
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
@@ -181,12 +227,17 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
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
 
@@ -194,7 +245,12 @@ static void inv_icm42607_disable_vddio_reg(void *_data)
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
@@ -209,6 +265,8 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 	if (!st)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, st);
+
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
@@ -244,10 +302,77 @@ int inv_icm42607_core_probe(struct regmap *regmap,
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
+		       inv_icm42607_runtime_resume, NULL)
+};
+
 MODULE_AUTHOR("InvenSense, Inc.");
 MODULE_DESCRIPTION("InvenSense ICM-42607x device driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index 2946d5465853..0c2ff8e12643 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -80,6 +80,7 @@ static struct i2c_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-i2c",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_id,
 	.probe = inv_icm42607_probe,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
index 3485777ac5b6..1a7f6b0fa86b 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -92,6 +92,7 @@ static struct spi_driver inv_icm42607_driver = {
 	.driver = {
 		.name = "inv-icm42607-spi",
 		.of_match_table = inv_icm42607_of_matches,
+		.pm = pm_ptr(&inv_icm42607_pm_ops),
 	},
 	.id_table = inv_icm42607_spi_id_table,
 	.probe = inv_icm42607_probe,
-- 
2.43.0

